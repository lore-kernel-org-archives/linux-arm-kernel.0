From: ben@decadent.org.uk (Ben Hutchings)
Date: Mon, 10 Mar 2014 02:51:33 +0000
Subject: [PATCH] net: phy: fix uninitalized WOL parameters in
 phy_ethtool_get_wol
In-Reply-To: <1394413270-7169-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1394413270-7169-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1394419893.15968.88.camel@deadeye.wl.decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-03-10 at 02:01 +0100, Sebastian Hesselbarth wrote:
> phy_ethtool_get_wol is a helper to get current WOL settings from
> a phy device. When using this helper on a PHY without .get_wol
> callback, struct ethtool_wolinfo is never set-up correctly and
> may contain misleading information about WOL status.
> 
> To fix this, always zero relevant fields of struct ethtool_wolinfo
> regardless of .get_wol callback availability.

I think it's the caller's responsibility to zero out struct
ethtool_wolinfo.  That is what ethtool_get_wol() does.

Maybe you could split ethtool_get_wol() like we did
ethtool_get_settings(), to support in-kernel invocation of ETHTOOL_GWOL?

Ben.

> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Cc: David Miller <davem@davemloft.net>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: netdev at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  drivers/net/phy/phy.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index 19c9eca0ef26..62a7cd401e1c 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c
> @@ -1092,6 +1092,7 @@ EXPORT_SYMBOL(phy_ethtool_set_wol);
>  
>  void phy_ethtool_get_wol(struct phy_device *phydev, struct ethtool_wolinfo *wol)
>  {
> +	wol->supported = wol->wolopts = 0;
>  	if (phydev->drv->get_wol)
>  		phydev->drv->get_wol(phydev, wol);
>  }

-- 
Ben Hutchings
Computers are not intelligent.	They only think they are.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 811 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140310/77d8477a/attachment.sig>
