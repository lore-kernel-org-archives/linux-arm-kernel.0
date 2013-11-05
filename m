From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 5 Nov 2013 11:51:36 -0800
Subject: [PATCH v3 12/28] mtd: nand: pxa3xx: Use a completion to signal
 device ready
In-Reply-To: <1383656135-8627-13-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1383656135-8627-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1383656135-8627-13-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20131105195136.GS20061@ld-irv-0074.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 05, 2013 at 09:55:19AM -0300, Ezequiel Garcia wrote:
> Apparently, the expected behavior of the waitfunc() NAND chip call
> is to wait for the device to be READY (this is a standard chip line).
> However, the current implementation does almost nothing, which opens
> a possibility to issue a command to a non-ready device.
> 
> Fix this by adding a new completion to wait for the ready event to arrive.
> 
> Because the "is ready" flag is cleared from the controller status
> register, it's needed to store that state in the driver, and because the
> field is accesed from an interruption, the field needs to be of an
> atomic type.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  drivers/mtd/nand/pxa3xx_nand.c | 45 +++++++++++++++++++++++++++++-------------
>  1 file changed, 31 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
> index 2fb0f38..e198c94 100644
> --- a/drivers/mtd/nand/pxa3xx_nand.c
> +++ b/drivers/mtd/nand/pxa3xx_nand.c
> @@ -35,6 +35,7 @@
>  
>  #include <linux/platform_data/mtd-nand-pxa3xx.h>
>  
> +#define NAND_DEV_READY_TIMEOUT  50
>  #define	CHIP_DELAY_TIMEOUT	(2 * HZ/10)
>  #define NAND_STOP_DELAY		(2 * HZ/50)
>  #define PAGE_CHUNK_SIZE		(2048)
> @@ -166,7 +167,7 @@ struct pxa3xx_nand_info {
>  	struct clk		*clk;
>  	void __iomem		*mmio_base;
>  	unsigned long		mmio_phys;
> -	struct completion	cmd_complete;
> +	struct completion	cmd_complete, dev_ready;

I still kinda think this could be consolidated into one completion,
under which cmdfunc() performs all the necessary waiting (for both the
"command complete" and "device ready" signals), but I think this is not
a big advantage right now, considering your code is not too complex
right now.

>  
>  	unsigned int 		buf_start;
>  	unsigned int		buf_count;
> @@ -196,7 +197,13 @@ struct pxa3xx_nand_info {
>  	int			use_ecc;	/* use HW ECC ? */
>  	int			use_dma;	/* use DMA ? */
>  	int			use_spare;	/* use spare ? */
> -	int			is_ready;
> +
> +	/*
> +	 * The is_ready flag is accesed from several places,
> +	 * including an interruption hander. We need an atomic
> +	 * type to avoid races.
> +	 */
> +	atomic_t		is_ready;

I believe your handling of this 'is_ready' bit is a little unwise, as
you are actually creating extra concurrency that is unneeded. I'll
summarize what you're doing with this 'is_ready' field:

  cmdfunc() -> sets info->is_ready=0 for appropriate commands
            -> kicks off the hardware

The following two sequences may then occur concurrently:

  (1) pxa3xx_nand_irq -> ready interrupt occurs
                      -> set info->is_ready=1
		      -> signal 'dev_ready' completion

  (2) waitfunc -> check info->is_ready, if it is 0...
                  |_ ... wait for the dev_ready completion

Instead of setting info->is_ready=1 under (1), you could set it in (2),
after the completion (or timeout). This avoids the concurrency, since
cmdfunc() and waitfunc() are sequential. This also avoids a benign race
in which you may not even call wait_for_completion() in (2) in the
following scenario:

  * Suppose waitfunc is delayed a long time
  * The IRQ handler...
    - receives the 'ready' interrupt
    - clears info->is_ready
    - calls complete(&info->dev_ready)
  * waitfunc() finally executes
    - because info->is_ready==1, it skips the wait_for_completion...(),
      leaving your completion unbalanced

This influences a comment I have below regarding your re-initialization
of the completion struct.

>  
>  	unsigned int		fifo_size;	/* max. data size in the FIFO */
>  	unsigned int		data_size;	/* data to be read from FIFO */
> @@ -478,7 +485,7 @@ static void start_data_dma(struct pxa3xx_nand_info *info)
>  static irqreturn_t pxa3xx_nand_irq(int irq, void *devid)
>  {
>  	struct pxa3xx_nand_info *info = devid;
> -	unsigned int status, is_completed = 0;
> +	unsigned int status, is_completed = 0, is_ready = 0;
>  	unsigned int ready, cmd_done;
>  
>  	if (info->cs == 0) {
> @@ -514,8 +521,9 @@ static irqreturn_t pxa3xx_nand_irq(int irq, void *devid)
>  		is_completed = 1;
>  	}
>  	if (status & ready) {
> -		info->is_ready = 1;
> +		atomic_set(&info->is_ready, 1);

According to my suggestions, I don't think you need to set
info->is_ready=1 here.

>  		info->state = STATE_READY;
> +		is_ready = 1;
>  	}
>  
>  	if (status & NDSR_WRCMDREQ) {
> @@ -544,6 +552,8 @@ static irqreturn_t pxa3xx_nand_irq(int irq, void *devid)
>  	nand_writel(info, NDSR, status);
>  	if (is_completed)
>  		complete(&info->cmd_complete);
> +	if (is_ready)
> +		complete(&info->dev_ready);
>  NORMAL_IRQ_EXIT:
>  	return IRQ_HANDLED;
>  }
> @@ -574,7 +584,6 @@ static int prepare_command_pool(struct pxa3xx_nand_info *info, int command,
>  	info->oob_size		= 0;
>  	info->use_ecc		= 0;
>  	info->use_spare		= 1;
> -	info->is_ready		= 0;
>  	info->retcode		= ERR_NONE;
>  	if (info->cs != 0)
>  		info->ndcb0 = NDCB0_CSEL;
> @@ -747,6 +756,8 @@ static void pxa3xx_nand_cmdfunc(struct mtd_info *mtd, unsigned command,
>  	exec_cmd = prepare_command_pool(info, command, column, page_addr);
>  	if (exec_cmd) {
>  		init_completion(&info->cmd_complete);
> +		init_completion(&info->dev_ready);

Do you really need to init the completions each time you run a command?
AIUI, the only reason you would need to do this is if you aren't
matching up your calls to complete() and wait_for_completion*()
properly, so that you simply dodge the issue and reset the completion
count each time. This might be a result of the complexity of your
2-completion signalling design.

> +		atomic_set(&info->is_ready, 0);
>  		pxa3xx_nand_start(info);
>  
>  		ret = wait_for_completion_timeout(&info->cmd_complete,
> @@ -859,21 +870,27 @@ static int pxa3xx_nand_waitfunc(struct mtd_info *mtd, struct nand_chip *this)
>  {
>  	struct pxa3xx_nand_host *host = mtd->priv;
>  	struct pxa3xx_nand_info *info = host->info_data;
> +	int ret;
> +
> +	/* Need to wait? */
> +	if (!atomic_read(&info->is_ready)) {

This read of info->is_ready will no longer need to be atomic, because
you never modify it from the IRQ context--only from the cmdfunc() and
waitfunc().

> +		ret = wait_for_completion_timeout(&info->dev_ready,
> +				CHIP_DELAY_TIMEOUT);

I think you can just do a (non-atomic) info->is_ready=1 here.

> +		if (!ret) {
> +			dev_err(&info->pdev->dev, "Ready time out!!!\n");
> +			return NAND_STATUS_FAIL;
> +		}
> +	}
>  
>  	/* pxa3xx_nand_send_command has waited for command complete */
>  	if (this->state == FL_WRITING || this->state == FL_ERASING) {
>  		if (info->retcode == ERR_NONE)
>  			return 0;
> -		else {
> -			/*
> -			 * any error make it return 0x01 which will tell
> -			 * the caller the erase and write fail
> -			 */
> -			return 0x01;
> -		}
> +		else
> +			return NAND_STATUS_FAIL;
>  	}
>  
> -	return 0;
> +	return NAND_STATUS_READY;
>  }
>  
>  static int pxa3xx_nand_config_flash(struct pxa3xx_nand_info *info,
> @@ -1026,7 +1043,7 @@ static int pxa3xx_nand_sensing(struct pxa3xx_nand_info *info)
>  		return ret;
>  
>  	chip->cmdfunc(mtd, NAND_CMD_RESET, 0, 0);
> -	if (info->is_ready)
> +	if (atomic_read(&info->is_ready))

Does this need to wait on the dev_ready completion? I'm not sure I can
guarantee there is no race on info->is_ready here, but then that means
I'm not sure the code is correct even with the atomic read (which I
don't think will be necessary, according to my suggestion above).

>  		return 0;
>  
>  	return -ENODEV;

Brian
