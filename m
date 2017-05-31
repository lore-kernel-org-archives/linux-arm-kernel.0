From: robh@kernel.org (Rob Herring)
Date: Wed, 31 May 2017 14:22:11 -0500
Subject: [PATCH 3/4] Documentation: dt: Add bindings for Davinci DSP
 processors
In-Reply-To: <20170526202140.10472-4-s-anna@ti.com>
References: <20170526202140.10472-1-s-anna@ti.com>
 <20170526202140.10472-4-s-anna@ti.com>
Message-ID: <20170531192211.xszanmzvj34ohblk@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 26, 2017 at 03:21:39PM -0500, Suman Anna wrote:
> Add the device tree bindings document for the DSP processor
> subsystem devices on TI Davinci DA8xx/OMAP-L13x SoCs.

"dt-bindings: remoteproc:  ..." for the subject.

> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
>  .../bindings/remoteproc/ti,davinci-rproc.txt       | 92 ++++++++++++++++++++++
>  1 file changed, 92 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,davinci-rproc.txt
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,davinci-rproc.txt b/Documentation/devicetree/bindings/remoteproc/ti,davinci-rproc.txt
> new file mode 100644
> index 000000000000..e53572e22002
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/ti,davinci-rproc.txt
> @@ -0,0 +1,92 @@
> +TI Davinci DSP devices
> +=======================
> +
> +Binding status: Unstable - Subject to changes for DT clocks and resets

Sorry, understandable if you didn't have documentation, but you work for 
TI, figure out what the clocks and resets are.

> +
> +The TI Davinci family of SoCs usually contains a TI DSP Core sub-system that
> +is used to offload some of the processor-intensive tasks or algorithms, for
> +achieving various system level goals.
> +
> +The processor cores in the sub-system usually contain additional sub-modules
> +like L1 and/or L2 caches/SRAMs, an Interrupt Controller, an external memory
> +controller, a dedicated local power/sleep controller etc. The DSP processor
> +core used in Davinci SoCs is usually a C674x DSP CPU.

I'm wondering if your compatible string is specific enough with this 
statement.

> +
> +DSP Device Node:
> +================
> +Each DSP Core sub-system is represented as a single DT node.
> +
> +Required properties:
> +--------------------
> +The following are the mandatory properties:
> +
> +- compatible:		Should be one of the following,
> +			    "ti,da850-dsp" for DSPs on OMAP-L138 SoCs
> +
> +- reg:			Should contain an entry for each value in 'reg-names'.
> +			Each entry should have the memory region's start address
> +			and the size of the region, the representation matching
> +			the parent node's '#address-cells' and '#size-cells' values.
> +
> +- reg-names:		Should contain strings with the following names, each
> +			representing a specific internal memory region or a
> +			specific register space,
> +			     "l2sram", "l1pram", "l1dram", "host1cfg", "chipsig_base"
> +
> +- interrupts: 		Should contain the interrupt number used to receive the
> +			interrupts from the DSP. The value should follow the
> +			interrupt-specifier format as dictated by the
> +			'interrupt-parent' node.
> +
> +- memory-region:	phandle to the reserved memory node to be associated
> +			with the remoteproc device. The reserved memory node
> +			can be a CMA memory node, and should be defined as
> +			per the bindings in
> +			Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> +
> +Optional properties:
> +--------------------
> +- interrupt-parent:	phandle to the interrupt controller node. This property
> +			is needed if the device node hierarchy doesn't have an
> +			interrupt controller.
> +
> +
> +Example:
> +--------
> +
> +	/* DA850 DTS file */

Don't show the dts split in examples.

> +	{
> +		dsp: dsp at 11800000 {
> +			compatible = "ti,da850-dsp";
> +			reg = <0x11800000 0x40000>,
> +			      <0x11e00000 0x8000>,
> +			      <0x11f00000 0x8000>,
> +			      <0x01c14044 0x4>,
> +			      <0x01c14174 0x8>;
> +			reg-names = "l2sram", "l1pram", "l1dram", "host1cfg",
> +				    "chipsig";
> +			interrupt-parent = <&intc>;
> +			interrupts = <28>;
> +			status = "disabled";

Don't show status in examples.

> +		};
> +
> +	};
> +
> +	/* OMAP-L138 LCDK Board file */
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		dsp_cma_pool: dsp_cma at c3000000 {

cma is a linuxism. dsp-memory at ...

> +                        compatible = "shared-dma-pool";
> +                        reg = <0xc3000000 0x1000000>;
> +                        reusable;
> +                        status = "okay";
> +                };
> +	};
> +
> +	&dsp {
> +		status = "okay";
> +		memory-region = <&dsp_cma_pool>;
> +	};
> -- 
> 2.12.0
> 
