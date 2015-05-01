From: leo.yan@linaro.org (Leo Yan)
Date: Fri, 1 May 2015 09:55:03 +0800
Subject: [PATCH] arm64: dts: Add idle-states for Juno
In-Reply-To: <1430402268.2868.20.camel@linaro.org>
References: <1430402268.2868.20.camel@linaro.org>
Message-ID: <20150501015502.GA4679@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 30, 2015 at 02:57:48PM +0100, Jon Medhurst (Tixy) wrote:
> From: Jon Medhurst <tixy@linaro.org>
> 
> Signed-off-by: Jon Medhurst <tixy@linaro.org>
> ---
> 
> These have been kicking around out of tree for ages, any reason they
> shouldn't be in mainline? Also, was unsure of what to put in commit
> message.
> 
>  arch/arm64/boot/dts/arm/juno.dts | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
> index 133ee59..7a9a449 100644
> --- a/arch/arm64/boot/dts/arm/juno.dts
> +++ b/arch/arm64/boot/dts/arm/juno.dts
> @@ -34,12 +34,35 @@
>  		#address-cells = <2>;
>  		#size-cells = <0>;
>  
> +		idle-states {
> +			entry-method = "arm,psci";
> +
> +			CPU_SLEEP_0: cpu-sleep-0 {
> +				compatible = "arm,idle-state";
> +				arm,psci-suspend-param = <0x0010000>;
> +				local-timer-stop;

Just want to figure out the best way for big.LITTLE system; so have
one question: CA53 and CA57 have different power domain for arch
timer, right? If this is the case, should we define two kinds of cpu
sleep states, one of them will not migrate to broadcast timer and
keep using arch timer after cpu has been powered down?

> +				entry-latency-us = <100>;
> +				exit-latency-us = <250>;
> +				min-residency-us = <2000>;
> +			};
> +
> +			CLUSTER_SLEEP_0: cluster-sleep-0 {
> +				compatible = "arm,idle-state";
> +				arm,psci-suspend-param = <0x1010000>;
> +				local-timer-stop;
> +				entry-latency-us = <800>;
> +				exit-latency-us = <700>;
> +				min-residency-us = <2500>;
> +			};
> +		};
> +
>  		A57_0: cpu at 0 {
>  			compatible = "arm,cortex-a57","arm,armv8";
>  			reg = <0x0 0x0>;
>  			device_type = "cpu";
>  			enable-method = "psci";
>  			next-level-cache = <&A57_L2>;
> +			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
>  		};
>  
>  		A57_1: cpu at 1 {
> @@ -48,6 +71,7 @@
>  			device_type = "cpu";
>  			enable-method = "psci";
>  			next-level-cache = <&A57_L2>;
> +			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
>  		};
>  
>  		A53_0: cpu at 100 {
> @@ -56,6 +80,7 @@
>  			device_type = "cpu";
>  			enable-method = "psci";
>  			next-level-cache = <&A53_L2>;
> +			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
>  		};
>  
>  		A53_1: cpu at 101 {
> @@ -64,6 +89,7 @@
>  			device_type = "cpu";
>  			enable-method = "psci";
>  			next-level-cache = <&A53_L2>;
> +			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
>  		};
>  
>  		A53_2: cpu at 102 {
> @@ -72,6 +98,7 @@
>  			device_type = "cpu";
>  			enable-method = "psci";
>  			next-level-cache = <&A53_L2>;
> +			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
>  		};
>  
>  		A53_3: cpu at 103 {
> @@ -80,6 +107,7 @@
>  			device_type = "cpu";
>  			enable-method = "psci";
>  			next-level-cache = <&A53_L2>;
> +			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
>  		};
>  
>  		A57_L2: l2-cache0 {
