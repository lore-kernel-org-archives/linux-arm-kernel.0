From: robh@kernel.org (Rob Herring)
Date: Mon, 22 May 2017 19:39:08 -0500
Subject: [PATCH 05/12] arm64: dts: Add I2C nodes for Hi3660
In-Reply-To: <20170517083745.24479-6-guodong.xu@linaro.org>
References: <20170517083745.24479-1-guodong.xu@linaro.org>
 <20170517083745.24479-6-guodong.xu@linaro.org>
Message-ID: <20170523003908.ztuh4oohdk3g34pm@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 17, 2017 at 04:37:38PM +0800, Guodong Xu wrote:
> From: Zhangfei Gao <zhangfei.gao@linaro.org>
> 
> Add I2C nodes for Hi3660-hikey960.
> 
> On HiKey960,
> I2C0, I2C7 is connected to Low Speed Expansion Connector.
> I2C1 is connected to ADV7535.
> I2C3 is connected to USB5734.
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
> ---
>  arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 18 ++++++++
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi         | 56 +++++++++++++++++++++++
>  2 files changed, 74 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> index 64875a5..f685b1e 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> @@ -29,6 +29,24 @@
>  	};
>  };
>  
> +&i2c0 {
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +
> +	adv7533: adv7533 at 39 {
> +		status = "ok";
> +		compatible = "adi,adv7533";
> +		reg = <0x39>;
> +	};
> +};
> +
> +&i2c7 {
> +	status = "okay";
> +};

labels for the LS connector?

> +
>  &uart5 {
>  	status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> index f55710a..f217c9d 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> @@ -186,6 +186,62 @@
>  			#reset-cells = <2>;
>  		};
>  
> +		i2c0: i2c at FFD71000 {

lowercase hex please.

> +			compatible = "snps,designware-i2c";

These should have an SoC specific compatible.

> +			reg = <0x0 0xFFD71000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			clock-frequency = <400000>;
> +			clocks = <&crg_ctrl HI3660_CLK_GATE_I2C0>;
> +			resets = <&iomcu_rst 0x20 3>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&i2c0_pmx_func &i2c0_cfg_func>;
> +			status = "disabled";
> +		};
> +
> +		i2c1: i2c at FFD72000 {

ditto

> +			compatible = "snps,designware-i2c";
> +			reg = <0x0 0xFFD72000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			clock-frequency = <400000>;
> +			clocks = <&crg_ctrl HI3660_CLK_GATE_I2C1>;
> +			resets = <&iomcu_rst 0x20 4>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&i2c1_pmx_func &i2c1_cfg_func>;
> +			status = "disabled";
> +		};
> +
> +		i2c3: i2c at FDF0C000 {
> +			compatible = "snps,designware-i2c";
> +			reg = <0x0 0xFDF0C000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			clock-frequency = <400000>;
> +			clocks = <&crg_ctrl HI3660_CLK_GATE_I2C3>;
> +			resets = <&crg_rst 0x78 7>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&i2c3_pmx_func &i2c3_cfg_func>;
> +			status = "disabled";
> +		};
> +
> +		i2c7: i2c at FDF0B000 {
> +			compatible = "snps,designware-i2c";
> +			reg = <0x0 0xFDF0B000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			clock-frequency = <400000>;
> +			clocks = <&crg_ctrl HI3660_CLK_GATE_I2C7>;
> +			resets = <&crg_rst 0x60 14>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&i2c7_pmx_func &i2c7_cfg_func>;
> +			status = "disabled";
> +		};
> +
>  		uart5: serial at fdf05000 {
>  			compatible = "arm,pl011", "arm,primecell";
>  			reg = <0x0 0xfdf05000 0x0 0x1000>;
> -- 
> 2.10.2
> 
