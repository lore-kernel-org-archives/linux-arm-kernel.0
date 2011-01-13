From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 13 Jan 2011 22:06:00 +0100
Subject: [PATCH v4 05/10] net/fec: add dual fec support for mx28
In-Reply-To: <1294297998-26930-6-git-send-email-shawn.guo@freescale.com>
References: <1294297998-26930-1-git-send-email-shawn.guo@freescale.com>
	<1294297998-26930-6-git-send-email-shawn.guo@freescale.com>
Message-ID: <20110113210600.GY24920@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello again,

On Thu, Jan 06, 2011 at 03:13:13PM +0800, Shawn Guo wrote:
>  static netdev_tx_t
>  fec_enet_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  {
>  	struct fec_enet_private *fep = netdev_priv(dev);
> +	const struct platform_device_id *id_entry =
> +				platform_get_device_id(fep->pdev);
>  	struct bufdesc *bdp;
>  	void *bufaddr;
>  	unsigned short	status;
> @@ -256,6 +288,14 @@ fec_enet_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  		bufaddr = fep->tx_bounce[index];
>  	}
>  
> +	/*
> +	 * Some design made an incorrect assumption on endian mode of
> +	 * the system that it's running on. As the result, driver has to
> +	 * swap every frame going to and coming from the controller.
> +	 */
> +	if (id_entry->driver_data & FEC_QUIRK_SWAP_FRAME)
> +		swap_buffer(bufaddr, skb->len);
> +
Is that save here?  bufaddr either points to a bounce buffer (which
should be OK definitely) or skb->data.  Or asked differently:  Is the
skb here owned by the driver such that it is allowed to write to it?
Does the driver eventually need to restore the original data?

Just before this if, there is some bounce buffer handling.  If it is not
OK to modify skb->data, the call to swap_buffer can easily be moved in
there.

>  	/* Save skb pointer */
>  	fep->tx_skbuff[fep->skb_cur] = skb;
>  
> @@ -424,6 +464,8 @@ static void
>  fec_enet_rx(struct net_device *dev)
>  {
>  	struct	fec_enet_private *fep = netdev_priv(dev);
> +	const struct platform_device_id *id_entry =
> +				platform_get_device_id(fep->pdev);
>  	struct bufdesc *bdp;
>  	unsigned short status;
>  	struct	sk_buff	*skb;
> @@ -487,6 +529,9 @@ fec_enet_rx(struct net_device *dev)
>  	        dma_unmap_single(NULL, bdp->cbd_bufaddr, bdp->cbd_datlen,
>          			DMA_FROM_DEVICE);
>  
> +		if (id_entry->driver_data & FEC_QUIRK_SWAP_FRAME)
> +			swap_buffer(data, pkt_len);
> +
Here I guess it's OK, the hardware just wrote to the buffer, so the skb
cannot be shared to anything else and the write is all right.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
