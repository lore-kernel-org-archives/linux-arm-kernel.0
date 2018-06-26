From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 26 Jun 2018 08:53:20 +0100
Subject: [PATCH v2 2/2] arm64: dts: mediatek: add mt6765 support
In-Reply-To: <1529978646-28976-3-git-send-email-mars.cheng@mediatek.com>
References: <1529978646-28976-1-git-send-email-mars.cheng@mediatek.com>
 <1529978646-28976-3-git-send-email-mars.cheng@mediatek.com>
Message-ID: <86h8lq6l1r.wl-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 26 Jun 2018 03:04:06 +0100,
Mars Cheng <mars.cheng@mediatek.com> wrote:
> 
> This adds basic chip support for MT6765 SoC.
> 
> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/Makefile       |    1 +
>  arch/arm64/boot/dts/mediatek/mt6765-evb.dts |   33 ++++++
>  arch/arm64/boot/dts/mediatek/mt6765.dtsi    |  158 +++++++++++++++++++++++++++
>  3 files changed, 192 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt6765-evb.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt6765.dtsi
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt6765.dtsi b/arch/arm64/boot/dts/mediatek/mt6765.dtsi
> new file mode 100644
> index 0000000..ab34c0f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt6765.dtsi

[...]

> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_PPI 13
> +			     (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14
> +			     (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11
> +			     (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10
> +			     (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;

GICv3 doesn't encode the PPI affinity in its interrupt specifiers (or
at least not this way). Please drop it.

> +	};
> +
> +	soc {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		compatible = "simple-bus";
> +		ranges;
> +
> +		sysirq: intpol-controller at 10200a80 {
> +			compatible = "mediatek,mt6765-sysirq",
> +				     "mediatek,mt6577-sysirq";
> +			interrupt-controller;
> +			#interrupt-cells = <3>;
> +			interrupt-parent = <&gic>;
> +			reg = <0 0x10200a80 0 0x50>;
> +		};
> +
> +		gic: interrupt-controller at 0c000000 {
> +			compatible = "arm,gic-v3";
> +			#interrupt-cells = <3>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			#redistributor-regions = <1>;

A single redistributor is the default, and you don't need to specify
it in the DT.

> +			interrupt-parent = <&gic>;
> +			interrupt-controller;
> +			reg = <0 0x0c000000 0 0x40000>, // distributor
> +			      <0 0x0c100000 0 0x200000>; // redistributor

How about the GICv2 compatibility regions, which are provided by the
CPUs at a fixed offset from PERIPHBASE? See the Cortex-A53 TRM for
detail, and please add the missing regions.

> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +		};

Thanks,

	M.

-- 
Jazz is not dead, it just smell funny.
