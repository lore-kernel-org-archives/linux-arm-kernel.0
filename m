From: bhsharma@redhat.com (Bhupesh Sharma)
Date: Tue, 12 Jun 2018 13:55:18 +0530
Subject: [PATCH] arm64/mm: Introduce a variable to hold base address of
 linear region
In-Reply-To: <CAKv+Gu8Hs+CArdkAWoBPbr_p-nq5+0oPwOPg0NsJDRMkE_bM9A@mail.gmail.com>
References: <1528785361-24477-1-git-send-email-bhsharma@redhat.com>
 <CAKv+Gu8Hs+CArdkAWoBPbr_p-nq5+0oPwOPg0NsJDRMkE_bM9A@mail.gmail.com>
Message-ID: <CACi5LpNdg=Enp66BybNNuj5tQOp3ggyX=tm_SVzr8v2qCRteDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On Tue, Jun 12, 2018 at 12:23 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 12 June 2018 at 08:36, Bhupesh Sharma <bhsharma@redhat.com> wrote:
>> The start of the linear region map on a KASLR enabled ARM64 machine -
>> which supports a compatible EFI firmware (with EFI_RNG_PROTOCOL
>> support), is no longer correctly represented by the PAGE_OFFSET macro,
>> since it is defined as:
>>
>>     (UL(1) << (VA_BITS - 1)) + 1)
>>
>
> PAGE_OFFSET is the VA of the start of the linear map. The linear map
> can be sparsely populated with actual memory, regardless of whether
> KASLR is in effect or not. The only difference in the presence of
> KASLR is that there may be such a hole at the beginning, but that does
> not mean the linear map has moved, or that the value of PAGE_OFFSET is
> now wrong.
>
>> So taking an example of a platform with VA_BITS=48, this gives a static
>> value of:
>> PAGE_OFFSET = 0xffff800000000000
>>
>> However, for the KASLR case, we use the 'memstart_offset_seed'
>> to randomize the linear region - since 'memstart_addr' indicates the
>> start of physical RAM, we randomize the same on basis
>> of 'memstart_offset_seed' value.
>>
>> As the PAGE_OFFSET value is used presently by several user space
>> tools (for e.g. makedumpfile and crash tools) to determine the start
>> of linear region and hence to read addresses (like PT_NOTE fields) from
>> '/proc/kcore' for the non-KASLR boot cases, so it would be better to
>> use 'memblock_start_of_DRAM()' value (converted to virtual) as
>> the start of linear region for the KASLR cases and default to
>> the PAGE_OFFSET value for non-KASLR cases to indicate the start of
>> linear region.
>>
>
> Userland code that assumes that the linear map cannot have a hole at
> the beginning should be fixed.

That is a separate case (although that needs fixing as well via a
kernel patch probably as the user-space tools rely on '/proc/iomem'
contents to determine the first System RAM/reserved range).

1. In that particular case (see [1]) the EFI firmware sets the first
EFI block as EfiReservedMemType:

Region1: 0x000000000000-0x000000200000 [EfiReservedMemType]
Region2: 0x000000200000-0x00000021fffff [EfiRuntimeServiceData]

Since EFI firmware won't return the "EfiReservedMemType" memory to
Linux kernel, so the kernel can't get any info about the first mem
block, and kernel can only see region2 as below:

efi: Processing EFI memory map:
efi:   0x000000200000-0x00000021ffff [Runtime Data       |RUN|  |  |
|  |  |  |   |WB|WT|WC|UC]

# head -1 /proc/iomem
00200000-0021ffff : reserved

2a. If we add debug prints to 'arch/arm64/mm/init.c' to print the
kernel Virtual map we can see that the memory node is set to:

# dmesg | grep memory
..........
memory  : 0xffff800000200000 - 0xffff801800000000

2b. Now if we use kexec-tools to obtain a crash vmcore we can see that
if we use 'readelf' to get the last program Header from vmcore (logs
below are for the non-kaslr case):

# readelf -l vmcore

ELF Header:
........................

Program Headers:
  Type           Offset             VirtAddr           PhysAddr
         FileSiz            MemSiz              Flags  Align
..............................................................................................................................................................
  LOAD        0x0000000076d40000 0xffff80017fe00000 0x0000000180000000
                0x0000001680000000 0x0000001680000000  RWE    0

3. So if we do a simple calculation:

(VirtAddr + MemSiz) = 0xffff80017fe00000 + 0x0000001680000000 =
0xFFFF8017FFE00000 != 0xffff801800000000.

which indicates that the end virtual memory nodes are not the same
between vmlinux and vmcore.

This happens because the kexec-tools rely on 'proc/iomem' contents
while 'memstart_addr' is computed as 0 by kernel (as value of
memblock_start_of_DRAM() < ARM64_MEMSTART_ALIGN).

Returning back to this patch, this is a generic requirement where we
need the linear region start/base addresses in user-space applications
which is used to read addresses which lie in the linear region (for
e.g. when we read /proc/kcore contents).

>> I tested this on my qualcomm (which supports EFI_RNG_PROTOCOL)
>> and apm mustang (which does not support EFI_RNG_PROTOCOL) arm64 boards
>> and was able to use a modified user space utility (like kexec-tools and
>> makedumpfile) to determine the start of linear region correctly for
>> both the KASLR and non-KASLR boot cases.
>>
>
> Can you explain the nature of the changes to the userland code?

The changes are not to rely on the fixed PAGE_OFFSET macro value for
determining the base address of the linear region, but rather read the
' linear_reg_start_addr' symbol from kernel and use the same both in
case of KASLR and non-KASLR boots to determine the base of the linear
region (in [2], I have implemented a test change to kexec-tools to
read the 'linear_reg_start_addr' symbol which is available on my
public github tree, I have a similar change available in makedumpfile
which I have not yet pushed to github, as it implements other features
as well)

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-June/582407.html
[2] https://github.com/bhupesh-sharma/kexec-tools/commit/ae511833e948ccf864fae142ccd903f9c7b3461d

Regards,
Bhupesh

>> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
>> Cc: James Morse <james.morse@arm.com>
>> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
>> ---
>>  arch/arm64/include/asm/memory.h | 3 +++
>>  arch/arm64/kernel/arm64ksyms.c  | 1 +
>>  arch/arm64/mm/init.c            | 3 +++
>>  3 files changed, 7 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
>> index 49d99214f43c..bfd0915ecaf8 100644
>> --- a/arch/arm64/include/asm/memory.h
>> +++ b/arch/arm64/include/asm/memory.h
>> @@ -178,6 +178,9 @@ extern s64                  memstart_addr;
>>  /* PHYS_OFFSET - the physical address of the start of memory. */
>>  #define PHYS_OFFSET            ({ VM_BUG_ON(memstart_addr & 1); memstart_addr; })
>>
>> +/* the virtual base of the linear region. */
>> +extern s64                     linear_reg_start_addr;
>> +
>>  /* the virtual base of the kernel image (minus TEXT_OFFSET) */
>>  extern u64                     kimage_vaddr;
>>
>> diff --git a/arch/arm64/kernel/arm64ksyms.c b/arch/arm64/kernel/arm64ksyms.c
>> index d894a20b70b2..a92238ea45ff 100644
>> --- a/arch/arm64/kernel/arm64ksyms.c
>> +++ b/arch/arm64/kernel/arm64ksyms.c
>> @@ -42,6 +42,7 @@ EXPORT_SYMBOL(__arch_copy_in_user);
>>
>>         /* physical memory */
>>  EXPORT_SYMBOL(memstart_addr);
>> +EXPORT_SYMBOL(linear_reg_start_addr);
>>
>>         /* string / mem functions */
>>  EXPORT_SYMBOL(strchr);
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index 325cfb3b858a..29447adb0eef 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -60,6 +60,7 @@
>>   * that cannot be mistaken for a real physical address.
>>   */
>>  s64 memstart_addr __ro_after_init = -1;
>> +s64 linear_reg_start_addr __ro_after_init = PAGE_OFFSET;
>>  phys_addr_t arm64_dma_phys_limit __ro_after_init;
>>
>>  #ifdef CONFIG_BLK_DEV_INITRD
>> @@ -452,6 +453,8 @@ void __init arm64_memblock_init(void)
>>                 }
>>         }
>>
>> +       linear_reg_start_addr = __phys_to_virt(memblock_start_of_DRAM());
>> +
>>         /*
>>          * Register the kernel text, kernel data, initrd, and initial
>>          * pagetables with memblock.
>> --
>> 2.7.4
>>
