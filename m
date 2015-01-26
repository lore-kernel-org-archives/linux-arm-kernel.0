From: afaerber@suse.de (=?ISO-8859-15?Q?Andreas_F=E4rber?=)
Date: Mon, 26 Jan 2015 04:01:59 +0100
Subject: [PATCH v1 2/2] net: stmmac: add fixed_phy support via fixed-link
 DT binding
In-Reply-To: <1422239858-3452-3-git-send-email-ming.lei@canonical.com>
References: <1422239858-3452-1-git-send-email-ming.lei@canonical.com>
 <1422239858-3452-3-git-send-email-ming.lei@canonical.com>
Message-ID: <54C5AE27.4080206@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 26.01.2015 um 03:37 schrieb Ming Lei:
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 8c6b7c16..ddb4351 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -847,8 +847,11 @@ static int stmmac_init_phy(struct net_device *dev)
>  	 * 0 rather than 0xffff. Catch this here and treat 0 as a non-existent
>  	 * device as well.
>  	 * Note: phydev->phy_id is the result of reading the UID PHY registers.
> +	 * But phy_id returned from fixed phy is always zero, so bypass the
> +	 * check for fixed phy.
>  	 */
> -	if (phydev->phy_id == 0) {
> +	if (phydev->phy_id == 0 && (!priv->plat->phy_bus_name ||
> +			strcmp(priv->plat->phy_bus_name,"fixed"))) {

Small nit here: There's a space missing between the arguments.

Cheers,
Andreas

>  		phy_disconnect(phydev);
>  		return -ENODEV;
>  	}
[snip]

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Jennifer Guild, Dilip Upmanyu,
Graham Norton; HRB 21284 (AG N?rnberg)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150126/4315fdde/attachment.sig>
