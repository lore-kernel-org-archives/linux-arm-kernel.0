From: jon-hunter@ti.com (Jon Hunter)
Date: Wed, 8 Jun 2011 15:39:04 -0500
Subject: [PATCH v3 04/12] Serial: OMAP: Add runtime pm support for
	omap-serial driver
In-Reply-To: <1307532194-13039-5-git-send-email-govindraj.raja@ti.com>
References: <1307532194-13039-1-git-send-email-govindraj.raja@ti.com>
	<1307532194-13039-5-git-send-email-govindraj.raja@ti.com>
Message-ID: <4DEFDDE8.3090808@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Govindraj,

On 6/8/2011 6:23 AM, Govindraj.R wrote:

[snip]

> +
> +#define OMAP_UART_AUTOSUSPEND_DELAY (30 * HZ) /* Value is msecs */

[snip]

> @@ -1295,18 +1381,36 @@ static int serial_omap_probe(struct platform_device *pdev)
>   		up->uart_dma.rx_dma_channel = OMAP_UART_DMA_CH_FREE;
>   	}
>
> +	pm_runtime_use_autosuspend(&pdev->dev);
> +	pm_runtime_set_autosuspend_delay(&pdev->dev,
> +			OMAP_UART_AUTOSUSPEND_DELAY);

Something is weird here...DEFAULT_AUTOSUSPEND_DELAY is defined as 
(30*HZ) which would appear to be jiffies (ticks per second) and NOT 
msecs. However, pm_runtime_set_autosuspend is clearly expecting msecs. 
So this seems to conflict. By default 30*HZ for omap would be 30*128 = 
3840ms so not quite 4 seconds.

What were you intending here?

Cheers
Jon
