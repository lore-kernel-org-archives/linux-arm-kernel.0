From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 11 Aug 2010 14:46:17 +0200
Subject: [PATCH 11/12] mxc_nand: do not depend on disabling the irq in
	the interrupt handler
In-Reply-To: <1281442473-31428-3-git-send-email-s.hauer@pengutronix.de>
References: <1281442473-31428-1-git-send-email-s.hauer@pengutronix.de>
	<1281442473-31428-3-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20100811124617.GR27749@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 10, 2010 at 02:14:32PM +0200, Sascha Hauer wrote:
> This patch reverts the driver to enabling/disabling the NFC interrupt
> mask rather than enabling/disabling the system interrupt. This cleans
> up the driver so that it doesn't rely on interrupts being disabled
> within the interrupt handler.
> This patch is based on earlier work by John Ogness.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/mtd/nand/mxc_nand.c |   78 +++++++++++++++++++++++++++++++++++++------
>  1 files changed, 67 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
> index 3767dcc..0cc4343 100644
> --- a/drivers/mtd/nand/mxc_nand.c
> +++ b/drivers/mtd/nand/mxc_nand.c
> @@ -30,6 +30,8 @@
>  #include <linux/clk.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/completion.h>
>  
>  #include <asm/mach/flash.h>
>  #include <mach/mxc_nand.h>
> @@ -149,7 +151,7 @@ struct mxc_nand_host {
>  	int			irq;
>  	int			eccsize;
>  
> -	wait_queue_head_t	irq_waitq;
> +	struct completion	op_completion;
>  
>  	uint8_t			*data_buf;
>  	unsigned int		buf_start;
> @@ -162,6 +164,7 @@ struct mxc_nand_host {
>  	void			(*send_read_id)(struct mxc_nand_host *);
>  	uint16_t		(*get_dev_status)(struct mxc_nand_host *);
>  	int			(*check_int)(struct mxc_nand_host *);
> +	void			(*irq_control)(struct mxc_nand_host *, int);
>  };
>  
>  /* OOB placement block for use with hardware ecc generation */
> @@ -214,9 +217,14 @@ static irqreturn_t mxc_nfc_irq(int irq, void *dev_id)
>  {
>  	struct mxc_nand_host *host = dev_id;
>  
> -	disable_irq_nosync(irq);
> +	if (!host->check_int(host)) {
> +		printk("none?\n");

Nah, this printk goes away of course.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
