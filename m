From: nsekhar@ti.com (Sekhar Nori)
Date: Sun, 8 Jul 2012 19:56:47 +0530
Subject: [PATCH v5 4/7] ARM: davinci: net: davinci_emac: add OF support
In-Reply-To: <1338373143-7467-5-git-send-email-hs@denx.de>
References: <1338373143-7467-1-git-send-email-hs@denx.de>
 <1338373143-7467-5-git-send-email-hs@denx.de>
Message-ID: <4FF998A7.50309@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On 5/30/2012 3:49 PM, Heiko Schocher wrote:
> add of support for the davinci_emac driver.
> 
> Signed-off-by: Heiko Schocher <hs@denx.de>
> Cc: davinci-linux-open-source at linux.davincidsp.com
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: devicetree-discuss at lists.ozlabs.org
> Cc: netdev at vger.kernel.org
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Wolfgang Denk <wd@denx.de>
> Cc: Anatoly Sivov <mm05@mail.ru>
> 
> ---

> +#ifdef CONFIG_OF
> +static struct emac_platform_data
> +	*davinci_emac_of_get_pdata(struct platform_device *pdev,
> +	struct emac_priv *priv)
> +{
> +	struct device_node *np;
> +	struct emac_platform_data *pdata = NULL;
> +	const u8 *mac_addr;
> +	u32 data;
> +	int ret;
> +
> +	pdata = pdev->dev.platform_data;
> +	if (!pdata) {
> +		pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
> +		if (!pdata)
> +			goto nodata;
> +	}
> +
> +	np = pdev->dev.of_node;
> +	if (!np)
> +		goto nodata;
> +	else
> +		pdata->version = EMAC_VERSION_2;
> +
> +	mac_addr = of_get_mac_address(np);
> +	if (mac_addr)
> +		memcpy(pdata->mac_addr, mac_addr, ETH_ALEN);

I suspect that even in the DT case, many boards will continue to
read mac address from on-board EEPROMs or from an on-chip eFUSE.
To take care of such cases, I propose use mac address in DT data
only if no valid address is passed through platform data. The
attached patch does this change.

If you are OK with this modification, can you please merge it and
repost just this patch for review? Please CC David Miller
(davem at davemloft.net) on your next post as he is the netdev maintainer
and this patch needs to be merged through him or at least needs his ack.

With this modification, you can add my:

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar

---8<----
diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
index 645618d..6b4b0fe 100644
--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -1795,9 +1795,11 @@ static struct emac_platform_data
 	else
 		pdata->version = EMAC_VERSION_2;
 
-	mac_addr = of_get_mac_address(np);
-	if (mac_addr)
-		memcpy(pdata->mac_addr, mac_addr, ETH_ALEN);
+	if (!is_valid_ether_addr(pdata->mac_addr)) {
+		mac_addr = of_get_mac_address(np);
+		if (mac_addr)
+			memcpy(pdata->mac_addr, mac_addr, ETH_ALEN);
+	}
 
 	ret = of_property_read_u32(np, "ti,davinci-ctrl-reg-offset", &data);
 	if (!ret)
