From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 15 Dec 2014 11:07:06 +0000
Subject: [RFC] ARM: dts: mt8173: Add psci cpuidle support
In-Reply-To: <1418633948-2513-1-git-send-email-howard.chen@linaro.org>
References: <1418633948-2513-1-git-send-email-howard.chen@linaro.org>
Message-ID: <20141215110706.GD462@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 15, 2014 at 08:59:08AM +0000, Howard Chen wrote:
> add device tree for psci-0.2 on mt8173 platform
> add device tree for cupidle-arm64 on mt8173 platform
> 
> Signed-off-by: Howard Chen <howard.chen@linaro.org>
> ---
>  arch/arm64/boot/dts/mt8173.dtsi | 51 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mt8173.dtsi b/arch/arm64/boot/dts/mt8173.dtsi
> index 79b7e46..c5e1127 100644
> --- a/arch/arm64/boot/dts/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mt8173.dtsi
> @@ -44,6 +44,11 @@
>  		};
>  	};
>  
> +	psci {
> +		compatible = "arm,psci-0.2";
> +		method = "smc";
> +	};
> +
>  	cpus {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> @@ -54,6 +59,7 @@
>  			reg = <0x000>;
>  			enable-method = "mt-boot";

What is "mt-boot", and why is this not "psci"?

What tree is this based on?

The additions for idle look fine as of themselves, but we shouldn't
require non-standard enable method code with PSCI.

Mark.

>  			cpu-release-addr = <0x0 0x40000200>;
> +			cpu-idle-states = <&CPU_SLEEP_1_0 &CLUSTER_SLEEP_1>;
>  		};
>  
>  		cpu1: cpu at 1 {
> @@ -62,6 +68,7 @@
>  			reg = <0x001>;
>  			enable-method = "mt-boot";
>  			cpu-release-addr = <0x0 0x40000200>;
> +			cpu-idle-states = <&CPU_SLEEP_1_0 &CLUSTER_SLEEP_1>;
>  		};
>  
>  		cpu2: cpu at 2 {
> @@ -70,6 +77,7 @@
>  			reg = <0x100>;
>  			enable-method = "mt-boot";
>  			cpu-release-addr = <0x0 0x40000200>;
> +			cpu-idle-states = <&CPU_SLEEP_0_0 &CLUSTER_SLEEP_0>;
>  		};
>  
>  		cpu3: cpu at 3 {
> @@ -78,8 +86,51 @@
>  			reg = <0x101>;
>  			enable-method = "mt-boot";
>  			cpu-release-addr = <0x0 0x40000200>;
> +			cpu-idle-states = <&CPU_SLEEP_0_0 &CLUSTER_SLEEP_0>;
>  		};
>  
> +		idle-states {
> +			entry-method = "arm,psci-0.2";
> +
> +			CPU_SLEEP_0_0: cpu-sleep-0-0 {
> +				compatible = "arm,idle-state";
> +				local-timer-stop;
> +				arm,psci-suspend-param = <0x0010000>;
> +				entry-latency-us = <250>;
> +				exit-latency-us = <500>;
> +				min-residency-us = <950>;
> +			};
> +
> +			CLUSTER_SLEEP_0: cluster-sleep-0 {
> +				compatible = "arm,idle-state";
> +				local-timer-stop;
> +				arm,psci-suspend-param = <0x1010000>;
> +				entry-latency-us = <600>;
> +				exit-latency-us = <1100>;
> +				min-residency-us = <2700>;
> +				wakeup-latency-us = <1500>;
> +			};
> +
> +			CPU_SLEEP_1_0: cpu-sleep-1-0 {
> +				compatible = "arm,idle-state";
> +				local-timer-stop;
> +				arm,psci-suspend-param = <0x0010000>;
> +				entry-latency-us = <70>;
> +				exit-latency-us = <100>;
> +				min-residency-us = <300>;
> +				wakeup-latency-us = <150>;
> +			};
> +
> +			CLUSTER_SLEEP_1: cluster-sleep-1 {
> +				compatible = "arm,idle-state";
> +				local-timer-stop;
> +				arm,psci-suspend-param = <0x1010000>;
> +				entry-latency-us = <500>;
> +				exit-latency-us = <1200>;
> +				min-residency-us = <3500>;
> +				wakeup-latency-us = <1300>;
> +			};
> +		};
>  	};
>  
>  	clocks {
> -- 
> 1.9.1
> 
> 
