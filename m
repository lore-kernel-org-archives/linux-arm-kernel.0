From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 7 Apr 2010 15:40:39 +0200
Subject: [PATCH] ARM: MXC: mxc_nand: support i.MX21
In-Reply-To: <q2tba216b431004060652jeb9df33eqd141836e46980f00@mail.gmail.com>
References: <q2tba216b431004060652jeb9df33eqd141836e46980f00@mail.gmail.com>
Message-ID: <20100407134039.GE3688@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 06, 2010 at 03:52:23PM +0200, Ivo Clarysse wrote:
> Allow mxc_nand.c to function on i.MX21 SoCs, since:
> 
> 1) On i.MX21, if the NFC_INT_MASK bit in NFC_CONFIG1 is set, the NFC_INT
>   bit of NFC_CONFIG2 always reads out zero, even if an operation is
>   completed.
> 
> 2) On i.MX21, sending a RESET command to the NAND flash controller does
>   not trigger an interrupt, nor does it cause the NFC_INT bit of
>   NFC_CONFIG2 to get set.
> 
> To accommodate for this, I modified the interrupt handler to use
> completions instead of a wait queue, and check the value of NFC_CONFIG2
> in the interrupt handler instead of after wait_event(..)
> 
> To allow polling for a basic NFC operation to complete, I leave
> the interrupt handler disabled using disable_irq(..) and only enable it
> for interrupt-based basic operations.
> 
> Signed-off-by: Ivo Clarysse <ivo.clarysse@gmail.com>
> ---
> diff -u -r -N linux-2.6.33.2/drivers/mtd/nand/mxc_nand.c
> linux-2.6.33.2-mine/drivers/mtd/nand/mxc_nand.c
> --- linux-2.6.33.2/drivers/mtd/nand/mxc_nand.c	2010-04-02
> 01:02:33.000000000 +0200
> +++ linux-2.6.33.2-mine/drivers/mtd/nand/mxc_nand.c	2010-04-06
> 15:40:55.000000000 +0200
> @@ -38,7 +38,7 @@
>  #define DRIVER_NAME "mxc_nand"
> 
>  #define nfc_is_v21()		(cpu_is_mx25() || cpu_is_mx35())
> -#define nfc_is_v1()		(cpu_is_mx31() || cpu_is_mx27())
> +#define nfc_is_v1()		(cpu_is_mx31() || cpu_is_mx27() || cpu_is_mx21())
> 
>  /* Addresses for NFC registers */
>  #define NFC_BUF_SIZE		0xE00
> @@ -111,7 +111,7 @@
>  	int			clk_act;
>  	int			irq;
> 
> -	wait_queue_head_t	irq_waitq;
> +	struct completion	op_completion;
> 
>  	uint8_t			*data_buf;
>  	unsigned int		buf_start;
> @@ -168,13 +168,21 @@
>  {
>  	struct mxc_nand_host *host = dev_id;
> 
> -	uint16_t tmp;
> +	uint16_t tmp, config2;
> +
> +	/* On i.MX21, setting NFC_INT_MSK of NFC_CONFIG2
> +	 * will clear NFC_INT in NFC_CONFIG1, so we read
> +	 * NFC_CONFIG2 first.
> +	 */
> +	config2 = readw(host->regs + NFC_CONFIG2);
> 
>  	tmp = readw(host->regs + NFC_CONFIG1);
>  	tmp |= NFC_INT_MSK; /* Disable interrupt */
>  	writew(tmp, host->regs + NFC_CONFIG1);
> 
> -	wake_up(&host->irq_waitq);
> +	if (config2 & NFC_INT) {
> +		complete(&host->op_completion);
> +	}

Why do we need the check for NFC_INT? This is no shared interrupt so we
can be sure the nfc actually has an interrupt.
What's wrong with the current waitqueue approach?

> 
>  	return IRQ_HANDLED;
>  }
> @@ -185,7 +193,7 @@
>  static void wait_op_done(struct mxc_nand_host *host, int useirq)
>  {
>  	uint32_t tmp;
> -	int max_retries = 2000;
> +	int max_retries = 8000;
> 
>  	if (useirq) {
>  		if ((readw(host->regs + NFC_CONFIG2) & NFC_INT) == 0) {
> @@ -194,14 +202,28 @@
>  			tmp  &= ~NFC_INT_MSK;	/* Enable interrupt */
>  			writew(tmp, host->regs + NFC_CONFIG1);
> 
> -			wait_event(host->irq_waitq,
> -				readw(host->regs + NFC_CONFIG2) & NFC_INT);
> +			INIT_COMPLETION(host->op_completion);

This does not work. You have to call INIT_COMPLETION before enabling the
interrupt, otherwise we get stuck when the interrupt comes between
enabling it and initialising the completion.

> +
> +			if (cpu_is_mx21()) {
> +				enable_irq(host->irq);
> +			}
> +
> +			wait_for_completion(&host->op_completion);
> +
> +			if (cpu_is_mx21()) {
> +				disable_irq(host->irq);
> +			}
> 
>  			tmp = readw(host->regs + NFC_CONFIG2);
>  			tmp  &= ~NFC_INT;
>  			writew(tmp, host->regs + NFC_CONFIG2);
>  		}
>  	} else {
> +		if (cpu_is_mx21()) {
> +			tmp = readw(host->regs + NFC_CONFIG1);
> +			tmp  &= ~NFC_INT_MSK;	/* Enable interrupt */
> +			writew(tmp, host->regs + NFC_CONFIG1);
> +		}
>  		while (max_retries-- > 0) {
>  			if (readw(host->regs + NFC_CONFIG2) & NFC_INT) {
>  				tmp = readw(host->regs + NFC_CONFIG2);
> @@ -211,6 +233,11 @@
>  			}
>  			udelay(1);
>  		}
> +		if (cpu_is_mx21()) {
> +			tmp = readw(host->regs + NFC_CONFIG1);
> +			tmp  |= NFC_INT_MSK;
> +			writew(tmp, host->regs + NFC_CONFIG1);
> +		}
>  		if (max_retries < 0)
>  			DEBUG(MTD_DEBUG_LEVEL0, "%s: INT not set\n",
>  			      __func__);
> @@ -559,6 +586,24 @@
> 
>  	/* Command pre-processing step */
>  	switch (command) {
> +	case NAND_CMD_RESET:
> +		if (cpu_is_mx21()) {
> +			int max_retries = 100;
> +			writew(command, host->regs + NFC_FLASH_CMD);
> +			writew(NFC_CMD, host->regs + NFC_CONFIG2);

I just realized that the original driver does not handle the reset
command at all. Maybe we should fix this first, like this:

	case NAND_CMD_RESET:
		writew(command, host->regs + NFC_FLASH_CMD);
		writew(NFC_CMD, host->regs + NFC_CONFIG2);
		if (cpu_is_mx21()){
			...
		} else
			wait_op_done(host, 0);

> +			/* Reset completion is indicated by NFC_CONFIG2 */
> +			/* being set to 0 */
> +			while (max_retries-- > 0) {
> +				if (readw(host->regs + NFC_CONFIG2) == 0) {
> +					break;
> +				}
> +				udelay(1);
> +			}
> +			if (max_retries < 0)
> +				DEBUG(MTD_DEBUG_LEVEL0, "%s: RESET failed\n",
> +				      __func__);
> +		}
> +		break;
> 
>  	case NAND_CMD_STATUS:
>  		host->buf_start = 0;
> @@ -758,7 +803,7 @@
>  	tmp &= ~NFC_SP_EN;
>  	writew(tmp, host->regs + NFC_CONFIG1);
> 
> -	init_waitqueue_head(&host->irq_waitq);
> +	init_completion(&host->op_completion);
> 
>  	host->irq = platform_get_irq(pdev, 0);
> 
> @@ -766,6 +811,10 @@
>  	if (err)
>  		goto eirq;
> 
> +	if (cpu_is_mx21()) {
> +		disable_irq(host->irq);
> +	}
> +
>  	/* Reset NAND */
>  	this->cmdfunc(mtd, NAND_CMD_RESET, -1, -1);
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
