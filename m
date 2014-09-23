From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Sep 2014 19:02:33 +0200
Subject: [PATCH v4 3/9] Documentation: bindings: net: add the Marvell
 PXA168 Ethernet controller
In-Reply-To: <5421A28E.7060600@gmail.com>
References: <1411474536-22626-1-git-send-email-antoine.tenart@free-electrons.com>
 <9401592.hUYDkriFVO@wuerfel> <5421A28E.7060600@gmail.com>
Message-ID: <5150779.ibmzDh88cj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 September 2014 18:40:46 Sebastian Hesselbarth wrote:
> On 09/23/2014 06:29 PM, Arnd Bergmann wrote:
> > On Tuesday 23 September 2014 17:45:52 Sebastian Hesselbarth wrote:
> >> For reference, this is what we have for MVEBU SoCs with multiple ports
> >> per controller:
> >>
> >> eth: ethernet-ctrl at 72000 {
> >>          compatible = "marvell,orion-eth";
> ...
> >>          reg = <0x72000 0x4000>;
> ...
> >>
> >>          ethernet-port at 0 {
> >>                  compatible = "marvell,orion-eth-port";
> ...
> >>                  phy-handle = <&ethphy>;
> >>          };
> >> };
> >>
> >> mdio: mdio-bus at 72004 {
> >>          compatible = "marvell,orion-mdio";
> ...
> >>          reg = <0x72004 0x84>;
> ..
> >>          ethphy: ethernet-phy {
> >>                  /* set phy address in board file */
> >>          };
> >> };
> 
> > But in this example, you have the same registers and the same
> > clocks in two nodes, which are even used by the same device driver
> > at the moment. It's not a big issue, but my feeling is that Antoine's
> > approach was actually better because it more closely reflects
> > the way that the hardware is built.
> 
> I was not referring to the separate mdio bus node, but putting the
> ethernet-phy node as a child of ethernet-ctrl.

Ah, got it (I think). Yes, that makes sense.

The part I don't understand yet is how one uses multiple ports. pxa168_eth.c
seems to be written with the assumption that only one port is ever used at
a time, while mv643xx_eth.c can actually use multiple ports simultaneously.

Do you think that is that a hardware limitation of pxa168_eth or a feature
that nobody so far has needed from the driver?

If there is only one port and we just have to know which one that is,
I don't think we need the child nodes, but if one can have multiple
ports operate independently then the driver will need a rework 
to actually be usable with that configuration.


	Arnd
