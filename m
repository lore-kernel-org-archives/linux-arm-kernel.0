From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 23 Apr 2015 13:53:58 +0100
Subject: [PATCH 2/2] ARM64: mt8173: dts Add MT8173 cpufreq driver support
In-Reply-To: <1429522047-16675-3-git-send-email-pi-cheng.chen@linaro.org>
References: <1429522047-16675-1-git-send-email-pi-cheng.chen@linaro.org>
 <1429522047-16675-3-git-send-email-pi-cheng.chen@linaro.org>
Message-ID: <20150423125358.GA29702@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 20, 2015 at 10:27:27AM +0100, pi-cheng.chen wrote:
> This patch adds voltage supplies and clocks used by MT8173 cpufreq driver.
> 
> Signed-off-by: pi-cheng.chen <pi-cheng.chen@linaro.org>

This series has no bindings for these properties.

> ---
>  arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 9 +++++++++
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi    | 6 ++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> index 96e141c..7a00cfe 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> @@ -330,3 +330,12 @@
>  	status = "okay";
>  	clock-frequency = <100000>;
>  };
> +
> +&cpu0 {
> +	proc-supply = <&mt6397_vpca15_reg>;
> +};
> +
> +&cpu2 {
> +	proc-supply = <&da9211_vcpu_reg>;
> +	sram-supply = <&mt6397_vsramca7_reg>;
> +};


Why do only two CPUs have these properties, and why does one need an
sram-supply?

> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index d9cc84e..b8a5454 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -51,6 +51,9 @@
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a53";
>  			reg = <0x000>;
> +			clocks = <&infracfg INFRA_CA53SEL>,
> +				 <&apmixedsys APMIXED_MAINPLL>;
> +			clock-names = "cpu", "intermediate";
>  		};
>  
>  		cpu1: cpu at 1 {
> @@ -65,6 +68,9 @@
>  			compatible = "arm,cortex-a57";
>  			reg = <0x100>;
>  			enable-method = "psci";
> +			clocks = <&infracfg INFRA_CA57SEL>,
> +				 <&apmixedsys APMIXED_MAINPLL>;
> +			clock-names = "cpu", "intermediate";
>  		};

We should really describe this information per-cpu rather than assuming
that it's the same for siblings. Arbitrarily making one CPU in each
cluster (or other arbitrary grouping) special for the binding is silly.

Mark.
