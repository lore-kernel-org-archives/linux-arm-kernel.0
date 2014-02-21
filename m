From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 21 Feb 2014 09:26:57 +0000
Subject: [Patch v6 1/2] dmaengine: qcom_bam_dma: Add device tree binding
In-Reply-To: <1392964986-5207-2-git-send-email-agross@codeaurora.org>
References: <1392964986-5207-1-git-send-email-agross@codeaurora.org>
 <1392964986-5207-2-git-send-email-agross@codeaurora.org>
Message-ID: <20140221092657.GD7541@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 21, 2014 at 06:43:04AM +0000, Andy Gross wrote:
> Add device tree binding support for the QCOM BAM DMA driver.
> 
> Acked-by: Kumar Gala <galak@codeaurora.org>
> Signed-off-by: Andy Gross <agross@codeaurora.org>
> ---
>  .../devicetree/bindings/dma/qcom_bam_dma.txt       |   48 ++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
> 
> diff --git a/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt b/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
> new file mode 100644
> index 0000000..86344f1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
> @@ -0,0 +1,48 @@
> +QCOM BAM DMA controller
> +
> +Required properties:
> +- compatible:	Must be "qcom,bam-v1.4.0" for MSM8974 V1
> +		Must be "qcom,bam-v1.4.1" for MSM8974 V2

This looks a bit odd. How about:

- compatible: must contain:
  * "qcom,bam-v1.4.0" for MSM8974 V1
  * "qcom,bam-v1.4.1" for MSM8974 V2

> +- reg: Address range for DMA registers
> +- interrupts: single interrupt for this controller

This device only has a single interrupt? Or there's only one we care
about at the moment?

> +- #dma-cells: must be <1>
> +- clocks: required clock
> +- clock-names: name of clock

Either describe the _exact_ name this binding expects for any clocks
input, or get rid of clock-names. I would prefer the former.

> +- qcom,ee : indicates the active Execution Environment identifier (0-7)
> +
> +Example:
> +
> +	uart-bam: dma at f9984000 = {
> +		compatible = "qcom,bam-v1.4.1";
> +		reg = <0xf9984000 0x15000>;
> +		interrupts = <0 94 0>;
> +		clocks = <&gcc GCC_BAM_DMA_AHB_CLK>;
> +		clock-names = "bam_clk";
> +		#dma-cells = <1>;
> +		qcom,ee = <0>;
> +	};
> +
> +Client:
> +Required properties:
> +- dmas: List of dma channel requests
> +- dma-names: Names of aforementioned requested channels

Do we really need to describe the client binding? Do we not have a
generic DMA binding doc we can refer to?

> +
> +Clients must use the format described in the dma.txt file, using a two cell
> +specifier for each channel.
> +
> +The three cells in order are:
> +  1. A phandle pointing to the DMA controller
> +  2. The channel number

s/three/two/

I think this can go if we refer to a generic document for the client
binding and state in the #dma-cells description that the single dma cell
is the channel number.

Thanks,
Mark.
