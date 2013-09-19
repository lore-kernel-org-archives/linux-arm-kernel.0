From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Thu, 19 Sep 2013 11:40:36 -0700
Subject: [PATCH v2] clk: si570: Add a driver for SI570 oscillators
In-Reply-To: <20130919180512.5246.73360@quantum>
References: <1379544219-23579-1-git-send-email-soren.brinkmann@xilinx.com>
 <20130919180512.5246.73360@quantum>
Message-ID: <2c474f75-8d0c-497b-ad64-8cd4beb09956@CO9EHSMHS013.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 19, 2013 at 11:05:12AM -0700, Mike Turquette wrote:
> Quoting Soren Brinkmann (2013-09-18 15:43:38)
> > diff --git a/Documentation/devicetree/bindings/clock/silabs,si570.txt b/Documentation/devicetree/bindings/clock/silabs,si570.txt
> > new file mode 100644
> > index 0000000..7ab5c8b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/silabs,si570.txt
> > @@ -0,0 +1,38 @@
> > +Binding for Silicon Labs 570, 571, 598 and 599 programmable
> > +I2C clock generators.
> > +
> > +Reference
> > +This binding uses the common clock binding[1]. Details about the devices can be
> > +found in the data sheets[2][3].
> > +
> > +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> > +[2] Si570/571 Data Sheet
> > +    http://www.silabs.com/Support%20Documents/TechnicalDocs/si570.pdf
> > +[3] Si598/599 Data Sheet
> > +    http://www.silabs.com/Support%20Documents/TechnicalDocs/si598-99.pdf
> > +
> > +Required properties:
> > + - compatible: Shall be one of "silabs,si570", "silabs,si571",
> > +                              "silabs,si598", "silabs,si599"
> > + - reg: I2C device address.
> > + - #clock-cells: From common clock bindings: Shall be 0.
> > + - factory-fout: Factory set default frequency. This frequency is part specific.
> > +                The correct frequency for the part used has to be provided in
> > +                order to generate the correct output frequencies. For more
> > +                details, please refer to the data sheet.
> > +
> > +Optional properties:
> > + - clock-output-names: From common clock bindings. Recommended to be "si570".
> > + - clock-frequency: Output frequency to generate. This defines the output
> > +                   frequency set during boot. It can be reprogrammed during
> > +                   runtime using the common clock framework.
> > + - temperature-stability-7ppm: Indicate a device with a temperature stability
> > +                              of 7ppm
> 
> Some DT binding bike-shedding:
> 
> Should this be "temperature-stability-ppm = <7>;" ? Do you think that
> this value might change in the future?
Well, according to the data sheet all devices behave the same and only
the si570/571 with a temperature stability of 7ppm (there are actually
some more choices for this) need some special attention.
So, the only case we really care about and has to be treated differently
is the 7ppm case.
I don't mind how we detect it, but with this boolean property it results
in the least lines of code, I think.

> 
> > diff --git a/drivers/clk/clk-si570.c b/drivers/clk/clk-si570.c
> > new file mode 100644
> > index 0000000..c20dfce
> > --- /dev/null
> > +++ b/drivers/clk/clk-si570.c
> > @@ -0,0 +1,517 @@
> <snip>
> > +static bool si570_regmap_is_volatile(struct device *dev, unsigned int reg)
> > +{
> > +       switch (reg) {
> > +       case 135:
> > +               return true;
> > +       default:
> > +               return false;
> > +       }
> > +}
> > +
> > +static bool si570_regmap_is_writeable(struct device *dev, unsigned int reg)
> > +{
> > +       switch (reg) {
> > +       case 7 ... 18:
> > +       case 135:
> > +       case 137:
> > +               return true;
> > +       default:
> > +               return false;
> > +       }
> > +}
> 
> Should magic numbers above be symbolic constants?
I'll change it. Corresponding #defines already exist anyway.

	S?ren
