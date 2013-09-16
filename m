From: linux@roeck-us.net (Guenter Roeck)
Date: Mon, 16 Sep 2013 09:49:27 -0700
Subject: [PATCH] clk: si570: Add a driver for SI570 oscillators
In-Reply-To: <52373314.5070806@wwwdotorg.org>
References: <1379033737-30015-1-git-send-email-soren.brinkmann@xilinx.com>
 <1379033737-30015-2-git-send-email-soren.brinkmann@xilinx.com>
 <52373314.5070806@wwwdotorg.org>
Message-ID: <20130916164927.GB21352@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 16, 2013 at 10:34:28AM -0600, Stephen Warren wrote:
> On 09/12/2013 06:55 PM, Soren Brinkmann wrote:
> > Add a driver for SILabs 570, 571, 598, 599 programmable oscillators.
> > The devices generate low-jitter clock signals and are reprogrammable via
> > an I2C interface.
> 
> > diff --git a/Documentation/devicetree/bindings/clock/silabs,si570.txt b/Documentation/devicetree/bindings/clock/silabs,si570.txt
> 
> > +Required properties:
> > + - compatible: Shall be one of "silabs,si57x", "silabs,si59x".
> > + - reg: I2C device address.
> > + - #clock-cells: From common clock bindings: Shall be 0.
> > + - factory-fout: Factory set default frequency
> 
> So, there's no way to query this from the device at all? Looking at the
> data-sheet, all the frequency generation parameters are in registers,
> and the device supports I2C read commands. As such, I'm not convinced
> this property is necessary.
> 
Unfortunately, the chip does not report the factory setting for fout,
so the property is needed. The chip can not be programmed without it.

> > +Optional properties:
> > + - initial-fout: Initial output frequency to set during probe
> 
> "probe" is a Linux-specific concept. This property should be removed. If
> the driver is asked to set a specific frequency, it should do so, but I
> don't think it should program something pro-actively just because it
> starts up.
> 
> If this property is acceptable, it'd be better to describe it more along
> the lines of the following:
> 
> initial-fout: The frequency at which the system requires the clock to
> operate.
> 
It should probably be something like "clock-frequency". In many use cases
the programmed frequency is set to a constant frequency at system startup
and never changed, similar to other clocks.

Guenter

> > + - temperature-stability-7ppm: Indicate a device with a temperature stability
> > +			       of 7ppm
> > +
> > +Example:
> > +	si570: clock-generator at 5d {
> > +		#clock-cells = <0>;
> > +		compatible = "silabs,si570";
> > +		reg = <0x5d>;
> > +		factory-fout = <156250000>;
> > +	};
> 
> 
