From: marvin24@gmx.de (Marc Dietrich)
Date: Thu, 29 Jan 2015 11:01:56 +0100
Subject: [PATCH 3/3] dt: paz00: define nvec as child of i2c bus
In-Reply-To: <1422516022-27161-4-git-send-email-danindrey@mail.ru>
References: <1422516022-27161-1-git-send-email-danindrey@mail.ru>
 <1422516022-27161-4-git-send-email-danindrey@mail.ru>
Message-ID: <1500927.ysGdJAUmOd@fb07-iapwap2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 29. Januar 2015, 10:20:22 schrieb Andrey Danin:
> NVEC driver was reimplemented to use tegra i2c. Use common i2c bindings
> for NVEC node.
> 
> Signed-off-by: Andrey Danin <danindrey@mail.ru>
> ---
>  .../devicetree/bindings/nvec/nvidia,nvec.txt       | 19 ++-----------------
> arch/arm/boot/dts/tegra20-paz00.dts                | 22
> +++++++++------------- 2 files changed, 11 insertions(+), 30 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/nvec/nvidia,nvec.txt
> b/Documentation/devicetree/bindings/nvec/nvidia,nvec.txt index
> 5ae601e..d82c125 100644
> --- a/Documentation/devicetree/bindings/nvec/nvidia,nvec.txt
> +++ b/Documentation/devicetree/bindings/nvec/nvidia,nvec.txt
> @@ -2,20 +2,5 @@ NVIDIA compliant embedded controller
> 
>  Required properties:
>  - compatible : should be "nvidia,nvec".

based on the earlier discussion with Wolfram, this should be "nvidia,nvec-
slave" to distunguish it from a possible nvec master driver.


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
> diff --git a/arch/arm/boot/dts/tegra20-paz00.dts
> b/arch/arm/boot/dts/tegra20-paz00.dts index ed7e100..65e247b 100644
> --- a/arch/arm/boot/dts/tegra20-paz00.dts
> +++ b/arch/arm/boot/dts/tegra20-paz00.dts
> @@ -288,20 +288,16 @@
>  		clock-frequency = <100000>;
>  	};
> 
> -	nvec at 7000c500 {
> -		compatible = "nvidia,nvec";
> -		reg = <0x7000c500 0x100>;
> -		interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> +	i2c at 7000c500 {
> +		status = "okay";
>  		clock-frequency = <80000>;
> -		request-gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_HIGH>;
> -		slave-addr = <138>;
> -		clocks = <&tegra_car TEGRA20_CLK_I2C3>,
> -		         <&tegra_car TEGRA20_CLK_PLL_P_OUT3>;
> -		clock-names = "div-clk", "fast-clk";
> -		resets = <&tegra_car 67>;
> -		reset-names = "i2c";
> +
> +		nvec: nvec at 45 {
> +			compatible = "nvidia,nvec";
> +			request-gpios = <&gpio TEGRA_GPIO(V, 2)
> +				GPIO_ACTIVE_HIGH>;
> +			reg = <0x45>;
> +		};
>  	};
> 
>  	i2c at 7000d000 {
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150129/8e419aec/attachment-0001.sig>
