From: lauraa@codeaurora.org (Laura Abbott)
Date: Mon, 25 Aug 2014 11:38:31 -0700
Subject: [PATCHv3 6/7] arm64: use fixmap for text patching when text is RO
In-Reply-To: <CAGXu5jJKhBZigRYtAa0h554tNoGoMd46_nsNvQS2Wds_DbZM1g@mail.gmail.com>
References: <1408584039-12735-1-git-send-email-lauraa@codeaurora.org>
 <1408584039-12735-7-git-send-email-lauraa@codeaurora.org>
 <CAGXu5jJKhBZigRYtAa0h554tNoGoMd46_nsNvQS2Wds_DbZM1g@mail.gmail.com>
Message-ID: <53FB82A7.3030806@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/22/2014 10:51 PM, Kees Cook wrote:
> On Wed, Aug 20, 2014 at 6:20 PM, Laura Abbott <lauraa@codeaurora.org> wrote:
>> When kernel text is marked as read only, it cannot be modified directly.
>> Use a fixmap to modify the text instead in a similar manner to
>> x86 and arm.
>>
>> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
>> ---
>> I think there were some questions on spinlocks for the arm version, not
>> sure if similar concerns apply here.
>> ---
>>  arch/arm64/include/asm/fixmap.h |  1 +
>>  arch/arm64/include/asm/insn.h   |  2 ++
>>  arch/arm64/kernel/insn.c        | 74 +++++++++++++++++++++++++++++++++++++++--
>>  arch/arm64/kernel/jump_label.c  |  2 +-
>>  4 files changed, 75 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
>> index db26a2f2..2cd4b0d 100644
>> --- a/arch/arm64/include/asm/fixmap.h
>> +++ b/arch/arm64/include/asm/fixmap.h
>> @@ -48,6 +48,7 @@ enum fixed_addresses {
>>
>>         FIX_BTMAP_END = __end_of_permanent_fixed_addresses,
>>         FIX_BTMAP_BEGIN = FIX_BTMAP_END + TOTAL_FIX_BTMAPS - 1,
>> +       FIX_TEXT_POKE0,
>>         __end_of_fixed_addresses
>>  };
>>
>> diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
>> index dc1f73b..07ac29b 100644
>> --- a/arch/arm64/include/asm/insn.h
>> +++ b/arch/arm64/include/asm/insn.h
>> @@ -92,6 +92,7 @@ bool aarch64_insn_is_nop(u32 insn);
>>
>>  int aarch64_insn_read(void *addr, u32 *insnp);
>>  int aarch64_insn_write(void *addr, u32 insn);
>> +int aarch64_insn_write_early(void *addr, u32 insn);
>>  enum aarch64_insn_encoding_class aarch64_get_insn_class(u32 insn);
>>  u32 aarch64_insn_encode_immediate(enum aarch64_insn_imm_type type,
>>                                   u32 insn, u64 imm);
>> @@ -103,6 +104,7 @@ u32 aarch64_insn_gen_nop(void);
>>  bool aarch64_insn_hotpatch_safe(u32 old_insn, u32 new_insn);
>>
>>  int aarch64_insn_patch_text_nosync(void *addr, u32 insn);
>> +int __aarch64_insn_patch_text_nosync(void *addr, u32 insn, bool early);
>>  int aarch64_insn_patch_text_sync(void *addrs[], u32 insns[], int cnt);
>>  int aarch64_insn_patch_text(void *addrs[], u32 insns[], int cnt);
>>  #endif /* __ASSEMBLY__ */
>> diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
>> index 92f3683..b25f8db 100644
>> --- a/arch/arm64/kernel/insn.c
>> +++ b/arch/arm64/kernel/insn.c
>> @@ -17,10 +17,13 @@
>>  #include <linux/bitops.h>
>>  #include <linux/compiler.h>
>>  #include <linux/kernel.h>
>> +#include <linux/mm.h>
>>  #include <linux/smp.h>
>> +#include <linux/spinlock.h>
>>  #include <linux/stop_machine.h>
>>  #include <linux/uaccess.h>
>>  #include <asm/cacheflush.h>
>> +#include <asm/fixmap.h>
>>  #include <asm/insn.h>
>>
>>  static int aarch64_insn_encoding_class[] = {
>> @@ -65,6 +68,36 @@ bool __kprobes aarch64_insn_is_nop(u32 insn)
>>         }
>>  }
>>
>> +static DEFINE_SPINLOCK(patch_lock);
>> +
>> +static void __kprobes *patch_map(void *addr, int fixmap, unsigned long *flags)
>> +{
>> +       unsigned long uintaddr = (uintptr_t) addr;
>> +       bool module = !core_kernel_text(uintaddr);
>> +       struct page *page;
>> +
>> +       if (module && IS_ENABLED(CONFIG_DEBUG_SET_MODULE_RONX))
>> +               page = vmalloc_to_page(addr);
>> +       else if (!module && IS_ENABLED(CONFIG_DEBUG_RODATA))
>> +               page = virt_to_page(addr);
>> +       else
>> +               return addr;
>> +
>> +       if (flags)
>> +               spin_lock_irqsave(&patch_lock, *flags);
>> +
>> +       set_fixmap(fixmap, page_to_phys(page));
>> +
>> +       return (void *) (__fix_to_virt(fixmap) + (uintaddr & ~PAGE_MASK));
>> +}
>> +
>> +static void __kprobes patch_unmap(int fixmap, unsigned long *flags)
>> +{
>> +       clear_fixmap(fixmap);
>> +
>> +       if (flags)
>> +               spin_unlock_irqrestore(&patch_lock, *flags);
>> +}
>>  /*
>>   * In ARMv8-A, A64 instructions have a fixed length of 32 bits and are always
>>   * little-endian.
>> @@ -81,10 +114,36 @@ int __kprobes aarch64_insn_read(void *addr, u32 *insnp)
>>         return ret;
>>  }
>>
>> +static int __kprobes __aarch64_insn_write(void *addr, u32 insn, bool patch)
>> +{
>> +       void *waddr = addr;
>> +       unsigned long flags;
>> +       int ret;
>> +
>> +       if (patch)
>> +               waddr = patch_map(addr, FIX_TEXT_POKE0, &flags);
>> +
>> +       ret = probe_kernel_write(waddr, &insn, AARCH64_INSN_SIZE);
>> +
>> +       if (waddr != addr) {
>> +               __flush_dcache_area(waddr, AARCH64_INSN_SIZE);
> 
> Is this flush to make sure the waddr change has actually made it to
> physical memory?
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> -Kees
> 

It's more for the alias flushing to match what arm was doing. This was
one of the parts that I wasn't sure if it was necessary or not.

Laura

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
