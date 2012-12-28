From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Fri, 28 Dec 2012 15:45:32 +0100
Subject: [PATCH v2 1/1 net-next] NET: FEC: dynamtic check DMA desc buff
 type
In-Reply-To: <1356676164-10910-1-git-send-email-Frank.Li@freescale.com>
References: <1356676164-10910-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <20701.45196.361432.80622@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Frank Li writes:
> MX6 and mx28 support enhanced DMA descript buff to support 1588
> ptp. But MX25, MX3x, MX5x can't support enhanced DMA descript buff.
> Check fec type and choose correct DAM descript buff type.
                                    ^^^
s/DAM/DMA/
s/descript/descriptor/g

[...]
> diff --git a/drivers/net/ethernet/freescale/fec.c b/drivers/net/ethernet/freescale/fec.c
> index 0704bca..290f91c 100644
> --- a/drivers/net/ethernet/freescale/fec.c
> +++ b/drivers/net/ethernet/freescale/fec.c
> @@ -76,6 +76,8 @@
>  #define FEC_QUIRK_USE_GASKET		(1 << 2)
>  /* Controller has GBIT support */
>  #define FEC_QUIRK_HAS_GBIT		(1 << 3)
> +/* Controller has extend desc buffer */
> +#define FEC_QUICK_HAS_BUFDESC_EX	(1 << 4)
               ^^^^^
As Sascha has already pointed out, this should be 'QUIRK' rather than
'QUICK' (like in the preceeding lines)!

>  static struct platform_device_id fec_devtype[] = {
>  	{
> @@ -93,7 +95,8 @@ static struct platform_device_id fec_devtype[] = {
>  		.driver_data = FEC_QUIRK_ENET_MAC | FEC_QUIRK_SWAP_FRAME,
>  	}, {
>  		.name = "imx6q-fec",
> -		.driver_data = FEC_QUIRK_ENET_MAC | FEC_QUIRK_HAS_GBIT,
> +		.driver_data = FEC_QUIRK_ENET_MAC | FEC_QUIRK_HAS_GBIT |
> +				FEC_QUICK_HAS_BUFDESC_EX,
                                    ^^^^^
same as above.

[...]
> @@ -1574,6 +1617,8 @@ fec_probe(struct platform_device *pdev)
>  	fep->pdev = pdev;
>  	fep->dev_id = dev_id++;
>  
> +	fep->bufdesc_ex = 0;
> +
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
> +		pdev->id_entry->driver_data & FEC_QUICK_HAS_BUFDESC_EX;
                                                  ^^^^^
same as above.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
