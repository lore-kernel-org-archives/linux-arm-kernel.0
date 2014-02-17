From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 17 Feb 2014 10:37:07 +0100
Subject: [PATCH] can: xilinx CAN controller support.
In-Reply-To: <93c7272e-d8bf-43af-b39b-aaa0e0b70b6f@TX2EHSMHS036.ehs.local>
References: <93c7272e-d8bf-43af-b39b-aaa0e0b70b6f@TX2EHSMHS036.ehs.local>
Message-ID: <5301D843.2080203@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/17/2014 10:23 AM, Kedareswara rao Appana wrote:
> This patch adds xilinx CAN controller support.
> This driver supports both ZYNQ CANPS and Soft IP
> AXI CAN controller.

I just had a quick look at the driver:

[...]

> +/**
> + * xcan_tx_interrupt - Tx Done Isr
> + * @ndev:	net_device pointer
> + */
> +static void xcan_tx_interrupt(struct net_device *ndev)
> +{
> +	struct xcan_priv *priv = netdev_priv(ndev);
> +	struct net_device_stats *stats = &ndev->stats;
> +
> +	stats->tx_packets++;
> +	while (priv->tx_head - priv->tx_tail > 0) {

Note, there might be still CAN frames in the TX FIFO that have not been
transmitted yet. You have to check your hardware! What to do depends on
how you FIFO is organized.

> +		can_get_echo_skb(ndev, priv->tx_tail %
> +					priv->xcan_echo_skb_max_tx);
> +		priv->tx_tail++;
> +	}
> +
> +	netif_wake_queue(ndev);
> +	can_led_event(ndev, CAN_LED_EVENT_TX);
> +}

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 242 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140217/0df7ed29/attachment.sig>
