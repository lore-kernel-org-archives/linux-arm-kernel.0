From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 31 Mar 2015 16:33:23 +0100
Subject: [PATCH] ARM: dts: mt8173: support arm64 cpuidle-dt
In-Reply-To: <1427772277-2414-1-git-send-email-howard.chen@linaro.org>
References: <1427772277-2414-1-git-send-email-howard.chen@linaro.org>
Message-ID: <20150331153323.GA24851@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 31, 2015 at 04:24:37AM +0100, Howard Chen wrote:
> add an idle-states node to describe the mt8173 cpu idle
> add a reference to the idle-states node in each CPU node

You are also changing the PSCI version in this patch, but
I think it is acceptable to have multiple changes at once
to avoid churning out dts changes.

Commit log should be rewritten, lack of punctuation,
missing capitalization, etc; in short, please rewrite it.

> Signed-off-by: Howard Chen <howard.chen@linaro.org>
> ---
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index 8554ec3..96dff1e 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -48,6 +48,8 @@
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a53";
>  			reg = <0x000>;
> +			enable-method = "psci";
> +			cpu-idle-states = <&CPU_SLEEP_0_0 &CLUSTER_SLEEP_0>;

You are free to use the labels you want, but you tell me why
CPU_SLEEP_0_0 is used where eg CPU_SLEEP_0 would be sufficient
and clearer (comment valid for all cpu nodes). Copy'n'paste ?

>  		};
>  
>  		cpu1: cpu at 1 {
> @@ -55,6 +57,7 @@
>  			compatible = "arm,cortex-a53";
>  			reg = <0x001>;
>  			enable-method = "psci";
> +			cpu-idle-states = <&CPU_SLEEP_0_0 &CLUSTER_SLEEP_0>;
>  		};
>  
>  		cpu2: cpu at 100 {
> @@ -62,6 +65,7 @@
>  			compatible = "arm,cortex-a57";
>  			reg = <0x100>;
>  			enable-method = "psci";
> +			cpu-idle-states = <&CPU_SLEEP_0_0 &CLUSTER_SLEEP_0>;
>  		};
>  
>  		cpu3: cpu at 101 {
> @@ -69,15 +73,33 @@
>  			compatible = "arm,cortex-a57";
>  			reg = <0x101>;
>  			enable-method = "psci";
> +			cpu-idle-states = <&CPU_SLEEP_0_0 &CLUSTER_SLEEP_0>;
>  		};
> +
> +		idle-states {
> +			entry-method = "arm,psci-0.2";

"arm,psci"

> +
> +			CPU_SLEEP_0_0: cpu-sleep-0-0 {
> +				compatible = "arm,idle-state";
> +				arm,psci-suspend-param = <0x0010000>;
> +				entry-latency-us = <600>;
> +				exit-latency-us = <600>;
> +				min-residency-us = <1200>;
> +			};
> +
> +			CLUSTER_SLEEP_0: cluster-sleep-0 {
> +				compatible = "arm,idle-state";
> +				arm,psci-suspend-param = <0x1010000>;
> +				entry-latency-us = <800>;
> +				exit-latency-us = <1000>;
> +				min-residency-us = <2000>;
> +				wakeup-latency-us = <1000>;
> +			};

You tested these latency values right ?

>  	};
>  
>  	psci {
> -		compatible = "arm,psci";
> +		compatible = "arm,psci-0.2";

See my comment in the commit log, this change is independent of idle
states changes.

Thanks,
Lorenzo

>  		method = "smc";
> -		cpu_suspend   = <0x84000001>;
> -		cpu_off	      = <0x84000002>;
> -		cpu_on	      = <0x84000003>;
>  	};
>  
>  	uart_clk: dummy26m {
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
