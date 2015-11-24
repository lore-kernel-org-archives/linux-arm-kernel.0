From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 24 Nov 2015 11:44:51 +0100
Subject: [PATCH v8 1/8] ARM: dt: Binding documentation for imx25 ADC/TSC
In-Reply-To: <20151123145952.GC31376@x1>
References: <1447675269-8831-1-git-send-email-mpa@pengutronix.de>
 <1447675269-8831-2-git-send-email-mpa@pengutronix.de>
 <20151123145952.GC31376@x1>
Message-ID: <6186462.YDum13BH0b@adelgunde>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 23 November 2015 14:59:52 Lee Jones wrote:
> On Mon, 16 Nov 2015, Markus Pargmann wrote:
> 
> > This documentation describes the devicetree bindings for the
> > ADC/Touchscreen unit of the i.MX25 SoC.
> > 
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > Acked-by: Jonathan Cameron <jic23@kernel.org>
> > ---
> > 
> > Notes:
> >     Changes in v6:
> >      - Removed adc-ref property and replaced it with refp and refn for positive and
> >        negative references. The properties are optional now as the default
> >        behaviour is a positive internal reference voltage and ADC GND as negative
> >        reference.
> > 
> >  .../devicetree/bindings/mfd/fsl-imx25-tsadc.txt    | 46 ++++++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.txt b/Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.txt
> > new file mode 100644
> > index 000000000000..a857af0eb68c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.txt
> > @@ -0,0 +1,46 @@
> > +Freescale mx25 ADC/TSC multifunction device
> 
> Prefer "MX25" and "MultiFunction Device (MFD)"

Fixed.

> 
> > +This device combines two general purpose conversion queues one used for general
> > +ADC and the other used for touchscreens.
> > +
> > +Required properties:
> > + - compatible: Should be "fsl,imx25-tsadc".
> > + - reg: Memory range of the device.
> 
> Not exactly.  More like start location and size.
> 
> > + - interrupts: Interrupt for this device as described in
> > +   interrupts/interrupts.txt
> 
> No such file.  In any case, I'd prefer:
> 
> "(See: ../interrupt-controller/interrupts.txt)".
> 
> > + - clocks: An 'ipg' clock defined as described in clocks/clock.txt
> 
> Didn't you check any of what you've written?
> 
> "(See: ../clock/clock-bindings.txt)"

Seems I didn't check these, sorry.

> 
> > + - interrupt-controller: This device is an interrupt controller. It controls
> > +   the interrupts of both conversion queues.
> > + - #interrupt-cells: Should be '<1>'.
> > + - #address-cells: Should be '<1>'.
> > + - #size-cells: Should be '<1>'.
> > + - ranges
> 
> ?
> 
> Also, don't think think that this looks better/easier to read?

Yes a bit, changed it.

> 
> > +Required properties:
> > + - compatible:		Should be "fsl,imx25-tsadc".
> > + - reg:			Memory range of the device.
> > + - interrupts:		Interrupt for this device as described in
> > +				interrupts/interrupts.txt
> > + - clocks:			An 'ipg' clock defined as described in clocks/clock.txt
> > + - interrupt-controller:	This device is an interrupt controller. It controls
> > +   				the interrupts of both conversion queues.
> > + - #interrupt-cells:		Should be '<1>'.
> > + - #address-cells:		Should be '<1>'.
> > + - #size-cells:		Should be '<1>'.
> 
> [...]
> 
> > +This device includes two conversion queues which can be added as subnodes.
> > +The first queue is for the touchscreen, the second for general purpose ADC.
> > +
> > +Example:
> > +	tscadc: tscadc at 50030000 {
> > +		compatible = "fsl,imx25-tsadc";
> > +		reg = <0x50030000 0xc>;
> > +		interrupts = <46>;
> > +		clocks = <&clks 119>;
> > +		clock-names = "ipg";
> 
> I don't think this is required, if you only have a single clock.

I prefer this variation so that you immediately see what the clock is
for. The number is not terribly helpful.

Thanks,

Markus

> 
> > +		interrupt-controller;
> > +		#interrupt-cells = <1>;
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		ranges;
> > +
> > +		tsc: tcq at 50030400 {
> > +			compatible = "fsl,imx25-tcq";
> > +			reg = <0x50030400 0x60>;
> > +			...
> > +		};
> > +
> > +		adc: gcq at 50030800 {
> > +			compatible = "fsl,imx25-gcq";
> > +			reg = <0x50030800 0x60>;
> > +			...
> > +		};
> > +	};
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151124/9f3b22a0/attachment.sig>
