From: florian@openwrt.org (Florian Fainelli)
Date: Thu, 24 Jan 2013 14:11:43 +0100
Subject: [PATCH v2 1/1 net-next] net: fec: add napi support to improve
 proformance
In-Reply-To: <1359014309-8636-1-git-send-email-Frank.Li@freescale.com>
References: <1359014309-8636-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <5101330F.3030702@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/24/2013 08:58 AM, Frank Li wrote:
65,6 +566,20 @@ fec_timeout(struct net_device *ndev)
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

This function is badly named with respect to what it does. A better name 
would be fec_enet_rx_interrupt_set() for instance.
--
Florian
