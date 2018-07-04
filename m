From: ladis@linux-mips.org (Ladislav Michl)
Date: Wed, 4 Jul 2018 09:09:19 +0200
Subject: [PATCH v4 08/18] net: davinci_emac: potentially get the MAC
 address from MTD
In-Reply-To: <03b77e24-9ab9-fa01-2387-9de0408a9942@gmail.com>
References: <20180629094039.7543-1-brgl@bgdev.pl>
 <20180629094039.7543-9-brgl@bgdev.pl>
 <03b77e24-9ab9-fa01-2387-9de0408a9942@gmail.com>
Message-ID: <20180704070919.GA14051@lenoch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 03, 2018 at 09:39:51AM -0700, Florian Fainelli wrote:
> 
> 
> On 06/29/2018 02:40 AM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > 
> > On da850-evm board we can read the MAC address from MTD. It's currently
> > done in the relevant board file, but we want to get rid of all the MAC
> > reading callbacks from the board file (SPI and NAND). Move the reading
> > of the MAC address from SPI to the emac driver's probe function.
> 
> This should be made something generic to all drivers, not just something
> the davinci_emac driver does, something like this actually:
> 
> https://lkml.org/lkml/2018/3/24/312

...and that's would also make it work when MAC address is stored
in 24c08 EEPROM, which is quite common.

> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >  drivers/net/ethernet/ti/davinci_emac.c | 20 ++++++++++++++++++--
> >  1 file changed, 18 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
> > index a1a6445b5a7e..48e6a7755811 100644
> > --- a/drivers/net/ethernet/ti/davinci_emac.c
> > +++ b/drivers/net/ethernet/ti/davinci_emac.c
> > @@ -67,7 +67,7 @@
> >  #include <linux/of_irq.h>
> >  #include <linux/of_net.h>
> >  #include <linux/mfd/syscon.h>
> > -
> > +#include <linux/mtd/mtd.h>
> >  #include <asm/irq.h>
> >  #include <asm/page.h>
> >  
> > @@ -1783,7 +1783,10 @@ static int davinci_emac_probe(struct platform_device *pdev)
> >  	struct cpdma_params dma_params;
> >  	struct clk *emac_clk;
> >  	unsigned long emac_bus_frequency;
> > -
> > +#ifdef CONFIG_MTD
> > +	size_t mac_addr_len;
> > +	struct mtd_info *mtd;
> > +#endif /* CONFIG_MTD */
> >  
> >  	/* obtain emac clock from kernel */
> >  	emac_clk = devm_clk_get(&pdev->dev, NULL);
> > @@ -1815,6 +1818,19 @@ static int davinci_emac_probe(struct platform_device *pdev)
> >  		goto err_free_netdev;
> >  	}
> >  
> > +#ifdef CONFIG_MTD
> > +	mtd = get_mtd_device_nm("MAC-Address");
> > +	if (!IS_ERR(mtd)) {
> > +		rc = mtd_read(mtd, 0, ETH_ALEN,
> > +			      &mac_addr_len, priv->mac_addr);
> > +		if (rc == 0)
> > +			dev_info(&pdev->dev,
> > +				 "Read MAC addr from SPI Flash: %pM\n",
> > +				 priv->mac_addr);
> > +		put_mtd_device(mtd);
> > +	}
> > +#endif /* CONFIG_MTD */
> > +
> >  	/* MAC addr and PHY mask , RMII enable info from platform_data */
> >  	memcpy(priv->mac_addr, pdata->mac_addr, ETH_ALEN);
> >  	priv->phy_id = pdata->phy_id;
> > 
> 
> -- 
> Florian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
