From: ben@decadent.org.uk (Ben Hutchings)
Date: Thu, 13 Mar 2014 02:21:45 +0000
Subject: [PATCH v3] net: phy: fix uninitalized WOL parameters in
 phy_ethtool_get_wol
In-Reply-To: <1394578975-12588-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1394484661-4554-2-git-send-email-sebastian.hesselbarth@gmail.com>
 <1394578975-12588-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1394677305.20857.29.camel@deadeye.wl.decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-03-12 at 00:02 +0100, Sebastian Hesselbarth wrote:
> phy_ethtool_get_wol is a helper to get current WOL settings from
> a phy device. When using this helper on a PHY without .get_wol
> callback, struct ethtool_wolinfo is never set-up correctly and
> may contain misleading information about WOL status.
> 
> To fix this, always zero relevant fields of struct ethtool_wolinfo
> regardless of .get_wol callback availability.

Sorry, I still disagree with this.

You're trying to make phy_ethtool_get_wol() do two subtly different
things:
- Provide an implementation of ethtool_ops::get_wol, leaving the net
  driver only to look up phy_device
- Provide a standalone function for executing ETHTOOL_GWOL on a
  phy_device

You may notice that phy_suspend() already sets wol.cmd = ETHTOOL_GWOL.
So it seems to me like it's taking responsibility for initialising the
structure like ethtool_get_wol() does.  The bug is then that
phy_suspend() doesn't clear the rest of the structure.  That is not the
responsibility of phy_ethtool_get_wol().

Ben.

> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> Changelog:
> v1->v2:
> - clear whole struct ethtool_wolinfo
> - check for non-NULL phy_device
> v2->v3:
> - only clear ->supported and ->wolopts (Suggested by Ben Hutchings)
> 
> Cc: David Miller <davem@davemloft.net>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Ben Hutchings <ben@decadent.org.uk>
> Cc: netdev at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  drivers/net/phy/phy.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index 19c9eca0ef26..94234a91a50f 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c
> @@ -1092,7 +1092,9 @@ EXPORT_SYMBOL(phy_ethtool_set_wol);
>  
>  void phy_ethtool_get_wol(struct phy_device *phydev, struct ethtool_wolinfo *wol)
>  {
> -	if (phydev->drv->get_wol)
> +	wol->supported = wol->wolopts = 0;
> +
> +	if (phydev && phydev->drv->get_wol)
>  		phydev->drv->get_wol(phydev, wol);
>  }
>  EXPORT_SYMBOL(phy_ethtool_get_wol);

-- 
Ben Hutchings
Experience is directly proportional to the value of equipment destroyed.
                                                         - Carolyn Scheppner
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 811 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140313/2bfd7788/attachment.sig>
