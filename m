From: jbrunet@baylibre.com (Jerome Brunet)
Date: Tue, 27 Mar 2018 11:20:50 +0200
Subject: [PATCH 3/3] ARM64: dts: meson: fix clock source of the pclk for
 UART_AO
In-Reply-To: <20180326081809.49493-4-yixun.lan@amlogic.com>
References: <20180326081809.49493-1-yixun.lan@amlogic.com>
 <20180326081809.49493-4-yixun.lan@amlogic.com>
Message-ID: <1522142450.2632.41.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2018-03-26 at 16:18 +0800, Yixun Lan wrote:
> From the hardware perspective, the clk81 is the parent of
> the UART_AO clocks. So it make more sense to mark
> the CLKID_AO_UART1/2 as the pclk.
> 
> Previous we had flag=CLK_IGNORE_UNUSED in AO clock driver.
> This will make kernel leave clock as it is while bootloader
> set the clock on.
> 

Hi Yixun,

I'm not sure I understand your description correctly so I'll phrase. Please tell
me if I misunderstood something

The actual pclk of the AO uarts is the corresponding clkc_ao uart gate, not the
main clock controller clk81. This was not problem so far, because the uart_gate
had the CLK_IGNORE_UNUSED flag, which kept the gate open.

In another patch, you removed this flag, so you need to give the correct clock
in DT to make things work again ? right ?

If I got it correctly, please rephrase the description a bit.
Also you need to be careful in which order patches get merged.

1. You need the clkc_ao in place, exporting CLKID_AO_UARTx with
CLK_IGNORE_UNUSED.

2. This patch can be merged (still with CLK_IGNORE_UNUSED)

3. Once the DT patch have reached mainline, you should a patch to remove to
CLK_IGNORE_UNUSED flag

This way, we avoid breaking bisect, with revision where CLKID_AO_UARTx would get
disabled by the CCF clk_disable_unused() mechanism while the UART driver does
not claim the appropriate clock.


> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi  | 4 ++--
>  arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 4 ++--
>  arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> index 48584d5a329b..e538e2448bb5 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> @@ -533,7 +533,7 @@
>  				compatible = "amlogic,meson-gx-uart", "amlogic,meson-ao-uart";
>  				reg = <0x0 0x3000 0x0 0x18>;
>  				interrupts = <GIC_SPI 193 IRQ_TYPE_EDGE_RISING>;
> -				clocks = <&xtal>, <&clkc CLKID_CLK81>, <&xtal>;
> +				clocks = <&xtal>, <&clkc_AO CLKID_AO_UART1>, <&xtal>;
>  				clock-names = "xtal", "pclk", "baud";
>  				status = "disabled";
>  			};
> @@ -542,7 +542,7 @@
>  				compatible = "amlogic,meson-gx-uart", "amlogic,meson-ao-uart";
>  				reg = <0x0 0x4000 0x0 0x18>;
>  				interrupts = <GIC_SPI 197 IRQ_TYPE_EDGE_RISING>;
> -				clocks = <&xtal>, <&clkc CLKID_CLK81>, <&xtal>;
> +				clocks = <&xtal>, <&clkc_AO CLKID_AO_UART2>, <&xtal>;
>  				clock-names = "xtal", "pclk", "baud";
>  				status = "disabled";
>  			};
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> index 3290a4dc3522..a458ea50c2ef 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> @@ -783,12 +783,12 @@
>  };
>  
>  &uart_AO {
> -	clocks = <&xtal>, <&clkc CLKID_CLK81>, <&xtal>;
> +	clocks = <&xtal>, <&clkc_AO CLKID_AO_UART1>, <&xtal>;
>  	clock-names = "xtal", "pclk", "baud";
>  };
>  
>  &uart_AO_B {
> -	clocks = <&xtal>, <&clkc CLKID_CLK81>, <&xtal>;
> +	clocks = <&xtal>, <&clkc_AO CLKID_AO_UART2>, <&xtal>;
>  	clock-names = "xtal", "pclk", "baud";
>  };
>  
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
> index 4f355f17eed6..474f4f9630e4 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
> @@ -733,12 +733,12 @@
>  };
>  
>  &uart_AO {
> -	clocks = <&xtal>, <&clkc CLKID_CLK81>, <&xtal>;
> +	clocks = <&xtal>, <&clkc_AO CLKID_AO_UART1>, <&xtal>;
>  	clock-names = "xtal", "pclk", "baud";
>  };
>  
>  &uart_AO_B {
> -	clocks = <&xtal>, <&clkc CLKID_CLK81>, <&xtal>;
> +	clocks = <&xtal>, <&clkc_AO CLKID_AO_UART2>, <&xtal>;
>  	clock-names = "xtal", "pclk", "baud";
>  };
>  
