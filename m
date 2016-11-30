From: jun.nie@linaro.org (Jun Nie)
Date: Wed, 30 Nov 2016 16:26:18 +0800
Subject: [PATCH] arm64: dts: add zx296718's topcrm node
In-Reply-To: <1480491237-5169-1-git-send-email-baoyou.xie@linaro.org>
References: <1480491237-5169-1-git-send-email-baoyou.xie@linaro.org>
Message-ID: <CABymUCPMDqcfKQOtfj6gHWs69sh3HXaErDjE740xq6UQh_DFow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-11-30 15:33 GMT+08:00 Baoyou Xie <baoyou.xie@linaro.org>:
> Enable topcrm clock node for zx296718, which is used for
> CPU's frequency change.

Please follow general rule, such as
arm64: dts: zx: brief title of your changes

>
> Furthermore, this patch adds the CPU clock phandle in CPU's node
> and uses operating-points-v2 to register operating points.
>
> So it can be used by cpufreq-dt driver.

Suggest to split clock nodes and cpu-freq nodes changes into different patches.

>
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
> ---
>  arch/arm64/boot/dts/zte/zx296718.dtsi | 48 +++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/zte/zx296718.dtsi b/arch/arm64/boot/dts/zte/zx296718.dtsi
> index 6b239a3..f9eb37d 100644
> --- a/arch/arm64/boot/dts/zte/zx296718.dtsi
> +++ b/arch/arm64/boot/dts/zte/zx296718.dtsi
> @@ -44,6 +44,7 @@
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/clock/zx296718-clock.h>
>
>  / {
>         compatible = "zte,zx296718";
> @@ -81,6 +82,8 @@
>                         compatible = "arm,cortex-a53","arm,armv8";
>                         reg = <0x0 0x0>;
>                         enable-method = "psci";
> +                       clocks = <&topcrm A53_GATE>;
> +                       operating-points-v2 = <&cluster0_opp>;
>                 };
>
>                 cpu1: cpu at 1 {
> @@ -88,6 +91,7 @@
>                         compatible = "arm,cortex-a53","arm,armv8";
>                         reg = <0x0 0x1>;
>                         enable-method = "psci";
> +                       operating-points-v2 = <&cluster0_opp>;
>                 };
>
>                 cpu2: cpu at 2 {
> @@ -95,6 +99,7 @@
>                         compatible = "arm,cortex-a53","arm,armv8";
>                         reg = <0x0 0x2>;
>                         enable-method = "psci";
> +                       operating-points-v2 = <&cluster0_opp>;
>                 };
>
>                 cpu3: cpu at 3 {
> @@ -102,6 +107,43 @@
>                         compatible = "arm,cortex-a53","arm,armv8";
>                         reg = <0x0 0x3>;
>                         enable-method = "psci";
> +                       operating-points-v2 = <&cluster0_opp>;
> +               };
> +       };
> +
> +       cluster0_opp: opp_table0 {
> +               compatible = "operating-points-v2";
> +               opp-shared;
> +
> +               opp at 1000000000 {
> +                       opp-hz = /bits/ 64 <500000000>;

Why frequency in opp name differ with opp-hz value?

> +                       opp-microvolt = <857000>;
> +                       clock-latency-ns = <500000>;
> +               };
> +               opp at 1100000000 {
> +                       opp-hz = /bits/ 64 <648000000>;
> +                       opp-microvolt = <857000>;
> +                       clock-latency-ns = <500000>;
> +               };
> +               opp at 1200000000 {
> +                       opp-hz = /bits/ 64 <800000000>;
> +                       opp-microvolt = <882000>;
> +                       clock-latency-ns = <500000>;
> +               };
> +               opp at 1300000000 {
> +                       opp-hz = /bits/ 64 <1000000000>;
> +                       opp-microvolt = <892000>;
> +                       clock-latency-ns = <500000>;
> +               };
> +               opp at 1400000000 {
> +                       opp-hz = /bits/ 64 <1188000000>;
> +                       opp-microvolt = <1009000>;
> +                       clock-latency-ns = <500000>;
> +               };
> +               opp at 1500000000 {
> +                       opp-hz = /bits/ 64 <1312000000>;
> +                       opp-microvolt = <1052000>;
> +                       clock-latency-ns = <500000>;
>                 };

I did not see frequency 1500000000 or 1312000000 in clock drivers for
A53. Please confirm whether clock driver need update or your need
revise your patch.

>         };
>
> @@ -279,6 +321,12 @@
>                         dma-requests = <32>;
>                 };
>
> +               topcrm: clock-controller at 01461000 {

Removing heading 0 in address of name.

> +                       compatible = "zte,zx296718-topcrm";
> +                       reg = <0x01461000 0x1000>;
> +                       #clock-cells = <1>;
> +               };
> +
>                 sysctrl: sysctrl at 1463000 {
>                         compatible = "zte,zx296718-sysctrl", "syscon";
>                         reg = <0x1463000 0x1000>;
> --
> 2.7.4
>
