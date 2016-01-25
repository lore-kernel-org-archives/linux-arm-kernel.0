From: caesar.upstream@gmail.com (Caesar Wang)
Date: Tue, 26 Jan 2016 00:06:27 +0800
Subject: [PATCH v2] ARM: dts: rockchip: add support emac for RK3036
In-Reply-To: <1453725488-5279-1-git-send-email-wxt@rock-chips.com>
References: <1453725488-5279-1-git-send-email-wxt@rock-chips.com>
Message-ID: <56A64803.8070006@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2016?01?25? 20:38, Caesar Wang ??:
> From: zhengxing <zhengxing@rock-chips.com>
>
> This patch describe the emac, and we need to let mac clock under
> the APLL which is able to provide the accurate 50MHz what mac_ref
> need.
>
> This patch makes the emac parent clock is DPLL instead of APLL.
> since that will cause some unstable things if the cpufreq is working.
>
> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
>
> ---
[...]
> diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
> index 7897449..436c77a 100644
> --- a/arch/arm/boot/dts/rk3036.dtsi
> +++ b/arch/arm/boot/dts/rk3036.dtsi
> @@ -186,6 +186,27 @@
>   		status = "disabled";
>   	};
>   
> +	emac: ethernet at 10200000 {
> +		compatible = "rockchip,rk3036-emac", "snps,arc-emac";
> +		reg = <0x10200000 0x4000>;
> +		interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		rockchip,grf = <&grf>;
> +		clocks = <&cru HCLK_MAC>, <&cru SCLK_MACREF>, <&cru SCLK_MAC>;
> +		clock-names = "hclk", "macref", "macclk";
> +		/*
> +		 * Fix the emac parent clock is DPLL instead of APLL.
> +		 * since that will cause some unstable things if the cpufreq
> +		 * is working. (e.g: the accurate 50MHz what mac_ref need)
> +		 */
> +		assigned-clocks = <&cru SCLK_MACPLL>;
> +		assigned-clock-parents = <&cru PLL_DPLL>;

This patch depends on the clock patch. :-( ?still in my work branch)

> +		max-speed = <100>;
> +		phy-mode = "rmii";
> +		status = "disabled";
> +	};
> +
>   	sdmmc: dwmmc at 10214000 {
>   		compatible = "rockchip,rk3036-dw-mshc", "rockchip,rk3288-dw-mshc";
>   		reg = <0x10214000 0x4000>;
> @@ -556,6 +577,24 @@
>   			};
>   		};
>   
> +		emac {
> +			emac_xfer: emac-xfer {
> +				rockchip,pins = <2 10 RK_FUNC_1 &pcfg_pull_default>, /* crs_dvalid */
> +						<2 13 RK_FUNC_1 &pcfg_pull_default>, /* tx_en */
> +						<2 14 RK_FUNC_1 &pcfg_pull_default>, /* mac_clk */
> +						<2 15 RK_FUNC_1 &pcfg_pull_default>, /* rx_err */
> +						<2 16 RK_FUNC_1 &pcfg_pull_default>, /* rxd1 */
> +						<2 17 RK_FUNC_1 &pcfg_pull_default>, /* rxd0 */
> +						<2 18 RK_FUNC_1 &pcfg_pull_default>, /* txd1 */
> +						<2 19 RK_FUNC_1 &pcfg_pull_default>; /* txd0 */
> +			};
> +
> +			emac_mdio: emac-mdio {
> +				rockchip,pins = <2 12 RK_FUNC_1 &pcfg_pull_default>, /* mac_md */
> +						<2 25 RK_FUNC_1 &pcfg_pull_default>; /* mac_mdclk */
> +			};
> +		};
> +
>   		i2c0 {
>   			i2c0_xfer: i2c0-xfer {
>   				rockchip,pins = <0 0 RK_FUNC_1 &pcfg_pull_none>,

-- 
Thanks,
Caesar
