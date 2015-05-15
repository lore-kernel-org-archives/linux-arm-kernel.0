From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 May 2015 13:13:47 +0200
Subject: [PATCH v2] dmaengine: sirf: add CSRatlas7 SoC support
In-Reply-To: <1431684903-11219-1-git-send-email-21cnbao@gmail.com>
References: <1431684903-11219-1-git-send-email-21cnbao@gmail.com>
Message-ID: <2307498.30iKRMPrgR@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 May 2015 10:15:03 Barry Song wrote:
> @@ -658,8 +849,16 @@ static int sirfsoc_dma_probe(struct platform_device *op)
>                 return -ENOMEM;
>         }
>  
> -       if (of_device_is_compatible(dn, "sirf,marco-dmac"))
> -               sdma->is_marco = true;
> +       if (of_device_is_compatible(dn, "sirf,atlas7-dmac")) {
> +               sdma->ip_ver = SIRFSOC_DMA_VER_A7V1;
> +               sdma->exec_desc = sirfsoc_dma_execute_hw_a7v1;
> +       } else if (of_device_is_compatible(dn, "sirf,atlas7-dmac-v2")) {
> +               sdma->ip_ver = SIRFSOC_DMA_VER_A7V2;
> +               sdma->exec_desc = sirfsoc_dma_execute_hw_a7v2;
> +       } else {
> +               sdma->ip_ver = SIRFSOC_DMA_VER_A6;
> +               sdma->exec_desc = sirfsoc_dma_execute_hw_a6;
> +       }
>  
>         if (of_property_read_u32(dn, "cell-index", &id)) {
>                 dev_err(dev, "Fail to get DMAC index\n");

Please send a separate patch for the removal of the marco support, it's
always better to keep those things separate.

When you have noticeable differences like this, use the data field of
the sirfsoc_dma_match[] array to pass a structure with the differences,
to avoid the chain of 'of_device_is_compatible' calls. You can use

	data = of_match_device(dev->driver->of_match_table, dev)->data;

to get that pointer from the probe function.

	Arnd
