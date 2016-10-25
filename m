From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 25 Oct 2016 14:28:54 +0100
Subject: [PATCH] irqchip/ls-scfg-msi: update Layerscape SCFG MSI driver
In-Reply-To: <1477399162-22881-1-git-send-email-Minghuan.Lian@nxp.com>
References: <1477399162-22881-1-git-send-email-Minghuan.Lian@nxp.com>
Message-ID: <20161025132854.GC8898@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 25, 2016 at 08:39:22PM +0800, Minghuan Lian wrote:
> 1. The patch uses soc_device_match() to match the SoC family
> and revision instead of DTS compatible, because compatible cannot
> describe the SoC revision information.

What difference do you care about? If it affects the programming model
of the device, it should be described in the compatible string, or in
properties on the device node.

Matching the SoC is a bit aof a warning sign. If there's information
that we need, but don't currently have, please extend the binding to
provide it.

> +struct ls_scfg_msi_cfg {
> +	u32 ibs_shift; /* Shift of interrupt bit select */
> +	u32 msir_irqs; /* The irq number per MSIR */
> +	u32 msir_base; /* The base address of MSIR */
> +};

> +static struct ls_scfg_msi_cfg ls1021_msi_cfg = {
> +	.ibs_shift = 3,
> +	.msir_irqs = IRQS_32_PER_MSIR,
> +	.msir_base = 0x4,
> +};
> +
> +static struct ls_scfg_msi_cfg ls1043_rev11_msi_cfg = {
> +	.ibs_shift = 2,
> +	.msir_irqs = IRQS_8_PER_MSIR,
> +	.msir_base = 0x10,
> +};
> +
> +static struct ls_scfg_msi_cfg ls1046_msi_cfg = {
> +	.ibs_shift = 2,
> +	.msir_irqs = IRQS_32_PER_MSIR,
> +	.msir_base = 0x4,
> +};
> +
> +static struct soc_device_attribute soc_msi_matches[] = {
> +	{ .family = "QorIQ LS1021A",
> +	  .data = &ls1021_msi_cfg },
> +	{ .family = "QorIQ LS1012A",
> +	  .data = &ls1021_msi_cfg },
> +	{ .family = "QorIQ LS1043A", .revision = "1.0",
> +	  .data = &ls1021_msi_cfg },
> +	{ .family = "QorIQ LS1043A", .revision = "1.1",
> +	  .data = &ls1043_rev11_msi_cfg },
> +	{ .family = "QorIQ LS1046A",
> +	  .data = &ls1046_msi_cfg },
> +	{ },

If the base address of a register differs in this manner, then these
aren't "compatible", and should have separate strings.

Either that, or the binding should mandate a property to describe this.

You can *add* a new string, for which that property is mandatory, if you
believe you will see greate variation here in future.

>  static const struct of_device_id ls_scfg_msi_id[] = {
> -	{ .compatible = "fsl,1s1021a-msi", },
> -	{ .compatible = "fsl,1s1043a-msi", },
> +	{ .compatible = "fsl,ls-scfg-msi" },
>  	{},

NAK. Breaking support for existing DTBs is not ok.

Thanks,
Mark.
