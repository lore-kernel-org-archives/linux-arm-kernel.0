From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 19 Sep 2013 14:15:35 -0700
Subject: [PATCH v2] clk: si570: Add a driver for SI570 oscillators
In-Reply-To: <20130919180512.5246.73360@quantum>
References: <1379544219-23579-1-git-send-email-soren.brinkmann@xilinx.com>
 <20130919180512.5246.73360@quantum>
Message-ID: <20130919211535.GB11537@roeck-us.net>
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
> 
Valid values are 7, 20, and 50 as far as I know. Problem is that the value is
not used directly, but only to hint that a specific set of registers shall be
used.

Given that, it may in fact be better to use an explicit number. Even though the
two register sets are specified by <7> in one case and <20,50> in the other
today, there may at some point be yet another value which might use the 7 ppm
register set or the 20/50 ppm register set ... or yet another register set.
An explicit number would cover all future accuracy ranges, not just the
existing ones.

Guenter
