From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 24 Sep 2018 12:19:29 -0700
Subject: [PATCH] arm64: dts: sdm630 SoC and Sony Pioneer (Xperia XA2)
 support
In-Reply-To: <20180811162549.12312-1-ctatlor97@gmail.com>
References: <20180811162549.12312-1-ctatlor97@gmail.com>
Message-ID: <20180924191929.GQ1367@tuxbook-pro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat 11 Aug 09:25 PDT 2018, Craig Tatlor wrote:

> Initial device tree support for Qualcomm SDM630 SoC and
> Sony Pioneer (Xperia XA2).
> 
> SDM630 is based off of the SDM660 soc and all SDM660 specific drivers are
> compatible with it. SDM660 is also based off of MSM8998 so it uses some
> of its drivers aswell.

Consider adding both sdm630 and sdm660 compatibles to the bindings and
drivers and use the right one in the dts, in case we find details that
differs in the future.

> 
> The device tree is based on the CAF 4.4 kernel tree.
> 
> The device can be booted into the initrd with a shell over UART.
> 
> Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
[..]
> diff --git a/arch/arm64/boot/dts/qcom/sdm630-pins.dtsi b/arch/arm64/boot/dts/qcom/sdm630-pins.dtsi
> new file mode 100644
> index 000000000000..78b79c1076f1
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sdm630-pins.dtsi
> @@ -0,0 +1,17 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2018, Craig Tatlor. */
> +
> +&tlmm {
> +	blsp1_uart1_default: blsp1_uart1_default {
> +		pinmux {
> +			pins = "gpio0", "gpio1", "gpio2", "gpio3";
> +			function = "gpio";

Please put these in the sdm630.dtsi directly, rather than spreading the
pins out in a separate file.

> +		};
> +
> +		pinconf {
> +			pins = "gpio0", "gpio1", "gpio2", "gpio3";
> +			drive-strength = <2>;
> +			bias-disable;

Please extend &blsp1_uart1_default in the pioneer dtsi with these
"electrical properties".

> +		};
> +	};
> +};
[..]
> diff --git a/arch/arm64/boot/dts/qcom/sdm630-pioneer.dtsi b/arch/arm64/boot/dts/qcom/sdm630-pioneer.dtsi
> new file mode 100644
> index 000000000000..512792c23369
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sdm630-pioneer.dtsi
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2018, Craig Tatlor. */
> +
> +#include "sdm630.dtsi"
> +
> +/ {
> +	aliases {
> +		serial0 = &blsp1_uart1;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> +
> +&soc {
> +	serial at c170000 {

Please reference this by &blsp1_uart1, rather than duplicating the
hierarchy.

> +		status = "okay";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&blsp1_uart1_default>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> new file mode 100644
> index 000000000000..8a544979b7c0
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> @@ -0,0 +1,383 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2018, Craig Tatlor. */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/qcom,gcc-sdm660.h>
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. SDM630";

We expect the board to always override this, so no need to specify it
here.

> +
> +	interrupt-parent = <&intc>;
> +
> +	qcom,msm-id = <318 0x0>;
> +
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	chosen { };
> +
> +	memory {
> +		device_type = "memory";
> +		/* We expect the bootloader to fill in the reg */
> +		reg = <0 0 0 0>;
> +	};
> +
> +

Extra empty line.

> +	cpus {
[..]
> +
> +	timer {

Please sort these nodes by name, except for "soc" which is convenient
to have last.

> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 1 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 2 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 3 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 0 IRQ_TYPE_LEVEL_LOW>;
> +	};
[..]
> +	firmware {
> +		scm {
> +			compatible = "qcom,scm-sdm660";
> +		};
> +	};
> +
> +

Extra empty line.

> +	rpm-glink {
> +		compatible = "qcom,glink-rpm";
> +
> +		interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
> +
> +		qcom,rpm-msg-ram = <&rpm_msg_ram>;
> +
> +		mboxes = <&apcs_glb 0>;

Remove a few of these extra empty lines and add the rpm_requests channel
here while you're at it:

		rpm_requests: glink-channel {
                        compatible = "qcom,rpm-sdm660";
                        qcom,glink-channels = "rpm_requests";
                };

> +	};
> +
> +	soc: soc {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0 0 0 0xffffffff>;
> +		compatible = "simple-bus";
> +
> +		intc: interrupt-controller at 17a00000 {

Please sort these nodes by base address.

> +			compatible = "arm,gic-v3";
> +			reg = <0x17a00000 0x10000>,
> +			      <0x17b00000 0x100000>;
> +			#interrupt-cells = <3>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +			interrupt-controller;
> +			#redistributor-regions = <1>;
> +			redistributor-stride = <0x0 0x20000>;
> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		gcc: clock-controller at 100000 {
> +			compatible = "qcom,gcc-sdm660";
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +			#power-domain-cells = <1>;
> +			reg = <0x100000 0x94000>;

Please 0-pad addresses in "reg", makes it easier to sort them as well
(but keep the @address after the node name unpadded).

> +		};
> +
[..]
> +		rpm_msg_ram: memory at 778000 {
> +			compatible = "qcom,rpm-msg-ram";
> +			reg = <0x778000 0x7000>;
> +		};
> +
> +		apcs_glb: mailbox at 17911000 {
> +			compatible = "qcom,msm8998-apcs-hmss-global";

Please update the apcs ipc driver with a sdm660 compatible and update
this.

> +			reg = <0x17911000 0x1000>;
> +
> +			#mbox-cells = <1>;
> +		};

Regards,
Bjorn
