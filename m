From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 14 Feb 2017 10:25:32 +0800
Subject: [PATCH v1 1/3] ASoC: zx-tdm: add documentation for zte's tdm
 controller
In-Reply-To: <1486973853-25291-1-git-send-email-baoyou.xie@linaro.org>
References: <1486973853-25291-1-git-send-email-baoyou.xie@linaro.org>
Message-ID: <20170214022530.GB4151@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 13, 2017 at 04:17:31PM +0800, Baoyou Xie wrote:
> This patch adds dt-binding documentation for zte's tdm controller.
> 
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>

"bindings doc" instead of "documentation" in patch subject is more
clear.

> ---
>  .../devicetree/bindings/sound/zte,tdm.txt          | 32 ++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/zte,tdm.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/zte,tdm.txt b/Documentation/devicetree/bindings/sound/zte,tdm.txt
> new file mode 100644
> index 0000000..f6e4f7f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/zte,tdm.txt
> @@ -0,0 +1,32 @@
> +ZTE TDM DAI driver
> +
> +Required properties:
> +
> +- compatible : should be one of the following.
> +       * zte,zx-tdm

We usually use particular SoC name (e.g. zx296702) rather than family
name (e.g. zx or zx2967) in the compatible string to specify the
programming model, because that's more explicit.

> +- reg : physical base address of the controller and length of memory mapped
> +    region.
> +- clocks : Pairs of phandle and specifier referencing the controller's clocks.
> +- clock-names: "tdm_wclk" for the wclk.
> +               "tdm_pclk" for the pclk.

The "tdm_" prefix in the name is redundant, as it's in tdm context
anyway.

> +-#clock-cells: should be 1.
> +- zte,tdm-dma-sysctrl : Reference to the sysctrl controller controlling
> +    the dma. includes:
> +	phandle of sysctrl.
> +	register offset in sysctrl for control dma.
> +	mask of the register that be written to dma.
> +	value of the register that be written to dma.

written to dma?  I think it gets written to sysctrl block.

> +
> +Example:
> +
> +	tdm: tdm at 1487000 {
> +		compatible = "zte,zx-tdm";
> +		reg = <0x01487000 0x1000>;
> +		clocks = <&audiocrm AUDIO_TDM_WCLK>, <&audiocrm AUDIO_TDM_PCLK>;
> +		clock-names = "tdm_wclk", "tdm_pclk";
> +		#clock-cells = <1>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&tdm_global_pin>;
> +		zte,tdm-dma-sysctrl = <&sysctrl 0x10c 0xf 0xf>;

I think we only need to set up bit 2 instead of bits [3:0], since we
only need to select dma channel 20 and 21 for PCM/TDM from UART5.

> +		status = "ok";

We usually use "okay" instead of "ok" for status.  For example in
bindings doc, I would suggest that we simply omit 'status' property.

Shawn

> +	};
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
