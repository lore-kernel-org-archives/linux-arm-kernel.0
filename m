From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 30 Oct 2013 16:15:41 +0000
Subject: [PATCH v2] vfp: clear vfp_current_hw_state for dying cpu
In-Reply-To: <1382470553-19624-1-git-send-email-zyy@motorola.com>
References: <1382470553-19624-1-git-send-email-zyy@motorola.com>
Message-ID: <20131030161541.GF16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 22, 2013 at 02:35:53PM -0500, Yuanyuan Zhong wrote:
> Previous version of the patch can be found at:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-October/201893.html
> 
> The CPU_DYING notifier is called by cpu stopper task which
> does not own the context held in the VFP hardware. Calling
> vfp_force_reload() has no effect.
> Replace it with clearing vfp_current_hw_state.
> 
> Change-Id: Icb2c726334c5b0463b8126170cac2b44cd4ac38f
> Signed-off-by: Yuanyuan Zhong <zyy@motorola.com>

This is fine, please put the patch into the patch system and I'll send it
to Linus soon.  Please omit the Change-Id though.  Thanks.

> ---
>  arch/arm/vfp/vfpmodule.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
> index 52b8f40..2f37e1d 100644
> --- a/arch/arm/vfp/vfpmodule.c
> +++ b/arch/arm/vfp/vfpmodule.c
> @@ -642,9 +642,9 @@ int vfp_restore_user_hwstate(struct user_vfp __user *ufp,
>  static int vfp_hotplug(struct notifier_block *b, unsigned long action,
>  	void *hcpu)
>  {
> -	if (action == CPU_DYING || action == CPU_DYING_FROZEN) {
> -		vfp_force_reload((long)hcpu, current_thread_info());
> -	} else if (action == CPU_STARTING || action == CPU_STARTING_FROZEN)
> +	if (action == CPU_DYING || action == CPU_DYING_FROZEN)
> +		vfp_current_hw_state[(long)hcpu] = NULL;
> +	else if (action == CPU_STARTING || action == CPU_STARTING_FROZEN)
>  		vfp_enable(NULL);
>  	return NOTIFY_OK;
>  }
> -- 
> 1.7.9.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
