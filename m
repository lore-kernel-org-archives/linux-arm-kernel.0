From: robh@kernel.org (Rob Herring)
Date: Sat, 16 Jan 2016 18:04:34 -0600
Subject: [PATCH v2 1/2] regulator: Add coupled regulator
In-Reply-To: <20160115085734.GG4581@lukather>
References: <1452605842-9317-1-git-send-email-maxime.ripard@free-electrons.com>
 <1452605842-9317-2-git-send-email-maxime.ripard@free-electrons.com>
 <20160112143100.GA14628@rob-hp-laptop>
 <20160115085734.GG4581@lukather>
Message-ID: <20160117000434.GB7774@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 15, 2016 at 09:57:34AM +0100, Maxime Ripard wrote:
> Hi Rob,
> 
> On Tue, Jan 12, 2016 at 08:31:00AM -0600, Rob Herring wrote:
> > On Tue, Jan 12, 2016 at 02:37:21PM +0100, Maxime Ripard wrote:
> > > Some boards, in order to power devices that have a quite high power
> > > consumption, wire multiple regulators in parallel.
> > > 
> > > In such a case, the regulators need to be kept in sync, all of them being
> > > enabled or disabled in parallel.
> > > 
> > > This also requires to expose only the voltages that are common to all the
> > > regulators.

[...]

> > > +Coupled voltage regulators
> > > +
> > > +Required properties:
> > > +- compatible		: Must be "coupled-voltage-regulator".
> > > +
> > > +Optional properties:
> > > +- vinX-supply		: Phandle to the regulators it aggregates
> > > +
> > > +Any property defined as part of the core regulator binding defined in
> > > +regulator.txt can also be used.
> > > +
> > > +Example:
> > > +	vcc_wifi: wifi_reg {
> > > +		compatible = "coupled-voltage-regulator";
> > > +		regulator-name = "vcc-wifi";
> > > +		vin0-supply = <&reg_ldo3>;
> > > +		vin1-supply = <&reg_ldo4>;
> > > +	};
> > 
> > Why not just make ?-supply a list of phandles? That would be simpler 
> > than a virtual regulator.
> 
> I'm not sure I get what you're saying. Do you want to remove that
> driver entirely, or just allow the -supply properties in the device
> tree to take a list?

Both actually, I think. If a power supply input for a device has 2 
supplies connected then list both of them for that device rather than 
create a virtual device in DT. Of course, you could keep a virtual 
regulator independent of DT. That is more of an implementation choice.

> In the former case, the rationale behind this driver is that the
> regulators powering a device also have to be kept in sync, both by
> enabling and disabling all of them at once, but also by all having
> them at the same voltages.

None of this has anything to do with the binding other than you can 
write a regulator driver and already have the mechanism to instantiate 
it with DT.

> We could push that code in the consumer drivers, but that has some
> significant drawbacks:
>   - That would duplicate that code in all the drivers, leading to the
>     usual drawbacks of code duplication, especially when it's not
>     really trivial to handle (or at least, when there's a few
>     gotchas).

Either you could keep the driver and the consumer driver is responsible 
for instantiating the regulator. It could also be implemented as a helper 
library in the regulator core. 

>   - When you come to consider it from an hardware point of view, the
>     device usually have a single pin that powers it. It's the board
>     designer that chose to route that pin to multiple regulators, so
>     it's really the board that is wired that way, and putting that
>     code in the consumer drivers would be an abstraction leak imho.

That's a good point. Perhaps the regulator core needs to be able to 
parse the list and return the single ptr to the virtual regulator.

>   - We might not even have a driver for these regulators, or at least
>     one that play by the rules. In our case, that's an out-of-tree
>     WiFi driver.

Support of out of tree things has never been a winning argument for 
upstream.

With an out of tree binding as well?

> In the latter case, I remember Mark saying several times that he was
> not in favour of such a change, even recently:
> https://lkml.org/lkml/2015/10/14/238

I think this case is somewhat different. What I'm suggesting is closer 
to the hardware which is what Mark also argued for, but we should let 
him speak. If the input supply name on a device is VCC and you have REG1 
and REG2 attached, then having "vcc-supply = <&REG1>, <&REG2>;" makes 
perfect sense in terms of matching the h/w.

Also, simplefb is not a good thing to compare with. 

Rob
