From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 25 Oct 2016 20:38:24 +0300
Subject: [PATCH 3/4] usb: musb: da8xx: Add DT support for the DA8xx driver
In-Reply-To: <1477406345-27192-4-git-send-email-abailon@baylibre.com>
References: <1477406345-27192-1-git-send-email-abailon@baylibre.com>
 <1477406345-27192-4-git-send-email-abailon@baylibre.com>
Message-ID: <82a39c63-8486-de00-3a0f-8d9d267b6404@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 10/25/2016 05:39 PM, Alexandre Bailon wrote:

> From: Petr Kulhavy <petr@barix.com>
>
> This adds DT support for TI DA8xx/OMAP-L1x/AM17xx/AM18xx MUSB driver
>
> Signed-off-by: Petr Kulhavy <petr@barix.com>
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> ---
>  drivers/usb/musb/da8xx.c | 76 ++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 67 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c
> index 210b7e4..d465087 100644
> --- a/drivers/usb/musb/da8xx.c
> +++ b/drivers/usb/musb/da8xx.c
> @@ -6,6 +6,9 @@
>   * Based on the DaVinci "glue layer" code.
>   * Copyright (C) 2005-2006 by Texas Instruments
>   *
> + * DT support
> + * Copyright (c) 2016 Petr Kulhavy <petr@barix.com>
> + *
>   * This file is part of the Inventra Controller Driver for Linux.
>   *
>   * The Inventra Controller Driver for Linux is free software; you
[...]
> @@ -499,15 +537,21 @@ static int da8xx_probe(struct platform_device *pdev)
>  	memset(musb_resources, 0x00, sizeof(*musb_resources) *
>  			ARRAY_SIZE(musb_resources));
>
> -	musb_resources[0].name = pdev->resource[0].name;
> -	musb_resources[0].start = pdev->resource[0].start;
> -	musb_resources[0].end = pdev->resource[0].end;
> -	musb_resources[0].flags = pdev->resource[0].flags;
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "failed to get memory.\n");
> +		ret = -EINVAL;
> +		goto err_unregister_usb_phy;
> +	}
> +	musb_resources[0] = *res;

    What does this change have to do with the DT conversion?

>
> -	musb_resources[1].name = pdev->resource[1].name;
> -	musb_resources[1].start = pdev->resource[1].start;
> -	musb_resources[1].end = pdev->resource[1].end;
> -	musb_resources[1].flags = pdev->resource[1].flags;
> +	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "failed to get irq.\n");
> +		ret = -EINVAL;
> +		goto err_unregister_usb_phy;
> +	}
> +	musb_resources[1] = *res;

    And this?
    I'm also concerned that you'd copy the resource linkage fields which the 
existing code avoids...

[...]

MBR, Sergei
