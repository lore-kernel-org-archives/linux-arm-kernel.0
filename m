From: fugang.duan@nxp.com (Fugang Duan)
Date: Wed, 2 Mar 2016 15:01:34 +0000
Subject: [PATCH net-next V2 02/16] net: fec: pass rxq to fec_enet_rx_queue
 instead of queue_id
In-Reply-To: <1456360619-24390-3-git-send-email-troy.kisky@boundarydevices.com>
References: <1456360619-24390-1-git-send-email-troy.kisky@boundarydevices.com>
 <1456360619-24390-3-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <VI1PR0401MB18551D7754A6D2EC350E1D9BFFBC0@VI1PR0401MB1855.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Troy Kisky <troy.kisky@boundarydevices.com> Sent: Thursday, February 25, 2016 8:37 AM
> To: netdev at vger.kernel.org; davem at davemloft.net; b38611 at freescale.com
> Cc: fabio.estevam at freescale.com; l.stach at pengutronix.de; andrew at lunn.ch;
> tremyfr at gmail.com; linux at arm.linux.org.uk; linux-arm-
> kernel at lists.infradead.org; laci at boundarydevices.com; shawnguo at kernel.org;
> johannes at sipsolutions.net; stillcompiling at gmail.com;
> sergei.shtylyov at cogentembedded.com; arnd at arndb.de; Troy Kisky
> <troy.kisky@boundarydevices.com>
> Subject: [PATCH net-next V2 02/16] net: fec: pass rxq to fec_enet_rx_queue
> instead of queue_id
> 
> The queue_id is the qid member of struct bufdesc_prop.
> 
> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> ---
>  drivers/net/ethernet/freescale/fec_main.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fec_main.c
> b/drivers/net/ethernet/freescale/fec_main.c
> index dbac975..9619b9e 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -1328,11 +1328,9 @@ static bool fec_enet_copybreak(struct net_device
> *ndev, struct sk_buff **skb,
>   * not been given to the system, we just set the empty indicator,
>   * effectively tossing the packet.
>   */
> -static int
> -fec_enet_rx_queue(struct net_device *ndev, int budget, u16 queue_id)
> +static int fec_rxq(struct net_device *ndev, struct fec_enet_private *fep,
> +		   struct fec_enet_priv_rx_q *rxq, int budget)
>  {
> -	struct fec_enet_private *fep = netdev_priv(ndev);
> -	struct fec_enet_priv_rx_q *rxq;
>  	struct bufdesc *bdp;
>  	unsigned short status;
>  	struct  sk_buff *skb_new = NULL;
> @@ -1350,8 +1348,6 @@ fec_enet_rx_queue(struct net_device *ndev, int
> budget, u16 queue_id)  #ifdef CONFIG_M532x
>  	flush_cache_all();
>  #endif
> -	queue_id = FEC_ENET_GET_QUQUE(queue_id);
> -	rxq = fep->rx_queue[queue_id];
> 
>  	/* First, grab all of the stats for the incoming packet.
>  	 * These get messed up if we get called due to a busy condition.
> @@ -1519,11 +1515,12 @@ fec_enet_rx(struct net_device *ndev, int budget)
>  	int     pkt_received = 0;
>  	u16	queue_id;
>  	struct fec_enet_private *fep = netdev_priv(ndev);
> +	struct fec_enet_priv_rx_q *rxq;
> 
>  	for_each_set_bit(queue_id, &fep->work_rx, FEC_ENET_MAX_RX_QS)
> {
>  		clear_bit(queue_id, &fep->work_rx);
> -		pkt_received += fec_enet_rx_queue(ndev,
> -					budget - pkt_received, queue_id);
> +		rxq = fep->rx_queue[FEC_ENET_GET_QUQUE(queue_id)];
> +		pkt_received += fec_rxq(ndev, fep, rxq, budget -
> pkt_received);
>  	}
>  	return pkt_received;
>  }
> --
> 2.5.0

This is one clean up patch that you introduce struct bufdesc_prop.

Acked-by: Fugang Duan <fugang.duan@nxp.com>
