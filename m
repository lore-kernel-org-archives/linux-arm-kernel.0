From: dima@android.com (Dima Zavin)
Date: Wed, 28 Apr 2010 00:35:41 -0700
Subject: [PATCH] [ARM] Do not call flush_cache_user_range with mmap_sem
	held
In-Reply-To: <1272439931-12795-1-git-send-email-dima@android.com>
References: <1272439931-12795-1-git-send-email-dima@android.com>
Message-ID: <z2j404ea8001004280035o806a0903zb6628d70887bcff2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is probably not as efficient as it could be since the flush
will end up faulting in pages the user never touched. I think we
should print a warning regarding that and skip over the unmapped
pages, I just wasn't sure how to do that correctly.

--Dima

2010/4/28 Dima Zavin <dima@android.com>:
> We can't be holding the mmap_sem while calling flush_cache_user_range
> because the flush can fault. If we fault on a user address, the
> page fault handler will try to take mmap_sem again. Since both places
> acquire the read lock, most of the time it succeeds. However, if another
> thread tries to acquire the write lock on the mmap_sem (e.g. mmap) in
> between the call to flush_cache_user_range and the fault, the down_read
> in do_page_fault will deadlock.
>
> Also, since we really can't be holding the mmap_sem while calling
> flush_cache_user_range AND vma is actually unused by the flush itself,
> get rid of vma as an argument.
>
> Signed-off-by: Dima Zavin <dima@android.com>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: Arve Hj?nnev?g <arve@android.com>
> ---
> ?arch/arm/include/asm/cacheflush.h | ? ?2 +-
> ?arch/arm/kernel/traps.c ? ? ? ? ? | ? ?4 +++-
> ?2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
> index 0d08d41..b68a2b4 100644
> --- a/arch/arm/include/asm/cacheflush.h
> +++ b/arch/arm/include/asm/cacheflush.h
> @@ -336,7 +336,7 @@ extern void flush_cache_page(struct vm_area_struct *vma, unsigned long user_addr
> ?* Harvard caches are synchronised for the user space address range.
> ?* This is used for the ARM private sys_cacheflush system call.
> ?*/
> -#define flush_cache_user_range(vma,start,end) \
> +#define flush_cache_user_range(start,end) \
> ? ? ? ?__cpuc_coherent_user_range((start) & PAGE_MASK, PAGE_ALIGN(end))
>
> ?/*
> diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
> index 1621e53..2455fd3 100644
> --- a/arch/arm/kernel/traps.c
> +++ b/arch/arm/kernel/traps.c
> @@ -453,7 +453,9 @@ do_cache_op(unsigned long start, unsigned long end, int flags)
> ? ? ? ? ? ? ? ?if (end > vma->vm_end)
> ? ? ? ? ? ? ? ? ? ? ? ?end = vma->vm_end;
>
> - ? ? ? ? ? ? ? flush_cache_user_range(vma, start, end);
> + ? ? ? ? ? ? ? up_read(&mm->mmap_sem);
> + ? ? ? ? ? ? ? flush_cache_user_range(start, end);
> + ? ? ? ? ? ? ? return;
> ? ? ? ?}
> ? ? ? ?up_read(&mm->mmap_sem);
> ?}
> --
> 1.6.6
>
>
