From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 13 Jun 2013 21:12:55 +0900
Subject: [PATCH 1/2] ARM: dts: enable spi for EXYNOS5440 SOC
In-Reply-To: <1366102733-3570-1-git-send-email-ks.giri@samsung.com>
References: <1366102733-3570-1-git-send-email-ks.giri@samsung.com>
Message-ID: <150c01ce682f$55c44200$014cc600$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Girish K S wrote:
> 
> This patch enables the SPI in EXYNOS5440 SoC. The NOR
> Flash can be accessed by enabling the spi interface
> 
> Signed-off-by: Girish K S <ks.giri@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5440-ssdk5440.dts |   39
> +++++++++++++++++++++++++++-
>  arch/arm/boot/dts/exynos5440.dtsi         |   16 +++++++----
>  2 files changed, 47 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos5440-ssdk5440.dts
> b/arch/arm/boot/dts/exynos5440-ssdk5440.dts
> index d55042b..a85ac0e 100644
> --- a/arch/arm/boot/dts/exynos5440-ssdk5440.dts
> +++ b/arch/arm/boot/dts/exynos5440-ssdk5440.dts
> @@ -20,8 +20,43 @@
>  		bootargs = "root=/dev/sda2 rw rootwait ignore_loglevel
> early_printk no_console_suspend mem=2048M at 0x80000000
> console=ttySAC0,115200";
>  	};
> 
> -	spi {
> -		status = "disabled";
> +	spi_0: spi at D0000 {
> +
> +		flash: w25q128 at 0 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			compatible = "winbond,w25q128";
> +			spi-max-frequency = <15625000>;
> +			reg = <0>;
> +			controller-data {
> +				samsung,spi-feedback-delay = <0>;
> +			};
> +
> +			partition at 00000 {
> +				label = "BootLoader";
> +				reg = <0x60000 0x80000>;
> +				read-only;
> +			};
> +
> +			partition at e0000 {
> +				label = "Recovery-Kernel";
> +				reg = <0xe0000 0x300000>;
> +				read-only;
> +			};
> +
> +			partition at 3e0000 {
> +				label = "CRAM-FS";
> +				reg = <0x3e0000 0x700000>;
> +				read-only;
> +			};
> +
> +			partition at ae0000 {
> +				label = "User-Data";
> +				reg = <0xae0000 0x520000>;
> +			};
> +
> +		};
> +
>  	};
> 
>  	fixed-rate-clocks {
> diff --git a/arch/arm/boot/dts/exynos5440.dtsi
> b/arch/arm/boot/dts/exynos5440.dtsi
> index f6b1c89..7c5dc38 100644
> --- a/arch/arm/boot/dts/exynos5440.dtsi
> +++ b/arch/arm/boot/dts/exynos5440.dtsi
> @@ -16,6 +16,10 @@
> 
>  	interrupt-parent = <&gic>;
> 
> +	aliases {
> +		spi0 = &spi_0;
> +	};
> +
>  	clock: clock-controller at 0x160000 {
>  		compatible = "samsung,exynos5440-clock";
>  		reg = <0x160000 0x1000>;
> @@ -101,15 +105,15 @@
>  		clock-names = "uart", "clk_uart_baud0";
>  	};
> 
> -	spi {
> -		compatible = "samsung,exynos4210-spi";
> -		reg = <0xD0000 0x1000>;
> +	spi_0: spi at D0000 {
> +		compatible = "samsung,exynos5440-spi";
> +		reg = <0xD0000 0x100>;
>  		interrupts = <0 4 0>;
> -		tx-dma-channel = <&pdma0 5>; /* preliminary */
> -		rx-dma-channel = <&pdma0 4>; /* preliminary */
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> -		clocks = <&clock 21>, <&clock 16>;
> +		samsung,spi-src-clk = <0>;
> +		num-cs = <1>;
> +		clocks = <&clock 8>, <&clock 3>;

Should be,
+		clocks = <&clock 21>, <&clock 16>;

>  		clock-names = "spi", "spi_busclk0";
>  	};
> 
> --

Others, look good to me, and please create separated patches for SoC and
board.

Anway, will apply with fix the clock.

Thanks,
- Kukjin
