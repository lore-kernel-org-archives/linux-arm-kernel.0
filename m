From: horms@verge.net.au (Simon Horman)
Date: Thu, 13 Jul 2017 10:16:36 +0200
Subject: [PATCH v3] arm64: dts: r8a7795: Add all MSIOF nodes
In-Reply-To: <1499855661-21386-1-git-send-email-geert+renesas@glider.be>
References: <1499855661-21386-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20170713081635.GM5580@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 12, 2017 at 12:34:21PM +0200, Geert Uytterhoeven wrote:
> Add the device nodes for all MSIOF SPI controllers, incl. clocks, power
> domain, dma, and reset properties.
> 
> Due to a hardware erratum on R-Car H3 ES1.x, using MSIOF for SPI is only
> supported on ES2.0 and later.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Tested on r8a7795/salvator-xs with MSIOF3(A) connected to a HD44780
> character LCD through a pair of 74HCT595 shift registers.

Thanks, applied for v4.14.

> 
> v3:
>   - Add resets properties,
>   - Add family-specific compatible values,
>   - Add link to second DMA controller for MSIOF[01],
> 
> v2:
>   - Rebased,
>   - Switch to final CPG/MSSR bindings,
>   - Change one-line summary prefix to match current arm-soc practices.
> ---
>  arch/arm64/boot/dts/renesas/r8a7795.dtsi | 62 ++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> index 6f5130766a212d6d..507d8ad07aaf9007 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> @@ -899,6 +899,68 @@
>  			status = "disabled";
>  		};
>  
> +		msiof0: spi at e6e90000 {
> +			compatible = "renesas,msiof-r8a7795",

I take it there is also a patch to add the above compat string
to the bindings documentation.

> +				     "renesas,rcar-gen3-msiof";
> +			reg = <0 0xe6e90000 0 0x0064>;
> +			interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg CPG_MOD 211>;
> +			dmas = <&dmac1 0x41>, <&dmac1 0x40>,
> +			       <&dmac2 0x41>, <&dmac2 0x40>;
> +			dma-names = "tx", "rx", "tx", "rx";
> +			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
> +			resets = <&cpg 211>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};

...
