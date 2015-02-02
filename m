From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 02 Feb 2015 14:20:47 -0700
Subject: [PATCH 3/3] dt: paz00: define nvec as child of i2c bus
In-Reply-To: <1422516022-27161-4-git-send-email-danindrey@mail.ru>
References: <1422516022-27161-1-git-send-email-danindrey@mail.ru>
 <1422516022-27161-4-git-send-email-danindrey@mail.ru>
Message-ID: <54CFEA2F.8040701@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/29/2015 12:20 AM, Andrey Danin wrote:
> NVEC driver was reimplemented to use tegra i2c. Use common i2c bindings
> for NVEC node.

> diff --git a/Documentation/devicetree/bindings/nvec/nvidia,nvec.txt b/Documentation/devicetree/bindings/nvec/nvidia,nvec.txt

The changes to this file make more sense either as a standalone patch 
1/4, or as part of the driver changes.

> @@ -2,20 +2,5 @@ NVIDIA compliant embedded controller
>
>   Required properties:
>   - compatible : should be "nvidia,nvec".
> -- reg : the iomem of the i2c slave controller
> -- interrupts : the interrupt line of the i2c slave controller
> -- clock-frequency : the frequency of the i2c bus
> -- gpios : the gpio used for ec request
> -- slave-addr: the i2c address of the slave controller
> -- clocks : Must contain an entry for each entry in clock-names.
> -  See ../clocks/clock-bindings.txt for details.
> -- clock-names : Must include the following entries:
> -  Tegra20/Tegra30:
> -  - div-clk
> -  - fast-clk
> -  Tegra114:
> -  - div-clk
> -- resets : Must contain an entry for each entry in reset-names.
> -  See ../reset/reset.txt for details.
> -- reset-names : Must include the following entries:
> -  - i2c
> +- request-gpios : the gpio used for ec request
> +- reg: the i2c address of the slave controller

This change breaks ABI.

Instead of modifying the definition of the existing compatible value, I 
think you should introduce a new compatible value to describe the 
external NVEC chip.

> diff --git a/arch/arm/boot/dts/tegra20-paz00.dts b/arch/arm/boot/dts/tegra20-paz00.dts

> -	nvec at 7000c500 {
> -		compatible = "nvidia,nvec";
> -		reg = <0x7000c500 0x100>;
> -		interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> +	i2c at 7000c500 {
> +		status = "okay";
>   		clock-frequency = <80000>;
> -		request-gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_HIGH>;
> -		slave-addr = <138>;
> -		clocks = <&tegra_car TEGRA20_CLK_I2C3>,
> -		         <&tegra_car TEGRA20_CLK_PLL_P_OUT3>;
> -		clock-names = "div-clk", "fast-clk";
> -		resets = <&tegra_car 67>;
> -		reset-names = "i2c";
> +
> +		nvec: nvec at 45 {

This doesn't feel correct. There's nothing here to indicate that this 
child device is a slave that is implemented by the host SoC rather than 
something external attached to the I2C bus.

Perhaps you can get away with this, since the driver for nvidia,nvec 
only calls I2C APIs suitable for internal slaves rather than external 
slaves? Even so though, I think the distinction needs to be clearly 
marked in the DT so that any generic code outside the NVEC driver that 
parses the DT can determine the difference.

I would recommend the I2C controller having #address-cells=<2> with cell 
0 being 0==master,1==slave, cell 1 being the I2C address. The I2C driver 
would need to support #address-cells=<1> for backwards-compatibility.

> +			compatible = "nvidia,nvec";
> +			request-gpios = <&gpio TEGRA_GPIO(V, 2)
> +				GPIO_ACTIVE_HIGH>;
> +			reg = <0x45>;

The order is typically compatible, reg, other properties.

> +		};
>   	};
