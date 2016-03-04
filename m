From: fugang.duan@nxp.com (Fugang Duan)
Date: Fri, 4 Mar 2016 09:11:57 +0000
Subject: [PATCH net-next V2 06/16] net: fec: don't clear all rx queue bits
 when just one is being checked
In-Reply-To: <1456360619-24390-7-git-send-email-troy.kisky@boundarydevices.com>
References: <1456360619-24390-1-git-send-email-troy.kisky@boundarydevices.com>
 <1456360619-24390-7-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <VI1PR0401MB18550FD3A944783B88BEDB64FFBE0@VI1PR0401MB1855.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Troy Kisky <troy.kisky@boundarydevices.com>Sent: Thursday, February 25, 2016 8:37 AM
> To: netdev at vger.kernel.org; davem at davemloft.net; b38611 at freescale.com
> Cc: fabio.estevam at freescale.com; l.stach at pengutronix.de; andrew at lunn.ch;
> tremyfr at gmail.com; linux at arm.linux.org.uk; linux-arm-
> kernel at lists.infradead.org; laci at boundarydevices.com; shawnguo at kernel.org;
> johannes at sipsolutions.net; stillcompiling at gmail.com;
> sergei.shtylyov at cogentembedded.com; arnd at arndb.de; Troy Kisky
> <troy.kisky@boundarydevices.com>
> Subject: [PATCH net-next V2 06/16] net: fec: don't clear all rx queue bits when
> just one is being checked
> 
> FEC_ENET_RXF is 3 separate bits, we only check one queue at a time. So, when
> the last queue is being checked, it is bad to remove the interrupt on the 1st
> queue.
> 
> Also, since this is now done in the napi routine and not the interrupt, it is not
> needed.
> 
> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> ---
>  drivers/net/ethernet/freescale/fec_main.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fec_main.c
> b/drivers/net/ethernet/freescale/fec_main.c
> index 610cf6c..791f385 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -1338,8 +1338,6 @@ static int fec_rxq(struct net_device *ndev, struct
> fec_enet_private *fep,
>  			break;
>  		pkt_received++;
> 
> -		writel(FEC_ENET_RXF, fep->hwp + FEC_IEVENT);
> -

We should clear the related rx queue ievent, not remove the code.
Pls see commit: db3421c114cf that was submitted by Russell King.

No ack the patch.

>  		/* Check for errors. */
>  		status ^= BD_ENET_RX_LAST;
>  		if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH |
> BD_ENET_RX_NO |
> --
> 2.5.0
