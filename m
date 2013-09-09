From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 9 Sep 2013 14:08:45 +0200
Subject: [PATCH v2] pwm: pxa: add device tree support to pwm driver
In-Reply-To: <1378669218-10944-1-git-send-email-mikedunn@newsguy.com>
References: <1378669218-10944-1-git-send-email-mikedunn@newsguy.com>
Message-ID: <20130909120845.GB22197@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 08, 2013 at 12:40:18PM -0700, Mike Dunn wrote:
> This patch adds device tree support to the pxa's pwm driver.  Only an OF match

"PXA" and "PWM"

> table is added; nothing needs to be extracted from the device tree node.  The
> existing platform_device id table is reused for the match table data.  Support

"ID table"

> Changle log:
> v2:
> - of_match_table contains only the "pxa250-pwm" compatible string; require one
>   device instance per pwm
> - add Documentation/devicetree/bindings/pwm/pxa-pwm.txt
> - add support for polarity flag in DT and implement set_polarity() method
>   (the treo 680 inverts the signal between pwm out and backlight)
> - return -EINVAL instead of -ENODEV if platform data or DT node not found
> - output dev_info string if platform data missing
> - expanded CC list of patch

I think this needs to be reviewed by the device tree bindings
maintainers (as listed in MAINTAINERS) as well. Would you mind resending
the patch with all of them on Cc so that they have full context? Thanks.

>  Documentation/devicetree/bindings/pwm/pxa-pwm.txt | 33 +++++++++++++
>  arch/arm/boot/dts/pxa27x.dtsi                     | 24 ++++++++++
>  drivers/pwm/pwm-pxa.c                             | 57 +++++++++++++++++++++++
>  3 files changed, 114 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pxa-pwm.txt
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pxa-pwm.txt b/Documentation/devicetree/bindings/pwm/pxa-pwm.txt
> new file mode 100644
> index 0000000..7b09bfa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pxa-pwm.txt
> @@ -0,0 +1,33 @@
> +Marvell pwm controller
> +
> +Required properties:
> +- compatible:
> +  for pxa25x, pxa27x, pxa168, pxa910: must be compatible = "marvell,pxa250-pwm";
> +- reg: physical base address and length of the registers used by the pwm channel

"pwm" -> "PWM". There are a few more occurrences that I haven't
explicitly pointed out.

> +  NB: One device instance must be created for each pwm that is used, so the
> +  length covers only the register window for one pwm output, not that of the
> +  entire pwm controller.  Currently length is 0x10 for all supported devices.

I'm not sure I like that very much. It seems a wrong representation of
the hardware for the sake of modifying a smaller number of lines in the
driver.

> +- #pwm-cells: should be 3.
> +   cell 1: the per-chip index of the PWM to use,
> +   cell 2: the period in nanoseconds,
> +   cell 3: flags; set bit 0 to specify inverse polarity.  The pwm controller

This is the standard binding, so you can just refer to the standard
binding documentation instead, like so:

	- #pwm-cells: Should be 2. See pwm.txt in this directory for a description of
	  the cells format.

> +   does not implement reverse polarity, but some boards may pass the pwm output
> +   through an external inverter, which can cause problems if a client device
> +   assumes that an increase in the duty cycle results in an increase in output
> +   power.  The pwm-backlight is an example of such a client.

Please don't do that. Reverse polarity support should not be emulated.
Either the hardware supports it or it doesn't. In the above case you
should be able to achieve the same effect by adding the correct values
in the pwm-backlight device node's brightness-levels property.

> +Example pwm client node:
> +
> +backlight {
> +      	compatible = "pwm-backlight";
> +     	pwms = <&pwm0 0 5000000 1>;  /* pwm output is inverted */
> +	...

The indentation here is funky. You should be using only tabs to indent.

> +#ifdef CONFIG_OF
> +/*
> + * Device tree users should create one device instance for each pwm channel.
> + * Hence we dispense with the HAS_SECONDARY_PWM and "tell" the original driver
> + * code that this is a single channel pxa25x-pwm.
> + */
> +static struct of_device_id pwm_of_match[] = {
> +	{ .compatible = "marvell,pxa250-pwm", .data = &pwm_id_table[0]},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, pwm_of_match);
> +
> +static const struct platform_device_id *pxa_pwm_get_id_dt(struct device *dev)
> +{
> +	const struct of_device_id *pwm_pxa_devid =
> +		of_match_device(pwm_of_match, dev);

If you name this variable something much shorter, like "id", this will
fit on a single line, and the code below will be slightly more readable
as well.

> +	if (pwm_pxa_devid)
> +		return (const struct platform_device_id *)pwm_pxa_devid->data;
> +	else
> +		return NULL;
> +}

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130909/11a5bcaf/attachment.sig>
