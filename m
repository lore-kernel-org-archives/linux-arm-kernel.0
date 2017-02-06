From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 6 Feb 2017 09:52:38 -0700
Subject: [PATCH 2/2] ARM: dts: qcom: Add msm8974 CoreSight components
In-Reply-To: <20170203183628.28198-1-georgi.djakov@linaro.org>
References: <20170203183628.28198-1-georgi.djakov@linaro.org>
Message-ID: <20170206165238.GA11391@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Georgi,

Looks good to me, just a cosmetic comment below...

On Fri, Feb 03, 2017 at 08:36:28PM +0200, Georgi Djakov wrote:
> From: "Ivan T. Ivanov" <ivan.ivanov@linaro.org>
> 
> Add initial set of CoreSight components found on Qualcomm
> msm8974 and apq8074 based platforms, including the APQ8074
> Dragonboard board.
> 
> Signed-off-by: Ivan T. Ivanov <ivan.ivanov@linaro.org>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  arch/arm/boot/dts/qcom-msm8974.dtsi | 280 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 276 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
> index 4b4c61e2ee35..ab766a36a461 100644
> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
> @@ -68,7 +68,7 @@
>  		#size-cells = <0>;
>  		interrupts = <1 9 0xf04>;
>  
> -		cpu at 0 {
> +		CPU0: cpu at 0 {
>  			compatible = "qcom,krait";
>  			enable-method = "qcom,kpss-acc-v2";
>  			device_type = "cpu";
> @@ -79,7 +79,7 @@
>  			cpu-idle-states = <&CPU_SPC>;
>  		};
>  
> -		cpu at 1 {
> +		CPU1: cpu at 1 {
>  			compatible = "qcom,krait";
>  			enable-method = "qcom,kpss-acc-v2";
>  			device_type = "cpu";
> @@ -90,7 +90,7 @@
>  			cpu-idle-states = <&CPU_SPC>;
>  		};
>  
> -		cpu at 2 {
> +		CPU2: cpu at 2 {
>  			compatible = "qcom,krait";
>  			enable-method = "qcom,kpss-acc-v2";
>  			device_type = "cpu";
> @@ -101,7 +101,7 @@
>  			cpu-idle-states = <&CPU_SPC>;
>  		};
>  
> -		cpu at 3 {
> +		CPU3: cpu at 3 {
>  			compatible = "qcom,krait";
>  			enable-method = "qcom,kpss-acc-v2";
>  			device_type = "cpu";
> @@ -733,6 +733,278 @@
>  
>  			status = "disabled";
>  		};
> +
> +		etr at fc322000 {
> +			compatible = "arm,coresight-tmc", "arm,primecell";
> +			reg = <0xfc322000 0x1000>;
> +
> +			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
> +			clock-names = "apb_pclk", "atclk";
> +
> +			port {
> +				etr_in: endpoint {
> +					slave-mode;
> +					remote-endpoint = <&replicator_out0>;
> +				};
> +			};
> +		};
> +
> +		tpiu at fc318000 {
> +			compatible = "arm,coresight-tpiu", "arm,primecell";
> +			reg = <0xfc318000 0x1000>;
> +
> +			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
> +			clock-names = "apb_pclk", "atclk";
> +
> +			port {
> +				tpiu_in: endpoint {
> +					 slave-mode;
> +					 remote-endpoint = <&replicator_out1>;
> +				 };
> +			};
> +		};
> +
> +		replicator at fc31c000 {
> +			compatible = "qcom,coresight-replicator1x", "arm,primecell";
> +			reg = <0xfc31c000 0x1000>;
> +
> +			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
> +			clock-names = "apb_pclk", "atclk";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port at 0 {
> +					reg = <0>;
> +					replicator_out0: endpoint {
> +						remote-endpoint = <&etr_in>;
> +					};
> +				};
> +				port at 1 {
> +					reg = <1>;
> +					replicator_out1: endpoint {
> +						remote-endpoint = <&tpiu_in>;
> +					};
> +				};
> +				port at 2 {
> +					reg = <0>;
> +					replicator_in: endpoint {
> +						slave-mode;
> +						remote-endpoint = <&etf_out>;
> +					};
> +				};
> +			};
> +		};
> +
> +		etf at fc307000 {
> +			compatible = "arm,coresight-tmc", "arm,primecell";
> +			reg = <0xfc307000 0x1000>;
> +
> +			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
> +			clock-names = "apb_pclk", "atclk";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port at 0 {
> +					reg = <0>;
> +					etf_out: endpoint {
> +						remote-endpoint = <&replicator_in>;
> +					};
> +				};
> +				port at 1 {
> +					reg = <0>;
> +					etf_in: endpoint {
> +						slave-mode;
> +						remote-endpoint = <&merger_out>;
> +					};
> +				};
> +			};
> +		};

For the replicator and ETF above, output ports are listed before input
ports, while the rest of the components below do the opposite.  As such
picturing the topology of the CS components is a little more difficult but has
no ramification on functionality.  I would suggest revising that but either way:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> +
> +		funnel at fc31b000 {
> +			compatible = "arm,coresight-funnel", "arm,primecell";
> +			reg = <0xfc31b000 0x1000>;
> +
> +			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
> +			clock-names = "apb_pclk", "atclk";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				/*
> +				 * Not described input ports:
> +				 * 0 - connected trought funnel to Audio, Modem and
> +				 *     Resource and Power Manager CPU's
> +				 * 2...7 - not-connected
> +				 */
> +				port at 1 {
> +					reg = <1>;
> +					merger_in1: endpoint {
> +						slave-mode;
> +						remote-endpoint = <&funnel1_out>;
> +					};
> +				};
> +				port at 8 {
> +					reg = <0>;
> +					merger_out: endpoint {
> +						remote-endpoint = <&etf_in>;
> +					};
> +				};
> +			};
> +		};
> +
> +		funnel at fc31a000 {
> +			compatible = "arm,coresight-funnel", "arm,primecell";
> +			reg = <0xfc31a000 0x1000>;
> +
> +			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
> +			clock-names = "apb_pclk", "atclk";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				/*
> +				 * Not described input ports:
> +				 * 0 - not-connected
> +				 * 1 - connected trought funnel to Multimedia CPU
> +				 * 2 - connected to Wireless CPU
> +				 * 3 - not-connected
> +				 * 4 - not-connected
> +				 * 6 - not-connected
> +				 * 7 - connected to STM
> +				 */
> +				port at 5 {
> +					reg = <5>;
> +					funnel1_in5: endpoint {
> +						slave-mode;
> +						remote-endpoint = <&kpss_out>;
> +					};
> +				};
> +				port at 8 {
> +					reg = <0>;
> +					funnel1_out: endpoint {
> +						remote-endpoint = <&merger_in1>;
> +					};
> +				};
> +			};
> +		};
> +
> +		funnel at fc345000 { /* KPSS funnel only 4 inputs are used */
> +			compatible = "arm,coresight-funnel", "arm,primecell";
> +			reg = <0xfc345000 0x1000>;
> +
> +			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
> +			clock-names = "apb_pclk", "atclk";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port at 0 {
> +					reg = <0>;
> +					kpss_in0: endpoint {
> +						slave-mode;
> +						remote-endpoint = <&etm0_out>;
> +					};
> +				};
> +				port at 1 {
> +					reg = <1>;
> +					kpss_in1: endpoint {
> +						slave-mode;
> +						remote-endpoint = <&etm1_out>;
> +					};
> +				};
> +				port at 2 {
> +					reg = <2>;
> +					kpss_in2: endpoint {
> +						slave-mode;
> +						remote-endpoint = <&etm2_out>;
> +					};
> +				};
> +				port at 3 {
> +					reg = <3>;
> +					kpss_in3: endpoint {
> +						slave-mode;
> +						remote-endpoint = <&etm3_out>;
> +					};
> +				};
> +				port at 8 {
> +					reg = <0>;
> +					kpss_out: endpoint {
> +						remote-endpoint = <&funnel1_in5>;
> +					};
> +				};
> +			};
> +		};
> +
> +		etm at fc33c000 {
> +			compatible = "arm,coresight-etm4x", "arm,primecell";
> +			reg = <0xfc33c000 0x1000>;
> +
> +			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
> +			clock-names = "apb_pclk", "atclk";
> +
> +			cpu = <&CPU0>;
> +
> +			port {
> +				etm0_out: endpoint {
> +					remote-endpoint = <&kpss_in0>;
> +				};
> +			};
> +		};
> +
> +		etm at fc33d000 {
> +			compatible = "arm,coresight-etm4x", "arm,primecell";
> +			reg = <0xfc33d000 0x1000>;
> +
> +			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
> +			clock-names = "apb_pclk", "atclk";
> +
> +			cpu = <&CPU1>;
> +
> +			port {
> +				etm1_out: endpoint {
> +					remote-endpoint = <&kpss_in1>;
> +				};
> +			};
> +		};
> +
> +		etm at fc33e000 {
> +			compatible = "arm,coresight-etm4x", "arm,primecell";
> +			reg = <0xfc33e000 0x1000>;
> +
> +			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
> +			clock-names = "apb_pclk", "atclk";
> +
> +			cpu = <&CPU2>;
> +
> +			port {
> +				etm2_out: endpoint {
> +					remote-endpoint = <&kpss_in2>;
> +				};
> +			};
> +		};
> +
> +		etm at fc33f000 {
> +			compatible = "arm,coresight-etm4x", "arm,primecell";
> +			reg = <0xfc33f000 0x1000>;
> +
> +			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
> +			clock-names = "apb_pclk", "atclk";
> +
> +			cpu = <&CPU3>;
> +
> +			port {
> +				etm3_out: endpoint {
> +					remote-endpoint = <&kpss_in3>;
> +				};
> +			};
> +		};
>  	};
>  
>  	smd {
