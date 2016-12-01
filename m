From: jun.nie@linaro.org (Jun Nie)
Date: Thu, 1 Dec 2016 09:54:49 +0800
Subject: [PATCH v2] arm64: dts: zx: add zx296718's topcrm node
In-Reply-To: <1480499418-13905-1-git-send-email-baoyou.xie@linaro.org>
References: <1480499418-13905-1-git-send-email-baoyou.xie@linaro.org>
Message-ID: <CABymUCMo=ADmZLhQp4HoUM5DD2AfQH8gzSLaNWTNt0Hxd9tBLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-11-30 17:50 GMT+08:00 Baoyou Xie <baoyou.xie@linaro.org>:
> Enable topcrm clock node for zx296718, which is used for
> CPU's frequency change.

Please reference other device tree patches title to add a simple title
with category information. Such as
arm64: dts: uniphier: change MIO node to SD control node

>
> Furthermore, this patch adds the CPU clock phandle in CPU's node
> and uses operating-points-v2 to register operating points.
>
> So it can be used by cpufreq-dt driver.

Detail comment should provide more information to support title. So
topcrm and cpu freq changes shall be split into two patches.

>
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
> ---
>  arch/arm64/boot/dts/zte/zx296718.dtsi | 43 +++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/zte/zx296718.dtsi b/arch/arm64/boot/dts/zte/zx296718.dtsi
> index 6b239a3..992158a 100644
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
> @@ -102,6 +107,38 @@
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
> +               opp at 500000000 {
> +                       opp-hz = /bits/ 64 <500000000>;
> +                       opp-microvolt = <857000>;
> +                       clock-latency-ns = <500000>;
> +               };
> +               opp at 648000000 {
> +                       opp-hz = /bits/ 64 <648000000>;
> +                       opp-microvolt = <857000>;
> +                       clock-latency-ns = <500000>;
> +               };
> +               opp at 800000000 {
> +                       opp-hz = /bits/ 64 <800000000>;
> +                       opp-microvolt = <882000>;
> +                       clock-latency-ns = <500000>;
> +               };
> +               opp at 1000000000 {
> +                       opp-hz = /bits/ 64 <1000000000>;
> +                       opp-microvolt = <892000>;
> +                       clock-latency-ns = <500000>;
> +               };
> +               opp at 1188000000 {
> +                       opp-hz = /bits/ 64 <1188000000>;
> +                       opp-microvolt = <1009000>;
> +                       clock-latency-ns = <500000>;
>                 };
I see 1600m and 1800m for a53 clock source in clk driver. Aren't they
supported by product chip?
>         };
>
> @@ -279,6 +316,12 @@
>                         dma-requests = <32>;
>                 };
>
> +               topcrm: clock-controller at 1461000 {
> +                       compatible = "zte,zx296718-topcrm";
> +                       reg = <0x01461000 0x1000>;
> +                       #clock-cells = <1>;
> +               };
> +

Top clock nodes patch is just merged into linux-next. You can prepare
your patch based on it.

https://www.spinics.net/lists/arm-kernel/msg535883.html

>                 sysctrl: sysctrl at 1463000 {
>                         compatible = "zte,zx296718-sysctrl", "syscon";
>                         reg = <0x1463000 0x1000>;
> --
> 2.7.4
>
