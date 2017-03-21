From: eballetbo@gmail.com (Enric Balletbo Serra)
Date: Tue, 21 Mar 2017 12:04:25 +0100
Subject: [PATCH v3 3/4] arm64: dts: rockchip: describe Gru/Kevin OPPs +
 CPU regulators
In-Reply-To: <20170320235344.126298-4-briannorris@chromium.org>
References: <20170320235344.126298-1-briannorris@chromium.org>
 <20170320235344.126298-4-briannorris@chromium.org>
Message-ID: <CAFqH_52mNz0fBDNrqO1DwL1C=QaqO6d9kxdCfAT9WLcG+=jHWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-03-21 0:53 GMT+01:00 Brian Norris <briannorris@chromium.org>:
> Used for Gru/Kevin only, as they're the only ones which have a described
> CPU regulator. Also, I'm not sure we've validated this table non-Gru
> boards.
>
> At the same time, partially describe PWM regulators for Gru, so cpufreq
> doesn't think it can crank up the clock speed without changing the
> voltage. However, we don't yet have the DT bindings to fully describe
> the Over Voltage Protection (OVP) circuits on these boards. Without that
> description, we might end up changing the voltage too much, too fast.
>
> Add the pwm-regulator descriptions and associate the CPU OPPs, but leave
> them disabled.
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> v2 --> v3: no change
>
> v1 --> v2:
>  * combine the OPP table into the regulator patch, to keep from
>    regressing
>  * don't include the OPP table in top-level rk3399.dtsi, to avoid
>    breaking other boards
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi | 147 +++++++++++++++++++++++++++
>  arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi | 145 ++++++++++++++++++++++++++
>  2 files changed, 292 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> index 9c581173cb64..b512b27c78c5 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> @@ -44,6 +44,7 @@
>
>  #include <dt-bindings/input/input.h>
>  #include "rk3399.dtsi"
> +#include "rk3399-opp.dtsi"
>
>  / {
>         chosen {
> @@ -170,6 +171,98 @@
>                 vin-supply = <&ppvar_sys>;
>         };
>
> +       ppvar_bigcpu: ppvar-bigcpu {
> +               compatible = "pwm-regulator";
> +               regulator-name = "ppvar_bigcpu";
> +               /*
> +                * OVP circuit requires special handling which is not yet
> +                * represented. Keep disabled for now.
> +                */
> +               status = "disabled";
> +
> +               pwms = <&pwm1 0 3337 0>;
> +
> +               /* EC turns on w/ ap_core_en; always on for AP */
> +               regulator-always-on;
> +               regulator-boot-on;
> +
> +               regulator-min-microvolt = <798674>;
> +               regulator-max-microvolt = <1302172>;
> +
> +               pwm-supply = <&ppvar_sys>;
> +               pwm-dutycycle-range = <100 0>;
> +               pwm-dutycycle-unit = <100>;
> +       };
> +
> +       ppvar_litcpu: ppvar-litcpu {
> +               compatible = "pwm-regulator";
> +               regulator-name = "ppvar_litcpu";
> +               /*
> +                * OVP circuit requires special handling which is not yet
> +                * represented. Keep disabled for now.
> +                */
> +               status = "disabled";
> +
> +               pwms = <&pwm2 0 3337 0>;
> +
> +               /* EC turns on w/ ap_core_en; always on for AP */
> +               regulator-always-on;
> +               regulator-boot-on;
> +
> +               regulator-min-microvolt = <799065>;
> +               regulator-max-microvolt = <1303738>;
> +
> +               pwm-supply = <&ppvar_sys>;
> +               pwm-dutycycle-range = <100 0>;
> +               pwm-dutycycle-unit = <100>;
> +       };
> +
> +       ppvar_gpu: ppvar-gpu {
> +               compatible = "pwm-regulator";
> +               regulator-name = "ppvar_gpu";
> +               /*
> +                * OVP circuit requires special handling which is not yet
> +                * represented. Keep disabled for now.
> +                */
> +               status = "disabled";
> +
> +               pwms = <&pwm0 0 3337 0>;
> +
> +               /* EC turns on w/ ap_core_en; always on for AP */
> +               regulator-always-on;
> +               regulator-boot-on;
> +
> +               regulator-min-microvolt = <785782>;
> +               regulator-max-microvolt = <1217729>;
> +
> +               pwm-supply = <&ppvar_sys>;
> +               pwm-dutycycle-range = <100 0>;
> +               pwm-dutycycle-unit = <100>;
> +       };
> +
> +       ppvar_centerlogic: ppvar-centerlogic {
> +               compatible = "pwm-regulator";
> +               regulator-name = "ppvar_centerlogic";
> +               /*
> +                * OVP circuit requires special handling which is not yet
> +                * represented. Keep disabled for now.
> +                */
> +               status = "disabled";
> +
> +               pwms = <&pwm3 0 3337 0>;
> +
> +               /* EC turns on w/ ppvar_centerlogic_en; always on for AP */
> +               regulator-always-on;
> +               regulator-boot-on;
> +
> +               regulator-min-microvolt = <800069>;
> +               regulator-max-microvolt = <1049692>;
> +
> +               pwm-supply = <&ppvar_sys>;
> +               pwm-dutycycle-range = <100 0>;
> +               pwm-dutycycle-unit = <100>;
> +       };
> +
>         /* Schematics call this PPVAR even though it's fixed */
>         ppvar_logic: ppvar-logic {
>                 compatible = "regulator-fixed";
> @@ -405,6 +498,60 @@
>         };
>  };
>
> +/*
> + * Set some suspend operating points to avoid OVP in suspend
> + *
> + * When we go into S3 ARM Trusted Firmware will transition our PWM regulators
> + * from wherever they're at back to the "default" operating point (whatever
> + * voltage we get when we set the PWM pins to "input").
> + *
> + * This quick transition under light load has the possibility to trigger the
> + * regulator "over voltage protection" (OVP).
> + *
> + * To make extra certain that we don't hit this OVP at suspend time, we'll
> + * transition to a voltage that's much closer to the default (~1.0 V) so that
> + * there will not be a big jump.  Technically we only need to get within 200 mV
> + * of the default voltage, but the speed here should be fast enough and we need
> + * suspend/resume to be rock solid.
> + */
> +
> +&cluster0_opp {
> +       opp05 {
> +               opp-suspend;
> +       };
> +};
> +
> +&cluster1_opp {
> +       opp06 {
> +               opp-suspend;
> +       };
> +};
> +
> +&cpu_l0 {
> +       cpu-supply = <&ppvar_litcpu>;
> +};
> +
> +&cpu_l1 {
> +       cpu-supply = <&ppvar_litcpu>;
> +};
> +
> +&cpu_l2 {
> +       cpu-supply = <&ppvar_litcpu>;
> +};
> +
> +&cpu_l3 {
> +       cpu-supply = <&ppvar_litcpu>;
> +};
> +
> +&cpu_b0 {
> +       cpu-supply = <&ppvar_bigcpu>;
> +};
> +
> +&cpu_b1 {
> +       cpu-supply = <&ppvar_bigcpu>;
> +};
> +
> +
>  &cru {
>         assigned-clocks =
>                 <&cru PLL_GPLL>, <&cru PLL_CPLL>,
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi
> new file mode 100644
> index 000000000000..dd82e16236a8
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi
> @@ -0,0 +1,145 @@
> +/*
> + * Copyright (c) 2016-2017 Fuzhou Rockchip Electronics Co., Ltd
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This library is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This library is distributed in the hope that it will be useful,
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + * Or, alternatively,
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use,
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +/ {
> +       cluster0_opp: opp-table0 {
> +               compatible = "operating-points-v2";
> +               opp-shared;
> +
> +               opp00 {
> +                       opp-hz = /bits/ 64 <408000000>;
> +                       opp-microvolt = <800000>;
> +                       clock-latency-ns = <40000>;
> +               };
> +               opp01 {
> +                       opp-hz = /bits/ 64 <600000000>;
> +                       opp-microvolt = <800000>;
> +               };
> +               opp02 {
> +                       opp-hz = /bits/ 64 <816000000>;
> +                       opp-microvolt = <800000>;
> +               };
> +               opp03 {
> +                       opp-hz = /bits/ 64 <1008000000>;
> +                       opp-microvolt = <875000>;
> +               };
> +               opp04 {
> +                       opp-hz = /bits/ 64 <1200000000>;
> +                       opp-microvolt = <925000>;
> +               };
> +               opp05 {
> +                       opp-hz = /bits/ 64 <1416000000>;
> +                       opp-microvolt = <1050000>;
> +               };
> +               opp06 {
> +                       opp-hz = /bits/ 64 <1512000000>;
> +                       opp-microvolt = <1125000>;
> +               };
> +       };
> +
> +       cluster1_opp: opp-table1 {
> +               compatible = "operating-points-v2";
> +               opp-shared;
> +
> +               opp00 {
> +                       opp-hz = /bits/ 64 <408000000>;
> +                       opp-microvolt = <800000>;
> +                       clock-latency-ns = <40000>;
> +               };
> +               opp01 {
> +                       opp-hz = /bits/ 64 <600000000>;
> +                       opp-microvolt = <800000>;
> +               };
> +               opp02 {
> +                       opp-hz = /bits/ 64 <816000000>;
> +                       opp-microvolt = <825000>;
> +               };
> +               opp03 {
> +                       opp-hz = /bits/ 64 <1008000000>;
> +                       opp-microvolt = <875000>;
> +               };
> +               opp04 {
> +                       opp-hz = /bits/ 64 <1200000000>;
> +                       opp-microvolt = <950000>;
> +               };
> +               opp05 {
> +                       opp-hz = /bits/ 64 <1416000000>;
> +                       opp-microvolt = <1025000>;
> +               };
> +               opp06 {
> +                       opp-hz = /bits/ 64 <1608000000>;
> +                       opp-microvolt = <1075000>;
> +               };
> +               opp07 {
> +                       opp-hz = /bits/ 64 <1800000000>;
> +                       opp-microvolt = <1150000>;
> +               };
> +               opp08 {
> +                       opp-hz = /bits/ 64 <2016000000>;
> +                       opp-microvolt = <1250000>;
> +               };
> +       };
> +};
> +
> +&cpu_l0 {
> +       operating-points-v2 = <&cluster0_opp>;
> +};
> +
> +&cpu_l1 {
> +       operating-points-v2 = <&cluster0_opp>;
> +};
> +
> +&cpu_l2 {
> +       operating-points-v2 = <&cluster0_opp>;
> +};
> +
> +&cpu_l3 {
> +       operating-points-v2 = <&cluster0_opp>;
> +};
> +
> +&cpu_b0 {
> +       operating-points-v2 = <&cluster1_opp>;
> +};
> +
> +&cpu_b1 {
> +       operating-points-v2 = <&cluster1_opp>;
> +};
> --
> 2.12.0.367.g23dc2f6d3c-goog
>

I don't have a kevin but I have a gru, so for the shared parts I can say

Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
