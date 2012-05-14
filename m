From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Mon, 14 May 2012 15:33:55 +0100
Subject: [PATCH v4 2/2] ARM: vfp: clear fpscr length and stride bits on
 entry to sig handler
In-Reply-To: <1330009632-1235-2-git-send-email-will.deacon@arm.com>
References: <1330009632-1235-1-git-send-email-will.deacon@arm.com>
 <1330009632-1235-2-git-send-email-will.deacon@arm.com>
Message-ID: <1337006035.16954.21.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will

I've bisected a screen corruption problem on vexpress down to this
commit, I've commented at the end of the patch at to what I see the
problem being...

On Thu, 2012-02-23 at 15:07 +0000, Will Deacon wrote:
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
> index 1dfe7d8..269f40d 100644
> --- a/arch/arm/vfp/vfpmodule.c
> +++ b/arch/arm/vfp/vfpmodule.c
> @@ -562,6 +562,21 @@ int vfp_preserve_user_clear_hwstate(struct user_vfp __user *ufp,
>  
>  	if (err)
>  		return -EFAULT;
> +
> +	/* Ensure that VFP is disabled. */
> +	vfp_flush_hwstate(thread);
> +
> +	/*
> +	 * As per the PCS, clear the length and stride bits for function
> +	 * entry.
> +	 */
> +	hwstate->fpscr &= ~(FPSCR_LENGTH_MASK | FPSCR_STRIDE_MASK);
> +
> +	/*
> +	 * Disable VFP in the hwstate so that we can detect if it gets
> +	 * used.
> +	 */
> +	hwstate->fpexc &= ~FPEXC_EN;
>  	return 0;
>  }
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

If the signal handler uses VFP, will it actually cause hwstate->fpexc &
FPEXC_EN to be set? Won't it instead just enable the VFP in the hardware
registers? (It looks to me that hwstate only gets updated by
vfp_flush_hwstate().)

This certainly seems to be the case in my screen corruption situation
where on entry to vfp_restore_user_hwstate() "fmrx(FPEXC) & FPEXC_EN"
is true and "hwstate->fpexc & FPEXC_EN" is false.

With the code as it stands this means that on return from a signal
handler the vfp hardware registers will be in whatever state the signal
handler left them in, not the thread's state at the point the signal
happened.

Assuming that I have understood things correctly, then I plan on posting
a patch that would make code changes like...

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index bc683b8..386a81a 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -574,11 +574,6 @@ int vfp_preserve_user_clear_hwstate(struct user_vfp
__user *ufp,
         */
        hwstate->fpscr &= ~(FPSCR_LENGTH_MASK | FPSCR_STRIDE_MASK);
 
-       /*
-        * Disable VFP in the hwstate so that we can detect if it gets
-        * used.
-        */
-       hwstate->fpexc &= ~FPEXC_EN;
        return 0;
 }
 
@@ -591,12 +586,7 @@ int vfp_restore_user_hwstate(struct user_vfp __user
*ufp,
        unsigned long fpexc;
        int err = 0;
 
-       /*
-        * If VFP has been used, then disable it to avoid corrupting
-        * the new thread state.
-        */
-       if (hwstate->fpexc & FPEXC_EN)
-               vfp_flush_hwstate(thread);
+       vfp_flush_hwstate(thread);
 
        /*
         * Copy the floating point registers. There can be unused


-- 
Tixy 
