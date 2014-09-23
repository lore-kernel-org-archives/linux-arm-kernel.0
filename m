From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Sep 2014 20:18:19 +0200
Subject: [PATCH v4 3/9] Documentation: bindings: net: add the Marvell
 PXA168 Ethernet controller
In-Reply-To: <5421AE7C.30504@gmail.com>
References: <1411474536-22626-1-git-send-email-antoine.tenart@free-electrons.com>
 <5150779.ibmzDh88cj@wuerfel> <5421AE7C.30504@gmail.com>
Message-ID: <3847496.NqfTxpsf9X@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 September 2014 19:31:40 Sebastian Hesselbarth wrote:
> It has been a while I looked it up in the pxa168 datasheet, but IIRC
> there is only one port per controller. FWIW, there actually is also
> just one port per controller for Orion SoCs. The multiple ports per
> controller comes from the PPC system controllers, i.e. mv643xx hence
> the name. We just made the binding look like it is more ports available
> to make it backwards compatible.. although I doubt anyone is still using
> mv643xx anywhere.

Ok, I see.

> > If there is only one port and we just have to know which one that is,
> > I don't think we need the child nodes, but if one can have multiple
> > ports operate independently then the driver will need a rework
> > to actually be usable with that configuration.
> 
> I doubt pxa168 needs port nodes at all, i.e. we have the phy-handle
> directly as property of the controller node.

Ah, good.

> The HEC PHY node itself will be a sub-node of some future CEC node,
> while the (internal) MII PHY node can stay as a sub-node of the
> controller, e.g.
> 
> (one final example to make sure we agree on the same)
> 
> eth0: ethernet at f7b90000 {
>         compatible = "marvell,pxa168-eth";
>         reg = <...>;
>         #address-cells = <1>;
>         #size-cells = <0>;
>         phy-handle = <&ethphy0>;
> 
>         ethphy0: ethernet-phy at 0 {
>                 reg = <0>;
>         };
> };
> 
> cec0: cec at f7f00baa {
>         compatible = "marvell,berlin-cec";
>         reg = <...>;
>         #address-cells = <1>;
>         #size-cells = <0>;
>         
>         hecphy0: hdmi-ethernet-phy at 0 {
>                 reg = <0>;
>         };
> };
> 
> With berlin2cd-google-chromecast.dts overwriting
> 
> &eth0 { phy-handle = <&hecphy0>; };

Ok, now I also understood how the cec fits into this. Yes, I think this
looks very good.

	Arnd
