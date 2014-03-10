From: ben@decadent.org.uk (Ben Hutchings)
Date: Mon, 10 Mar 2014 23:17:57 +0000
Subject: [PATCH] net: phy: fix uninitalized WOL parameters in
 phy_ethtool_get_wol
In-Reply-To: <531D98D1.4000707@gmail.com>
References: <1394413270-7169-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1394419893.15968.88.camel@deadeye.wl.decadent.org.uk>
 <531D98D1.4000707@gmail.com>
Message-ID: <1394493477.23624.21.camel@deadeye.wl.decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-03-10 at 10:49 +0000, Sebastian Hesselbarth wrote:
> On 03/10/2014 02:51 AM, Ben Hutchings wrote:
> > On Mon, 2014-03-10 at 02:01 +0100, Sebastian Hesselbarth wrote:
> >> phy_ethtool_get_wol is a helper to get current WOL settings from
> >> a phy device. When using this helper on a PHY without .get_wol
> >> callback, struct ethtool_wolinfo is never set-up correctly and
> >> may contain misleading information about WOL status.
> >>
> >> To fix this, always zero relevant fields of struct ethtool_wolinfo
> >> regardless of .get_wol callback availability.
> >
> > I think it's the caller's responsibility to zero out struct
> > ethtool_wolinfo.  That is what ethtool_get_wol() does.
> 
> Actually, phy_ethtool_get_wol is the caller here. This belongs to
> a set of helpers that deal with phy_device, not netdev.

Right, but ethtool_get_wol() is further up the stack and is responsible
for initialising the struct to defaults.

> > Maybe you could split ethtool_get_wol() like we did
> > ethtool_get_settings(), to support in-kernel invocation of ETHTOOL_GWOL?
> 
> Looking at the other users of phy_ethtool_get_wol (mv643xx_eth and
> cpsw), both drivers use this helper to determine what to pass back
> on the corresponding ethtool_get_wol call.
> 
> BTW, both drivers above do zero ethtool_wolinfo before calling
> phy_ethtool_get_wol. I can either zero it in phy_suspend too or we
> deal with it properly in phy_ethtool_get_wol instead:
> 
> void phy_ethtool_get_wol(struct phy_device *phydev, struct 
> ethtool_wolinfo *wol)
> {
> 	memset(wol, 0, sizeof(*wol));
> 
> 	if (phydev && phydev->drv->get_wol)
> 		phydev->drv->get_wol(phydev, wol);
> }
[...]

This trashes wol->cmd.  Don't do that.

Ben.

-- 
Ben Hutchings
Computers are not intelligent.	They only think they are.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 811 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140310/59c0486b/attachment-0001.sig>
