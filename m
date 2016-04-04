From: robh@kernel.org (Rob Herring)
Date: Mon, 4 Apr 2016 00:16:38 -0500
Subject: [PATCH v2 06/16] arm64: dts: add Hi6220 spi configuration nodes
In-Reply-To: <1459589383-16914-7-git-send-email-guodong.xu@linaro.org>
References: <1459589383-16914-1-git-send-email-guodong.xu@linaro.org>
 <1459589383-16914-7-git-send-email-guodong.xu@linaro.org>
Message-ID: <20160404051638.GR17806@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 02, 2016 at 05:29:33PM +0800, Guodong Xu wrote:
> From: Zhong Kaihua <zhongkaihua@huawei.com>
> 
> Add Hi6220 spi configuration nodes
> 
> Signed-off-by: Zhong Kaihua <zhongkaihua@huawei.com>
> Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
> ---
>  arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts   |  1 +
>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi        | 15 +++++++++++++++
>  arch/arm64/boot/dts/hisilicon/hikey-pinctrl.dtsi | 21 +++++++++++++++++++++
>  3 files changed, 37 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> index 985a2ad..5c9ee31 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> @@ -20,6 +20,7 @@
>  		serial1 = &uart1; /* BT UART */
>  		serial2 = &uart2; /* LS Expansion UART0 */
>  		serial3 = &uart3; /* LS Expansion UART1 */
> +		spi0 = &spi_0;

You shouldn't really need an alias for SPI.

>  	};
>  
>  	chosen {
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> index e96cc3c..dcca83b 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> @@ -585,5 +585,20 @@
>  			clock-names = "apb_pclk";
>  			status = "ok";
>  		};
> +
> +		spi_0: spi at f7106000 {
> +			compatible = "arm,pl022", "arm,primecell";
> +			reg = <0x0 0xf7106000 0x0 0x1000>;
> +			interrupts = <0 50 4>;
> +			bus-id = <0>;
> +			enable-dma = <0>;
> +			clocks = <&sys_ctrl HI6220_SPI_CLK>;
> +			clock-names = "apb_pclk";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&spi0_pmx_func &spi0_cfg_func>;
> +			num-cs = <1>;
> +			cs-gpios = <&gpio6 2 0>;
> +			status = "ok";

You only need an ok to override a disabled status, so I think you can 
drop this. Or disable by default and let boards override it if that 
makes sense.

Rob
