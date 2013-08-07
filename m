From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 7 Aug 2013 17:59:03 +0200
Subject: [PATCH 09/20] ata: pdata_pxa: migrate over to dmaengine usage
In-Reply-To: <1375889649-14638-10-git-send-email-zonque@gmail.com>
References: <1375889649-14638-1-git-send-email-zonque@gmail.com>
 <1375889649-14638-10-git-send-email-zonque@gmail.com>
Message-ID: <201308071759.03838.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 August 2013, Daniel Mack wrote:
> +       dma_cap_zero(mask);
> +       dma_cap_set(DMA_SLAVE, mask);
> +
> +       data->dma_channel =
> +               dma_request_slave_channel_compat(mask, mmp_pdma_filter_fn,
> +                                                &pdata->dma_dreq, &pdev->dev,
> +                                                "data");
> +       if (data->dma_channel == NULL)
>                 return -EBUSY;

Here and in other drivers, you hardwire the mmp_pdma_filter_fn pointer, which creates
an explicit module dependency to the dmaengine driver, which should not be there
when booting with DT.

You can avoid that by open-coding the dma_request_slave_channel_compat() function:

	data->dma_channel = dma_request_slave_channel(&pdev->dev, "data");
	if (IS_ENABLED(CONFIG_ATAGS) && !data->dma_channel && pdata)
		data->dma_channel = dma_request_channel(mask, mmp_pdma_filter_fn,
						&pdata->dma_dreq);

	Arnd
