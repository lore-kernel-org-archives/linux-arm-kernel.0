From: david@lechnology.com (David Lechner)
Date: Fri, 29 Jun 2018 15:09:34 -0500
Subject: [PATCH v4 08/18] net: davinci_emac: potentially get the MAC
 address from MTD
In-Reply-To: <20180629094039.7543-9-brgl@bgdev.pl>
References: <20180629094039.7543-1-brgl@bgdev.pl>
 <20180629094039.7543-9-brgl@bgdev.pl>
Message-ID: <e2579b81-7c66-8be6-fcad-ab7a3a5b0765@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/29/2018 04:40 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> On da850-evm board we can read the MAC address from MTD. It's currently
> done in the relevant board file, but we want to get rid of all the MAC
> reading callbacks from the board file (SPI and NAND). Move the reading
> of the MAC address from SPI to the emac driver's probe function.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   drivers/net/ethernet/ti/davinci_emac.c | 20 ++++++++++++++++++--
>   1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
> index a1a6445b5a7e..48e6a7755811 100644
> --- a/drivers/net/ethernet/ti/davinci_emac.c
> +++ b/drivers/net/ethernet/ti/davinci_emac.c
> @@ -67,7 +67,7 @@
>   #include <linux/of_irq.h>
>   #include <linux/of_net.h>
>   #include <linux/mfd/syscon.h>
> -
> +#include <linux/mtd/mtd.h>
>   #include <asm/irq.h>
>   #include <asm/page.h>
>   
> @@ -1783,7 +1783,10 @@ static int davinci_emac_probe(struct platform_device *pdev)
>   	struct cpdma_params dma_params;
>   	struct clk *emac_clk;
>   	unsigned long emac_bus_frequency;
> -
> +#ifdef CONFIG_MTD
> +	size_t mac_addr_len;
> +	struct mtd_info *mtd;
> +#endif /* CONFIG_MTD */
>   
>   	/* obtain emac clock from kernel */
>   	emac_clk = devm_clk_get(&pdev->dev, NULL);
> @@ -1815,6 +1818,19 @@ static int davinci_emac_probe(struct platform_device *pdev)
>   		goto err_free_netdev;
>   	}
>   
> +#ifdef CONFIG_MTD

What about the case when MTD is compiled as a module?

> +	mtd = get_mtd_device_nm("MAC-Address");

What about the case when PTR_ERR(mtd) == -EPROBE_DEFER?

> +	if (!IS_ERR(mtd)) {
> +		rc = mtd_read(mtd, 0, ETH_ALEN,
> +			      &mac_addr_len, priv->mac_addr);
> +		if (rc == 0)
> +			dev_info(&pdev->dev,
> +				 "Read MAC addr from SPI Flash: %pM\n",
> +				 priv->mac_addr);
> +		put_mtd_device(mtd);
> +	}
> +#endif /* CONFIG_MTD */
> +
>   	/* MAC addr and PHY mask , RMII enable info from platform_data */
>   	memcpy(priv->mac_addr, pdata->mac_addr, ETH_ALEN);
>   	priv->phy_id = pdata->phy_id;
> 
