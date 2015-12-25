From: caesar.upstream@gmail.com (Caesar Wang)
Date: Fri, 25 Dec 2015 10:36:04 +0800
Subject: [PATCH 4/4] ARM: dts: rockchip: Add support emac for RK3036
In-Reply-To: <1450862390-407-4-git-send-email-zhengxing@rock-chips.com>
References: <1450862390-407-1-git-send-email-zhengxing@rock-chips.com>
 <1450862390-407-4-git-send-email-zhengxing@rock-chips.com>
Message-ID: <567CAB94.7090701@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Xing,

? 2015?12?23? 17:19, Xing Zheng ??:
> This patch describe the emac, and we need to let mac clock under
> the APLL which is able to provide the accurate 50MHz what mac_ref
> need.
>
> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
> ---
>
>   arch/arm/boot/dts/rk3036-evb.dts   |   25 +++++++++++++++++++++++++
>   arch/arm/boot/dts/rk3036-kylin.dts |   23 +++++++++++++++++++++++
>   arch/arm/boot/dts/rk3036.dtsi      |   32 ++++++++++++++++++++++++++++++++
>   3 files changed, 80 insertions(+)
>
> diff --git a/arch/arm/boot/dts/rk3036-evb.dts b/arch/arm/boot/dts/rk3036-evb.dts
> index 28a0336..69b96e6 100644
> --- a/arch/arm/boot/dts/rk3036-evb.dts
> +++ b/arch/arm/boot/dts/rk3036-evb.dts
> @@ -62,3 +62,28 @@
>   &uart2 {
>   	status = "okay";
>   };
> +
> +&emac {
> +	assigned-clocks = <&cru SCLK_MACPLL>;
> +	assigned-clock-parents = <&cru PLL_APLL>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&emac_xfer>, <&emac_mdio>, <&rmii_rst>;
> +	phy = <&phy0>;
> +	status = "okay";
> +
> +	phy0: ethernet-phy at 0 {
> +		reg = <0>;
> +	};
> +};
> +
> +&pinctrl {
> +	pcfg_output_high: pcfg-output-high {
> +		output-high;
> +	};
> +

That's seem a new preperty for pinctrl on rk3036, we should submit it in 
rk3036 dtsi.

Do we are really need it?

GPIO2_C6 is pulled up in internal chip.
So, maybe you only do that:

rockchip,pins = <2 22 RK_FUNC_GPIO &pcfg_pull_default>;


> +	emac {
> +		rmii_rst: rmii-rst {
> +			rockchip,pins = <2 22 RK_FUNC_GPIO &pcfg_output_high>;
> +		};
> +	};
> +};
> diff --git a/arch/arm/boot/dts/rk3036-kylin.dts b/arch/arm/boot/dts/rk3036-kylin.dts
> index 992f9ca..3fb1cfe 100644
> --- a/arch/arm/boot/dts/rk3036-kylin.dts
> +++ b/arch/arm/boot/dts/rk3036-kylin.dts
> @@ -285,7 +285,24 @@
>   	status = "okay";
>   };
>   
> +&emac {
> +	assigned-clocks = <&cru SCLK_MACPLL>;
> +	assigned-clock-parents = <&cru PLL_APLL>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&emac_xfer>, <&emac_mdio>, <&rmii_rst>;
> +	phy = <&phy0>;
> +	status = "okay";
> +
> +	phy0: ethernet-phy at 0 {
> +		reg = <0>;
> +	};
> +};
> +
>   &pinctrl {
> +	pcfg_output_high: pcfg-output-high {
> +		output-high;
> +	};
> +
>   	pmic {
>   		pmic_int: pmic-int {
>   			rockchip,pins = <2 2 RK_FUNC_GPIO &pcfg_pull_default>;
> @@ -297,4 +314,10 @@
>   			rockchip,pins = <2 7 RK_FUNC_1 &pcfg_pull_none>;
>   		};
>   	};
> +
> +	emac {
> +		rmii_rst: rmii-rst {
> +			rockchip,pins = <2 22 RK_FUNC_GPIO &pcfg_output_high>;
> +		};
> +	};
>   };
> diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
> index b9567c1..0c09fb3 100644
> --- a/arch/arm/boot/dts/rk3036.dtsi
> +++ b/arch/arm/boot/dts/rk3036.dtsi
> @@ -186,6 +186,20 @@
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
> +		max-speed = <100>;
> +		phy-mode = "rmii";
> +		status = "disabled";
> +	};
> +
>   	sdmmc: dwmmc at 10214000 {
>   		compatible = "rockchip,rk3036-dw-mshc", "rockchip,rk3288-dw-mshc";
>   		reg = <0x10214000 0x4000>;
> @@ -556,6 +570,24 @@
>   			};
>   		};
>   
> +		emac {
> +			emac_xfer: emac-xfer {
> +				rockchip,pins = <2 10 RK_FUNC_1 &pcfg_pull_none>, /* crs_dvalid */
> +						<2 13 RK_FUNC_1 &pcfg_pull_none>, /* tx_en */
> +						<2 14 RK_FUNC_1 &pcfg_pull_none>, /* mac_clk */
> +						<2 15 RK_FUNC_1 &pcfg_pull_none>, /* rx_err */
> +						<2 16 RK_FUNC_1 &pcfg_pull_none>, /* rxd1 */
> +						<2 17 RK_FUNC_1 &pcfg_pull_none>, /* rxd0 */
> +						<2 18 RK_FUNC_1 &pcfg_pull_none>, /* txd1 */
> +						<2 19 RK_FUNC_1 &pcfg_pull_none>; /* txd0 */
> +			};
> +
> +			emac_mdio: emac-mdio {
> +				rockchip,pins = <2 12 RK_FUNC_1 &pcfg_pull_none>, /* mac_md */
> +						<2 25 RK_FUNC_1 &pcfg_pull_none>; /* mac_mdclk */
> +			};
> +		};
> +
>   		i2c0 {
>   			i2c0_xfer: i2c0-xfer {
>   				rockchip,pins = <0 0 RK_FUNC_1 &pcfg_pull_none>,


-- 
Thanks,
Caesar
