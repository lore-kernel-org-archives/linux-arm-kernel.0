From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 25 Jun 2014 15:27:14 +0100
Subject: [PATCH v5 8/8] arm64: boot: dts: update rtsm aemv8 dts with PSCI
 and idle states
In-Reply-To: <1403705421-17597-9-git-send-email-lorenzo.pieralisi@arm.com>
References: <1403705421-17597-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1403705421-17597-9-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20140625142714.GB15240@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

On Wed, Jun 25, 2014 at 03:10:21PM +0100, Lorenzo Pieralisi wrote:
> This patch updates the RTSM dts file with PSCI bindings and nodes
> describing the AEMv8 model idle states parameters.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  arch/arm64/boot/dts/rtsm_ve-aemv8a.dts | 44 +++++++++++++++++++++++++++-------
>  1 file changed, 36 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rtsm_ve-aemv8a.dts b/arch/arm64/boot/dts/rtsm_ve-aemv8a.dts
> index d79de9c..4051ffb 100644
> --- a/arch/arm64/boot/dts/rtsm_ve-aemv8a.dts
> +++ b/arch/arm64/boot/dts/rtsm_ve-aemv8a.dts
> @@ -27,37 +27,65 @@
>  		serial3 = &v2m_serial3;
>  	};
>  
> +	psci {
> +		compatible = "arm,psci-0.2";

Where can I find a PSCI 0.2 implementation for the RTSM VE model? I
couldn't find a link in the cover.

The upstream bootwrapper is not PSCI 0.2 compliant and it does not
implement CPU_SUSPEND.

> +		method = "smc";
> +		cpu_suspend = <0xc4000001>;
> +		cpu_off = <0x84000002>;
> +		cpu_on = <0xc4000003>;

Without "arm,psci" in the compatible list, these three properties are
meaningless.

> +	};
> +
>  	cpus {
>  		#address-cells = <2>;
>  		#size-cells = <0>;
>  
> +		idle-states {
> +			entry-method = "arm,psci";
> +
> +			CPU_SLEEP_0: cpu-sleep-0 {
> +				compatible = "arm,idle-state";
> +				entry-method-param = <0x0010000>;
> +				entry-latency-us = <40>;
> +				exit-latency-us = <100>;
> +				min-residency-us = <150>;
> +			};
> +
> +			CLUSTER_SLEEP_0: cluster-sleep-0 {
> +				compatible = "arm,idle-state";
> +				entry-method-param = <0x1010000>;
> +				entry-latency-us = <500>;
> +				exit-latency-us = <1000>;
> +				min-residency-us = <2500>;
> +			};
> +		};
> +

If this is going to live in the /cpus node, could it please be placed
after the cpu nodes?

>  		cpu at 0 {
>  			device_type = "cpu";
>  			compatible = "arm,armv8";
>  			reg = <0x0 0x0>;
> -			enable-method = "spin-table";
> -			cpu-release-addr = <0x0 0x8000fff8>;
> +			enable-method = "psci";

Changing the enable-method will break boot on a model when using a
bootwrapper without PSCI support. Really we should leave it up to the
bootwrapper to inject the enable method...

Mark.
