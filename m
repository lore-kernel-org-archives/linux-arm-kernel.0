From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 8 Apr 2014 16:32:02 -0700
Subject: [PATCH v2] ARM: qcom: Add initial APQ8064 SoC and IFC6410 board
 device trees
In-Reply-To: <1396972391-11759-1-git-send-email-galak@codeaurora.org>
References: <1396972391-11759-1-git-send-email-galak@codeaurora.org>
Message-ID: <20140408233202.GM9985@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/08, Kumar Gala wrote:
> diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
> new file mode 100644
> index 0000000..e336c09
> --- /dev/null
> +++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
> @@ -0,0 +1,154 @@
> +/dts-v1/;
> +
> +#include "skeleton.dtsi"
> +#include <dt-bindings/clock/qcom,gcc-msm8960.h>
> +
> +/ {
> +	model = "Qualcomm APQ8064";
> +	compatible = "qcom,apq8064";
> +	interrupt-parent = <&intc>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "qcom,krait";

This doesn't follow the binding. We're supposed to put the
compatible in each cpu node even though it's always the same.

> +		enable-method = "qcom,kpss-acc-v1";
> +
> +		cpu at 0 {
> +			device_type = "cpu";
> +			reg = <0>;
> +			next-level-cache = <&L2>;
> +			qcom,acc = <&acc0>;
> +			qcom,saw = <&saw0>;
> +		};
> +
> +		cpu at 1 {
> +			device_type = "cpu";
> +			reg = <1>;
> +			next-level-cache = <&L2>;
> +			qcom,acc = <&acc1>;
> +			qcom,saw = <&saw1>;
> +		};
> +
> +		cpu at 2 {
> +			device_type = "cpu";
> +			reg = <2>;
> +			next-level-cache = <&L2>;
> +			qcom,acc = <&acc2>;
> +			qcom,saw = <&saw2>;
> +		};
> +
> +		cpu at 3 {
> +			device_type = "cpu";
> +			reg = <3>;
> +			next-level-cache = <&L2>;
> +			qcom,acc = <&acc3>;
> +			qcom,saw = <&saw3>;
> +		};
> +
> +		L2: l2-cache {
> +			compatible = "cache";

This would be "qcom,arch-cache" if the binding is accepted.

> +			cache-level = <2>;
> +			interrupts = <0 2 0x4>;

These interrupts here are also not accepted as a binding yet.

> +		};
> +	};
> +
> +	cpu-pmu {
> +		compatible = "qcom,krait-pmu";
> +		interrupts = <1 10 0x304>;
> +	};
> +
> +	soc: soc {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +		compatible = "simple-bus";
> +
> +

Nit: Weird two newlines here

> +		intc: interrupt-controller at 2000000 {
> +			compatible = "qcom,msm-qgic2";
> +			interrupt-controller;
> +			#interrupt-cells = <3>;
> +			reg = < 0x02000000 0x1000 >,
> +			      < 0x02002000 0x1000 >;
> +		};
> +

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
