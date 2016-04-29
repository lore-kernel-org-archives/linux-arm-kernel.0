From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 29 Apr 2016 13:55:14 +0200
Subject: [RFT PATCH 1/3] usb: misc: usb3503: Fix HUB mode after bootloader
 initialization
In-Reply-To: <20160429113059.GX3217@sirena.org.uk>
References: <1461927591-7864-1-git-send-email-k.kozlowski@samsung.com>
 <1461927591-7864-2-git-send-email-k.kozlowski@samsung.com>
 <20160429113059.GX3217@sirena.org.uk>
Message-ID: <57234BA2.6020304@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/29/2016 01:30 PM, Mark Brown wrote:
> On Fri, Apr 29, 2016 at 12:59:49PM +0200, Krzysztof Kozlowski wrote:
> 
>> +++ b/Documentation/devicetree/bindings/usb/usb3503.txt
>> @@ -24,6 +24,7 @@ Optional properties:
>>  	pins (optional, if not provided, driver will not set rate of the
>>  	REFCLK signal and assume that a value from the primary reference
>>  	clock frequencies table is used)
>> +- vdd33-supply: Optional supply for VDD 3.3 V power source.
> 
> Supplies are only optional if they may be physically absent.  In this
> case it's possible that on device regulators may be used instead, a
> pattern more like that used for arizona-ldo1 where we represent those
> regulators might be better as it's more clearly describing the
> situation.  I'm just wondering if the supply lookup stuff there should
> be factored out as this is not an uncommon pattern..
> 
> It should at least be clearly stated what's going on, ignoring failure
> to get supplies is generally a bug and people will tend to blindly cut
> and paste things (witness all the breakage in graphics drivers with
> this).

The device has four power input lines (called VBAT, VDD33, VDD_CORE and
VDD_12). Datasheet describes 4 valid configurations... but impression of
the Odroid U3 board schematics is that they used another (custom?)
configuration.

I did not add rest of regulators on purpose:
1. I don't have other configurations to test.
2. It is rather old device, so I don't expect active development.

The VDD33 is really optional. The device can work in different
configuration, e.g. only on VBAT. How the reset logic would work then? I
don't know... I would suspect that it could be exactly the same (just
replace VDD33 with VBAT) but I am not sure.

>>  static int usb3503_reset(struct usb3503 *hub, int state)
>>  {
>> +	int err;
>> +
>> +	err = usb3503_regulator(hub, state);
>> +	if (err) {
>> +		dev_err(hub->dev, "unable to %s VDD33 regulator to (%d)\n",
>> +			(state ? "enable" : "disable"), err);
>> +	}
> 
> Are we sure that the callers all balance enables and disables and we
> don't ever end up going through reset more than once on the way down?

I double checked the code and there might be in-balance if DT or
platform data sets initial mode to suspend. Otherwise it should be balanced.

I'll re-think the patch and fix this.

> 
>> +		hub->vdd_reg = devm_regulator_get_optional(dev, "vdd33");
>> +		if (IS_ERR(hub->vdd_reg)) {
>> +			if (PTR_ERR(hub->vdd_reg) == -EPROBE_DEFER)
>> +				return -EPROBE_DEFER;
> 
> This should explicitly check for -ENODEV and return the error if it gets
> anything else, that will mean that if the supply is needed but lookup
> fails somehow due to a non-deferral error we'll handle it properly.

I must admit I wasn't sure about handling the ENODEV and some other
examples (drivers) were handling this just like that.

Thanks for pointing this out.

> 
>> +	err = usb3503_regulator(hub, true);
> 
> The naming on this function is very obscure (and there's also a couple
> of other supplies).  I'd suggest just folding this into the reset
> function, or at least renaming so the reader can tell what these calls
> do.

Okay.

Thanks for feedback!

Best regards,
Krzysztof
