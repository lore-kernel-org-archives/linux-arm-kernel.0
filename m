From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 29 Oct 2012 12:42:21 +0100
Subject: [PATCH 1/6] DMA: AT91: Serial: Add parameter for serial dma use
In-Reply-To: <1351501773-29024-1-git-send-email-elen.song@atmel.com>
References: <1351501754-25028-1-git-send-email-elen.song@atmel.com>
 <1351501773-29024-1-git-send-email-elen.song@atmel.com>
Message-ID: <20121029114221.GA31214@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:09 Mon 29 Oct     , Elen Song wrote:
> Signed-off-by: Elen Song <elen.song@atmel.com>
> ---
>  arch/arm/mach-at91/include/mach/board.h |    2 ++
>  drivers/tty/serial/atmel_serial.c       |    1 +
>  include/linux/platform_data/dma-atmel.h |   10 ++++++++++
>  3 files changed, 13 insertions(+)

you will have to rebase this over a clean if the platofrm_data I'll send today
or tomorrow that will move all the platform_data to inclide/linux

btw your patch broke the avr32

Best Regards.
J.
> 
> diff --git a/arch/arm/mach-at91/include/mach/board.h b/arch/arm/mach-at91/include/mach/board.h
> index c55a436..a2188a6 100644
> --- a/arch/arm/mach-at91/include/mach/board.h
> +++ b/arch/arm/mach-at91/include/mach/board.h
> @@ -129,6 +129,8 @@ struct atmel_uart_data {
>  	short			use_dma_tx;	/* use transmit DMA? */
>  	short			use_dma_rx;	/* use receive DMA? */
>  	void __iomem		*regs;		/* virt. base address, if any */
> +	struct at_dma_slave     *dma_tx_slave;
> +	struct at_dma_slave     *dma_rx_slave;
>  	struct serial_rs485	rs485;		/* rs485 settings */
>  };
>  extern void __init at91_add_device_serial(void);
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 3d7e1ee..1b1bd4f 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -45,6 +45,7 @@
>  
>  #include <asm/mach/serial_at91.h>
>  #include <mach/board.h>
> +#include <linux/platform_data/dma-atmel.h>
>  
>  #ifdef CONFIG_ARM
>  #include <mach/cpu.h>
> diff --git a/include/linux/platform_data/dma-atmel.h b/include/linux/platform_data/dma-atmel.h
> index cab0997..bb05302 100644
> --- a/include/linux/platform_data/dma-atmel.h
> +++ b/include/linux/platform_data/dma-atmel.h
> @@ -26,11 +26,21 @@ struct at_dma_platform_data {
>  /**
>   * struct at_dma_slave - Controller-specific information about a slave
>   * @dma_dev: required DMA master device
> + * @tx_reg: physical address of data register used for
> + *      memory-to-peripheral transfers
> + * @rx_reg: physical address of data register used for
> + *      peripheral-to-memory transfers
> + * @reg_width: peripheral register width
>   * @cfg: Platform-specific initializer for the CFG register
> + * @ctrla: Platform-specific initializer for the CTRLA register
>   */
>  struct at_dma_slave {
>  	struct device		*dma_dev;
> +	dma_addr_t              tx_reg;
> +	dma_addr_t              rx_reg;
> +	u32			reg_width;
>  	u32			cfg;
> +	u32                     ctrla;
>  };
>  
>  
> -- 
> 1.7.9.5
> 
