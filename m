From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat, 17 Oct 2009 16:47:27 +0200
Subject: [PATCH v3 6/7] [ARM]: adds AB4500 as pl022 device
In-Reply-To: <1255300094.21542.414.camel@vinay-desktop>
References: <1255300082.21542.413.camel@vinay-desktop>
	<1255300094.21542.414.camel@vinay-desktop>
Message-ID: <20091017144727.GD14673@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03:58 Mon 12 Oct     , srinidhi kasagar wrote:
> From: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
> 
> This adds AB4500 device support for the
> mop500 board. AB4500 connects to U8500
> on the SSP/SPI bus.
> 
> Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
> Acked-by: Andrea Gallo <andrea.gallo@stericsson.com>
> ---
>  arch/arm/mach-ux500/board-mop500.c |   67 ++++++++++++++++++++++++++++++++++++
>  1 files changed, 67 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
> index fc02e9a..db5aa9e 100644
> --- a/arch/arm/mach-ux500/board-mop500.c
> +++ b/arch/arm/mach-ux500/board-mop500.c
> @@ -14,6 +14,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/io.h>
>  #include <linux/amba/bus.h>
> +#include <linux/amba/pl022.h>
> +#include <linux/spi/spi.h>
>  
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
> @@ -43,10 +45,72 @@ static struct amba_device uart2_device = {
>  	.irq = {IRQ_UART2, NO_IRQ},
>  };
>  
> +static void ab4500_spi_cs_control(u32 command)
> +{
> +	/* set the FRM signal, which is CS  - TODO */
> +}
> +
> +struct pl022_config_chip ab4500_chip_info = {
> +	.lbm = LOOPBACK_DISABLED,
> +	.com_mode = INTERRUPT_TRANSFER,
> +	.iface = SSP_INTERFACE_MOTOROLA_SPI,
> +	/* we can act as master only */
> +	.hierarchy = SSP_MASTER,
> +	.slave_tx_disable = 0,
> +	.endian_rx = SSP_RX_MSB,
> +	.endian_tx = SSP_TX_MSB,
> +	.data_size = SSP_DATA_BITS_24,
> +	.rx_lev_trig = SSP_RX_1_OR_MORE_ELEM,
> +	.tx_lev_trig = SSP_TX_1_OR_MORE_EMPTY_LOC,
> +	.clk_phase = SSP_CLK_SECOND_EDGE,
> +	.clk_pol = SSP_CLK_POL_IDLE_HIGH,
> +	.cs_control = ab4500_spi_cs_control,
> +};
> +
> +static struct spi_board_info u8500_spi_devices[] = {
> +	{
> +	.modalias = "ab4500",
> +	.platform_data = NULL,
no need
> +	.controller_data = &ab4500_chip_info,
> +	.max_speed_hz = 12000000,
> +	.bus_num = 0,
> +	.chip_select = 0,
> +	.mode = SPI_MODE_0,
> +	.irq = AB4500_IRQ,
it will be nice to ident it with one \t more
> +	},
> +};
> +
> +static struct pl022_ssp_controller ssp0_platform_data = {
> +	.bus_id = 0,
> +	/* pl022 not yet supports dma */
> +	.enable_dma = 0,
> +	/* on this platform, gpio 31,142,144,214 &
> +	 * 224 are connected as chip selects
> +	 */
> +	.num_chipselect = 5,
> +};
> +
> +static struct amba_device pl022_device = {
> +	.dev = {
> +		.coherent_dma_mask = ~0,
> +		.init_name = "pl022",
> +		.platform_data = &ssp0_platform_data,
> +	},
> +	.res = {
> +		.start = U8500_SSP0_BASE,
> +		.end   = U8500_SSP0_BASE + SZ_4K - 1,
> +		.flags = IORESOURCE_MEM,
> +	},
> +	.irq = {IRQ_SSP0, NO_IRQ },
> +	/* ST-Ericsson modified id */
> +	.periphid = 0x01080022,
it will be better to have a define here

Best Regards,
J.
