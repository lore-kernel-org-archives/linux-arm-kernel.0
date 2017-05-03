From: cyrille.pitchen@wedev4u.fr (Cyrille Pitchen)
Date: Wed, 3 May 2017 23:23:32 +0200
Subject: [RFC PATCH] mtd: spi-nor: handle signal case as failure
In-Reply-To: <1493805189-25327-1-git-send-email-der.herr@hofr.at>
References: <1493805189-25327-1-git-send-email-der.herr@hofr.at>
Message-ID: <b3de06f6-9fcd-4b58-60f2-14c55d83898d@wedev4u.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Le 03/05/2017 ? 11:53, Nicholas Mc Guire a ?crit :
>  The problem is that stm32_qspi_wait_cmd() will indicate success in case of
>  being interrupted. The if condition is incomplete here as
>  wait_for_copletion_interruptible_timeout can return -ERESTARTSYS but this
>  is not handled by if(!wait_for_completion_interruptible_timeout()).
>  While somewhat unlikely it probably would be hard to figure out what went
>  wrong if the signal case does occur.
> 
> Fixes: commit 0d43d7ab277a ("mtd: spi-nor: add driver for STM32 quad spi flash controller")
> Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
> ---
> Problem found by experimental coccinelle script
> 
> Its not clear if its sufficient to simply treat this case as failure or
> if it might need some debug output to allow differentiation of signal
> and timeout case. 
> 
> Patch was compile tested with: stm32_defconfig +CONFIG_MTD=y, CONFIG_MTD_SPI_NOR=y,
> CONFIG_SPI_STM32_QUADSPI=m
> 
> Patch is against v4.11-rc8 (localversion-next is next-20170503)
> 
>  drivers/mtd/spi-nor/stm32-quadspi.c  | 10 ++++++++--
>  1 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/stm32-quadspi.c b/drivers/mtd/spi-nor/stm32-quadspi.c
> index 1056e74..27147ad 100644
> --- a/drivers/mtd/spi-nor/stm32-quadspi.c
> +++ b/drivers/mtd/spi-nor/stm32-quadspi.c
> @@ -159,6 +159,7 @@ static int stm32_qspi_wait_cmd(struct stm32_qspi *qspi)
>  {
>  	u32 cr;
>  	int err = 0;
> +	long timeout = 0;
>  
>  	if (readl_relaxed(qspi->io_base + QUADSPI_SR) & SR_TCF)
>  		return 0;
> @@ -167,8 +168,13 @@ static int stm32_qspi_wait_cmd(struct stm32_qspi *qspi)
>  	cr = readl_relaxed(qspi->io_base + QUADSPI_CR);
>  	writel_relaxed(cr | CR_TCIE, qspi->io_base + QUADSPI_CR);
>  
> -	if (!wait_for_completion_interruptible_timeout(&qspi->cmd_completion,
> -						       msecs_to_jiffies(1000)))

Ludovic, can we just use wait_for_completion_timeout() instead?
I think so but you surely know better than me :)
Do you plan to receive signal? maybe to abort the current SPI flash command?

Best regards,

Cyrille

> +	timeout = wait_for_completion_interruptible_timeout(
> +				&qspi->cmd_completion, msecs_to_jiffies(1000));
> +
> +	/* since the calling side only cares about success of failure
> +	 * returning -ETIMEDOUT even when interrupted should be ok here
> +	 */
> +	if (timeout == 0 || timeout == -ERESTARTSYS)
>  		err = -ETIMEDOUT;
>  
>  	writel_relaxed(cr, qspi->io_base + QUADSPI_CR);
> 
