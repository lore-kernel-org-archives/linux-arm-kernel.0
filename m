From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 12 Mar 2018 11:29:51 +0000
Subject: [PATCH v6 3/3] arm64: dts: sdm845: Add minimal dts/dtsi files for
 sdm845 SoC and MTP
In-Reply-To: <20180312080656.13247-4-rnayak@codeaurora.org>
References: <20180312080656.13247-1-rnayak@codeaurora.org>
 <20180312080656.13247-4-rnayak@codeaurora.org>
Message-ID: <96fac632-8fb8-0933-cc1f-627acb38a595@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/18 08:06, Rajendra Nayak wrote:
> Add a skeletal sdm845 SoC dtsi and MTP board dts/dtsi files
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Reviewed-by: Doug Anderson <dianders@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/Makefile       |   1 +
>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts |  15 ++
>  arch/arm64/boot/dts/qcom/sdm845.dtsi    | 278 ++++++++++++++++++++++++++++++++
>  3 files changed, 294 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sdm845-mtp.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sdm845.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 55ec5ee7f7e8..9319e74b8906 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -6,3 +6,4 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-mtp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-bullhead-rev-101.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8994-angler-rev-101.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-mtp.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-mtp.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> new file mode 100644
> index 000000000000..979ab49913f1
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * SDM845 MTP board device tree source
> + *
> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include "sdm845.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. SDM845 MTP";
> +	compatible = "qcom,sdm845-mtp";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> new file mode 100644
> index 000000000000..d2407cd7a561
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi

[...]

> +		intc: interrupt-controller at 17a00000 {
> +			compatible = "arm,gic-v3";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +			#interrupt-cells = <3>;
> +			interrupt-controller;
> +			#redistributor-regions = <1>;
> +			redistributor-stride = <0x0 0x20000>;

You shouldn't need redistributor-stride here, unless your GIC
implementation is not compliant with the architecture (i.e. really
buggy). I only know of one such implementation, and I'd rather you
remove this property unless your GIC is indeed non-compliant. If that's
the case, you should also document it.

> +			reg = <0x17a00000 0x10000>,     /* GICD */
> +			      <0x17a60000 0x100000>;    /* GICR * 8 */
> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			gic-its at 17a40000 {
> +				compatible = "arm,gic-v3-its";
> +				msi-controller;
> +				#msi-cells = <1>;
> +				reg = <0x17a40000 0x20000>;
> +				status = "disabled";
> +			};
> +		};

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
