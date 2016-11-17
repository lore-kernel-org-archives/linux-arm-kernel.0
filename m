From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 17 Nov 2016 11:59:18 -0700
Subject: [PATCH v4] arm64: dts: qcom: Add msm8916 CoreSight components
In-Reply-To: <20161117153522.11630-1-georgi.djakov@linaro.org>
References: <20161117153522.11630-1-georgi.djakov@linaro.org>
Message-ID: <20161117185918.GA7884@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2016 at 05:35:22PM +0200, Georgi Djakov wrote:
> From: "Ivan T. Ivanov" <ivan.ivanov@linaro.org>
> 
> Add initial set of CoreSight components found on Qualcomm's 8x16 chipset.

Hello Georgi,

Could you add a better desccription for the SoC?  To me "8x16" doesn't
say much.

With that change:
Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> 
> Signed-off-by: Ivan T. Ivanov <ivan.ivanov@linaro.org>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
> 
> This patch was on hold for some time, as it has a dependency on RPM clocks,
> which is now merged into clk-next.
> 
> Changes since v3: (https://lkml.org/lkml/2015/5/11/134)
>  * Include msm8916-coresight.dtsi into msm8916.dtsi
> 
> Changes since v2: (https://lkml.org/lkml/2015/4/29/242)
>  * Added "1x" to "qcom,coresight-replicator" compatible string, to match what
>    devicetree bindings documentations says.
> 
> 
>  arch/arm64/boot/dts/qcom/msm8916-coresight.dtsi | 254 ++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/msm8916.dtsi           |   2 +
>  2 files changed, 256 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8916-coresight.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-coresight.dtsi b/arch/arm64/boot/dts/qcom/msm8916-coresight.dtsi
> new file mode 100644
> index 000000000000..900f1f484a0a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8916-coresight.dtsi
> @@ -0,0 +1,254 @@
> +/*
> + * Copyright (c) 2013 - 2015, The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +&soc {
> +
> +	tpiu at 820000 {
> +		compatible = "arm,coresight-tpiu", "arm,primecell";
> +		reg = <0x820000 0x1000>;
> +
> +		clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
> +		clock-names = "apb_pclk", "atclk";
> +
> +		port {
> +			tpiu_in: endpoint {
> +				slave-mode;
> +				remote-endpoint = <&replicator_out1>;
> +			};
> +		};
> +	};
> +
> +	funnel at 821000 {
> +		compatible = "arm,coresight-funnel", "arm,primecell";
> +		reg = <0x821000 0x1000>;
> +
> +		clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
> +		clock-names = "apb_pclk", "atclk";
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			/*
> +			 * Not described input ports:
> +			 * 0 - connected to Resource and Power Manger CPU ETM
> +			 * 1 - not-connected
> +			 * 2 - connected to Modem CPU ETM
> +			 * 3 - not-connected
> +			 * 5 - not-connected
> +			 * 6 - connected trought funnel to Wireless CPU ETM
> +			 * 7 - connected to STM component
> +			 */
> +			port at 4 {
> +				reg = <4>;
> +				funnel0_in4: endpoint {
> +					slave-mode;
> +					remote-endpoint = <&funnel1_out>;
> +				};
> +			};
> +			port at 8 {
> +				reg = <0>;
> +				funnel0_out: endpoint {
> +					remote-endpoint = <&etf_in>;
> +				};
> +			};
> +		};
> +	};
> +
> +	replicator at 824000 {
> +		compatible = "qcom,coresight-replicator1x", "arm,primecell";
> +		reg = <0x824000 0x1000>;
> +
> +		clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
> +		clock-names = "apb_pclk", "atclk";
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port at 0 {
> +				reg = <0>;
> +				replicator_out0: endpoint {
> +					remote-endpoint = <&etr_in>;
> +				};
> +			};
> +			port at 1 {
> +				reg = <1>;
> +				replicator_out1: endpoint {
> +					remote-endpoint = <&tpiu_in>;
> +				};
> +			};
> +			port at 2 {
> +				reg = <0>;
> +				replicator_in: endpoint {
> +					slave-mode;
> +					remote-endpoint = <&etf_out>;
> +				};
> +			};
> +		};
> +	};
> +
> +	etf at 825000 {
> +		compatible = "arm,coresight-tmc", "arm,primecell";
> +		reg = <0x825000 0x1000>;
> +
> +		clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
> +		clock-names = "apb_pclk", "atclk";
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port at 0 {
> +				reg = <0>;
> +				etf_out: endpoint {
> +					slave-mode;
> +					remote-endpoint = <&funnel0_out>;
> +				};
> +			};
> +			port at 1 {
> +				reg = <0>;
> +				etf_in: endpoint {
> +					remote-endpoint = <&replicator_in>;
> +				};
> +			};
> +		};
> +	};
> +
> +	etr at 826000 {
> +		compatible = "arm,coresight-tmc", "arm,primecell";
> +		reg = <0x826000 0x1000>;
> +
> +		clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
> +		clock-names = "apb_pclk", "atclk";
> +
> +		port {
> +			etr_in: endpoint {
> +				slave-mode;
> +				remote-endpoint = <&replicator_out0>;
> +			};
> +		};
> +	};
> +
> +	funnel at 841000 {	/* APSS funnel only 4 inputs are used */
> +		compatible = "arm,coresight-funnel", "arm,primecell";
> +		reg = <0x841000 0x1000>;
> +
> +		clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
> +		clock-names = "apb_pclk", "atclk";
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port at 0 {
> +				reg = <0>;
> +				funnel1_in0: endpoint {
> +					slave-mode;
> +					remote-endpoint = <&etm0_out>;
> +				};
> +			};
> +			port at 1 {
> +				reg = <1>;
> +				funnel1_in1: endpoint {
> +					slave-mode;
> +					remote-endpoint = <&etm1_out>;
> +				};
> +			};
> +			port at 2 {
> +				reg = <2>;
> +				funnel1_in2: endpoint {
> +					slave-mode;
> +					remote-endpoint = <&etm2_out>;
> +				};
> +			};
> +			port at 3 {
> +				reg = <3>;
> +				funnel1_in3: endpoint {
> +					slave-mode;
> +					remote-endpoint = <&etm3_out>;
> +				};
> +			};
> +			port at 4 {
> +				reg = <0>;
> +				funnel1_out: endpoint {
> +					remote-endpoint = <&funnel0_in4>;
> +				};
> +			};
> +		};
> +	};
> +
> +	etm at 85c000 {
> +		compatible = "arm,coresight-etm4x", "arm,primecell";
> +		reg = <0x85c000 0x1000>;
> +
> +		clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
> +		clock-names = "apb_pclk", "atclk";
> +
> +		cpu = <&CPU0>;
> +
> +		port {
> +			etm0_out: endpoint {
> +				remote-endpoint = <&funnel1_in0>;
> +			};
> +		};
> +	};
> +
> +	etm at 85d000 {
> +		compatible = "arm,coresight-etm4x", "arm,primecell";
> +		reg = <0x85d000 0x1000>;
> +
> +		clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
> +		clock-names = "apb_pclk", "atclk";
> +
> +		cpu = <&CPU1>;
> +
> +		port {
> +			etm1_out: endpoint {
> +				remote-endpoint = <&funnel1_in1>;
> +			};
> +		};
> +	};
> +
> +	etm at 85e000 {
> +		compatible = "arm,coresight-etm4x", "arm,primecell";
> +		reg = <0x85e000 0x1000>;
> +
> +		clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
> +		clock-names = "apb_pclk", "atclk";
> +
> +		cpu = <&CPU2>;
> +
> +		port {
> +			etm2_out: endpoint {
> +				remote-endpoint = <&funnel1_in2>;
> +			};
> +		};
> +	};
> +
> +	etm at 85f000 {
> +		compatible = "arm,coresight-etm4x", "arm,primecell";
> +		reg = <0x85f000 0x1000>;
> +
> +		clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
> +		clock-names = "apb_pclk", "atclk";
> +
> +		cpu = <&CPU3>;
> +
> +		port {
> +			etm3_out: endpoint {
> +				remote-endpoint = <&funnel1_in3>;
> +			};
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index 4221b7d2c0ce..bfaeb9364190 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -14,6 +14,7 @@
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/clock/qcom,gcc-msm8916.h>
>  #include <dt-bindings/reset/qcom,gcc-msm8916.h>
> +#include <dt-bindings/clock/qcom,rpmcc.h>
>  
>  / {
>  	model = "Qualcomm Technologies, Inc. MSM8916";
> @@ -993,4 +994,5 @@
>  	};
>  };
>  
> +#include "msm8916-coresight.dtsi"
>  #include "msm8916-pins.dtsi"
