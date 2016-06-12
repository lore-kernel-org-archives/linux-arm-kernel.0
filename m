From: fugang.duan@nxp.com (Fugang Duan)
Date: Sun, 12 Jun 2016 05:16:02 +0000
Subject: [PATCH net-next RFT] net: fec: handle small PHY reset durations
 more precisely
In-Reply-To: <1465418567-2694-1-git-send-email-stefan.wahren@i2se.com>
References: <1465418567-2694-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <VI1PR0401MB1855C3B3CF0634BAE6D8063CFF520@VI1PR0401MB1855.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stefan Wahren <stefan.wahren@i2se.com> Sent: Thursday, June 09, 2016 4:43 AM
> To: David Miller <davem@davemloft.net>; Fugang Duan
> <fugang.duan@nxp.com>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>; Lucas Stach
> <l.stach@pengutronix.de>; andrew at lunn.ch; holgerschurig at gmail.com; Troy
> Kisky <troy.kisky@boundarydevices.com>; linux-arm-kernel at lists.infradead.org;
> netdev at vger.kernel.org; Stefan Wahren <stefan.wahren@i2se.com>
> Subject: [PATCH net-next RFT] net: fec: handle small PHY reset durations more
> precisely
> 
> Since msleep is based on jiffies the PHY reset could take longer than expected.
> So use msleep for values greater than 20 msec otherwise usleep_range.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  drivers/net/ethernet/freescale/fec_main.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fec_main.c
> b/drivers/net/ethernet/freescale/fec_main.c
> index 3c0255e..49f8055 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -3191,7 +3191,12 @@ static void fec_reset_phy(struct platform_device
> *pdev)
>  		dev_err(&pdev->dev, "failed to get phy-reset-gpios: %d\n", err);
>  		return;
>  	}
> -	msleep(msec);
> +
> +	if (msec > 20)
> +		msleep(msec);
> +	else
> +		usleep_range(msec * 1000, msec * 1000 + 1000);
> +
>  	gpio_set_value_cansleep(phy_reset, !active_high);  }  #else /*
> CONFIG_OF */
> --
> 1.7.9.5

Thanks. You are correct base on Documentation/timers/timers-howto.txt.

Acked-by: Fugang Duan <fugang.duan@nxp.com>
