From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 15 Jul 2010 17:32:16 +0100
Subject: [PATCH 2/2] ARM: flush_ptrace_access: invalidate all I-caches
In-Reply-To: <1279209238-16234-3-git-send-email-will.deacon@arm.com>
References: <1279209238-16234-1-git-send-email-will.deacon@arm.com>
	<1279209238-16234-2-git-send-email-will.deacon@arm.com>
	<1279209238-16234-3-git-send-email-will.deacon@arm.com>
Message-ID: <20100715163216.GI29322@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 15, 2010 at 04:53:58PM +0100, Will Deacon wrote:
> copy_to_user_page can be used by access_process_vm to write to an
> executable page of a process using a mapping acquired by kmap.
> For systems with I-cache aliasing, flushing the I-cache using the
> Kernel mapping may leave stale data in the I-cache if the user
> mapping is of a different colour.
> 
> This patch replaces the coherent_kern_range call in flush_ptrace_access
> with a D-cache flush followed by a system-wide I-cache invalidation.
> This is required on all systems where the size of a way in the I-cache
> is larger than PAGE_SIZE.
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/mm/flush.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
> index c6844cb..45896a9 100644
> --- a/arch/arm/mm/flush.c
> +++ b/arch/arm/mm/flush.c
> @@ -120,8 +120,8 @@ void flush_ptrace_access(struct vm_area_struct *vma, struct page *page,
>  
>  	/* VIPT non-aliasing cache */
>  	if (vma->vm_flags & VM_EXEC) {
> -		unsigned long addr = (unsigned long)kaddr;
> -		__cpuc_coherent_kern_range(addr, addr + len);
> +		__cpuc_flush_dcache_area(kaddr, len);
> +		__flush_icache_all();

NAK.

If we have aliases in the I-cache, there's probably more places that
need to be fixed - and in any case I think the VIPT aliasing case
should be used in that instance.

This code is for non-aliasing D and I caches, and works as follows.

1. We flush the data out of the D cache, line by line, on at least the
   local CPU (and optionally the other CPUs.)  Since we disable
   preemption, we will own the cache lines.

2. We invalidate the I cache, line by line, on at least local CPU
   (and optionally the other CPUs.)

3. If the I-cache invalidate wasn't broadcast, we flush the entire
   I-cache on the other CPUs.

So, what CPUs report themselves as having VIPT non-aliasing caches but
actually have an aliasing I-cache?
