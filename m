From: fugang.duan@nxp.com (Fugang Duan)
Date: Fri, 4 Mar 2016 10:06:18 +0000
Subject: [PATCH net-next V2 13/16] net: fec: print more debug info in
 fec_timeout
In-Reply-To: <1456360619-24390-14-git-send-email-troy.kisky@boundarydevices.com>
References: <1456360619-24390-1-git-send-email-troy.kisky@boundarydevices.com>
 <1456360619-24390-14-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <VI1PR0401MB18552AB3E4128E412273B439FFBE0@VI1PR0401MB1855.eurprd04.prod.outlook.com>
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
> Subject: [PATCH net-next V2 13/16] net: fec: print more debug info in
> fec_timeout
> 
> Print the current interrupt flags and mask and the interrupt state during the last
> interrupt in fec_timeout.
> 
> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> ---
>  drivers/net/ethernet/freescale/fec.h      | 1 +
>  drivers/net/ethernet/freescale/fec_main.c | 4 ++++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/net/ethernet/freescale/fec.h
> b/drivers/net/ethernet/freescale/fec.h
> index 001200b..615cca1 100644
> --- a/drivers/net/ethernet/freescale/fec.h
> +++ b/drivers/net/ethernet/freescale/fec.h
> @@ -506,6 +506,7 @@ struct fec_enet_private {
>  	unsigned int total_tx_ring_size;
>  	unsigned int total_rx_ring_size;
>  	uint	events;
> +	uint	last_ievents;
> 
>  	struct	platform_device *pdev;
> 
> diff --git a/drivers/net/ethernet/freescale/fec_main.c
> b/drivers/net/ethernet/freescale/fec_main.c
> index afd4060..9a3136b 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -1107,6 +1107,9 @@ fec_timeout(struct net_device *ndev)
>  	int i;
>  	uint events = 0;
> 
> +	pr_err("%s: last=%x %x, mask %x\n", __func__, fep->last_ievents,
> +	       readl(fep->hwp + FEC_IEVENT), readl(fep->hwp + FEC_IMASK));
> +
pr_err() -> netdev_err()

I don't want the debug patch enter to the driver.

>  	for (i = 0; i < fep->num_tx_queues; i++) {
>  		struct fec_enet_priv_tx_q *txq = fep->tx_queue[i];
>  		int index;
> @@ -1514,6 +1517,7 @@ fec_enet_interrupt(int irq, void *dev_id)
> 
>  	if (!int_events)
>  		return IRQ_NONE;
> +	fep->last_ievents = int_events;
> 
>  	if (int_events & (FEC_ENET_RXF | FEC_ENET_TXF)) {
>  		if (napi_schedule_prep(&fep->napi)) {
> --
> 2.5.0
