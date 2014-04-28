From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 28 Apr 2014 12:37:21 +0100
Subject: [PATCH 1a/4] mfd: twl4030-power: Add generic reset configuration
In-Reply-To: <20140424004955.GG6053@atomide.com>
References: <1398300030-7386-1-git-send-email-tony@atomide.com>
 <20140424004955.GG6053@atomide.com>
Message-ID: <20140428113721.GU21279@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The twl4030 PMIC needs to be configured properly for things like
> warm reset and deeper idle states so the PMIC manages the regulators
> properly based on the hardware triggers from the SoC.
> 
> For example, when rebooting an OMAP3530 at 125 MHz, it hangs.
> With this patch, TWL4030 will be reset when a warm reset occures.
> This way the OMAP3530 does not hang on reboot.
> 
> Let's use this as the default when compatible = "ti,twl4030-power".
> Other more complicated configurations can be added to the driver
> based on other compatible flags.
> 
> Based on earlier patch by Matthias Brugger <matthias.bgg@gmail.com>:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-January/144161.html
> 
> For more information about twl4030 configuration for the
> "power scripts" see:
> 
> http://www.omappedia.com/wiki/TWL4030_power_scripts
> 
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Robert Nelson <robertcnelson@gmail.com>
> Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> ---
> 
> Sorry this got accidentally left out, should be the first patch
> in the series.
> 
> diff --git a/Documentation/devicetree/bindings/mfd/twl4030-power.txt b/Documentation/devicetree/bindings/mfd/twl4030-power.txt
> index 8e15ec3..b906116 100644
> --- a/Documentation/devicetree/bindings/mfd/twl4030-power.txt
> +++ b/Documentation/devicetree/bindings/mfd/twl4030-power.txt
> @@ -5,7 +5,12 @@ to control the power resources, including power scripts. For now, the
>  binding only supports the complete shutdown of the system after poweroff.
>  
>  Required properties:
> -- compatible : must be "ti,twl4030-power"
> +- compatible : must be one of the following
> +	"ti,twl4030-power"
> +	"ti,twl4030-power-reset"
> +

I think it'll be sensible to wait for a DT Ack for this kind of
change.


> +#ifdef CONFIG_OF
> +
> +/* Generic warm reset configuration for omap3 */
> +
> +static struct twl4030_ins omap3_wrst_seq[] = {
> +	{ MSG_SINGULAR(DEV_GRP_NULL, 0x1b, RES_STATE_OFF), 2 },
> +	{ MSG_SINGULAR(DEV_GRP_P1, 0xf, RES_STATE_WRST), 15 },
> +	{ MSG_SINGULAR(DEV_GRP_P1, 0x10, RES_STATE_WRST), 15 },
> +	{ MSG_SINGULAR(DEV_GRP_P1, 0x7, RES_STATE_WRST), 0x60 },
> +	{ MSG_SINGULAR(DEV_GRP_P1, 0x19, RES_STATE_ACTIVE), 2 },
> +	{ MSG_SINGULAR(DEV_GRP_NULL, 0x1b, RES_STATE_ACTIVE), 2 },
> +};

Nit: I'd prefer the number formatting to be unified here i.e. all in
the same base, all <0x10 with leading zero.
 
> +static struct twl4030_script omap3_wrst_script = {
> +	.script	= omap3_wrst_seq,
> +	.size	= ARRAY_SIZE(omap3_wrst_seq),
> +	.flags	= TWL4030_WRST_SCRIPT,
> +};
> +
> +static struct twl4030_script *omap3_reset_scripts[] = {
> +	&omap3_wrst_script,
> +};
> +
> +static struct twl4030_resconfig omap3_rconfig[] = {
> +	{ .resource = RES_HFCLKOUT, .devgroup = DEV_GRP_P3, .type = -1,
> +	  .type2 = -1 },
> +	{ .resource = RES_VDD1, .devgroup = DEV_GRP_P1, .type = -1,
> +	  .type2 = -1 },
> +	{ .resource = RES_VDD2, .devgroup = DEV_GRP_P1, .type = -1,
> +	  .type2 = -1 },
> +	{ 0, 0},
> +};

Nit: May be just my OCD, but this looks a little messy. Perhaps a
simple MACRO might tidy things up, although that seems a little
over-kill for such a small sturct[]. At the very least least please
even up the brackets in the sentinel.

/me goes to organise his soup tins into alphabetical order.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
