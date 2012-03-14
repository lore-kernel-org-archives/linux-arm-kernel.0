From: robherring2@gmail.com (Rob Herring)
Date: Wed, 14 Mar 2012 10:00:16 -0500
Subject: [PATCH 08/10] ARM: ux500: Enable PL011 AMBA UART Controller for
 Device Tree
In-Reply-To: <1331730306-11461-9-git-send-email-lee.jones@linaro.org>
References: <1331730306-11461-1-git-send-email-lee.jones@linaro.org>
 <1331730306-11461-9-git-send-email-lee.jones@linaro.org>
Message-ID: <4F60B280.1080404@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/14/2012 08:05 AM, Lee Jones wrote:
> Enables the 3 UARTs found on a u8500 using DT.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/arm/boot/dts/db8500.dtsi      |    6 +++---
>  arch/arm/boot/dts/snowball.dts     |   12 ++++++++++++
>  arch/arm/mach-ux500/board-mop500.c |    4 +++-
>  3 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/db8500.dtsi b/arch/arm/boot/dts/db8500.dtsi
> index 35d0146..9b5e06e 100644
> --- a/arch/arm/boot/dts/db8500.dtsi
> +++ b/arch/arm/boot/dts/db8500.dtsi
> @@ -208,19 +208,19 @@
>  		uart at 80120000 {
>  			compatible = "arm,pl011", "arm,primecell";
>  			reg = <0x80120000 0x1000>;
> -			interrupts = <11>;
> +			interrupts = <0 11 0x4>;
>  			status = "disabled";
>  		};
>  		uart at 80121000 {
>  			compatible = "arm,pl011", "arm,primecell";
>  			reg = <0x80121000 0x1000>;
> -			interrupts = <19>;
> +			interrupts = <0 19 0x4>;
>  			status = "disabled";
>  		};
>  		uart at 80007000 {
>  			compatible = "arm,pl011", "arm,primecell";
>  			reg = <0x80007000 0x1000>;
> -			interrupts = <26>;
> +			interrupts = <0 26 0x4>;
>  			status = "disabled";
>  		};
>  
> diff --git a/arch/arm/boot/dts/snowball.dts b/arch/arm/boot/dts/snowball.dts
> index 34bfd79..359c6d6 100644
> --- a/arch/arm/boot/dts/snowball.dts
> +++ b/arch/arm/boot/dts/snowball.dts
> @@ -96,6 +96,18 @@
>  			status = "enabled";
>  		};
>  
> +		uart at 80120000 {
> +			status = "okay";
> +		};
> +
> +		uart at 80121000 {
> +			status = "okay";
> +		};
> +
> +		uart at 80007000 {
> +			status = "okay";
> +		};
> +
>  		i2c at 80004000 {
>  			tc3589x at 42 {
>  				//compatible = "tc3589x";
> diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
> index 482b86e..ea0242a 100644
> --- a/arch/arm/mach-ux500/board-mop500.c
> +++ b/arch/arm/mach-ux500/board-mop500.c
> @@ -746,6 +746,9 @@ MACHINE_END
>  #ifdef CONFIG_MACH_UX500_DT
>  
>  struct of_dev_auxdata u8500_auxdata_lookup[] __initdata = {
> +	OF_DEV_AUXDATA("arm,pl011", 0x80120000, "uart0", &uart0_plat),
> +	OF_DEV_AUXDATA("arm,pl011", 0x80121000, "uart1", &uart1_plat),
> +	OF_DEV_AUXDATA("arm,pl011", 0x80007000, "uart2", &uart2_plat),

Unless I'm blind, the pl011 driver doesn't take any platform data.

Rob

>  	{},
>  };
>  
> @@ -802,7 +805,6 @@ static void __init u8500_init_machine(void)
>  	}
>  	mop500_i2c_init(parent);
>  	mop500_spi_init(parent);
> -	mop500_uart_init(parent);
>  
>  	i2c_register_board_info(0, mop500_i2c0_devices, i2c0_devs);
>  	i2c_register_board_info(2, mop500_i2c2_devices,
