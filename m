From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 31 Jan 2016 12:06:25 +0100
Subject: [PATCH v4 9/9] ARM: dts: rockchip: support the spi for rk3036
In-Reply-To: <1453970618-4383-10-git-send-email-wxt@rock-chips.com>
References: <1453970618-4383-1-git-send-email-wxt@rock-chips.com>
 <1453970618-4383-10-git-send-email-wxt@rock-chips.com>
Message-ID: <3295129.SttO6ack9z@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Caesar,

Am Donnerstag, 28. Januar 2016, 16:43:38 schrieb Caesar Wang:
> You have to use the 4 bus to work if someone wants to support
> the spi devices, since the the pin is re-used by data[5-8] and spi.
> If support the spi making the happy work, that will waste the
> emmc performance.
> 
> Moment, the kylin hasn't the spi devices to work, so maybe we need wait
> the new required to enable in kylin board.
> 
> Anyway, the spi should be needed land in rk3036 dts.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> 
> ---
> 
> Changes in v4:
> - Add this patch included in kylin series patches.
> 
>  arch/arm/boot/dts/rk3036.dtsi | 42
> ++++++++++++++++++++++++++++++++++++++++++ 1 file changed, 42
> insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
> index 532f232..40a5017 100644
> --- a/arch/arm/boot/dts/rk3036.dtsi
> +++ b/arch/arm/boot/dts/rk3036.dtsi
> @@ -60,6 +60,7 @@
>  		serial0 = &uart0;
>  		serial1 = &uart1;
>  		serial2 = &uart2;
> +		spi = &spi;
>  	};
> 
>  	memory {
> @@ -485,6 +486,23 @@
>  		status = "disabled";
>  	};
> 
> +	spi: spi at 20074000 {
> +		compatible = "rockchip,rockchip-spi";
> +		reg = <0x20074000 0x1000>;
> +		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&spi_txd &spi_rxd &spi_clk &spi_cs0 &spi_cs1>;

Do we really want to enable both chip-selects by default?

On the rk3288 Lin Huang wrote:
    * It's assumed that most users of the SPI ports are using chip select
      0.  Thus the default pinctrl for the ports enables chip select 0
      (but not chip select 1 on ports that have it).  If a board wants to
      use chip select 1 or wants a GPIO chip select the board should
      override the pinctrl (just like boards can override UART pinctrl if
      they have hardware flow control).

Do we expect again mostly a use of cs0 or will in the major cases both chip-
selects be needed?


> +		num-cs = <2>;
> +		clocks =<&cru PCLK_SPI>, <&cru SCLK_SPI>;
> +		clock-names = "apb-pclk","spi_pclk";
> +		dmas = <&pdma 8>, <&pdma 9>;
> +		#dma-cells = <2>;

What do you need #dma-cells for? This is not a dma-controller :-)


> +		dma-names = "tx", "rx";
> +		status = "disabled";
> +	};


Also I'd suggest an ordering like:

+	spi: spi at 20074000 {
+		compatible = "rockchip,rockchip-spi";
+		reg = <0x20074000 0x1000>;
+		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+		clocks =<&cru PCLK_SPI>, <&cru SCLK_SPI>;
+		clock-names = "apb-pclk","spi_pclk";
+		dmas = <&pdma 8>, <&pdma 9>;
+		dma-names = "tx", "rx";
+		num-cs = <2>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&spi_txd &spi_rxd &spi_clk &spi_cs0 &spi_cs1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};


Heiko
