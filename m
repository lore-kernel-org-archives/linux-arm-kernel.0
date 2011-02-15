From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 Feb 2011 17:03:36 +0000
Subject: [PATCH v2] ARM: vfp: Always save VFP state in vfp_pm_suspend
In-Reply-To: <1297724147-6320-1-git-send-email-ccross@android.com>
References: <AANLkTik_Jey_PtRmr530FVckA6RXHESeX+CyoJC=ZTkR@mail.gmail.com>
	<1297724147-6320-1-git-send-email-ccross@android.com>
Message-ID: <20110215170336.GP4152@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 14, 2011 at 02:55:47PM -0800, Colin Cross wrote:
> diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
> index 66bf8d1..7231d18 100644
> --- a/arch/arm/vfp/vfpmodule.c
> +++ b/arch/arm/vfp/vfpmodule.c
> @@ -415,13 +415,13 @@ static int vfp_pm_suspend(struct sys_device *dev, pm_message_t state)
>  	struct thread_info *ti = current_thread_info();
>  	u32 fpexc = fmrx(FPEXC);
>  
> -	/* if vfp is on, then save state for resumption */
> -	if (fpexc & FPEXC_EN) {
> +	/* save state for resume */
> +	if (last_VFP_context[ti->cpu]) {

I'm not entirely happy with this.

It is true that last_VFP_context[] when non-NULL indicates who owns the
hardware VFP state, so saving it would seem logical.  However, this new
code now saves the state with the saved fpexc indicating that it's disabled.

This will cause a VFP exception to misbehave by reloading the state, and
then disabling the VFP unit.  That will cause another VFP exception which
will find the VFP unit disabled, and re-enable it.  All in all, this is
rather wasteful.

So...
	/* If lazy disable, re-enable the VFP ready for it to be saved */
	if (last_VFP_context[ti->cpu] != &ti->vfpstate) {
		fpexc |= FPEXC_EN;
		fmxr(FPEXC, fpexc);
	}
	/* If VFP is on, then save state for resumption */
	if (fpexc & FPEXC_EN) {
		...
