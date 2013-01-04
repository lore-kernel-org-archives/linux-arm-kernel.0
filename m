From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 4 Jan 2013 14:09:17 +0100
Subject: [PATCH v3 1/1 net-next] NET: FEC: dynamtic check DMA desc buff
 type
In-Reply-To: <1357265063-30528-1-git-send-email-Frank.Li@freescale.com>
References: <1357265063-30528-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <20130104130917.GC1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 04, 2013 at 10:04:23AM +0800, Frank Li wrote:
> MX6 and mx28 support enhanced DMA descriptor buff to support 1588
> ptp. But MX25, MX3x, MX5x can't support enhanced DMA descriptor buff.
> Check fec type and choose correct DMA descriptor buff type.
> 
> Remove static config CONFIG_FEC_PTP.
> ptp function will be auto detected.
> 
> Signed-off-by: Frank Li <Frank.Li@freescale.com>

Two minor comments, otherwise:

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

> @@ -1574,6 +1617,8 @@ fec_probe(struct platform_device *pdev)
>  	fep->pdev = pdev;
>  	fep->dev_id = dev_id++;
>  
> +	fep->bufdesc_ex = 0;
> +

fep already is zeroed, so this is unnecessary.

>  	if (!fep->hwp) {
>  		ret = -ENOMEM;
>  		goto failed_ioremap;
> @@ -1628,19 +1673,19 @@ fec_probe(struct platform_device *pdev)
>  		goto failed_clk;
>  	}
>  
> -#ifdef CONFIG_FEC_PTP
>  	fep->clk_ptp = devm_clk_get(&pdev->dev, "ptp");
> +	fep->bufdesc_ex =
> +		pdev->id_entry->driver_data & FEC_QUIRK_HAS_BUFDESC_EX;
>  	if (IS_ERR(fep->clk_ptp)) {
>  		ret = PTR_ERR(fep->clk_ptp);
> -		goto failed_clk;
> +		fep->bufdesc_ex = 0;
>  	}

Since you remove the goto you can remove the 'ret =' aswell.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
