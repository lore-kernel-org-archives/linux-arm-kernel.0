From: shijie8@gmail.com (Huang Shijie)
Date: Sun, 3 Nov 2013 18:03:39 -0500
Subject: [PATCH v2 12/27] mtd: nand: pxa3xx: Use a completion to signal
 device ready
In-Reply-To: <1382137374-21251-13-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1382137374-21251-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1382137374-21251-13-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20131103230337.GF5896@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 18, 2013 at 08:02:39PM -0300, Ezequiel Garcia wrote:
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
> index 95e2ce3..1ceccb6 100644
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
Do we really need to change it to atomic_t?

IMHO, the write is also a atomic operation.

thanks
Huang Shijie
