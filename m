From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 13 Nov 2014 11:10:10 +0100
Subject: [PATCH V4 2/3] can: m_can: update to support CAN FD features
In-Reply-To: <1415349914-9145-2-git-send-email-b29396@freescale.com>
References: <1415349914-9145-1-git-send-email-b29396@freescale.com>
 <1415349914-9145-2-git-send-email-b29396@freescale.com>
Message-ID: <54648382.9080105@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/07/2014 09:45 AM, Dong Aisheng wrote:
> Bosch M_CAN is CAN FD capable device. This patch implements the CAN
> FD features include up to 64 bytes payload and bitrate switch function.
> 1) Change the Rx FIFO and Tx Buffer to 64 bytes for support CAN FD
>    up to 64 bytes payload. It's backward compatible with old 8 bytes
>    normal CAN frame.
> 2) Allocate can frame or canfd frame based on EDL bit
> 3) Bitrate Switch function is disabled by default and will be enabled
>    according to CANFD_BRS bit in cf->flags.
> 
> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Signed-off-by: Dong Aisheng <b29396@freescale.com>

[...]

> -static void m_can_read_fifo(const struct net_device *dev, struct can_frame *cf,
> -			    u32 rxfs)
> +static void m_can_read_fifo(struct net_device *dev, u32 rxfs)
>  {
> +	struct net_device_stats *stats = &dev->stats;
>  	struct m_can_priv *priv = netdev_priv(dev);
> -	u32 id, fgi;
> +	struct canfd_frame *cf;
> +	struct sk_buff *skb;
> +	u32 id, fgi, dlc;
> +	int i;
>  
>  	/* calculate the fifo get index for where to read data */
>  	fgi = (rxfs & RXFS_FGI_MASK) >> RXFS_FGI_OFF;
> +	dlc = m_can_fifo_read(priv, fgi, M_CAN_FIFO_DLC);
> +	if (dlc & RX_BUF_EDL)
> +		skb = alloc_canfd_skb(dev, &cf);
> +	else
> +		skb = alloc_can_skb(dev, (struct can_frame **)&cf);
> +	if (!skb) {
> +		stats->rx_dropped++;
> +		return;
> +	}
> +
>  	id = m_can_fifo_read(priv, fgi, M_CAN_FIFO_ID);
>  	if (id & RX_BUF_XTD)
>  		cf->can_id = (id & CAN_EFF_MASK) | CAN_EFF_FLAG;
>  	else
>  		cf->can_id = (id >> 18) & CAN_SFF_MASK;
>  
> -	if (id & RX_BUF_RTR) {
> +	if (id & RX_BUF_ESI) {
> +		cf->flags |= CANFD_ESI;
> +		netdev_dbg(dev, "ESI Error\n");
> +	}
> +
> +	if (!(dlc & RX_BUF_EDL) && (id & RX_BUF_RTR)) {
>  		cf->can_id |= CAN_RTR_FLAG;

I just noticed, that you don't set the cf->dlc (or cf->len) in the RTR
case. Please create a separate patch that fixes this problem.

>  	} else {
>  		id = m_can_fifo_read(priv, fgi, M_CAN_FIFO_DLC);
> -		cf->can_dlc = get_can_dlc((id >> 16) & 0x0F);
> -		*(u32 *)(cf->data + 0) = m_can_fifo_read(priv, fgi,
> -							 M_CAN_FIFO_DATA(0));
> -		*(u32 *)(cf->data + 4) = m_can_fifo_read(priv, fgi,
> -							 M_CAN_FIFO_DATA(1));
> +		if (dlc & RX_BUF_EDL)
> +			cf->len = can_dlc2len((id >> 16) & 0x0F);
> +		else
> +			cf->len = get_can_dlc((id >> 16) & 0x0F);
> +
> +		if (id & RX_BUF_BRS)
> +			cf->flags |= CANFD_BRS;
> +
> +		for (i = 0; i < cf->len; i += 4)
> +			*(u32 *)(cf->data + i) =
> +				m_can_fifo_read(priv, fgi,
> +						M_CAN_FIFO_DATA(i / 4));
>  	}
>  
>  	/* acknowledge rx fifo 0 */
>  	m_can_write(priv, M_CAN_RXF0A, fgi);
> +
> +	stats->rx_packets++;
> +	stats->rx_bytes += cf->len;
> +
> +	netif_receive_skb(skb);
>  }

Regards,
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
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141113/de63afbb/attachment.sig>
