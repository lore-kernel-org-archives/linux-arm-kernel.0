From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 Mar 2012 14:05:49 +0000
Subject: [PATCH 10/10] ARM: ux500: Enable PL022 SSP Controller in Device
 Tree
In-Reply-To: <1331730306-11461-11-git-send-email-lee.jones@linaro.org>
References: <1331730306-11461-1-git-send-email-lee.jones@linaro.org>
 <1331730306-11461-11-git-send-email-lee.jones@linaro.org>
Message-ID: <201203141405.50005.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 March 2012, Lee Jones wrote:
> This SSP Controller supports a number of serial communication methods.
> 
> Namely:
> 
> /**
>  * enum ssp_interface - interfaces allowed for this SSP Controller
>  * @SSP_INTERFACE_MOTOROLA_SPI: Motorola Interface
>  * @SSP_INTERFACE_TI_SYNC_SERIAL: Texas Instrument Synchronous Serial
>  * interface
>  * @SSP_INTERFACE_NATIONAL_MICROWIRE: National Semiconductor Microwire
>  * interface
>  * @SSP_INTERFACE_UNIDIRECTIONAL: Unidirectional interface (STn8810
>  * &STn8815 only)
>  */
> 
> ... and as such cannot be registered using of_register_spi_devices.
> Instead it can be registered simply as a primecell device.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Looks good to me, but this one needs review from Grant as the maintainer
for both device tree and SPI.

For this to be functional, I think you also need a way for the SPI
controller to find the child devices from the device tree, but I
don't see how ux500 currently does it, or how it should be done.

Acked-by: Arnd Bergmann <arnd@arndb.de>

> ---
>  arch/arm/boot/dts/db8500.dtsi      |    5 ++++-
>  arch/arm/mach-ux500/board-mop500.c |    6 +++---
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/db8500.dtsi b/arch/arm/boot/dts/db8500.dtsi
> index 6ae7f69..a9866a3 100644
> --- a/arch/arm/boot/dts/db8500.dtsi
> +++ b/arch/arm/boot/dts/db8500.dtsi
> @@ -206,11 +206,14 @@
>  		ssp at 80002000 {
>  			compatible = "arm,pl022", "arm,primecell";
>  			reg = <80002000 0x1000>;
> -			interrupts = <14>;
> +			interrupts = <0 14 4>;
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			status = "disabled";
> +
> +			// Add one of these for each child device
>  			cs-gpios = <&gpio0 31 &gpio4 14 &gpio4 16 &gpio6 22 &gpio7 0>;
> +
>  		};
>  
>  		uart at 80120000 {
> diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
> index ea0242a..d0799d5 100644
> --- a/arch/arm/mach-ux500/board-mop500.c
> +++ b/arch/arm/mach-ux500/board-mop500.c
> @@ -443,7 +443,7 @@ static struct stedma40_chan_cfg ssp0_dma_cfg_tx = {
>  };
>  #endif
>  
> -static struct pl022_ssp_controller ssp0_platform_data = {
> +static struct pl022_ssp_controller ssp0_plat = {
>  	.bus_id = 0,
>  #ifdef CONFIG_STE_DMA40
>  	.enable_dma = 1,
> @@ -461,7 +461,7 @@ static struct pl022_ssp_controller ssp0_platform_data = {
>  
>  static void __init mop500_spi_init(struct device *parent)
>  {
> -	db8500_add_ssp0(parent, &ssp0_platform_data);
> +	db8500_add_ssp0(parent, &ssp0_plat);
>  }
>  
>  #ifdef CONFIG_STE_DMA40
> @@ -749,6 +749,7 @@ struct of_dev_auxdata u8500_auxdata_lookup[] __initdata = {
>  	OF_DEV_AUXDATA("arm,pl011", 0x80120000, "uart0", &uart0_plat),
>  	OF_DEV_AUXDATA("arm,pl011", 0x80121000, "uart1", &uart1_plat),
>  	OF_DEV_AUXDATA("arm,pl011", 0x80007000, "uart2", &uart2_plat),
> +	OF_DEV_AUXDATA("arm,pl022", 0x80002000, "ssp0",  &ssp0_plat),
>  	{},
>  };
>  
> @@ -804,7 +805,6 @@ static void __init u8500_init_machine(void)
>  		hrefv60_sdi_init(parent);
>  	}
>  	mop500_i2c_init(parent);
> -	mop500_spi_init(parent);
>  
>  	i2c_register_board_info(0, mop500_i2c0_devices, i2c0_devs);
>  	i2c_register_board_info(2, mop500_i2c2_devices,
> -- 
> 1.7.5.4
> 
> 
