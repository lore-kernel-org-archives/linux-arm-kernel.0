From: jonathanh@nvidia.com (Jon Hunter)
Date: Mon, 7 Dec 2015 10:26:16 +0000
Subject: [PATCH v5 3/4] arm64: mm: support ARCH_MMAP_RND_BITS.
In-Reply-To: <1449000658-11475-4-git-send-email-dcashman@android.com>
References: <1449000658-11475-1-git-send-email-dcashman@android.com>
 <1449000658-11475-2-git-send-email-dcashman@android.com>
 <1449000658-11475-3-git-send-email-dcashman@android.com>
 <1449000658-11475-4-git-send-email-dcashman@android.com>
Message-ID: <56655EC8.6030905@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 01/12/15 20:10, Daniel Cashman wrote:
> From: dcashman <dcashman@google.com>
> 
> arm64: arch_mmap_rnd() uses STACK_RND_MASK to generate the
> random offset for the mmap base address.  This value represents a
> compromise between increased ASLR effectiveness and avoiding
> address-space fragmentation. Replace it with a Kconfig option, which
> is sensibly bounded, so that platform developers may choose where to
> place this compromise. Keep default values as new minimums.
> 
> Signed-off-by: Daniel Cashman <dcashman@android.com>
> ---
>  arch/arm64/Kconfig   | 31 +++++++++++++++++++++++++++++++
>  arch/arm64/mm/mmap.c |  8 ++++++--
>  2 files changed, 37 insertions(+), 2 deletions(-)

[snip]

> diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
> index ed17747..af461b9 100644
> --- a/arch/arm64/mm/mmap.c
> +++ b/arch/arm64/mm/mmap.c
> @@ -51,8 +51,12 @@ unsigned long arch_mmap_rnd(void)
>  {
>  	unsigned long rnd;
>  
> -	rnd = (unsigned long)get_random_int() & STACK_RND_MASK;
> -
> +ifdef CONFIG_COMPAT
> +	if (test_thread_flag(TIF_32BIT))
> +		rnd = (unsigned long)get_random_int() % (1 << mmap_rnd_compat_bits);
> +	else
> +#endif
> +		rnd = (unsigned long)get_random_int() % (1 << mmap_rnd_bits);
>  	return rnd << PAGE_SHIFT;
>  }

The above is causing a build failure on -next today.

commit 42a6c8953112a9856dd09148c3d6a2cc106b6003
Author: Jon Hunter <jonathanh@nvidia.com>
Date:   Mon Dec 7 10:15:47 2015 +0000

    ARM64: mm: Fix build failure caused by invalid ifdef statement
    
    Commit 2e4614190421 ("arm64-mm-support-arch_mmap_rnd_bits-v4") caused the
    following build failure due to a missing "#". Fix this.
    
    arch/arm64/mm/mmap.c: In function ?arch_mmap_rnd?:
    arch/arm64/mm/mmap.c:54:1: error: ?ifdef? undeclared (first use in this function)
     ifdef CONFIG_COMPAT
      ^
    Signed-off-by: Jon Hunter <jonathanh@nvidia.com>

diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
index af461b935137..e59a75a308bc 100644
--- a/arch/arm64/mm/mmap.c
+++ b/arch/arm64/mm/mmap.c
@@ -51,7 +51,7 @@ unsigned long arch_mmap_rnd(void)
 {
        unsigned long rnd;
 
-ifdef CONFIG_COMPAT
+#ifdef CONFIG_COMPAT
        if (test_thread_flag(TIF_32BIT))
                rnd = (unsigned long)get_random_int() % (1 << mmap_rnd_compat_bits);
        else

Cheers
Jon
