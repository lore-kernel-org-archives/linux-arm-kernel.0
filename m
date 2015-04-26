From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 26 Apr 2015 21:52:11 +0200
Subject: [PATCH 3/4] mtd: mxc_nand: fix truncate of unaligned oob copying
In-Reply-To: <1f8e85fd8e75170e1005473c075942cb3d4479fe.1430034929.git.baruch@tkos.co.il>
References: <cover.1430034929.git.baruch@tkos.co.il>
 <1f8e85fd8e75170e1005473c075942cb3d4479fe.1430034929.git.baruch@tkos.co.il>
Message-ID: <20150426195211.GB19431@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Baruch,

On Sun, Apr 26, 2015 at 11:16:50AM +0300, Baruch Siach wrote:
> diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
> index c650f0950b20..c05f5e8fef17 100644
> --- a/drivers/mtd/nand/mxc_nand.c
> +++ b/drivers/mtd/nand/mxc_nand.c
> @@ -840,22 +840,22 @@ static void copy_spare(struct mtd_info *mtd, bool bfrom)
>  		for (i = 0; i < num_chunks - 1; i++)
>  			memcpy32_fromio(d + i * oob_chunk_size,
>  					s + i * sparebuf_size,
> -					oob_chunk_size);
> +					ALIGN(oob_chunk_size, 4));
If oob_chunk_size isn't 32-bit-aligned, d + i * oob_chunk_size isn't
either for uneven i. That's not nice. I suggest to use memcpy16_fromio.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
