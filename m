From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 17 Jun 2017 20:05:53 +0200
Subject: [PATCH v1 2/2] arm64: dts: rk3328: add pdm node
In-Reply-To: <1497338867-52684-3-git-send-email-sugar.zhang@rock-chips.com>
References: <1497338867-52684-1-git-send-email-sugar.zhang@rock-chips.com>
 <1497338867-52684-3-git-send-email-sugar.zhang@rock-chips.com>
Message-ID: <8940631.X8XUXX2eL4@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Dienstag, 13. Juni 2017, 15:27:47 CEST schrieb Sugar Zhang:
> This patch add pdm controller device node for rk3328.
> 
> Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>

please make the subject
	"arm64: dts: rockchip: add rk3328 pdm node"

> 
> ---
> 
>  arch/arm64/boot/dts/rockchip/rk3328.dtsi | 55 ++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> index 7e69f1f..2435044 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> @@ -156,6 +156,25 @@
>  		clock-output-names = "xin24m";
>  	};
>  
> +	pdm: pdm at ff040000 {
> +		compatible = "rockchip,pdm";
> +		reg = <0x0 0xff040000 0x0 0x1000>;
> +		clocks = <&cru SCLK_PDM>, <&cru HCLK_PDM>;
> +		clock-names = "pdm_clk", "pdm_hclk";
> +		dmas = <&dmac 16>;
> +		#dma-cells = <1>;

please drop #dma-cells, this is not a dma-controller and only
a dma-client. #dma-cells is a property of dma-controllers.


> +		dma-names = "rx";
> +		pinctrl-names = "default", "sleep";
> +		pinctrl-0 = <&pdmm0_clk
> +			     &pdmm0_fsync
> +			     &pdmm0_sdi0
> +			     &pdmm0_sdi1
> +			     &pdmm0_sdi2
> +			     &pdmm0_sdi3>;
> +		pinctrl-1 = <&pdmm0_sleep>;

pinctrl doesn't match up. default pins are all separate, sleep pins are
all in one entry. So what is the use-case for the pins being separate?

I guess you always need clk, fsync and then one or more of the sdiX pins?
Can these be used independently [like sdi2 only] or is it something like
sdio pins and one of {1}, {1,2,3,4} or so?

So in general the groupings should match for all pinctrl states, because
if you for example do not use sdi3 and reuse it as gpio or so the sleep
pinctrl state would fail, as there would be conflict then.


Heiko

> +		status = "disabled";
> +	};
> +
>  	grf: syscon at ff100000 {
>  		compatible = "rockchip,rk3328-grf", "syscon", "simple-mfd";
>  		reg = <0x0 0xff100000 0x0 0x1000>;
> @@ -701,6 +720,42 @@
>  			};
>  		};
>  
> +		pdm-0 {
> +			pdmm0_clk: pdmm0-clk {
> +				rockchip,pins = <2 RK_PC2 2 &pcfg_pull_none>;
> +			};
> +
> +			pdmm0_fsync: pdmm0-fsync {
> +				rockchip,pins = <2 RK_PC7 2 &pcfg_pull_none>;
> +			};
> +
> +			pdmm0_sdi0: pdmm0-sdi0 {
> +				rockchip,pins = <2 RK_PC3 2 &pcfg_pull_none>;
> +			};
> +
> +			pdmm0_sdi1: pdmm0-sdi1 {
> +				rockchip,pins = <2 RK_PC4 2 &pcfg_pull_none>;
> +			};
> +
> +			pdmm0_sdi2: pdmm0-sdi2 {
> +				rockchip,pins = <2 RK_PC5 2 &pcfg_pull_none>;
> +			};
> +
> +			pdmm0_sdi3: pdmm0-sdi3 {
> +				rockchip,pins = <2 RK_PC6 2 &pcfg_pull_none>;
> +			};
> +
> +			pdmm0_sleep: pdmm0-sleep {
> +				rockchip,pins =
> +					<2 RK_PC2 RK_FUNC_GPIO &pcfg_input_high>,
> +					<2 RK_PC3 RK_FUNC_GPIO &pcfg_input_high>,
> +					<2 RK_PC4 RK_FUNC_GPIO &pcfg_input_high>,
> +					<2 RK_PC5 RK_FUNC_GPIO &pcfg_input_high>,
> +					<2 RK_PC6 RK_FUNC_GPIO &pcfg_input_high>,
> +					<2 RK_PC7 RK_FUNC_GPIO &pcfg_input_high>;
> +			};
> +		};
> +
>  		i2s1 {
>  			i2s1_mclk: i2s1-mclk {
>  				rockchip,pins = <2 RK_PB7 1 &pcfg_pull_none>;
> 
