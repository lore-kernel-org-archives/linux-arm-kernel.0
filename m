From: akpm@linux-foundation.org (Andrew Morton)
Date: Thu, 22 Mar 2012 14:21:06 -0700
Subject: [PATCH 07/16] mm/arm: use vm_flags_t for vma flags
In-Reply-To: <20120321065642.13852.95838.stgit@zurg>
References: <20120321065140.13852.52315.stgit@zurg>
 <20120321065642.13852.95838.stgit@zurg>
Message-ID: <20120322142106.3aa383a5.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 21 Mar 2012 10:56:42 +0400
Konstantin Khlebnikov <khlebnikov@openvz.org> wrote:

> Cast vm_flags to unsigned int for __cpuc_flush_user_range(),
> because its vm_flags argument declared as unsigned int.
> Asssembler code wants to test VM_EXEC bit on vma->vm_flags,
> but for big-endian we should get upper word for this.
> 
> ...
>
> --- a/arch/arm/include/asm/cacheflush.h
> +++ b/arch/arm/include/asm/cacheflush.h
> @@ -217,7 +217,7 @@ vivt_flush_cache_range(struct vm_area_struct *vma, unsigned long start, unsigned
>  {
>  	if (cpumask_test_cpu(smp_processor_id(), mm_cpumask(vma->vm_mm)))
>  		__cpuc_flush_user_range(start & PAGE_MASK, PAGE_ALIGN(end),
> -					vma->vm_flags);
> +					(__force unsigned int)vma->vm_flags);
>  }

This won't work if a later version of __cpuc_flush_user_range() needs
access to newly-added flags in the upper 32 bits.

I guess we don't have to do anything about it at this stage, and that
if we do ever hit this problem, we'll need to put those newly-added
flags into the lower 32 bits of the vm_flags_t.
