From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 2 Dec 2016 10:36:29 +0800
Subject: arm64: dts: zx: support cpu-freq for zx296718
In-Reply-To: <1480594135-27273-1-git-send-email-baoyou.xie@linaro.org>
References: <1480594135-27273-1-git-send-email-baoyou.xie@linaro.org>
Message-ID: <20161202023627.GA6657@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Viresh, the author of the bindings.

On Thu, Dec 01, 2016 at 08:08:55PM +0800, Baoyou Xie wrote:
> This patch adds the CPU clock phandle in CPU's node
> and uses operating-points-v2 to register operating points.
> 
> So it can be used by cpufreq-dt driver.
> 
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>

Just out of curiosity, why is there no '[PATCH]' prefix in the subject?

> ---
>  arch/arm64/boot/dts/zte/zx296718.dtsi | 37 +++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/zte/zx296718.dtsi b/arch/arm64/boot/dts/zte/zx296718.dtsi
> index 7a1aed7..16f7d5e 100644
> --- a/arch/arm64/boot/dts/zte/zx296718.dtsi
> +++ b/arch/arm64/boot/dts/zte/zx296718.dtsi
> @@ -44,6 +44,7 @@
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/clock/zx296718-clock.h>
>  
>  / {
>  	compatible = "zte,zx296718";
> @@ -81,6 +82,8 @@
>  			compatible = "arm,cortex-a53","arm,armv8";
>  			reg = <0x0 0x0>;
>  			enable-method = "psci";
> +			clocks = <&topcrm A53_GATE>;
> +			operating-points-v2 = <&cluster0_opp>;
>  		};
>  
>  		cpu1: cpu at 1 {
> @@ -88,6 +91,7 @@
>  			compatible = "arm,cortex-a53","arm,armv8";
>  			reg = <0x0 0x1>;
>  			enable-method = "psci";
> +			operating-points-v2 = <&cluster0_opp>;
>  		};
>  
>  		cpu2: cpu at 2 {
> @@ -95,6 +99,7 @@
>  			compatible = "arm,cortex-a53","arm,armv8";
>  			reg = <0x0 0x2>;
>  			enable-method = "psci";
> +			operating-points-v2 = <&cluster0_opp>;
>  		};
>  
>  		cpu3: cpu at 3 {
> @@ -102,6 +107,38 @@
>  			compatible = "arm,cortex-a53","arm,armv8";
>  			reg = <0x0 0x3>;
>  			enable-method = "psci";
> +			operating-points-v2 = <&cluster0_opp>;
> +		};
> +	};
> +
> +	cluster0_opp: opp_table0 {

I know this is how examples in the bindings doc written, but it's
recommended to use hyphen rather than underscore in node name.  That
said, the following naming form is better.

	cluster0_opp: opp-table0

> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp at 500000000 {
> +			opp-hz = /bits/ 64 <500000000>;
> +			opp-microvolt = <857000>;
> +			clock-latency-ns = <500000>;
> +		};

We prefer to have a newline between nodes.

> +		opp at 648000000 {
> +			opp-hz = /bits/ 64 <648000000>;
> +			opp-microvolt = <857000>;
> +			clock-latency-ns = <500000>;
> +		};
> +		opp at 800000000 {
> +			opp-hz = /bits/ 64 <800000000>;
> +			opp-microvolt = <882000>;
> +			clock-latency-ns = <500000>;
> +		};
> +		opp at 1000000000 {
> +			opp-hz = /bits/ 64 <1000000000>;
> +			opp-microvolt = <892000>;
> +			clock-latency-ns = <500000>;
> +		};
> +		opp at 1188000000 {
> +			opp-hz = /bits/ 64 <1188000000>;
> +			opp-microvolt = <1009000>;

So we have 5 setpoints with different frequency-voltage pair.  I have
seen 'clocks' specified in cpu0 node and understand how frequency
scaling works.  But what about voltage scaling?  There is no
'cpu-supply' defined, and how does voltage scale among these
opp-microvolt settings?

Another related question: if we do not support voltage scaling for now,
what's the actually voltage when system is up running?  Is that voltage
safe for cpu to run at all those 5 frequencies?

Shawn

> +			clock-latency-ns = <500000>;
>  		};
>  	};
>  
> -- 
> 2.7.4
> 
