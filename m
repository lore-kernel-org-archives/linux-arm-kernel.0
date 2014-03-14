From: ben@decadent.org.uk (Ben Hutchings)
Date: Fri, 14 Mar 2014 14:18:06 +0000
Subject: [PATCH] net: phy: fix uninitalized ethtool_wolinfo in phy_suspend
In-Reply-To: <1394788064-6832-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <20140313.153832.967564223480298567.davem@davemloft.net>
 <1394788064-6832-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1394806686.20857.31.camel@deadeye.wl.decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-03-14 at 10:07 +0100, Sebastian Hesselbarth wrote:
> Callers of phy_ethtool_get_wol are supposed to provide a properly
> cleared struct ethtool_wolinfo. Therefore, fix phy_suspend to clear
> it before passing it to phy_ethtool_get_wol.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Reviewed-by: Ben Hutchings <ben@decadent.org.uk>

> ---
> Cc: David Miller <davem@davemloft.net>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Ben Hutchings <ben@decadent.org.uk>
> Cc: netdev at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  drivers/net/phy/phy_device.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 4b03e63639b7..7512e28866f1 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -683,10 +683,9 @@ EXPORT_SYMBOL(phy_detach);
>  int phy_suspend(struct phy_device *phydev)
>  {
>  	struct phy_driver *phydrv = to_phy_driver(phydev->dev.driver);
> -	struct ethtool_wolinfo wol;
> +	struct ethtool_wolinfo wol = { .cmd = ETHTOOL_GWOL };
>  
>  	/* If the device has WOL enabled, we cannot suspend the PHY */
> -	wol.cmd = ETHTOOL_GWOL;
>  	phy_ethtool_get_wol(phydev, &wol);
>  	if (wol.wolopts)
>  		return -EBUSY;

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140314/41d4409e/attachment.sig>
