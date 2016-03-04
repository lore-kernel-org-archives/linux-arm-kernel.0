From: fugang.duan@nxp.com (Fugang Duan)
Date: Fri, 4 Mar 2016 09:29:52 +0000
Subject: [PATCH net-next V2 07/16] net: fec: set cbd_sc without relying on
 previous value
In-Reply-To: <1456360619-24390-8-git-send-email-troy.kisky@boundarydevices.com>
References: <1456360619-24390-1-git-send-email-troy.kisky@boundarydevices.com>
 <1456360619-24390-8-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <VI1PR0401MB18552747CE0E0FF2C7E0E4C5FFBE0@VI1PR0401MB1855.eurprd04.prod.outlook.com>
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
> Subject: [PATCH net-next V2 07/16] net: fec: set cbd_sc without relying on
> previous value
> 
> Relying on the wrap bit to stay valid once initialized when the controller also
> writes to this byte seems undesirable since we can easily know what the value
> should be.
> 
> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> ---
>  drivers/net/ethernet/freescale/fec_main.c | 38 +++++++++----------------------
>  1 file changed, 11 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fec_main.c
> b/drivers/net/ethernet/freescale/fec_main.c
> index 791f385..6ceb5f9 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -340,9 +340,8 @@ fec_enet_txq_submit_frag_skb(struct
> fec_enet_priv_tx_q *txq,
>  		bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
>  		ebdp = (struct bufdesc_ex *)bdp;
> 
> -		status = fec16_to_cpu(bdp->cbd_sc);
> -		status &= ~BD_ENET_TX_STATS;
> -		status |= (BD_ENET_TX_TC | BD_ENET_TX_READY);
> +		status = BD_ENET_TX_TC | BD_ENET_TX_READY |
> +				((bdp == txq->bd.last) ? BD_SC_WRAP : 0);
>  		frag_len = skb_shinfo(skb)->frags[frag].size;
> 
>  		/* Handle the last BD specially */
> @@ -436,8 +435,6 @@ static int fec_enet_txq_submit_skb(struct
> fec_enet_priv_tx_q *txq,
>  	/* Fill in a Tx ring entry */
>  	bdp = txq->bd.cur;
>  	last_bdp = bdp;
> -	status = fec16_to_cpu(bdp->cbd_sc);
> -	status &= ~BD_ENET_TX_STATS;
> 
>  	/* Set buffer length and buffer pointer */
>  	bufaddr = skb->data;
> @@ -462,6 +459,8 @@ static int fec_enet_txq_submit_skb(struct
> fec_enet_priv_tx_q *txq,
>  		return NETDEV_TX_OK;
>  	}
> 
> +	status = BD_ENET_TX_TC | BD_ENET_TX_READY |
> +			((bdp == txq->bd.last) ? BD_SC_WRAP : 0);
>  	if (nr_frags) {
>  		last_bdp = fec_enet_txq_submit_frag_skb(txq, skb, ndev);
>  		if (IS_ERR(last_bdp)) {
> @@ -512,7 +511,6 @@ static int fec_enet_txq_submit_skb(struct
> fec_enet_priv_tx_q *txq,
>  	/* Send it on its way.  Tell FEC it's ready, interrupt when done,
>  	 * it's the last BD of the frame, and to put the CRC on the end.
>  	 */
> -	status |= (BD_ENET_TX_READY | BD_ENET_TX_TC);

This is completely error.  We have to prepare all BDs for frag skb, and then enable "READY" and "TC" bit for the first BD, otherwise uDMA copy un-correct data to fifo.

<snip>
