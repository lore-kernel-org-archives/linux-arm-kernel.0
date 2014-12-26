From: sre@kernel.org (Sebastian Reichel)
Date: Sat, 27 Dec 2014 00:50:33 +0100
Subject: [PATCH 1/3] DT Binding for omap3 temperature sensor
In-Reply-To: <20141226171944.GA24756@amd>
References: <20141226102933.GA28778@amd>
 <1419597294-21487-1-git-send-email-sre@kernel.org>
 <1419597294-21487-2-git-send-email-sre@kernel.org>
 <20141226171944.GA24756@amd>
Message-ID: <20141226235032.GA29735@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

On Fri, Dec 26, 2014 at 06:19:44PM +0100, Pavel Machek wrote:
> On Fri 2014-12-26 13:34:52, Sebastian Reichel wrote:
> > OMAP34xx and OMAP36xx processors contain a register in the syscon area,
> > which can be used to determine the SoCs temperature. This provides a
> > DT binding specification for the temperature monitor.
> > 
> > Signed-off-by: Sebastian Reichel <sre@kernel.org>
> > ---
> >  .../bindings/hwmon/omap3-temperature.txt           | 25 ++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/hwmon/omap3-temperature.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/hwmon/omap3-temperature.txt b/Documentation/devicetree/bindings/hwmon/omap3-temperature.txt
> > new file mode 100644
> > index 0000000..99631ad
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/hwmon/omap3-temperature.txt
> > @@ -0,0 +1,25 @@
> > +* OMAP3 temperature sensor
> > +
> > +The OMAP34xx and OMAP36xx processors contain a register in the syscon area,
> > +which can be used to determine the SoCs temperature.
> > +
> > +Requires node properties:
> > +- compatible :	should contain one of
> > +	- "ti,omap34xx-temperature-sensor" for OMAP34xx
> > +	- "ti,omap36xx-temperature-sensor" for OMAP36xx
> > +- syscon :	Should be a phandle to system configuration node which
> > +		encompases the temperature register
> > +- clocks :	Should contain 32KHz fclk clock specifier
> > +- clock-names :	Should contain clock names
> > +	- "fck" for the 32KHz fclk clock specifier
> 
> I don't quite get it. The temperature sensor is internal on the CPU,
> right? Why do we need device tree to describe it? As soon as we have
> CPU that is compatible to ti,omap3430, we know everything we need to
> know, no?

Lots of stuff is SoC internal and described in the DT (e.g. serial
controllers). Just have a look in omap3.dtsi or omap34xx.dtsi.

I put the temperature sensor into its own node for the following
reasons:

 * syscon reference
 * clock reference

I first thought about loading the driver from the syscon driver,
but omap uses a generic one, so that's not an option. Apart from
that one would still need the clock reference.

> > +Example for omap34xx:
> > +
> > +/ {
> > +	temperature-sensor {
> > +		compatible = "ti,omap34xx-temperature-sensor";
> > +		syscon = <&omap3_scm_general>;
> > +		clocks = <&ts_fck>;
> > +		clock-names = "fck";
> > +	};
> > +};
> 
> Or is there something that depends on the board there? Or do we want
> to do it like this to be consistent with existing bindings?

This is SoC specific and should go into the omap34xx.dtsi and
omap36xx.dtsi files. See also PATCH 3/3.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141227/2b205907/attachment.sig>
