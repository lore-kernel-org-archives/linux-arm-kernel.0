From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 17 Feb 2016 11:27:43 +0000
Subject: [PATCH 6/6] ARM64: dts: rockchip: add core dtsi file for rk3399
In-Reply-To: <1455674476-16655-1-git-send-email-jay.xu@rock-chips.com>
References: <1455673992-16469-1-git-send-email-jay.xu@rock-chips.com>
 <1455674476-16655-1-git-send-email-jay.xu@rock-chips.com>
Message-ID: <56C4592F.4080608@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Xu,

On 17/02/16 02:01, jianqun.xu wrote:
> From: Xu Jianqun <jay.xu@rock-chips.com>
> 
> Add dtsi file for Rockchip rk3399 SoCs, which includes some
> general nodes such as cpu, pmu, cru, gic, amba and so on.
> 
> Change-Id: Ie3b824e8ead967d4cb119d73222b7a198478c29c
> Signed-off-by: Xu Jianqun <jay.xu@rock-chips.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 989 +++++++++++++++++++++++++++++++
>  1 file changed, 989 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399.dtsi
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> new file mode 100644
> index 0000000..eb671f6
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi

[...]

> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts =
> +			<GIC_PPI 13
> +			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
> +			<GIC_PPI 14
> +			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
> +			<GIC_PPI 11
> +			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
> +			<GIC_PPI 10
> +			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;

Please drop these GIC_CPU_MASK_SIMPLE from the interrupt specifiers,
they do not mean anything with GICv3.

> +		clock-frequency = <24000000>;

Are you sure you do need this? Can't your firmware be fixed to correctly
program CNTFRQ_EL0?

> +	};
> +
> +	xin24m: xin24m {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <24000000>;
> +		clock-output-names = "xin24m";
> +	};
> +
> +	gic: interrupt-controller at fee00000 {
> +		compatible = "arm,gic-v3";
> +		#interrupt-cells = <3>;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +		interrupt-controller;
> +
> +		reg = <0x0 0xfee00000 0 0x10000>, /* GICD */
> +		      <0x0 0xfef00000 0 0xc0000>, /* GICR */
> +		      <0x0 0xfff00000 0 0x10000>, /* GICC */
> +		      <0x0 0xfff10000 0 0x10000>, /* GICH */
> +		      <0x0 0xfff20000 0 0x10000>; /* GICV */
> +		interrupts =
> +			<GIC_PPI 9
> +			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;

Same remark about the mask.

> +		its: interrupt-controller at fee20000 {
> +			compatible = "arm,gic-v3-its";
> +			msi-controller;
> +			reg = <0x0 0xfee20000 0x0 0x20000>;
> +		};

Looks nice. Is there any peripheral capable of generating MSIs on this SoC?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
