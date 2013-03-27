From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 27 Mar 2013 11:12:11 +0000
Subject: [PATCH 3/3] ARM: cacheflush: add new iovec-based cache flushing
 system call
In-Reply-To: <1364235486-17738-4-git-send-email-will.deacon@arm.com>
References: <1364235486-17738-1-git-send-email-will.deacon@arm.com>
 <1364235486-17738-4-git-send-email-will.deacon@arm.com>
Message-ID: <20130327111210.GH801@MacBook-Pro.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 25, 2013 at 06:18:06PM +0000, Will Deacon wrote:
> The cacheflush system call flushes a contiguous range, specified by a
> pair of addresses. This means that user applications wishing to flush
> discrete ranges must issue multiple system calls, since attempting to
> flush past a vma results in range truncation.
> 
> This patch introduces a new private system call for ARM, cacheflush_iov,
> which processes a range of addresses described in an iovec structure.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/include/uapi/asm/unistd.h |  1 +
>  arch/arm/kernel/traps.c            | 36 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 37 insertions(+)
> 
> diff --git a/arch/arm/include/uapi/asm/unistd.h b/arch/arm/include/uapi/asm/unistd.h
> index af33b44..bcad38c 100644
> --- a/arch/arm/include/uapi/asm/unistd.h
> +++ b/arch/arm/include/uapi/asm/unistd.h
> @@ -421,6 +421,7 @@
>  #define __ARM_NR_usr26			(__ARM_NR_BASE+3)
>  #define __ARM_NR_usr32			(__ARM_NR_BASE+4)
>  #define __ARM_NR_set_tls		(__ARM_NR_BASE+5)
> +#define __ARM_NR_cacheflush_iov		(__ARM_NR_BASE+6)
>  
>  /*
>   * *NOTE*: This is a ghost syscall private to the kernel.  Only the
> diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
> index da5e268..f83eed6 100644
> --- a/arch/arm/kernel/traps.c
> +++ b/arch/arm/kernel/traps.c
> @@ -25,6 +25,7 @@
>  #include <linux/delay.h>
>  #include <linux/init.h>
>  #include <linux/sched.h>
> +#include <linux/slab.h>
>  
>  #include <linux/atomic.h>
>  #include <asm/cacheflush.h>
> @@ -515,6 +516,37 @@ do_cache_op(unsigned long start, unsigned long end, int flags)
>  	return flush_cache_user_range(start, end);
>  }
>  
> +static inline int
> +do_cache_op_iov(const struct iovec __user *uiov, unsigned long cnt, int flags)
> +{
> +	int i, ret = 0;
> +	unsigned long len = cnt * sizeof(struct iovec);
> +	struct iovec *iov = kmalloc(len, GFP_KERNEL);
> +
> +	if (iov == NULL) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	if (copy_from_user(iov, uiov, len)) {
> +		ret = -EFAULT;
> +		goto out_free;
> +	}
> +
> +	for (i = 0; i < cnt; ++i) {
> +		unsigned long start = (unsigned long __force)iov[i].iov_base;
> +		unsigned long end = start + iov[i].iov_len;
> +		ret = do_cache_op(start, end, flags);
> +		if (ret)
> +			break;
> +	}

Could you use get_user() on struct iovec fields directly to avoid
kmalloc? It would be slightly faster.

-- 
Catalin
