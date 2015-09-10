From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 10 Sep 2015 10:45:12 +0200
Subject: [PATCH 09/21] ARM: davinci: Add set dma_mask to eDMA devices
In-Reply-To: <1441874270-2399-10-git-send-email-peter.ujfalusi@ti.com>
References: <1441874270-2399-1-git-send-email-peter.ujfalusi@ti.com>
 <1441874270-2399-10-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1510483.LNzviKQJ8l@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 10 September 2015 11:37:38 Peter Ujfalusi wrote:
> +static u64 da8xx_edma0_dmamask = DMA_BIT_MASK(32);
> +
>  static struct platform_device da8xx_edma0_device = {
>         .name           = "edma",
>         .id             = 0,
>         .dev = {
>                 .platform_data = &da8xx_edma0_pdata,
> +               .dma_mask = &da8xx_edma0_dmamask,
> +               .coherent_dma_mask = DMA_BIT_MASK(32),
>         },
>         .num_resources  = ARRAY_SIZE(da8xx_edma0_resources),
>         .resource       = da8xx_edma0_resources,
>  };

While this is technically correct for all I can tell, could you
convert it to use __initconst platform_device_info and
platform_device_register_full() instead?

statically declaring platform_devices has been frowned upon for a long
time (even though a lot of arm platforms still do it), and statically
declaring the dma mask seems worse to me (and yes, I realize we also
do that elsewhere).

	Arnd
