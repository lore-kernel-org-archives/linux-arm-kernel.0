From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 3 Feb 2012 11:12:09 +0000
Subject: [PATCH v3 2/2] ARM: vfp: clear fpscr length and stride bits on
 entry to sig handler
In-Reply-To: <1328104992-8016-3-git-send-email-will.deacon@arm.com>
References: <1328104992-8016-1-git-send-email-will.deacon@arm.com>
 <1328104992-8016-3-git-send-email-will.deacon@arm.com>
Message-ID: <20120203111209.GA2098@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 01, 2012 at 02:03:12PM +0000, Will Deacon wrote:
> The ARM PCS mandates that the length and stride bits of the fpscr are
> cleared on entry to and return from a public interface. Although signal
> handlers run asynchronously with respect to the interrupted function,
> the handler itself expects to run as though it has been called like a
> normal function.
> 
> This patch updates the state mirroring the VFP hardware before entry to
> a signal handler so that it adheres to the PCS. Furthermore, we disable
> VFP to ensure that we trap on any floating point operation performed by
> the signal handler and synchronise the hardware appropriately. A check
> is inserted after the signal handler to avoid redundant flushing if VFP
> was not used.
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/vfp/vfpmodule.c |   22 +++++++++++++++++++++-
>  1 files changed, 21 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
> index 3e35e35..49cf328 100644
> --- a/arch/arm/vfp/vfpmodule.c
> +++ b/arch/arm/vfp/vfpmodule.c
> @@ -562,6 +562,21 @@ int vfp_preserve_user_hwstate(struct user_vfp __user *ufp,
>  
>  	if (err)
>  		return -EFAULT;
> +
> +	/* Ensure that VFP is disabled. */
> +	vfp_flush_hwstate(thread);
> +
> +	/*
> +	 * As per the PCS, clear the length and stride bits before entry
> +	 * to the signal handler.
> +	 */
> +	hwstate->fpscr &= ~(FPSCR_LENGTH_MASK | FPSCR_STRIDE_MASK);
> +
> +	/*
> +	 * Disable VFP in the hwstate so that we can detect if it was
> +	 * used by the signal handler.
> +	 */
> +	hwstate->fpexc &= ~FPEXC_EN;
>  	return 0;
>  }

^ 
These additions are nothing to do with preserving the VFP state.
Instead, they set up a clean signal frame, under the assumption that the
interrupted thread's state has already been preserved.

Would this be more cleanly factored out as a separate function,
something like vfp_setup_sigframe(), so:

setup_sigframe() {
	/* ... */

	vfp_preserve_user_hwstate();
	vfp_setup_sigframe();
}

...?


Alternatively, if this is an abstraction too far, and the "preserve" and
"setup sigframe" actions will never make sense independently of each
other, you could just rename the function to something clearer, like
vfp_user_preserve_setup_sigframe().

Cheers
---Dave

>  
> @@ -574,7 +589,12 @@ int vfp_restore_user_hwstate(struct user_vfp __user *ufp,
>  	unsigned long fpexc;
>  	int err = 0;
>  
> -	vfp_flush_hwstate(thread);
> +	/*
> +	 * If VFP has been used, then disable it to avoid corrupting
> +	 * the new thread state.
> +	 */
> +	if (hwstate->fpexc & FPEXC_EN)
> +		vfp_flush_hwstate(thread);
>  
>  	/*
>  	 * Copy the floating point registers. There can be unused
> -- 
> 1.7.4.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
