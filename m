From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 28 Apr 2010 17:22:00 +0200
Subject: [PATCH] pxa32xx_nand: add support for partition table parsing
In-Reply-To: <1272057944-19380-1-git-send-email-mkl@pengutronix.de>
References: <1272057944-19380-1-git-send-email-mkl@pengutronix.de>
Message-ID: <4BD85298.1000304@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Kleine-Budde wrote:
> The pxa32xx_nand driver doesn't support partition tables from the
> command line. This patch adds support for it.
> 
> Please review and consider to apply.

Can someone please have a look at this patch.

Cheers, Marc

>>From a2caa92b08351511ee60bd94bf735be5f3a6fb65 Mon Sep 17 00:00:00 2001
> From: Marc Kleine-Budde <mkl@pengutronix.de>
> Date: Fri, 23 Apr 2010 10:43:42 +0200
> Subject: [PATCH] pxa32xx_nand: add support for partition table parsing
> 
> The pxa32xx_nand driver doesn't support partition tables from the
> command line. This patch adds support for it.
> 
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/mtd/nand/pxa3xx_nand.c |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
> index 5d55152..e02fa4f 100644
> --- a/drivers/mtd/nand/pxa3xx_nand.c
> +++ b/drivers/mtd/nand/pxa3xx_nand.c
> @@ -1320,6 +1320,17 @@ static int pxa3xx_nand_probe(struct platform_device *pdev)
>  		goto fail_free_irq;
>  	}
>  
> +	if (mtd_has_cmdlinepart()) {
> +		static const char *probes[] = { "cmdlinepart", NULL };
> +		struct mtd_partition *parts;
> +		int nr_parts;
> +
> +		nr_parts = parse_mtd_partitions(mtd, probes, &parts, 0);
> +
> +		if (nr_parts)
> +			return add_mtd_partitions(mtd, parts, nr_parts);
> +	}
> +
>  	return add_mtd_partitions(mtd, pdata->parts, pdata->nr_parts);
>  
>  fail_free_irq:


-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 260 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100428/fd228e2b/attachment.sig>
