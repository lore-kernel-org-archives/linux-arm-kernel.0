From: baruch@tkos.co.il (Baruch Siach)
Date: Mon, 31 May 2010 08:41:43 +0300
Subject: [PATCH] mxc_nand: Fix OOB accesses on i.MX27
In-Reply-To: <20100528080217.GH23664@pengutronix.de>
References: <20100528080217.GH23664@pengutronix.de>
Message-ID: <20100531054142.GA6514@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Fri, May 28, 2010 at 10:02:17AM +0200, Sascha Hauer wrote:
> The OOB handling in the mxc_nand driver is broken for v1 type
> controllers (i.MX27/31) with 512 byte page size. This perhaps
> did not show up because ubi does not use OOB.
> Update the driver to always read/write a whole page even if
> only OOB is requested. With this patch the driver passes the
> mtd_oobtest on i.MX27 with 512 byte page size. Also tested
> with 2048 byte page size and on i.MX35 (v2 type controller)
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Tested on i.MX25 with 2K page size.

baruch

> ---
>  drivers/mtd/nand/mxc_nand.c |   31 +++++--------------------------
>  1 files changed, 5 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
> index 82e9438..6e8aa34 100644
> --- a/drivers/mtd/nand/mxc_nand.c
> +++ b/drivers/mtd/nand/mxc_nand.c
> @@ -623,8 +623,7 @@ static void mxc_nand_command(struct mtd_info *mtd, unsigned command,
>  		else
>  			host->buf_start = column + mtd->writesize;
>  
> -		if (mtd->writesize > 512)
> -			command = NAND_CMD_READ0; /* only READ0 is valid */
> +		command = NAND_CMD_READ0; /* only READ0 is valid */
>  
>  		send_cmd(host, command, false);
>  		mxc_do_addr_cycle(mtd, column, page_addr);
> @@ -639,31 +638,11 @@ static void mxc_nand_command(struct mtd_info *mtd, unsigned command,
>  		break;
>  
>  	case NAND_CMD_SEQIN:
> -		if (column >= mtd->writesize) {
> -			/*
> -			 * FIXME: before send SEQIN command for write OOB,
> -			 * We must read one page out.
> -			 * For K9F1GXX has no READ1 command to set current HW
> -			 * pointer to spare area, we must write the whole page
> -			 * including OOB together.
> -			 */
> -			if (mtd->writesize > 512)
> -				/* call ourself to read a page */
> -				mxc_nand_command(mtd, NAND_CMD_READ0, 0,
> -						page_addr);
> -
> -			host->buf_start = column;
> -
> -			/* Set program pointer to spare region */
> -			if (mtd->writesize == 512)
> -				send_cmd(host, NAND_CMD_READOOB, false);
> -		} else {
> -			host->buf_start = column;
> +		if (column >= mtd->writesize)
> +			/* call ourself to read a page */
> +			mxc_nand_command(mtd, NAND_CMD_READ0, 0, page_addr);
>  
> -			/* Set program pointer to page start */
> -			if (mtd->writesize == 512)
> -				send_cmd(host, NAND_CMD_READ0, false);
> -		}
> +		host->buf_start = column;
>  
>  		send_cmd(host, command, false);
>  		mxc_do_addr_cycle(mtd, column, page_addr);
> -- 
> 1.7.1
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
