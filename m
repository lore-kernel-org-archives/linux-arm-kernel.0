From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 21 Feb 2014 11:18:39 +0100
Subject: [PATCH 1/3] mfd: fsl imx25 Touchscreen ADC driver
In-Reply-To: <CAOMZO5BDyyvXs9CxJQOkuEpxZ8fqamCPB67sNhJxES+XU2XkXQ@mail.gmail.com>
References: <1392913312-9030-1-git-send-email-mpa@pengutronix.de>
 <1392913312-9030-2-git-send-email-mpa@pengutronix.de>
 <CAOMZO5BDyyvXs9CxJQOkuEpxZ8fqamCPB67sNhJxES+XU2XkXQ@mail.gmail.com>
Message-ID: <20140221101839.GD24758@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Thu, Feb 20, 2014 at 02:17:33PM -0300, Fabio Estevam wrote:
> Hi Markus,
> 
> On Thu, Feb 20, 2014 at 1:21 PM, Markus Pargmann <mpa@pengutronix.de> wrote:
> > This is the core driver for imx25 touchscreen/adc driver. The module
> > has one shared ADC and two different conversion queues which use the
> > ADC. The two queues are identical. Both can be used for general purpose
> > ADC but one is meant to be used for touchscreens.
> >
> > This driver is the core which manages the central components and
> > registers of the TSC/ADC unit. It manages the IRQs and forwards them to
> > the correct components.
> >
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> 
> That's great :-) Nice work!
> 
> > ---
> >  .../devicetree/bindings/mfd/fsl-imx25-tsadc.txt    |  46 ++++
> >  drivers/mfd/Kconfig                                |   9 +
> >  drivers/mfd/Makefile                               |   2 +
> >  drivers/mfd/fsl-imx25-tsadc.c                      | 234 +++++++++++++++++++++
> >  include/linux/mfd/imx25-tsadc.h                    | 138 ++++++++++++
> >  5 files changed, 429 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.txt
> >  create mode 100644 drivers/mfd/fsl-imx25-tsadc.c
> >  create mode 100644 include/linux/mfd/imx25-tsadc.h
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.txt b/Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.txt
> > new file mode 100644
> > index 0000000..a857af0e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.txt
> > @@ -0,0 +1,46 @@
> > +Freescale mx25 ADC/TSC multifunction device
> > +
> > +This device combines two general purpose conversion queues one used for general
> > +ADC and the other used for touchscreens.
> > +
> > +Required properties:
> > + - compatible: Should be "fsl,imx25-tsadc".
> > + - reg: Memory range of the device.
> > + - interrupts: Interrupt for this device as described in
> > +   interrupts/interrupts.txt
> > + - clocks: An 'ipg' clock defined as described in clocks/clock.txt
> > + - interrupt-controller: This device is an interrupt controller. It controls
> > +   the interrupts of both conversion queues.
> > + - #interrupt-cells: Should be '<1>'.
> > + - #address-cells: Should be '<1>'.
> > + - #size-cells: Should be '<1>'.
> > + - ranges
> > +
> > +This device includes two conversion queues which can be added as subnodes.
> > +The first queue is for the touchscreen, the second for general purpose ADC.
> > +
> > +Example:
> > +       tscadc: tscadc at 50030000 {
> > +               compatible = "fsl,imx25-tsadc";
> > +               reg = <0x50030000 0xc>;
> > +               interrupts = <46>;
> > +               clocks = <&clks 119>;
> > +               clock-names = "ipg";
> > +               interrupt-controller;
> > +               #interrupt-cells = <1>;
> > +               #address-cells = <1>;
> > +               #size-cells = <1>;
> > +               ranges;
> > +
> > +               tsc: tcq at 50030400 {
> > +                       compatible = "fsl,imx25-tcq";
> > +                       reg = <0x50030400 0x60>;
> > +                       ...
> > +               };
> > +
> > +               adc: gcq at 50030800 {
> > +                       compatible = "fsl,imx25-gcq";
> > +                       reg = <0x50030800 0x60>;
> > +                       ...
> > +               };
> > +       };
> 
> The meaning of 'tcq' and 'gcq' acronyms are not obvious. Could they be
> written more explicitily?
> 
> Also, what does the '...' mean?

I forgot to answer this one. The bindings for tcq and gcq are described
in the other files, so I didn't want to show any details that are not
relevant for this driver.

Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140221/5230b884/attachment.sig>
