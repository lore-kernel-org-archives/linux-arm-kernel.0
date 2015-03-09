From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 9 Mar 2015 14:48:31 +0000
Subject: [PATCH 1/5] arm: factor out mmap ASLR into mmap_rnd
In-Reply-To: <1425341988-1599-2-git-send-email-keescook@chromium.org>
References: <1425341988-1599-1-git-send-email-keescook@chromium.org>
 <1425341988-1599-2-git-send-email-keescook@chromium.org>
Message-ID: <20150309144831.GM8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 02, 2015 at 04:19:44PM -0800, Kees Cook wrote:
> In preparation for exporting per-arch mmap randomization functions,
> this moves the ASLR calculations for mmap on ARM into a separate routine.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Looks fine, thanks.

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

> ---
>  arch/arm/mm/mmap.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mm/mmap.c b/arch/arm/mm/mmap.c
> index 5e85ed371364..0f8bc158f2c6 100644
> --- a/arch/arm/mm/mmap.c
> +++ b/arch/arm/mm/mmap.c
> @@ -169,14 +169,21 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
>  	return addr;
>  }
>  
> -void arch_pick_mmap_layout(struct mm_struct *mm)
> +static unsigned long mmap_rnd(void)
>  {
> -	unsigned long random_factor = 0UL;
> +	unsigned long rnd = 0UL;
>  
>  	/* 8 bits of randomness in 20 address space bits */
>  	if ((current->flags & PF_RANDOMIZE) &&
>  	    !(current->personality & ADDR_NO_RANDOMIZE))
> -		random_factor = (get_random_int() % (1 << 8)) << PAGE_SHIFT;
> +		rnd = (get_random_int() % (1 << 8)) << PAGE_SHIFT;
> +
> +	return rnd;
> +}
> +
> +void arch_pick_mmap_layout(struct mm_struct *mm)
> +{
> +	unsigned long random_factor = mmap_rnd();
>  
>  	if (mmap_is_legacy()) {
>  		mm->mmap_base = TASK_UNMAPPED_BASE + random_factor;
> -- 
> 1.9.1
> 

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
