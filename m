From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 30 Oct 2015 11:34:42 +0100
Subject: [PATCH v4 5/6] ARM: dts: sunxi: Add Allwinner H3 DTSI
In-Reply-To: <1445964626-6484-6-git-send-email-jenskuske@gmail.com>
References: <1445964626-6484-1-git-send-email-jenskuske@gmail.com>
 <1445964626-6484-6-git-send-email-jenskuske@gmail.com>
Message-ID: <20151030113442.1ad381f9103aa052f929d4a9@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 27 Oct 2015 17:50:25 +0100
Jens Kuske <jenskuske@gmail.com> wrote:

> The Allwinner H3 is a home entertainment system oriented SoC with
> four Cortex-A7 cores and a Mali-400MP2 GPU.
> 
> Signed-off-by: Jens Kuske <jenskuske@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-h3.dtsi | 482 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 482 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun8i-h3.dtsi
> 
> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
> new file mode 100644
> index 0000000..c18b5f7
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
	[snip]
> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		dma: dma-controller at 01c02000 {
> +			compatible = "allwinner,sun8i-h3-dma";
> +			reg = <0x01c02000 0x1000>;
> +			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&bus_gates 6>;
> +			resets = <&bus_rst 6>;
> +			#dma-cells = <1>;
> +		};
	[snip]
> +
> +		bus_rst: reset at 01c202c0 {
> +			#reset-cells = <1>;
> +			compatible = "allwinner,sun8i-h3-bus-reset";
> +			reg = <0x01c202c0 0x1c>;
> +		};
> +
	[snip]
> +		uart0: serial at 01c28000 {
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0x01c28000 0x400>;
> +			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			clocks = <&bus_gates 112>;
> +			resets = <&bus_rst 144>;
> +			dmas = <&dma 6>, <&dma 6>;
> +			dma-names = "rx", "tx";
> +			status = "disabled";
> +		};

The reset definitions would be clearer with declarations as the other
Allwinner SoCs and without driver hack:

soc {
	compatible = "simple-bus";
	#address-cells = <1>;
	#size-cells = <1>;
	ranges;

		dma: dma-controller at 01c02000 {
		compatible = "allwinner,sun8i-h3-dma";
		reg = <0x01c02000 0x1000>;
		interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
		clocks = <&bus_gates 6>;
		resets = <&rst_reg0 6>;
		#dma-cells = <1>;
	};
    ...
	rst_reg0: reset at 01c202c0 {
		#reset-cells = <1>;
		compatible = "allwinner,sun6i-a31-clock-reset";
		reg = <0x01c202c0 0x04>;
	};
	...
 	rst_reg4: reset at 01c202d8 {
		#reset-cells = <1>;
		compatible = "allwinner,sun6i-a31-clock-reset";
		reg = <0x01c202d8 0x04>;
	};
   ...
	uart0: serial at 01c28000 {
		compatible = "snps,dw-apb-uart";
		reg = <0x01c28000 0x400>;
		interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
		reg-shift = <2>;
		reg-io-width = <4>;
		clocks = <&bus_gates 112>;
		resets = <&rst_reg4 16>;
		dmas = <&dma 6>, <&dma 6>;
		dma-names = "rx", "tx";
		status = "disabled";
	};

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
