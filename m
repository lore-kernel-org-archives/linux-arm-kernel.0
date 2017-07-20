From: sebastian.reichel@collabora.co.uk (Sebastian Reichel)
Date: Thu, 20 Jul 2017 16:45:06 +0200
Subject: [PATCH 08/11] ARM: OMAP2+: Remove unused legacy code for PRM
In-Reply-To: <20170630104256.GG3730@atomide.com>
References: <20170531225139.30723-1-tony@atomide.com>
 <20170531225139.30723-9-tony@atomide.com>
 <20170630104256.GG3730@atomide.com>
Message-ID: <20170720144506.rjar4dxih6ixavcp@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jun 30, 2017 at 03:42:56AM -0700, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [170531 15:55]:
> > We are now booting all mach-omap2 in device tree only mode.
> > Any code that is only called in legacy boot mode where
> > of_have_populated_dt() is not set is safe to remove now.
> ...
> 
> > diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
> > --- a/arch/arm/mach-omap2/prm44xx.c
> > +++ b/arch/arm/mach-omap2/prm44xx.c
> ...
> 
> > -static int omap44xx_prm_late_init(void)
> > -{
> > -	int irq_num;
> > -
> > -	if (!(prm_features & PRM_HAS_IO_WAKEUP))
> > -		return 0;
> > -
> > -	/* OMAP4+ is DT only now */
> > -	if (!of_have_populated_dt())
> > -		return 0;
> 
> Turns out I misread the above and this code is still needed for omap4 PRM
> interrupts, so applying a partial revert below to fix it.

I just spent a couple of hours to tracing this and now saw, that you
already did so. Why was this not part of the pull request? :(

> 8< ----------------------
> From tony Mon Sep 17 00:00:00 2001
> From: Tony Lindgren <tony@atomide.com>
> Date: Fri, 30 Jun 2017 03:37:03 -0700
> Subject: [PATCH] ARM: OMAP4: Fix legacy code clean-up regression
> 
> Commit 2a26d31b1bae ("ARM: OMAP2+: Remove unused legacy code for PRM")
> removed PRM platform init code that I thought is unused. Turns out omap4
> still needs this code, so let's do a partial revert to add it back.
> 
> I probably missed this earlier as the comments used to say
> "OMAP4+ is DT only now" for !of_have_populated_dt() to exit early and
> missed the negative test. Let's not add those lines back as they are
> confusing and no longer needed as we only boot in device tree mode.

haha, I came up with *exactly* the same patch and then noticed
this mail when I checked for a Message-ID as reference :)

> Without things things can mysterious fail for i2c, for example LM75
> I2C temperature sensor can stop working as the PRM interrupts won't work.

Here is the demystification:

Without this fix omap4_pmx_core and omap4_pmx_wakeup will not
register themself as interrupt controller, due to missing parent
interrupt. This means, that any device referencing an interrupt
in one of those controllers will fail their probe routine with
-EPROBE_DEFER waiting for the interrupt controller to appear.
At least for i2c this happens directly in the core, even before
calling the driver's probe routine making this look quite
mysterious.

TLDR: Fix "wakeup-source;" using devices on omap4.

> Fixes: 2a26d31b1bae ("ARM: OMAP2+: Remove unused legacy code for PRM")
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Tested-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

> ---
>  arch/arm/mach-omap2/prm44xx.c | 55 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
> --- a/arch/arm/mach-omap2/prm44xx.c
> +++ b/arch/arm/mach-omap2/prm44xx.c
> @@ -337,6 +337,27 @@ static void omap44xx_prm_reconfigure_io_chain(void)
>  }
>  
>  /**
> + * omap44xx_prm_enable_io_wakeup - enable wakeup events from I/O wakeup latches
> + *
> + * Activates the I/O wakeup event latches and allows events logged by
> + * those latches to signal a wakeup event to the PRCM.  For I/O wakeups
> + * to occur, WAKEUPENABLE bits must be set in the pad mux registers, and
> + * omap44xx_prm_reconfigure_io_chain() must be called.  No return value.
> + */
> +static void __init omap44xx_prm_enable_io_wakeup(void)
> +{
> +	s32 inst = omap4_prmst_get_prm_dev_inst();
> +
> +	if (inst == PRM_INSTANCE_UNKNOWN)
> +		return;
> +
> +	omap4_prm_rmw_inst_reg_bits(OMAP4430_GLOBAL_WUEN_MASK,
> +				    OMAP4430_GLOBAL_WUEN_MASK,
> +				    inst,
> +				    omap4_prcm_irq_setup.pm_ctrl);
> +}
> +
> +/**
>   * omap44xx_prm_read_reset_sources - return the last SoC reset source
>   *
>   * Return a u32 representing the last reset sources of the SoC.  The
> @@ -668,6 +689,8 @@ struct pwrdm_ops omap4_pwrdm_operations = {
>  	.pwrdm_has_voltdm	= omap4_check_vcvp,
>  };
>  
> +static int omap44xx_prm_late_init(void);
> +
>  /*
>   * XXX document
>   */
> @@ -675,6 +698,7 @@ static struct prm_ll_data omap44xx_prm_ll_data = {
>  	.read_reset_sources = &omap44xx_prm_read_reset_sources,
>  	.was_any_context_lost_old = &omap44xx_prm_was_any_context_lost_old,
>  	.clear_context_loss_flags_old = &omap44xx_prm_clear_context_loss_flags_old,
> +	.late_init = &omap44xx_prm_late_init,
>  	.assert_hardreset	= omap4_prminst_assert_hardreset,
>  	.deassert_hardreset	= omap4_prminst_deassert_hardreset,
>  	.is_hardreset_asserted	= omap4_prminst_is_hardreset_asserted,
> @@ -711,6 +735,37 @@ int __init omap44xx_prm_init(const struct omap_prcm_init_data *data)
>  	return prm_register(&omap44xx_prm_ll_data);
>  }
>  
> +static int omap44xx_prm_late_init(void)
> +{
> +	int irq_num;
> +
> +	if (!(prm_features & PRM_HAS_IO_WAKEUP))
> +		return 0;
> +
> +	irq_num = of_irq_get(prm_init_data->np, 0);
> +	/*
> +	 * Already have OMAP4 IRQ num. For all other platforms, we need
> +	 * IRQ numbers from DT
> +	 */
> +	if (irq_num < 0 && !(prm_init_data->flags & PRM_IRQ_DEFAULT)) {
> +		if (irq_num == -EPROBE_DEFER)
> +			return irq_num;
> +
> +		/* Have nothing to do */
> +		return 0;
> +	}
> +
> +	/* Once OMAP4 DT is filled as well */
> +	if (irq_num >= 0) {
> +		omap4_prcm_irq_setup.irq = irq_num;
> +		omap4_prcm_irq_setup.xlate_irq = NULL;
> +	}
> +
> +	omap44xx_prm_enable_io_wakeup();
> +
> +	return omap_prcm_register_chain_handler(&omap4_prcm_irq_setup);
> +}
> +
>  static void __exit omap44xx_prm_exit(void)
>  {
>  	prm_unregister(&omap44xx_prm_ll_data);
> -- 
> 2.13.1
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170720/174866bc/attachment.sig>
