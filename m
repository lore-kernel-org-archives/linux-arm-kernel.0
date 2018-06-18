From: joe@perches.com (Joe Perches)
Date: Mon, 18 Jun 2018 09:03:26 -0700
Subject: [PATCH 2/5] net: emaclite: Balance braces in else statement
In-Reply-To: <1529322610-27215-3-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1529322610-27215-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1529322610-27215-3-git-send-email-radhey.shyam.pandey@xilinx.com>
Message-ID: <644296b273a76469baf641dd712c7a5451cd34fe.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2018-06-18 at 17:20 +0530, Radhey Shyam Pandey wrote:
> Remove else as it is not required with if doing a return.
> Fixes below checkpatch warning.

> WARNING: else is not generally useful after a break or return

checkpatch is stupid and doesn't understand code flow.
Always try to improve code flow instead of merely
following brainless instructions from a script.

So:

> diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
[]
> @@ -569,13 +569,11 @@ static void xemaclite_tx_handler(struct net_device *dev)
>  					(u8 *) lp->deferred_skb->data,
>  					lp->deferred_skb->len) != 0)
>  			return;
> -		else {
> -			dev->stats.tx_bytes += lp->deferred_skb->len;
> -			dev_kfree_skb_irq(lp->deferred_skb);
> -			lp->deferred_skb = NULL;
> -			netif_trans_update(dev); /* prevent tx timeout */
> -			netif_wake_queue(dev);
> -		}
> +		dev->stats.tx_bytes += lp->deferred_skb->len;
> +		dev_kfree_skb_irq(lp->deferred_skb);
> +		lp->deferred_skb = NULL;
> +		netif_trans_update(dev); /* prevent tx timeout */
> +		netif_wake_queue(dev);
>  	}
>  }

If you really want to redo this function, perhaps something like:

static void xemaclite_tx_handler(struct net_device *dev)
{
	struct net_local *lp = netdev_priv(dev);

	dev->stats.tx_packets++;

	if (!lp->deferred_skb)
		return;

	if (xemaclite_send_data(lp, (u8 *)lp->deferred_skb->data,
				lp->deferred_skb->len))
		return;

	dev->stats.tx_bytes += lp->deferred_skb->len;
	dev_kfree_skb_irq(lp->deferred_skb);
	lp->deferred_skb = NULL;
	netif_trans_update(dev); /* prevent tx timeout */
	netif_wake_queue(dev);
}
 
> @@ -1052,13 +1050,13 @@ static bool get_bool(struct platform_device *ofdev, const char *s)
>  {
>  	u32 *p = (u32 *)of_get_property(ofdev->dev.of_node, s, NULL);
>  
> -	if (p) {
> +	if (p)
>  		return (bool)*p;
> -	} else {
> -		dev_warn(&ofdev->dev, "Parameter %s not found,"
> +
> +	dev_warn(&ofdev->dev, "Parameter %s not found,"
>  			"defaulting to false\n", s);
> -		return false;
> -	}
> +
> +	return false;
>  }

And this function has backward logic as the failure paths
are the ones that should return early or use a goto.

Perhaps something like:

static bool get_bool(struct platform_device *ofdev, const char *s)
{
	u32 *p = (u32 *)of_get_property(ofdev->dev.of_node, s, NULL);

	if (!p) {
		dev_warn(&ofdev->dev,
			 "Parameter '%s' not found, defaulting to false\n", s);
		return false;
	}

	return *p;
}
