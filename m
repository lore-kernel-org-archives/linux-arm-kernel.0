From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 28 Feb 2013 14:30:27 +0800
Subject: [PATCH v3 1/2] dma: imx-dma: Add oftree support
In-Reply-To: <1361808255-17381-1-git-send-email-mpa@pengutronix.de>
References: <1361543838-12604-1-git-send-email-mpa@pengutronix.de>
 <1361808255-17381-1-git-send-email-mpa@pengutronix.de>
Message-ID: <20130228063026.GC26106@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 25, 2013 at 05:04:14PM +0100, Markus Pargmann wrote:
> Adding devicetree support for imx-dma driver. Use driver name for
> function 'imx_dma_is_general_purpose' because the devicename for
> devicetree initialized devices is different.

...

> @@ -63,7 +66,8 @@ static inline int imx_dma_is_general_purpose(struct dma_chan *chan)
>  	return strstr(dev_name(chan->device->dev), "sdma") ||
>  		!strcmp(dev_name(chan->device->dev), "imx1-dma") ||
>  		!strcmp(dev_name(chan->device->dev), "imx21-dma") ||
> -		!strcmp(dev_name(chan->device->dev), "imx27-dma");
> +		!strcmp(dev_name(chan->device->dev), "imx27-dma") ||
> +		!strcmp(chan->device->dev->driver->name, "imx-dma");
>  }

So the function could just look like the following?

static inline int imx_dma_is_general_purpose(struct dma_chan *chan)
{
        return !strcmp(chan->device->dev->driver->name, "imx-sdma") ||
                !strcmp(chan->device->dev->driver->name, "imx-dma");
}

Shawn
