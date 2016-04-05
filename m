From: stefan@agner.ch (Stefan Agner)
Date: Mon, 04 Apr 2016 22:01:12 -0700
Subject: [PATCH v5 1/2] serial: fsl_lpuart: Add DMA quirk
In-Reply-To: <1459806792-7729-2-git-send-email-andrew@lunn.ch>
References: <1459806792-7729-1-git-send-email-andrew@lunn.ch>
 <1459806792-7729-2-git-send-email-andrew@lunn.ch>
Message-ID: <3b2da30d16238b852b3792b1c62cea23@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-04-04 14:53, Andrew Lunn wrote:
> Using DMA with the vf610 and other Vybrid devices results in a corrupt
> serial stream. Add a quirk to disable the use of DMA.
> 
> Refactor the existing code to add a 32 bit access quirk for the
> fsl,ls1021a-lpuart.

Hi Andrew,

[also added Greg and Jiri, maintainers of the tty subsystem]

Well, I am not sure if that is the right approach. Quirks are usually
used to hint to issues in the hardware. However, in this case we deal
with (a) software issue(s)...

At Toradex we were carry a patch which disabled DMA by default using a
module parameter:
http://git.toradex.com/cgit/linux-toradex.git/commit/?h=toradex_vf_4.4-next&id=f5baad61b77dd4b0ac0c7beeee284e12d49ba442

This allowed to re-enable the DMA easily for testing... Not sure if that
is the better approach.

However, we are working on a re-implementation of the DMA modes, I hope
we can post some patches soon.

IMHO we can just omit adding such a disable work around, people lived
with the current situation since 3.13, one more release probably doesn't
really matter... :-)

--
Stefan


> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/tty/serial/fsl_lpuart.c | 36 ++++++++++++++++++++++++++----------
>  1 file changed, 26 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index 3d790033744e..8d2f67b93e1f 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -257,12 +257,17 @@ struct lpuart_port {
>  	struct timer_list	lpuart_timer;
>  };
>  
> +#define QUIRK_LPUART32		BIT(0)
> +#define QUIRK_NO_DMA		BIT(1)
> +
>  static const struct of_device_id lpuart_dt_ids[] = {
>  	{
>  		.compatible = "fsl,vf610-lpuart",
> +		.data = (void *)QUIRK_NO_DMA,
>  	},
>  	{
>  		.compatible = "fsl,ls1021a-lpuart",
> +		.data = (void *)QUIRK_LPUART32,
>  	},
>  	{ /* sentinel */ }
>  };
> @@ -1803,7 +1808,9 @@ static struct uart_driver lpuart_reg = {
>  static int lpuart_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np = pdev->dev.of_node;
> +	const struct of_device_id *match;
>  	struct lpuart_port *sport;
> +	kernel_ulong_t quirks;
>  	struct resource *res;
>  	int ret;
>  
> @@ -1819,7 +1826,10 @@ static int lpuart_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  	sport->port.line = ret;
> -	sport->lpuart32 = of_device_is_compatible(np, "fsl,ls1021a-lpuart");
> +
> +	match = of_match_node(lpuart_dt_ids, np);
> +	quirks = (kernel_ulong_t)match->data;
> +	sport->lpuart32 = quirks & QUIRK_LPUART32;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	sport->port.membase = devm_ioremap_resource(&pdev->dev, res);
> @@ -1867,15 +1877,21 @@ static int lpuart_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	sport->dma_tx_chan = dma_request_slave_channel(sport->port.dev, "tx");
> -	if (!sport->dma_tx_chan)
> -		dev_info(sport->port.dev, "DMA tx channel request failed, "
> -				"operating without tx DMA\n");
> -
> -	sport->dma_rx_chan = dma_request_slave_channel(sport->port.dev, "rx");
> -	if (!sport->dma_rx_chan)
> -		dev_info(sport->port.dev, "DMA rx channel request failed, "
> -				"operating without rx DMA\n");
> +	if (quirks & QUIRK_NO_DMA) {
> +		dev_info(sport->port.dev, "Not using DMA\n");
> +	} else {
> +		sport->dma_tx_chan = dma_request_slave_channel(
> +			sport->port.dev, "tx");
> +		if (!sport->dma_tx_chan)
> +			dev_info(sport->port.dev,
> +				 "DMA tx channel request failed, operating without tx DMA\n");
> +
> +		sport->dma_rx_chan = dma_request_slave_channel(
> +			sport->port.dev, "rx");
> +		if (!sport->dma_rx_chan)
> +			dev_info(sport->port.dev,
> +				 "DMA rx channel request failed, operating without rx DMA\n");
> +	}
>  
>  	return 0;
>  }
