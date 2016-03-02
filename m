From: fugang.duan@nxp.com (Fugang Duan)
Date: Wed, 2 Mar 2016 14:57:32 +0000
Subject: [PATCH net-next V2 01/16] net: fec: only check queue 0 if
 RXF_0/TXF_0 interrupt is set
In-Reply-To: <1456360619-24390-2-git-send-email-troy.kisky@boundarydevices.com>
References: <1456360619-24390-1-git-send-email-troy.kisky@boundarydevices.com>
 <1456360619-24390-2-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <VI1PR0401MB18556705FA5E8111DF0C6A44FFBC0@VI1PR0401MB1855.eurprd04.prod.outlook.com>
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
> Subject: [PATCH net-next V2 01/16] net: fec: only check queue 0 if
> RXF_0/TXF_0 interrupt is set
> 
> Before queue 0 was always checked if any queue caused an interrupt.
> It is better to just mark queue 0 if queue 0 has caused an interrupt.
> 
> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> ---
>  drivers/net/ethernet/freescale/fec_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fec_main.c
> b/drivers/net/ethernet/freescale/fec_main.c
> index bad0ba2..dbac975 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -1534,14 +1534,14 @@ fec_enet_collect_events(struct fec_enet_private
> *fep, uint int_events)
>  	if (int_events == 0)
>  		return false;
> 
> -	if (int_events & FEC_ENET_RXF)
> +	if (int_events & FEC_ENET_RXF_0)
>  		fep->work_rx |= (1 << 2);
>  	if (int_events & FEC_ENET_RXF_1)
>  		fep->work_rx |= (1 << 0);
>  	if (int_events & FEC_ENET_RXF_2)
>  		fep->work_rx |= (1 << 1);
> 
> -	if (int_events & FEC_ENET_TXF)
> +	if (int_events & FEC_ENET_TXF_0)
>  		fep->work_tx |= (1 << 2);
>  	if (int_events & FEC_ENET_TXF_1)
>  		fep->work_tx |= (1 << 0);
> --
> 2.5.0

Acked-by: Fugang Duan <Fugang.duan@nxp.com>
