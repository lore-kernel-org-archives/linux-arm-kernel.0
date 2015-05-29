From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 29 May 2015 15:55:52 +0100
Subject: [PATCH v3] ARM: dts: mt8173: support arm64 cpuidle-dt
In-Reply-To: <1432882906-7940-1-git-send-email-howard.chen@linaro.org>
References: <1432882906-7940-1-git-send-email-howard.chen@linaro.org>
Message-ID: <20150529145552.GD18512@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 29, 2015 at 08:01:46AM +0100, Howard Chen wrote:
> This patch adds an idle-states node to describe the mt8173 idle states and
> also adds references to the idle-states node in all CPU nodes.
> 
> Signed-off-by: Howard Chen <howard.chen@linaro.org>
> ---
You should have added a list of incremental changes (v1->v2->v3) here
otherwise there is no point in adding a patch version, we are not
supposed to remember what you have changed.

>  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index 924fdb6..47e8d56 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -49,6 +49,8 @@
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a53";
>  			reg = <0x000>;
> +			enable-method = "psci";
> +			cpu-idle-states = <&CPU_SLEEP_0>;
>  		};
>  
>  		cpu1: cpu at 1 {
> @@ -56,6 +58,7 @@
>  			compatible = "arm,cortex-a53";
>  			reg = <0x001>;
>  			enable-method = "psci";
> +			cpu-idle-states = <&CPU_SLEEP_0>;
>  		};
>  
>  		cpu2: cpu at 100 {
> @@ -63,6 +66,7 @@
>  			compatible = "arm,cortex-a57";
>  			reg = <0x100>;
>  			enable-method = "psci";
> +			cpu-idle-states = <&CPU_SLEEP_0>;
>  		};
>  
>  		cpu3: cpu at 101 {
> @@ -70,6 +74,20 @@
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

UltraNit: please move local-timer-stop here to keep the property ordering
as in the bindings.

More importantly, IIRC the idle state was not local-timer-stop in v2,
what changed in the interim ? v1->v2 the cluster idle state disappeared,
now the local timer seems to stop when it was not before (and that is
the same HW), I hope things are settled now.

https://lkml.org/lkml/2015/4/7/76

> +				arm,psci-suspend-param = <0x0010000>;

Move this property as last on the list, let's keep the generic
properties first.

> +				entry-latency-us = <639>;
> +				exit-latency-us = <680>;
> +				min-residency-us = <1088>;
> +				local-timer-stop;
> +			};
>  		};
>  	};

I guess there is no hope of seeing the cluster state restored (?).

I would like some explanation regarding local-timer-stop change, apart
from that you can add:

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
