From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 9 Oct 2017 23:08:31 +0200
Subject: [PATCH v6 05/11] dt-bindings: net: dwmac-sun8i: update
 documentation about integrated PHY
In-Reply-To: <20171008183340.GA21531@Red>
References: <20170927073414.17361-1-clabbe.montjoie@gmail.com>
 <20170927073414.17361-6-clabbe.montjoie@gmail.com>
 <20170927140210.GE13516@lunn.ch> <20170928073708.GB32676@Red>
 <20171008183340.GA21531@Red>
Message-ID: <20171009210831.qc2cgxr4cx2qz5x7@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 08, 2017 at 06:33:40PM +0000, Corentin Labbe wrote:
> On Thu, Sep 28, 2017 at 09:37:08AM +0200, Corentin Labbe wrote:
> > On Wed, Sep 27, 2017 at 04:02:10PM +0200, Andrew Lunn wrote:
> > > Hi Corentin
> > > 
> > > > +Required properties for the mdio-mux node:
> > > > +  - compatible = "mdio-mux"
> > > 
> > > This is too generic. Please add a more specific compatible for this
> > > particular mux. You can keep "mdio-mux", since that is what the MDIO
> > > subsystem will look for.
> > > 
> > 
> > I will add allwinner,sun8i-h3-mdio-mux
> > 
> > > > +Required properties of the integrated phy node:
> > > >  - clocks: a phandle to the reference clock for the EPHY
> > > >  - resets: a phandle to the reset control for the EPHY
> > > > +- phy-is-integrated
> > > 
> > > So the last thing you said is that the mux is not the problem
> > > here. Something else is locking up. Did you discover what?
> > > 
> > > I really would like phy-is-integrated to go away.
> > > 
> > 
> > I have found the problem: by enabling ephy clk/reset the timeout does not occur anymore.
> > So we could remove phy-is-integrated by:
> > Moving internal phy clk/reset handling in mdio_mux_syscon_switch_fn()
> > But this means:
> > - getting internalphy node always by manually get internal_mdio/internal_phy (and not by the given phyhandle)
> > - doing some unnecessary tasks (enable/scan/disable) when external_phy is needed
> > 
> > Regards
> 
> Hello all
> 
> Below is the current patch, as you can read, it does not use anymore the phy-is-integrated property.
> So now, the mdio-mux must always enable the internal mdio when switch_fn ask for it and so reset MAC and so need to enable ephy clk/reset.
> But for this I need a reference to thoses clock and reset. (this is done in get_ephy_nodes)
> The current version set those clock in mdio-mux node, and as you can see it is already ugly (lots of get next node),
> if the clk/rst nodes were as it should be, in phy nodes, it will be more bad.
> 
> So, since the MAC have a dependency on thoses clk/rst nodes for
> doing reset(), I seek a proper way to get references on it.
>
> OR do you agree that putting ephy clk/rst in emac is acceptable ?

Why not just parsing the DT child nodes looking for resets and clocks
properties? The usual PHY don't have that.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171009/afbdd66c/attachment.sig>
