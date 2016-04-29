From: broonie@kernel.org (Mark Brown)
Date: Fri, 29 Apr 2016 12:30:59 +0100
Subject: [RFT PATCH 1/3] usb: misc: usb3503: Fix HUB mode after
 bootloader initialization
In-Reply-To: <1461927591-7864-2-git-send-email-k.kozlowski@samsung.com>
References: <1461927591-7864-1-git-send-email-k.kozlowski@samsung.com>
 <1461927591-7864-2-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20160429113059.GX3217@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 29, 2016 at 12:59:49PM +0200, Krzysztof Kozlowski wrote:

> +++ b/Documentation/devicetree/bindings/usb/usb3503.txt
> @@ -24,6 +24,7 @@ Optional properties:
>  	pins (optional, if not provided, driver will not set rate of the
>  	REFCLK signal and assume that a value from the primary reference
>  	clock frequencies table is used)
> +- vdd33-supply: Optional supply for VDD 3.3 V power source.

Supplies are only optional if they may be physically absent.  In this
case it's possible that on device regulators may be used instead, a
pattern more like that used for arizona-ldo1 where we represent those
regulators might be better as it's more clearly describing the
situation.  I'm just wondering if the supply lookup stuff there should
be factored out as this is not an uncommon pattern..

It should at least be clearly stated what's going on, ignoring failure
to get supplies is generally a bug and people will tend to blindly cut
and paste things (witness all the breakage in graphics drivers with
this).

>  static int usb3503_reset(struct usb3503 *hub, int state)
>  {
> +	int err;
> +
> +	err = usb3503_regulator(hub, state);
> +	if (err) {
> +		dev_err(hub->dev, "unable to %s VDD33 regulator to (%d)\n",
> +			(state ? "enable" : "disable"), err);
> +	}

Are we sure that the callers all balance enables and disables and we
don't ever end up going through reset more than once on the way down?

> +		hub->vdd_reg = devm_regulator_get_optional(dev, "vdd33");
> +		if (IS_ERR(hub->vdd_reg)) {
> +			if (PTR_ERR(hub->vdd_reg) == -EPROBE_DEFER)
> +				return -EPROBE_DEFER;

This should explicitly check for -ENODEV and return the error if it gets
anything else, that will mean that if the supply is needed but lookup
fails somehow due to a non-deferral error we'll handle it properly.

> +	err = usb3503_regulator(hub, true);

The naming on this function is very obscure (and there's also a couple
of other supplies).  I'd suggest just folding this into the reset
function, or at least renaming so the reader can tell what these calls
do.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160429/c73a0979/attachment.sig>
