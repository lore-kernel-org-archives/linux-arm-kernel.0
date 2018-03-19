From: sboyd@kernel.org (Stephen Boyd)
Date: Mon, 19 Mar 2018 09:48:42 -0700
Subject: [PATCH v3 09/10] DT: QCOM: Add cpufreq-dt to msm8996
In-Reply-To: <1518616792-29028-10-git-send-email-ilialin@codeaurora.org>
References: <1518616792-29028-1-git-send-email-ilialin@codeaurora.org>
 <1518616792-29028-10-git-send-email-ilialin@codeaurora.org>
Message-ID: <152147812199.242365.11821734771337881765@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Ilia Lin (2018-02-14 05:59:51)
> diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
> index 492a011..930f68b 100644
> --- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
> +++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (c) 2014-2016, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2014-2016,2018 The Linux Foundation. All rights reserved.
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 and

Why?

> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index 4b2afcc..0359197 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -144,6 +152,182 @@
>                 };
>         };
>  
> +       cluster0_opp: opp_table0 {
> +               compatible = "operating-points-v2";
> +               opp-shared;
> +
> +               opp at 307200000 {
> +                       opp-hz = /bits/ 64 <  307200000 >;
> +                       clock-latency-ns = <200000>;
> +               };
> +               opp at 422400000 {
> +                       opp-hz = /bits/ 64 <  422400000 >;
> +                       clock-latency-ns = <200000>;
> +               };
> +               opp at 480000000 {

It looks like opp-480000000 now instead of opp@<freq>.

> +                       opp-hz = /bits/ 64 <  480000000 >;
> +                       clock-latency-ns = <200000>;
> +               };
> +               opp at 556800000 {
> +                       opp-hz = /bits/ 64 <  556800000 >;
> +                       clock-latency-ns = <200000>;
> +               };
> +               opp at 652800000 {
> +                       opp-hz = /bits/ 64 <  652800000 >;
> +                       clock-latency-ns = <200000>;
> +               };
> +               opp at 729600000 {
> +                       opp-hz = /bits/ 64 <  729600000 >;
> +                       clock-latency-ns = <200000>;
> +               };
> +               opp at 844800000 {
> +                       opp-hz = /bits/ 64 <  844800000 >;
> +                       clock-latency-ns = <200000>;
> +               };
> +               opp at 960000000 {
> +                       opp-hz = /bits/ 64 <  960000000 >;
> +                       clock-latency-ns = <200000>;
> +               };
> +               opp at 1036800000 {
> +                       opp-hz = /bits/ 64 < 1036800000 >;
> +                       clock-latency-ns = <200000>;
> +               };
> +               opp at 1113600000 {
> +                       opp-hz = /bits/ 64 < 1113600000 >;
> +                       clock-latency-ns = <200000>;
> +               };
> +               opp at 1190400000 {
> +                       opp-hz = /bits/ 64 < 1190400000 >;
> +                       clock-latency-ns = <200000>;
> +               };
> +               opp at 1228800000 {
> +                       opp-hz = /bits/ 64 < 1228800000 >;
> +                       clock-latency-ns = <200000>;
> +               };
> +               opp at 1324800000 {
> +                       opp-hz = /bits/ 64 < 1324800000 >;
> +                       clock-latency-ns = <200000>;
> +               };
> +               opp at 1401600000 {
> +                       opp-hz = /bits/ 64 < 1401600000 >;
> +                       clock-latency-ns = <200000>;
> +               };
> +               opp at 1478400000 {
> +                       opp-hz = /bits/ 64 < 1478400000 >;
> +                       clock-latency-ns = <200000>;
> +               };
> +               opp at 1593600000 {
[...]
> +
> +       };
>         thermal-zones {
>                 cpu-thermal0 {
>                         polling-delay-passive = <250>;
> @@ -403,7 +587,7 @@
>                 };
>  
>                 kryocc: clock-controller at 6400000 {
> -                       compatible = "qcom,apcc-msm8996";
> +                       compatible = "qcom-msm8996-apcc";

Bad change?

>                         reg = <0x6400000 0x90000>;
>                         #clock-cells = <1>;
>                 };
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 3b585e4..b6cd0ae 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -95,6 +95,9 @@
>         { .compatible = "xlnx,zynq-7000", },
>         { .compatible = "xlnx,zynqmp", },
>  
> +       { .compatible = "qcom,msm8996", },
> +       { .compatible = "qcom,apq8096", },
> +

Why can't we base it on the kryocc node being present? Or even populate
the cpufreq-dt from the kryocc driver?
