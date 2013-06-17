From: robherring2@gmail.com (Rob Herring)
Date: Mon, 17 Jun 2013 18:41:27 -0500
Subject: [PATCH 2/4] ARM: rockchip: add sram dt nodes and documentation
In-Reply-To: <201306180044.18272.heiko@sntech.de>
References: <201306180043.11785.heiko@sntech.de>
 <201306180044.18272.heiko@sntech.de>
Message-ID: <51BF9EA7.3030408@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/17/2013 05:44 PM, Heiko St?bner wrote:
> The Rockchip SoCs need a special part of their sram for bringup
> of additional cores. Therefore the mapped area should be split
> into a special area for the smp code and a generic area that gets
> handled by mmio-sram.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  .../devicetree/bindings/arm/rockchip/smp-sram.txt  |   29 ++++++++++++++++++++
>  arch/arm/boot/dts/rk3066a.dtsi                     |   14 ++++++++++
>  2 files changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/rockchip/smp-sram.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip/smp-sram.txt b/Documentation/devicetree/bindings/arm/rockchip/smp-sram.txt
> new file mode 100644
> index 0000000..9c81fac
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/rockchip/smp-sram.txt
> @@ -0,0 +1,29 @@
> +Rockchip SRAM for smp bringup:
> +------------------------------
> +
> +Rockchip smp-capable SoCs use the first part of the sram for the bringup
> +of the cores. Once the core gets powered up it executes the code that is
> +residing at the very beginning of the sram.
> +
> +While the suspend also needs to have code in the sram that can be realized
> +with the generic mmio-sram driver and only the smp specific part needs to
> +be mapped specially in the smp code.
> +
> +Therefore split the sram mapping in a smp-specific part that gets used
> +by the smp code exclusively and a bigger generic part for mmio-sram
> +
> +Required node properties:
> +- compatible value : = "rockchip,rk3066-smp-sram";
> +- reg : physical base address and the size of the registers window
> +
> +Example:
> +
> +	sram at 10080000 {
> +		compatible = "rockchip,rk3066-smp-sram";
> +		reg = <0x10080000 0x100>;
> +	};
> +
> +	sram: sram at 10080100 {
> +		compatible = "mmio-sram";
> +		reg = <0x10080100 0x9900>;

I think a better way would be to specify some portion of the sram as
reserved rather than defining the s/w use of the sram in DT. Something
like this:

mmio-sram-reserved = <base size base size>;

where base values are relative to reg property base.

Rob

> +	};
> diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
> index 26c4311..44eabd2 100644
> --- a/arch/arm/boot/dts/rk3066a.dtsi
> +++ b/arch/arm/boot/dts/rk3066a.dtsi
> @@ -53,6 +53,20 @@
>  			reg = <0x1013c000 0x100>;
>  		};
>  
> +		/*
> +		 * the first part of the sram is needed for the smp
> +		 * trampoline code during cpu bringup
> +		 */
> +		sram at 10080000 {
> +			compatible = "rockchip,rk3066-smp-sram";
> +			reg = <0x10080000 0x100>;
> +		};
> +
> +		sram: sram at 10080100 {
> +			compatible = "mmio-sram";
> +			reg = <0x10080100 0x9900>;
> +		};
> +
>  		gic: interrupt-controller at 1013d000 {
>  			compatible = "arm,cortex-a9-gic";
>  			interrupt-controller;
> 
