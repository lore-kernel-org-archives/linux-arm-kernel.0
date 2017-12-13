From: xieyisheng1@huawei.com (Yisheng Xie)
Date: Wed, 13 Dec 2017 09:01:23 +0800
Subject: [PATCH] arm64: mm: Fix false positives in set_pte_at access/dirty
 race detection
In-Reply-To: <1513079030-8557-1-git-send-email-will.deacon@arm.com>
References: <1513079030-8557-1-git-send-email-will.deacon@arm.com>
Message-ID: <8761ce54-ad67-1113-44e1-0d1606d12dbf@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 2017/12/12 19:43, Will Deacon wrote:
> Jiankang reports that our race detection in set_pte_at is firing when
> copying the page tables in dup_mmap as a result of a fork(). In this
> situation, the page table isn't actually live and so there is no way
> that we can race with a concurrent update from the hardware page table
> walker.
> 
> This patch reworks the race detection so that we require either the
> mm to match the current active_mm (i.e. currently installed in our TTBR0)
> or the mm_users count to be greater than 1, implying that the page table
> could be live in another CPU. The mm_users check might still be racy,
> but we'll avoid false positives and it's not realistic to validate that
> all the necessary locks are held as part of this assertion.
> 
> Cc: Yisheng Xie <xieyisheng1@huawei.com>
> Reported-by: Jiankang Chen <chenjiankang1@huawei.com>
> Tested-by: Jiankang Chen <chenjiankang1@huawei.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/pgtable.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 3ff03a755c32..bdcc7f1c9d06 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -42,6 +42,8 @@
>  #include <asm/cmpxchg.h>
>  #include <asm/fixmap.h>
>  #include <linux/mmdebug.h>
> +#include <linux/mm_types.h>
> +#include <linux/sched.h>
>  

Do you have compiled kernel after apply this patch? In our environment, it will
fail to compile kernel if include file here(I will attach some log later).
Instead, we move these included file after mmdebug.h, and I do not know whether
this is just my compiler's problem:
  --- a/arch/arm64/include/asm/pgtable.h
  +++ b/arch/arm64/include/asm/pgtable.h
  @@ -42,6 +42,8 @@
   #include <asm/cmpxchg.h>
   #include <asm/fixmap.h>
   #include <linux/mmdebug.h>
   +#include <linux/mm_types.h>
   +#include <linux/sched.h>

Sorry for not having told you this information.

Thanks
Yisheng Xie

compiler err log: ==========
[...]
include/linux/mm_types_task.h:60: Error: unknown mnemonic `struct' -- `struct page_frag{'
include/asm-generic/preempt.h:9: Error: unknown mnemonic `static' -- `static inline int preempt_count(void)'
include/linux/mm_types_task.h:61: Error: unknown mnemonic `struct' -- `struct page*page'
include/asm-generic/preempt.h:10: Error: junk at end of line, first unrecognized character is `{'
include/linux/mm_types_task.h:63: Error: unknown mnemonic `__u32' -- `__u32 offset'
include/asm-generic/preempt.h:11: Error: unknown mnemonic `return' -- `return READ_ONCE(((struct thread_info*)current)->preempt_count)'
include/linux/mm_types_task.h:64: Error: unknown mnemonic `__u32' -- `__u32 size'
[...]
