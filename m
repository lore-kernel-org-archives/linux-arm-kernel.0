From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 28 Jul 2017 09:39:36 +0200
Subject: [PATCH v2 05/11] net: stmmac: dwmac-rk: Add internal phy support
In-Reply-To: <20170727173152.GA16362@Red>
References: <1501160156-30328-1-git-send-email-david.wu@rock-chips.com>
 <1501160540-30662-1-git-send-email-david.wu@rock-chips.com>
 <20170727134834.GD18666@lunn.ch>
 <65ae1747-4dff-b1d8-8aa3-684fc8c7809a@gmail.com>
 <20170727173152.GA16362@Red>
Message-ID: <20170728073936.jwgrq2z2nd3dqrti@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 27, 2017 at 07:31:52PM +0200, Corentin Labbe wrote:
> On Thu, Jul 27, 2017 at 09:54:01AM -0700, Florian Fainelli wrote:
> > On 07/27/2017 06:48 AM, Andrew Lunn wrote:
> > > On Thu, Jul 27, 2017 at 09:02:16PM +0800, David Wu wrote:
> > >> To make internal phy work, need to configure the phy_clock,
> > >> phy cru_reset and related registers.
> > >>
> > >> Signed-off-by: David Wu <david.wu@rock-chips.com>
> > >> ---
> > >> changes in v2:
> > >>  - Use the standard "phy-mode" property for internal phy. (Florian)
> > > 
> > > I think we need to discuss this. This PHY appears to be on an MDIO
> > > bus, it uses a standard PHY driver, and it appears to be using an RMII
> > > interface. So it is just an ordinary PHY.
> > 
> > First, the fact that the internal PHY also appears through MDIO is
> > orthogonal to the fact that it is internal or external. Plenty of
> > designs have internal PHYs exposed through MDIO because that is
> > convenient. What matters though is how the data/clock lines are wired
> > internally, which is what "phy-mode" describes.
> > 
> > > 
> > > Internal is supposed to be something which is not ordinary, does not
> > > use one of the standard phy modes, needs something special to make it
> > > work.
> > > 
> > > Florain, it appears to be your suggestion to use internal. What do you
> > > say?
> > 
> > phy-mode = "internal" really means that it is not a standard MII variant
> > to connect the data/clock lines between the Ethernet MAC and the PHY,
> > and this can happen in some designs (although quite unlikely). So from
> > there we could do several things depending on the requirements:
> > 
> > - if you can have your Ethernet MAC driver perform the necessary
> > configuration *after* you have been able to bind the PHY device with its
> > PHY driver, then the PHY driver should have PHY_IS_INTERNAL in its
> > flags, and you can use phy_is_internal() from PHYLIB to tell you that
> > and we could imagine using: phy-mode = "rmii" because that would not too
> > much of a stretch
> > 
> > - if you need knowledge about this PHY connection type prior to binding
> > the PHY device and its driver (that is, before of_phy_connect()) we
> > could add a boolean property e.g: "phy-is-internal" that allows us to
> > know that, or we can have a new phy-mode value, e.g: "internal-rmii"
> > which describes that, either way would probably be fine, but the former
> > scales better
> 
> We have the same problem on Allwinner SoCs for dwmac-sun8i, we need
> to set a syscon for chossing between internal/external PHY.
>
> Having this phy-is-internal would be very helpfull. (adding
> internal-xmii will add too many flags in our case)

In our case, we'll always have a phy node, so we can have a compatible
that will give you the same information.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170728/c65c919d/attachment-0001.sig>
