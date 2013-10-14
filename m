From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 14 Oct 2013 12:26:03 +0100
Subject: [PATCHv2 1/9] ARM: kirkwood: convert d2net_v2 to DT
In-Reply-To: <20131012172900.787c68eb@skate>
References: <1375369655-1310-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1375369655-1310-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130813095830.GI27165@e106331-lin.cambridge.arm.com>
 <20131012172900.787c68eb@skate>
Message-ID: <20131014112603.GA31708@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 12, 2013 at 04:29:00PM +0100, Thomas Petazzoni wrote:
> Dear Mark Rutland,
> 

Hi Thomas,

> On Tue, 13 Aug 2013 10:58:30 +0100, Mark Rutland wrote:
> 
> > > +       regulators {
> > > +               compatible = "simple-bus";
> > > +               pinctrl-0 = <&pmx_sata_power>;
> > > +               pinctrl-names = "default";
> > > +               #address-cells = <1>;
> > > +               #size-cells = <0>;
> > 
> > That's not really a simple-bus if there's no mapping to the parent's
> > address space (and it represents a completely different concept of
> > address).
> 
> Right, but I guess it is needed for the child nodes to be considered as
> platform devices. There are already gazillions of .dts doing this in
> arch/arm/boot/dts, not only Kirkwood platforms, but also Tegra
> platforms, i.MX platforms and a bunch of others. While I admit it
> doesn't look the most appropriate representation, I believe that
> considering the number of existing users, solving this problem is a
> separate matter to the conversion of the d2net_v2 to the Device Tree.

With regards to the general abuse of simple-bus, I think that's
something we need to fix up. I don't think the fact that something is
generally abused is a good reason for continuing to abuse it. We already
have enough maintenance nightmares and there's no reason to add to that.

> 
> > Could you explain what the pinctrl's doing here? I couldn't see what
> > code would be handling that given the node will get probed as a
> > simple-bus and the regulator-fixed binding doesn't mention anything
> > about the parent node.
> 
> Right, the pinctrl should be one-level down, in the DT sub-node that
> describes the regulator, so that it get automatically configured
> because the regulator driver is a platform_driver.
> 
> I'll fix this.

Ok.

> 
> > > +
> > > +               sata0_power: regulator at 1 {
> > > +                       compatible = "regulator-fixed";
> > > +                       reg = <1>;
> > 
> > Do we even need the unit-address?
> 
> No, I'll fix this one as well.

As the regulator is now not in any address space as such, I'm happier
having it in a simple-bus (as we won't even need to hack in a kludge to
prevent addresses being translated when the driver doesn't expect it).
However, if we have a simple bus we should define the mapping to the
parent address space using ranges (for one thing ePAPR lists ranges as
required for simple-bus).

That said, is there any reason to place the regulators under a
simple-bus at all? They could just live under the root of the tree.

Cheers,
Mark.
