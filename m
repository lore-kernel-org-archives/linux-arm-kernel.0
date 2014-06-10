From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Jun 2014 21:15:14 +0200
Subject: [RFC PATCH] dma: at_xdmac: creation of the atmel eXtended DMA
 Controller driver
In-Reply-To: <20140610154118.GA4254@lukather>
References: <1401179736-8235-1-git-send-email-ludovic.desroches@atmel.com>
 <20140610154118.GA4254@lukather>
Message-ID: <6544148.4RKn2Y8vCE@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 27, 2014 at 10:35:36AM +0200, Ludovic Desroches wrote:
> +static struct dma_chan *at_xdmac_xlate(struct of_phandle_args *dma_spec,
> +                                    struct of_dma *of_dma)
> +{
> +     struct at_xdmac_chan    *atchan;
> +     struct dma_chan         *chan;
> +     dma_cap_mask_t          mask;
> +     struct platform_device  *pdev = of_find_device_by_node(dma_spec->np);

No need to search through all the device nodes, you can look up the
device from of_dma->of_dma_data.

> +     if (dma_spec->args_count != 2) {
> +             dev_err(&pdev->dev, "dma phandler args: bad number of args\n");
> +             return NULL;
> +     }
> +
> +     dma_cap_zero(mask);
> +     dma_cap_set(DMA_SLAVE, mask);
> +     chan = dma_request_channel(mask, NULL, NULL);
> +     if (!chan) {
> +             dev_err(&pdev->dev, "can't get a dma channel\n");
> +             return NULL;
> +     }

You must use dma_get_any_slave_channel. dma_request_channel gives you a
channel from a random dma engine that is present in the system, not
necessarily the one you are managing here.

	Arnd
