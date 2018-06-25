From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Mon, 25 Jun 2018 18:09:07 -0500
Subject: [PATCH 07/14] net: davinci_emac: use nvmem to retrieve the mac
 address
In-Reply-To: <20180625155025.12567-8-brgl@bgdev.pl>
References: <20180625155025.12567-1-brgl@bgdev.pl>
 <20180625155025.12567-8-brgl@bgdev.pl>
Message-ID: <590fd122-1c13-8958-7e84-dbc5c5ea65f3@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/25/2018 10:50 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> All users which store the MAC address in EEPROM now register relevant
> nvmem cells. Switch to retrieving the MAC address over the nvmem
> framework.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   drivers/net/ethernet/ti/davinci_emac.c | 29 +++++++++++++++++---------
>   1 file changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
> index a1a6445b5a7e..22c2322e46be 100644
> --- a/drivers/net/ethernet/ti/davinci_emac.c
> +++ b/drivers/net/ethernet/ti/davinci_emac.c
> @@ -67,7 +67,7 @@
>   #include <linux/of_irq.h>
>   #include <linux/of_net.h>
>   #include <linux/mfd/syscon.h>
> -
> +#include <linux/nvmem-consumer.h>
>   #include <asm/irq.h>
>   #include <asm/page.h>
>   
> @@ -1696,7 +1696,6 @@ davinci_emac_of_get_pdata(struct platform_device *pdev, struct emac_priv *priv)
>   	const struct of_device_id *match;
>   	const struct emac_platform_data *auxdata;
>   	struct emac_platform_data *pdata = NULL;
> -	const u8 *mac_addr;
>   
>   	if (!IS_ENABLED(CONFIG_OF) || !pdev->dev.of_node)
>   		return dev_get_platdata(&pdev->dev);
> @@ -1708,12 +1707,6 @@ davinci_emac_of_get_pdata(struct platform_device *pdev, struct emac_priv *priv)
>   	np = pdev->dev.of_node;
>   	pdata->version = EMAC_VERSION_2;
>   
> -	if (!is_valid_ether_addr(pdata->mac_addr)) {
> -		mac_addr = of_get_mac_address(np);
> -		if (mac_addr)
> -			ether_addr_copy(pdata->mac_addr, mac_addr);
> -	}
> -

Not sure it is correct. of_get_mac_address() is called when board data doesn't
provide MAC address with expectation that MAC address is defined in DT (usually by u-boot).
Standard DT properties for MAC address "local-mac-address" and "mac-address".

So, you can't just drop it and replace with nvmem.

Two options are here:
1) try to read MAC-address from nvmem then try DT (as it's now)
2) try to read DT then try nvmem [then random MAC | fail]


>   	of_property_read_u32(np, "ti,davinci-ctrl-reg-offset",
>   			     &pdata->ctrl_reg_offset);
>   
> @@ -1783,7 +1776,9 @@ static int davinci_emac_probe(struct platform_device *pdev)
>   	struct cpdma_params dma_params;
>   	struct clk *emac_clk;
>   	unsigned long emac_bus_frequency;
> -
> +	struct nvmem_cell *cell;
> +	void *mac_addr;
> +	size_t mac_addr_len;
>   
>   	/* obtain emac clock from kernel */
>   	emac_clk = devm_clk_get(&pdev->dev, NULL);
> @@ -1815,8 +1810,22 @@ static int davinci_emac_probe(struct platform_device *pdev)
>   		goto err_free_netdev;
>   	}
>   
> +	cell = nvmem_cell_get(&pdev->dev, "mac-address");
> +	if (!IS_ERR(cell)) {
> +		mac_addr = nvmem_cell_read(cell, &mac_addr_len);
> +		if (!IS_ERR(mac_addr)) {
> +			if (is_valid_ether_addr(mac_addr)) {
> +				dev_info(&pdev->dev,
> +					 "Read MAC addr from EEPROM: %pM\n",
> +					 mac_addr);
> +				memcpy(priv->mac_addr, mac_addr, ETH_ALEN);
> +			}
> +			kfree(mac_addr);
> +		}
> +		nvmem_cell_put(cell);
> +	}
> +
>   	/* MAC addr and PHY mask , RMII enable info from platform_data */
> -	memcpy(priv->mac_addr, pdata->mac_addr, ETH_ALEN);
>   	priv->phy_id = pdata->phy_id;
>   	priv->rmii_en = pdata->rmii_en;
>   	priv->version = pdata->version;
> 

-- 
regards,
-grygorii
