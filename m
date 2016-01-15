From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 15 Jan 2016 09:57:34 +0100
Subject: [PATCH v2 1/2] regulator: Add coupled regulator
In-Reply-To: <20160112143100.GA14628@rob-hp-laptop>
References: <1452605842-9317-1-git-send-email-maxime.ripard@free-electrons.com>
 <1452605842-9317-2-git-send-email-maxime.ripard@free-electrons.com>
 <20160112143100.GA14628@rob-hp-laptop>
Message-ID: <20160115085734.GG4581@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Tue, Jan 12, 2016 at 08:31:00AM -0600, Rob Herring wrote:
> On Tue, Jan 12, 2016 at 02:37:21PM +0100, Maxime Ripard wrote:
> > Some boards, in order to power devices that have a quite high power
> > consumption, wire multiple regulators in parallel.
> > 
> > In such a case, the regulators need to be kept in sync, all of them being
> > enabled or disabled in parallel.
> > 
> > This also requires to expose only the voltages that are common to all the
> > regulators.
> > 
> > Eventually support for changing the voltage in parallel should be added
> > too, possibly with delays between each other to avoid having a too brutal
> > peak consumption.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  .../bindings/regulator/coupled-voltage.txt         |  18 ++
> >  drivers/regulator/Kconfig                          |   8 +
> >  drivers/regulator/Makefile                         |   1 +
> >  drivers/regulator/coupled-voltage-regulator.c      | 299 +++++++++++++++++++++
> >  4 files changed, 326 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/regulator/coupled-voltage.txt
> >  create mode 100644 drivers/regulator/coupled-voltage-regulator.c
> > 
> > diff --git a/Documentation/devicetree/bindings/regulator/coupled-voltage.txt b/Documentation/devicetree/bindings/regulator/coupled-voltage.txt
> > new file mode 100644
> > index 000000000000..f5401aab52f2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/regulator/coupled-voltage.txt
> > @@ -0,0 +1,18 @@
> > +Coupled voltage regulators
> > +
> > +Required properties:
> > +- compatible		: Must be "coupled-voltage-regulator".
> > +
> > +Optional properties:
> > +- vinX-supply		: Phandle to the regulators it aggregates
> > +
> > +Any property defined as part of the core regulator binding defined in
> > +regulator.txt can also be used.
> > +
> > +Example:
> > +	vcc_wifi: wifi_reg {
> > +		compatible = "coupled-voltage-regulator";
> > +		regulator-name = "vcc-wifi";
> > +		vin0-supply = <&reg_ldo3>;
> > +		vin1-supply = <&reg_ldo4>;
> > +	};
> 
> Why not just make ?-supply a list of phandles? That would be simpler 
> than a virtual regulator.

I'm not sure I get what you're saying. Do you want to remove that
driver entirely, or just allow the -supply properties in the device
tree to take a list?

In the former case, the rationale behind this driver is that the
regulators powering a device also have to be kept in sync, both by
enabling and disabling all of them at once, but also by all having
them at the same voltages.

We could push that code in the consumer drivers, but that has some
significant drawbacks:
  - That would duplicate that code in all the drivers, leading to the
    usual drawbacks of code duplication, especially when it's not
    really trivial to handle (or at least, when there's a few
    gotchas).
  - When you come to consider it from an hardware point of view, the
    device usually have a single pin that powers it. It's the board
    designer that chose to route that pin to multiple regulators, so
    it's really the board that is wired that way, and putting that
    code in the consumer drivers would be an abstraction leak imho.
  - We might not even have a driver for these regulators, or at least
    one that play by the rules. In our case, that's an out-of-tree
    WiFi driver.

In the latter case, I remember Mark saying several times that he was
not in favour of such a change, even recently:
https://lkml.org/lkml/2015/10/14/238

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160115/cf9595dd/attachment.sig>
