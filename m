From: robh@kernel.org (Rob Herring)
Date: Tue, 23 Aug 2016 13:31:21 -0500
Subject: [PATCH v2 1/4] dt-binding: remoteproc: Introduce ADSP loader
 binding
In-Reply-To: <1471931866-3107-1-git-send-email-bjorn.andersson@linaro.org>
References: <1471931866-3107-1-git-send-email-bjorn.andersson@linaro.org>
Message-ID: <20160823183121.GA13010@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 22, 2016 at 10:57:43PM -0700, Bjorn Andersson wrote:
> This document defines the binding for a component that loads firmware
> and control the life cycle of the Qualcomm ADSP core.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v1:
> - Added platform names to compatibility
> 
>  .../devicetree/bindings/remoteproc/qcom,adsp.txt   | 70 ++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
> new file mode 100644
> index 000000000000..3820151ce3e9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
> @@ -0,0 +1,70 @@
> +Qualcomm ADSP Peripheral Image Loader
> +
> +This document defines the binding for a component that loads and boots firmware
> +on the Qualcomm ADSP core.

ADSP is for Audio DSP? So there is another driver for the audio 
functions? Why doesn't it do the firmware loading? I'm still confused 
why this binding is separate? If you had one common interface (a rproc) 
to load and boot various other blocks like ADSP and Venus, then this 
would make sense. Or does every accel block have some separate control 
uC associated with it?

> +
> +- compatible:
> +	Usage: required
> +	Value type: <string>
> +	Definition: must be one of:
> +		    "qcom,msm8974-adsp-pil"
> +		    "qcom,msm8996-adsp-pil"
> +
> +- interrupts-extended:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: must list the watchdog, fatal IRQs ready, handover and
> +		    stop-ack IRQs
> +
> +- interrupt-names:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: must be "wdog", "fatal", "ready", "handover", "stop-ack"
> +
> +- cx-supply:
> +	Usage: required
> +	Value type: <phandle>
> +	Definition: reference to the regulator to be held on behalf of the
> +		    booting of the Hexagon core
> +
> +- memory-region:
> +	Usage: required
> +	Value type: <phandle>
> +	Definition: reference to the reserved-memory for the ADSP
> +
> +- qcom,smem-states:
> +	Usage: required
> +	Value type: <phandle>
> +	Definition: reference to the smem state for requesting the ADSP to
> +		    shut down
> +
> +- qcom,smem-state-names:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: must be "stop"
> +
> += EXAMPLE
> +The following example describes the resources needed to boot control the
> +ADSP, as it is found on MSM8974 boards.
> +
> +	adsp {
> +		compatible = "qcom,adsp-pil";
> +
> +		interrupts-extended = <&intc 0 162 IRQ_TYPE_EDGE_RISING>,
> +				      <&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
> +				      <&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
> +				      <&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
> +				      <&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
> +		interrupt-names = "wdog",
> +				  "fatal",
> +				  "ready",
> +				  "handover",
> +				  "stop-ack";
> +
> +		cx-supply = <&pm8841_s2>;
> +
> +		memory-region = <&adsp_region>;
> +
> +		qcom,smem-states = <&modem_smp2p_out 0>;
> +		qcom,smem-state-names = "stop";
> +	};
> -- 
> 2.5.0
> 
