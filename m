From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 8 Apr 2015 11:54:43 +0100
Subject: [PATCH v2] ARM: dts: mt8173: support arm64 cpuidle-dt
In-Reply-To: <1428393905-32166-1-git-send-email-howard.chen@linaro.org>
References: <1428393905-32166-1-git-send-email-howard.chen@linaro.org>
Message-ID: <20150408105443.GA23642@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 07, 2015 at 09:05:05AM +0100, Howard Chen wrote:
> This patch adds an idle-states node to describe the mt8173 idle states and
> also adds references to the idle-states node in all CPU nodes.
> 
> Signed-off-by: Howard Chen <howard.chen@linaro.org>

Is copying me in too much effort to ask ?

>  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index 8554ec3..0d31a34 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -48,6 +48,8 @@
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a53";
>  			reg = <0x000>;
> +			enable-method = "psci";
> +			cpu-idle-states = <&CPU_SLEEP_0>;

Cluster idle state vanished between v1 and v2.

?

>  		};
>  
>  		cpu1: cpu at 1 {
> @@ -55,6 +57,7 @@
>  			compatible = "arm,cortex-a53";
>  			reg = <0x001>;
>  			enable-method = "psci";
> +			cpu-idle-states = <&CPU_SLEEP_0>;
>  		};
>  
>  		cpu2: cpu at 100 {
> @@ -62,6 +65,7 @@
>  			compatible = "arm,cortex-a57";
>  			reg = <0x100>;
>  			enable-method = "psci";
> +			cpu-idle-states = <&CPU_SLEEP_0>;
>  		};
>  
>  		cpu3: cpu at 101 {
> @@ -69,6 +73,19 @@
>  			compatible = "arm,cortex-a57";
>  			reg = <0x101>;
>  			enable-method = "psci";
> +			cpu-idle-states = <&CPU_SLEEP_0>;
> +		};
> +
> +		idle-states {
> +			entry-method = "arm,psci";
> +
> +			CPU_SLEEP_0: cpu-sleep-0 {
> +				compatible = "arm,idle-state";
> +				arm,psci-suspend-param = <0x0010000>;
> +				entry-latency-us = <639>;
> +				exit-latency-us = <328>;
> +				min-residency-us = <1088>;
> +			};
>  		};
>  	};

Is the arch timer still running when you enter this state ?

Apart from these remarks the patch seems fine, I wonder whether we should
merge these changes into the kernel instead of keeping these changes in
firmware for specific kernel configurations.

Lorenzo
