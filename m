From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Thu, 24 Jan 2013 10:56:53 -0700
Subject: [PATCH v2 1/1 net-next] net: fec: add napi support to improve
 proformance
In-Reply-To: <1359014309-8636-1-git-send-email-Frank.Li@freescale.com>
References: <1359014309-8636-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <510175E5.4000306@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/24/2013 12:58 AM, Frank Li wrote:
> diff --git a/drivers/net/ethernet/freescale/fec.c b/drivers/net/ethernet/freescale/fec.c
> index f52ba33..39be2ab 100644
> --- a/drivers/net/ethernet/freescale/fec.c
> +++ b/drivers/net/ethernet/freescale/fec.c
> @@ -67,6 +67,7 @@
>   #endif
>   
>   #define DRIVER_NAME	"fec"
> +#define FEC_NAPI_WEIGHT	64
>   
>   /* Pause frame feild and FIFO threshold */
>   #define FEC_ENET_FCE	(1 << 5)
> @@ -565,6 +566,20 @@ fec_timeout(struct net_device *ndev)
>   }
>   
>   static void
> +fec_enet_rx_int_is_enabled(struct net_device *ndev, bool enabled)
> +{
> +	struct fec_enet_private *fep = netdev_priv(ndev);
> +	uint    int_events;
> +
> +	int_events = readl(fep->hwp + FEC_IMASK);
> +	if (enabled)
> +		int_events |= FEC_ENET_RXF;
> +	else
> +		int_events &= ~FEC_ENET_RXF;
> +	writel(int_events, fep->hwp + FEC_IMASK);
> +}

fec_enet_rx_int_is_enabled looks like a question.
fec_enet_rx_int_enable would be a better name
