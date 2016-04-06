From: fugang.duan@nxp.com (Fugang Duan)
Date: Wed, 6 Apr 2016 09:12:31 +0000
Subject: [PATCH net-next V3 03/16] net: fec: return IRQ_HANDLED if
 fec_ptp_check_pps_event handled it
In-Reply-To: <1459909562-22865-4-git-send-email-troy.kisky@boundarydevices.com>
References: <1459909562-22865-1-git-send-email-troy.kisky@boundarydevices.com>
 <1459909562-22865-4-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <VI1PR0401MB18556863D9FD7D4590D2DD38FF9F0@VI1PR0401MB1855.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Troy Kisky <troy.kisky@boundarydevices.com> Sent: Wednesday, April 06, 2016 10:26 AM
> To: netdev at vger.kernel.org; davem at davemloft.net; Fugang Duan
> <fugang.duan@nxp.com>; lznuaa at gmail.com
> Cc: Fabio Estevam <fabio.estevam@nxp.com>; l.stach at pengutronix.de;
> andrew at lunn.ch; tremyfr at gmail.com; gerg at uclinux.org; linux-arm-
> kernel at lists.infradead.org; johannes at sipsolutions.net;
> stillcompiling at gmail.com; sergei.shtylyov at cogentembedded.com;
> arnd at arndb.de; Troy Kisky <troy.kisky@boundarydevices.com>
> Subject: [PATCH net-next V3 03/16] net: fec: return IRQ_HANDLED if
> fec_ptp_check_pps_event handled it
> 
> fec_ptp_check_pps_event will return 1 if FEC_T_TF_MASK caused an interrupt.
> Don't return IRQ_NONE in this case.
> 
> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> 
> ---
> v3: New patch, came from feedback from another patch.
> ---
>  drivers/net/ethernet/freescale/fec_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fec_main.c
> b/drivers/net/ethernet/freescale/fec_main.c
> index a011719..7993040 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -1579,8 +1579,8 @@ fec_enet_interrupt(int irq, void *dev_id)
>  	}
> 
>  	if (fep->ptp_clock)
> -		fec_ptp_check_pps_event(fep);
> -
> +		if (fec_ptp_check_pps_event(fep))
> +			ret = IRQ_HANDLED;
>  	return ret;
>  }
> 
> --
> 2.5.0

Acked-by: Fugang Duan <fugang.duan@nxp.com>
