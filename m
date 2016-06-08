From: liviu.dudau@arm.com (Liviu Dudau)
Date: Wed, 8 Jun 2016 17:04:49 +0100
Subject: [PATCH 1/3] arm64: dts: juno: add coresight support
In-Reply-To: <1465228765-14038-2-git-send-email-sudeep.holla@arm.com>
References: <1465228765-14038-1-git-send-email-sudeep.holla@arm.com>
 <1465228765-14038-2-git-send-email-sudeep.holla@arm.com>
Message-ID: <20160608160449.GP1165@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 06, 2016 at 04:59:23PM +0100, Sudeep Holla wrote:
> Most of the debug-related components on Juno are located in the coreSight
> subsystem while others are located in the Cortex-Axx clusters, the SCP
> subsystem, and in the main system.
> 
> Each core in the two processor clusters contain an Embedded Trace
> Macrocell(ETM) which generates real-time trace information that trace
> tools can use and an ATB trace output that is sent to a funnel before
> going to the CoreSight subsystem.
> 
> The trace output signals combine with two trace expansions using another
> funnel and fed into the Embedded Trace FIFO(ETF0).
> 
> The output trace data stream of the funnel is then replicated before it
> is sent to either the:
> - Trace Port Interface Unit(TPIU), that sends it out using the trace port.
> - ETR that can write the trace data to memory located in the application
>   memory space
> 
> Cc: Liviu Dudau <liviu.dudau@arm.com>

Acked-by: Liviu Dudau <Liviu.Dudau@arm.com>

> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  arch/arm64/boot/dts/arm/juno-base.dtsi | 296 +++++++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/arm/juno-r1.dts    |  24 +++
>  arch/arm64/boot/dts/arm/juno-r2.dts    |  24 +++
>  arch/arm64/boot/dts/arm/juno.dts       |  24 +++
>  4 files changed, 368 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
> index dee2386d3b9b..90a8710f7032 100644
> --- a/arch/arm64/boot/dts/arm/juno-base.dtsi
> +++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
> @@ -56,6 +56,302 @@
>  			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>;
>  	};
> 
> +	/*
> +	 * Juno TRMs specify the size for these coresight components as 64K.
> +	 * The actual size is just 4K though 64K is reserved. Access to the
> +	 * unmapped reserved region results in a DECERR response.
> +	 */
> +	etf at 20010000 {
> +		compatible = "arm,coresight-tmc", "arm,primecell";
> +		reg = <0 0x20010000 0 0x1000>;
> +
> +		clocks = <&soc_smc50mhz>;
> +		clock-names = "apb_pclk";
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			/* input port */
> +			port at 0 {
> +				reg = <0>;
> +				etf_in_port: endpoint {
> +					slave-mode;
> +					remote-endpoint = <&main_funnel_out_port>;
> +				};
> +			};
> +
> +			/* output port */
> +			port at 1 {
> +				reg = <0>;
> +				etf_out_port: endpoint {
> +					remote-endpoint = <&replicator_in_port0>;
> +				};
> +			};
> +		};
> +	};
> +
> +	tpiu at 20030000 {
> +		compatible = "arm,coresight-tpiu", "arm,primecell";
> +		reg = <0 0x20030000 0 0x1000>;
> +
> +		clocks = <&soc_smc50mhz>;
> +		clock-names = "apb_pclk";
> +		port {
> +			tpiu_in_port: endpoint {
> +				slave-mode;
> +				remote-endpoint = <&replicator_out_port0>;
> +			};
> +		};
> +	};
> +
> +	main_funnel at 20040000 {
> +		compatible = "arm,coresight-funnel", "arm,primecell";
> +		reg = <0 0x20040000 0 0x1000>;
> +
> +		clocks = <&soc_smc50mhz>;
> +		clock-names = "apb_pclk";
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port at 0 {
> +				reg = <0>;
> +				main_funnel_out_port: endpoint {
> +					remote-endpoint = <&etf_in_port>;
> +				};
> +			};
> +
> +			port at 1 {
> +				reg = <0>;
> +				main_funnel_in_port0: endpoint {
> +					slave-mode;
> +					remote-endpoint = <&cluster0_funnel_out_port>;
> +				};
> +			};
> +
> +			port at 2 {
> +				reg = <1>;
> +				main_funnel_in_port1: endpoint {
> +					slave-mode;
> +					remote-endpoint = <&cluster1_funnel_out_port>;
> +				};
> +			};
> +
> +		};
> +	};
> +
> +	etr at 20070000 {
> +		compatible = "arm,coresight-tmc", "arm,primecell";
> +		reg = <0 0x20070000 0 0x1000>;
> +
> +		clocks = <&soc_smc50mhz>;
> +		clock-names = "apb_pclk";
> +		port {
> +			etr_in_port: endpoint {
> +				slave-mode;
> +				remote-endpoint = <&replicator_out_port1>;
> +			};
> +		};
> +	};
> +
> +	coresight-replicator {
> +		/* non-configurable replicators don't show up on the
> +		 * AMBA bus.  As such no need to add "arm,primecell".
> +		 */
> +		compatible = "arm,coresight-replicator";
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			/* replicator output ports */
> +			port at 0 {
> +				reg = <0>;
> +				replicator_out_port0: endpoint {
> +					remote-endpoint = <&tpiu_in_port>;
> +				};
> +			};
> +
> +			port at 1 {
> +				reg = <1>;
> +				replicator_out_port1: endpoint {
> +					remote-endpoint = <&etr_in_port>;
> +				};
> +			};
> +
> +			/* replicator input port */
> +			port at 2 {
> +				reg = <0>;
> +				replicator_in_port0: endpoint {
> +					slave-mode;
> +					remote-endpoint = <&etf_out_port>;
> +				};
> +			};
> +		};
> +	};
> +
> +	cluster0_funnel at 220c0000 {
> +		compatible = "arm,coresight-funnel", "arm,primecell";
> +		reg = <0 0x220c0000 0 0x1000>;
> +
> +		clocks = <&soc_smc50mhz>;
> +		clock-names = "apb_pclk";
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port at 0 {
> +				reg = <0>;
> +				cluster0_funnel_out_port: endpoint {
> +					remote-endpoint = <&main_funnel_in_port0>;
> +				};
> +			};
> +
> +			port at 1 {
> +				reg = <0>;
> +				cluster0_funnel_in_port0: endpoint {
> +					slave-mode;
> +					remote-endpoint = <&cluster0_etm0_out_port>;
> +				};
> +			};
> +
> +			port at 2 {
> +				reg = <1>;
> +				cluster0_funnel_in_port1: endpoint {
> +					slave-mode;
> +					remote-endpoint = <&cluster0_etm1_out_port>;
> +				};
> +			};
> +		};
> +	};
> +
> +	cluster1_funnel at 230c0000 {
> +		compatible = "arm,coresight-funnel", "arm,primecell";
> +		reg = <0 0x230c0000 0 0x1000>;
> +
> +		clocks = <&soc_smc50mhz>;
> +		clock-names = "apb_pclk";
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port at 0 {
> +				reg = <0>;
> +				cluster1_funnel_out_port: endpoint {
> +					remote-endpoint = <&main_funnel_in_port1>;
> +				};
> +			};
> +
> +			port at 1 {
> +				reg = <0>;
> +				cluster1_funnel_in_port0: endpoint {
> +					slave-mode;
> +					remote-endpoint = <&cluster1_etm0_out_port>;
> +				};
> +			};
> +
> +			port at 2 {
> +				reg = <1>;
> +				cluster1_funnel_in_port1: endpoint {
> +					slave-mode;
> +					remote-endpoint = <&cluster1_etm1_out_port>;
> +				};
> +			};
> +			port at 3 {
> +				reg = <2>;
> +				cluster1_funnel_in_port2: endpoint {
> +					slave-mode;
> +					remote-endpoint = <&cluster1_etm2_out_port>;
> +				};
> +			};
> +			port at 4 {
> +				reg = <3>;
> +				cluster1_funnel_in_port3: endpoint {
> +					slave-mode;
> +					remote-endpoint = <&cluster1_etm3_out_port>;
> +				};
> +			};
> +		};
> +	};
> +
> +	etm0: etm at 22040000 {
> +		compatible = "arm,coresight-etm4x", "arm,primecell";
> +		reg = <0 0x22040000 0 0x1000>;
> +
> +		clocks = <&soc_smc50mhz>;
> +		clock-names = "apb_pclk";
> +		port {
> +			cluster0_etm0_out_port: endpoint {
> +				remote-endpoint = <&cluster0_funnel_in_port0>;
> +			};
> +		};
> +	};
> +
> +	etm1: etm at 22140000 {
> +		compatible = "arm,coresight-etm4x", "arm,primecell";
> +		reg = <0 0x22140000 0 0x1000>;
> +
> +		clocks = <&soc_smc50mhz>;
> +		clock-names = "apb_pclk";
> +		port {
> +			cluster0_etm1_out_port: endpoint {
> +				remote-endpoint = <&cluster0_funnel_in_port1>;
> +			};
> +		};
> +	};
> +
> +	etm2: etm at 23040000 {
> +		compatible = "arm,coresight-etm4x", "arm,primecell";
> +		reg = <0 0x23040000 0 0x1000>;
> +
> +		clocks = <&soc_smc50mhz>;
> +		clock-names = "apb_pclk";
> +		port {
> +			cluster1_etm0_out_port: endpoint {
> +				remote-endpoint = <&cluster1_funnel_in_port0>;
> +			};
> +		};
> +	};
> +
> +	etm3: etm at 23140000 {
> +		compatible = "arm,coresight-etm4x", "arm,primecell";
> +		reg = <0 0x23140000 0 0x1000>;
> +
> +		clocks = <&soc_smc50mhz>;
> +		clock-names = "apb_pclk";
> +		port {
> +			cluster1_etm1_out_port: endpoint {
> +				remote-endpoint = <&cluster1_funnel_in_port1>;
> +			};
> +		};
> +	};
> +
> +	etm4: etm at 23240000 {
> +		compatible = "arm,coresight-etm4x", "arm,primecell";
> +		reg = <0 0x23240000 0 0x1000>;
> +
> +		clocks = <&soc_smc50mhz>;
> +		clock-names = "apb_pclk";
> +		port {
> +			cluster1_etm2_out_port: endpoint {
> +				remote-endpoint = <&cluster1_funnel_in_port2>;
> +			};
> +		};
> +	};
> +
> +	etm5: etm at 23340000 {
> +		compatible = "arm,coresight-etm4x", "arm,primecell";
> +		reg = <0 0x23340000 0 0x1000>;
> +
> +		clocks = <&soc_smc50mhz>;
> +		clock-names = "apb_pclk";
> +		port {
> +			cluster1_etm3_out_port: endpoint {
> +				remote-endpoint = <&cluster1_funnel_in_port3>;
> +			};
> +		};
> +	};
> +
>  	sram: sram at 2e000000 {
>  		compatible = "arm,juno-sram-ns", "mmio-sram";
>  		reg = <0x0 0x2e000000 0x0 0x8000>;
> diff --git a/arch/arm64/boot/dts/arm/juno-r1.dts b/arch/arm64/boot/dts/arm/juno-r1.dts
> index d95d9e7e2dc0..f4f8f54f8b85 100644
> --- a/arch/arm64/boot/dts/arm/juno-r1.dts
> +++ b/arch/arm64/boot/dts/arm/juno-r1.dts
> @@ -181,3 +181,27 @@
>  &pcie_ctlr {
>  	status = "okay";
>  };
> +
> +&etm0 {
> +	cpu = <&A57_0>;
> +};
> +
> +&etm1 {
> +	cpu = <&A57_1>;
> +};
> +
> +&etm2 {
> +	cpu = <&A53_0>;
> +};
> +
> +&etm3 {
> +	cpu = <&A53_1>;
> +};
> +
> +&etm4 {
> +	cpu = <&A53_2>;
> +};
> +
> +&etm5 {
> +	cpu = <&A53_3>;
> +};
> diff --git a/arch/arm64/boot/dts/arm/juno-r2.dts b/arch/arm64/boot/dts/arm/juno-r2.dts
> index 88ecd6182b67..d903e545b64c 100644
> --- a/arch/arm64/boot/dts/arm/juno-r2.dts
> +++ b/arch/arm64/boot/dts/arm/juno-r2.dts
> @@ -181,3 +181,27 @@
>  &pcie_ctlr {
>  	status = "okay";
>  };
> +
> +&etm0 {
> +	cpu = <&A72_0>;
> +};
> +
> +&etm1 {
> +	cpu = <&A72_1>;
> +};
> +
> +&etm2 {
> +	cpu = <&A53_0>;
> +};
> +
> +&etm3 {
> +	cpu = <&A53_1>;
> +};
> +
> +&etm4 {
> +	cpu = <&A53_2>;
> +};
> +
> +&etm5 {
> +	cpu = <&A53_3>;
> +};
> diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
> index dcfcf15a17f5..a7270eff6939 100644
> --- a/arch/arm64/boot/dts/arm/juno.dts
> +++ b/arch/arm64/boot/dts/arm/juno.dts
> @@ -173,3 +173,27 @@
> 
>  	#include "juno-base.dtsi"
>  };
> +
> +&etm0 {
> +	cpu = <&A57_0>;
> +};
> +
> +&etm1 {
> +	cpu = <&A57_1>;
> +};
> +
> +&etm2 {
> +	cpu = <&A53_0>;
> +};
> +
> +&etm3 {
> +	cpu = <&A53_1>;
> +};
> +
> +&etm4 {
> +	cpu = <&A53_2>;
> +};
> +
> +&etm5 {
> +	cpu = <&A53_3>;
> +};
> --
> 2.7.4
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
