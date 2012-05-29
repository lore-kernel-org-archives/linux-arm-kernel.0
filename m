From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 29 May 2012 11:12:54 +0200
Subject: [PATCH v2] mtd mxc_nand: use 32bit copy functions
In-Reply-To: <1338279369-25915-1-git-send-email-s.hauer@pengutronix.de>
References: <1338279369-25915-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20120529091254.GY3710@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, May 29, 2012 at 10:16:09AM +0200, Sascha Hauer wrote:
> The following commit changes the function used to copy from/to
> the hardware buffer to memcpy_[from|to]io. This does not work
> since the hardware cannot handle the byte accesses used by these
> functions. Instead of reverting this patch introduce 32bit
> correspondents of these functions.
Hmm, I didn't run an mtd test suite, but on mx27 it worked for me. IMHO
it's surprising that memcpy used to work, but memcpy_fromio doesn't. I
wouldn't expect a different semantic (apart from normal vs. __iomem
memory). And I wonder what will break when ARM's memcpy_fromio et al.
is optimized.

> | commit 5775ba36ea9c760c2d7e697dac04f2f7fc95aa62
> | Author: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> | Date:   Tue Apr 24 10:05:22 2012 +0200
> |
> |    mtd: mxc_nand: fix several sparse warnings about incorrect address space
> |
> |     Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> |     Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> 
> v2: remove volatile, fix line over 80 characters
I'm not sure about the need for volatile. I don't have my C Reference
handy, but maybe adding volatile prevents the compilier issuing code
that e.g. uses a different word size?! Not sure if it matters for a
static and so maybe inlined function.

Still:
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

> 
>  drivers/mtd/nand/mxc_nand.c |   37 +++++++++++++++++++++++++++++--------
>  1 file changed, 29 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
> index fd14966..17ddcf0 100644
> --- a/drivers/mtd/nand/mxc_nand.c
> +++ b/drivers/mtd/nand/mxc_nand.c
> @@ -273,6 +273,26 @@ static struct nand_ecclayout nandv2_hw_eccoob_4k = {
>  
>  static const char *part_probes[] = { "RedBoot", "cmdlinepart", "ofpart", NULL };
>  
> +static void memcpy32_fromio(void *trg, const void __iomem  *src, size_t size)
> +{
> +	int i;
> +	u32 *t = trg;
> +	const __iomem u32 *s = src;
> +
> +	for (i = 0; i < (size >> 2); i++)
> +		*t++ = __raw_readl(s++);
> +}
> +
> +static void memcpy32_toio(void __iomem *trg, const void *src, int size)
> +{
> +	int i;
> +	u32 __iomem *t = trg;
> +	const u32 *s = src;
> +
> +	for (i = 0; i < (size >> 2); i++)
> +		__raw_writel(*s++, t++);
> +}
> +
>  static int check_int_v3(struct mxc_nand_host *host)
>  {
>  	uint32_t tmp;
> @@ -519,7 +539,7 @@ static void send_read_id_v3(struct mxc_nand_host *host)
>  
>  	wait_op_done(host, true);
>  
> -	memcpy_fromio(host->data_buf, host->main_area0, 16);
> +	memcpy32_fromio(host->data_buf, host->main_area0, 16);
>  }
>  
>  /* Request the NANDFC to perform a read of the NAND device ID. */
> @@ -535,7 +555,7 @@ static void send_read_id_v1_v2(struct mxc_nand_host *host)
>  	/* Wait for operation to complete */
>  	wait_op_done(host, true);
>  
> -	memcpy_fromio(host->data_buf, host->main_area0, 16);
> +	memcpy32_fromio(host->data_buf, host->main_area0, 16);
>  
>  	if (this->options & NAND_BUSWIDTH_16) {
>  		/* compress the ID info */
> @@ -797,16 +817,16 @@ static void copy_spare(struct mtd_info *mtd, bool bfrom)
>  
>  	if (bfrom) {
>  		for (i = 0; i < n - 1; i++)
> -			memcpy_fromio(d + i * j, s + i * t, j);
> +			memcpy32_fromio(d + i * j, s + i * t, j);
>  
>  		/* the last section */
> -		memcpy_fromio(d + i * j, s + i * t, mtd->oobsize - i * j);
> +		memcpy32_fromio(d + i * j, s + i * t, mtd->oobsize - i * j);
>  	} else {
>  		for (i = 0; i < n - 1; i++)
> -			memcpy_toio(&s[i * t], &d[i * j], j);
> +			memcpy32_toio(&s[i * t], &d[i * j], j);
>  
>  		/* the last section */
> -		memcpy_toio(&s[i * t], &d[i * j], mtd->oobsize - i * j);
> +		memcpy32_toio(&s[i * t], &d[i * j], mtd->oobsize - i * j);
>  	}
>  }
>  
> @@ -1070,7 +1090,8 @@ static void mxc_nand_command(struct mtd_info *mtd, unsigned command,
>  
>  		host->devtype_data->send_page(mtd, NFC_OUTPUT);
>  
> -		memcpy_fromio(host->data_buf, host->main_area0, mtd->writesize);
> +		memcpy32_fromio(host->data_buf, host->main_area0,
> +				mtd->writesize);
>  		copy_spare(mtd, true);
>  		break;
>  
> @@ -1086,7 +1107,7 @@ static void mxc_nand_command(struct mtd_info *mtd, unsigned command,
>  		break;
>  
>  	case NAND_CMD_PAGEPROG:
> -		memcpy_toio(host->main_area0, host->data_buf, mtd->writesize);
> +		memcpy32_toio(host->main_area0, host->data_buf, mtd->writesize);
>  		copy_spare(mtd, false);
>  		host->devtype_data->send_page(mtd, NFC_INPUT);
>  		host->devtype_data->send_cmd(host, command, true);
> -- 
> 1.7.10
> 
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
