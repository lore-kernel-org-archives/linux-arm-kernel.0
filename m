From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 16 Feb 2015 21:11:24 +0100
Subject: [PATCH v3 1/2] mtd: nand: pxa3xx: Fix PIO FIFO draining
In-Reply-To: <1424091072-7738-2-git-send-email-maxime.ripard@free-electrons.com>
 (Maxime Ripard's message of "Mon, 16 Feb 2015 13:51:11 +0100")
References: <1424091072-7738-1-git-send-email-maxime.ripard@free-electrons.com>
 <1424091072-7738-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <87oaotaa6r.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Maxime Ripard <maxime.ripard@free-electrons.com> writes:

>  drivers/mtd/nand/pxa3xx_nand.c | 47 ++++++++++++++++++++++++++++++++++++------
>  1 file changed, 41 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
> index 96b0b1d27df1..b2d8d6960765 100644
> --- a/drivers/mtd/nand/pxa3xx_nand.c
> +++ b/drivers/mtd/nand/pxa3xx_nand.c
> @@ -480,6 +480,41 @@ static void disable_int(struct pxa3xx_nand_info *info, uint32_t int_mask)
>  	nand_writel(info, NDCR, ndcr | int_mask);
>  }
>  
> +static void drain_fifo(struct pxa3xx_nand_info *info, void *data, int len)
> +{
> +	if (info->ecc_bch) {
> +		int index = 0;
> +
> +		while (index < (len * 4)) {
> +			u32 timeout;
> +
> +			__raw_readsl(info->mmio_base + NDDB, data + index, 8);
> +
> +			/*
> +			 * According to the datasheet, when reading
> +			 * from NDDB with BCH enabled, after each 32
> +			 * bytes reads, we have to make sure that the
> +			 * NDSR.RDDREQ bit is set
> +			 */
> +			for (timeout = 0;
> +			     !(nand_readl(info, NDSR) & NDSR_RDDREQ);
> +			     timeout++) {
> +				if (timeout >= 5) {
> +					dev_err(&info->pdev->dev,
> +						"Timeout on RDDREQ while draining the FIFO\n");
> +					return;
> +				}
> +
> +				mdelay(1);
So in worst case, we'll end up with 4 times mdelay(1) times len / 32.
For a 2048 page, it is : 256ms where everything is stuck (mdelay and not
msleep).

I know you had no choice because this is called from interrupt handler (top
half). But having a irq handler and a irq thread handler would solve that issue,
and you'll end up with msleep(1) in this code.

I don't think an mdelay(256) is acceptable.

Cheers.

--
Robert
