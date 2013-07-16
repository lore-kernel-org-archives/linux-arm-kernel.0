From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 16 Jul 2013 16:09:24 +0900
Subject: [PATCH v2 6/6] ARM: S3C24XX: Convert s3c2416 and s3c2443 to common
 clock framework
In-Reply-To: <201307100100.28992.heiko@sntech.de>
References: <201307100057.06061.heiko@sntech.de>
 <201307100100.28992.heiko@sntech.de>
Message-ID: <02cf01ce81f3$6777e5f0$3667b1d0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko St?bner wrote:
> 
> This converts the mentioned platforms to use the newly introduced driver
> for the common clock framework for them.
> 
> With this the whole legacy clock structure can go away too.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/arm/boot/dts/s3c2416-smdk2416.dts  |    7 +
>  arch/arm/boot/dts/s3c2416.dtsi          |   42 ++
>  arch/arm/mach-s3c24xx/Kconfig           |   14 +-
>  arch/arm/mach-s3c24xx/Makefile          |    5 +-
>  arch/arm/mach-s3c24xx/clock-s3c2416.c   |  171 --------
>  arch/arm/mach-s3c24xx/clock-s3c2443.c   |  212 ----------
>  arch/arm/mach-s3c24xx/common-s3c2443.c  |  677 ---------------------------
> ----

In this case, to use '-D' in format-patch would be better :-)

>  arch/arm/mach-s3c24xx/common.c          |   18 +-
>  arch/arm/mach-s3c24xx/common.h          |    8 +
>  arch/arm/mach-s3c24xx/mach-s3c2416-dt.c |   45 +-
>  arch/arm/mach-s3c24xx/mach-smdk2416.c   |    9 +-
>  arch/arm/mach-s3c24xx/mach-smdk2443.c   |    9 +-
>  12 files changed, 102 insertions(+), 1115 deletions(-)
>  delete mode 100644 arch/arm/mach-s3c24xx/clock-s3c2416.c
>  delete mode 100644 arch/arm/mach-s3c24xx/clock-s3c2443.c
>  delete mode 100644 arch/arm/mach-s3c24xx/common-s3c2443.c
> 
> diff --git a/arch/arm/boot/dts/s3c2416-smdk2416.dts
> b/arch/arm/boot/dts/s3c2416-smdk2416.dts
> index 59594cf..9caeb89 100644
> --- a/arch/arm/boot/dts/s3c2416-smdk2416.dts
> +++ b/arch/arm/boot/dts/s3c2416-smdk2416.dts
> @@ -19,6 +19,13 @@
>  		reg =  <0x30000000 0x4000000>;
>  	};
> 
> +	fixed-rate-clocks {
> +		xti {
> +			compatible = "samsung,clock-xti";
> +			clock-frequency = <12000000>;
> +		};
> +	};
> +
>  	serial at 50000000 {
>  		status = "okay";
>  		pinctrl-names = "default";
> diff --git a/arch/arm/boot/dts/s3c2416.dtsi
> b/arch/arm/boot/dts/s3c2416.dtsi
> index e6555bd..c19d99c 100644
> --- a/arch/arm/boot/dts/s3c2416.dtsi
> +++ b/arch/arm/boot/dts/s3c2416.dtsi
> @@ -8,6 +8,7 @@
>   * published by the Free Software Foundation.
>   */
> 
> +#include <dt-bindings/clock/samsung,s3c2443-clock.h>
>  #include "s3c24xx.dtsi"
>  #include "s3c2416-pinctrl.dtsi"
> 
> @@ -28,26 +29,53 @@
>  		compatible = "samsung,s3c2416-irq";
>  	};
> 
> +	clocks: clock-controller at 0x4c000000 {

+	clock: clock-controller at 0x4c000000 {

for keeping same format for Samsung stuff...

> +		compatible = "samsung,s3c2416-clock";
> +		reg = <0x4c000000 0x40>;
> +		#clock-cells = <1>;
> +	};
> +
>  	pinctrl at 56000000 {
>  		compatible = "samsung,s3c2416-pinctrl";
>  	};
> 
> +	timer at 51000000 {
> +		clocks = <&clocks PCLK_PWM>;

+		clocks = <&clock PCLK_PWM>;

And I'm not sure using definition PCLK_PWM is better here...

> +		clock-names = "timers";
> +	};
> +
>  	serial at 50000000 {
>  		compatible = "samsung,s3c2440-uart";
> +		clock-names = "uart", "clk_uart_baud2",
> +				"clk_uart_baud3";
> +		clocks = <&clocks PCLK_UART0>, <&clocks PCLK_UART0>,
> +				<&clocks SCLK_UART>;

Please use same ordering...for 'clocks' and 'clock-names'.
See above the timers...'clocks' then 'clock-names'...

>  	};
> 
>  	serial at 50004000 {
>  		compatible = "samsung,s3c2440-uart";
> +		clock-names = "uart", "clk_uart_baud2",
> +				"clk_uart_baud3";
> +		clocks = <&clocks PCLK_UART1>, <&clocks PCLK_UART1>,
> +				<&clocks SCLK_UART>;

Same as above.

>  	};
> 
>  	serial at 50008000 {
>  		compatible = "samsung,s3c2440-uart";
> +		clock-names = "uart", "clk_uart_baud2",
> +				"clk_uart_baud3";
> +		clocks = <&clocks PCLK_UART2>, <&clocks PCLK_UART2>,
> +				<&clocks SCLK_UART>;

Same as above.

>  	};
> 
>  	serial at 5000C000 {
>  		compatible = "samsung,s3c2440-uart";
>  		reg = <0x5000C000 0x4000>;
>  		interrupts = <1 18 24 4>, <1 18 25 4>;
> +		clock-names = "uart", "clk_uart_baud2",
> +				"clk_uart_baud3";
> +		clocks = <&clocks PCLK_UART3>, <&clocks PCLK_UART3>,
> +				<&clocks SCLK_UART>;

Same as above.

>  		status = "disabled";
>  	};
> 
> @@ -55,6 +83,10 @@
>  		compatible = "samsung,s3c6410-sdhci";
>  		reg = <0x4AC00000 0x100>;
>  		interrupts = <0 0 21 3>;
> +		clock-names = "hsmmc", "mmc_busclk.0",
> +				"mmc_busclk.2";
> +		clocks = <&clocks HCLK_HSMMC0>, <&clocks HCLK_HSMMC0>,
> +				<&clocks MUX_HSMMC0>;

Same.

>  		status = "disabled";
>  	};
> 
> @@ -62,18 +94,28 @@
>  		compatible = "samsung,s3c6410-sdhci";
>  		reg = <0x4A800000 0x100>;
>  		interrupts = <0 0 20 3>;
> +		clock-names = "hsmmc", "mmc_busclk.0",
> +				"mmc_busclk.2";
> +		clocks = <&clocks HCLK_HSMMC1>, <&clocks HCLK_HSMMC1>,
> +				<&clocks MUX_HSMMC1>;

Same.

>  		status = "disabled";
>  	};
> 
>  	watchdog at 53000000 {
>  		interrupts = <1 9 27 3>;
> +		clocks = <&clocks PCLK_WDT>;
> +		clock-names = "watchdog";
>  	};
> 
>  	rtc at 57000000 {
>  		compatible = "samsung,s3c2416-rtc";
> +		clocks = <&clocks PCLK_RTC>;
> +		clock-names = "rtc";
>  	};
> 
>  	i2c at 54000000 {
>  		compatible = "samsung,s3c2440-i2c";
> +		clocks = <&clocks PCLK_I2C0>;
> +		clock-names = "i2c";
>  	};
>  };
> diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
> index b8ec0ec..37cbe5f 100644
> --- a/arch/arm/mach-s3c24xx/Kconfig
> +++ b/arch/arm/mach-s3c24xx/Kconfig
> @@ -49,9 +49,9 @@ config CPU_S3C2416
>  	select CPU_ARM926T
>  	select CPU_LLSERIAL_S3C2440
>  	select S3C2416_PM if PM
> -	select S3C2443_COMMON
>  	select S3C2443_DMA if S3C24XX_DMA
> -	select SAMSUNG_CLKSRC
> +	select COMMON_CLK
> +	select COMMON_CLK_S3C2443

Please put them in alphabetical ordering...

>  	help
>  	  Support for the S3C2416 SoC from the S3C24XX line
> 
> @@ -83,9 +83,9 @@ config CPU_S3C2443
>  	bool "SAMSUNG S3C2443"
>  	select CPU_ARM920T
>  	select CPU_LLSERIAL_S3C2440
> -	select S3C2443_COMMON
>  	select S3C2443_DMA if S3C24XX_DMA
> -	select SAMSUNG_CLKSRC
> +	select COMMON_CLK
> +	select COMMON_CLK_S3C2443

Same as above.

>  	help
>  	  Support for the S3C2443 SoC from the S3C24XX line
> 
> @@ -663,12 +663,6 @@ endif	# CPU_S3C2442
> 
>  if CPU_S3C2443 || CPU_S3C2416
> 
> -config S3C2443_COMMON
> -	bool
> -	help
> -	  Common code for the S3C2443 and similar processors, which
> includes
> -	  the S3C2416 and S3C2450.
> -
>  config S3C2443_DMA
>  	bool
>  	help

[...]

Thanks,
- Kukjin
