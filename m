From: peter.p.waskiewicz.jr@intel.com (Waskiewicz Jr, Peter P)
Date: Thu, 24 Jan 2013 20:33:13 -0800
Subject: [PATCH v3 1/1 net-next] net: fec: add napi support to improve
 proformance
In-Reply-To: <1359077343-8271-1-git-send-email-Frank.Li@freescale.com>
References: <1359077343-8271-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <20130125043311.GA4141@ppwaskie-mobl2.amr.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 25, 2013 at 09:29:03AM +0800, Frank Li wrote:

[...]

>  static void
> +fec_enet_rx_int_enable(struct net_device *ndev, bool enabled)
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

You hold your hw_lock when this is called to disable the interrupt, but
not when you re-enable it.  See below.

[...]

> @@ -813,7 +831,14 @@ fec_enet_interrupt(int irq, void *dev_id)
>  
>  		if (int_events & FEC_ENET_RXF) {
>  			ret = IRQ_HANDLED;
> -			fec_enet_rx(ndev);
> +
> +			spin_lock(&fep->hw_lock);
> +			/* Disable the RX interrupt */
> +			if (napi_schedule_prep(&fep->napi)) {
> +				fec_enet_rx_int_enable(ndev, false);
> +				__napi_schedule(&fep->napi);
> +			}
> +			spin_unlock(&fep->hw_lock);
>  		}
>  
>  		/* Transmit OK, or non-fatal error. Update the buffer
> @@ -834,7 +859,16 @@ fec_enet_interrupt(int irq, void *dev_id)
>  	return ret;
>  }
>  
> -
> +static int fec_enet_rx_napi(struct napi_struct *napi, int budget)
> +{
> +	struct net_device *ndev = napi->dev;
> +	int pkgs = fec_enet_rx(ndev, budget);
> +	if (pkgs < budget) {
> +		napi_complete(napi);
> +		fec_enet_rx_int_enable(ndev, true);

Here you're not locking when re-enabling, but you do in the disable path.

Also, when you're disabling interrupts above, you're doing that in your
HW interrupt handler, you should be using spin_lock_irqsave()/irq_restore().

Cheers,
-PJ
