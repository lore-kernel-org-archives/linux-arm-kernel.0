From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 08 Dec 2015 17:13:26 +0900
Subject: [PATCH v4 7/8] ARM: dts: Exynos5422: fix OPP tables
In-Reply-To: <1449512300-17230-8-git-send-email-b.zolnierkie@samsung.com>
References: <1449512300-17230-1-git-send-email-b.zolnierkie@samsung.com>
 <1449512300-17230-8-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <56669126.7050803@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08.12.2015 03:18, Bartlomiej Zolnierkiewicz wrote:
> From: Ben Gamari <ben@smart-cactus.org>
> 
> The Exynos 5422 is identical to the 5800 except for the fact that it
> boots from the A7 cores. Consequently, the core numbering is different:
> cores 0-3 are A7s whereas 4-7 are A15s.
> 
> We can reuse the device tree of the 5800 for the 5422 but we must take
> care to override the OPP tables and CPU clocks.  These are otherwise
> inherited from the exynos5800 devicetree, which has the CPU clusters
> reversed compared to the 5422. This results in the A15 cores only
> reaching 1.4GHz, the maximum rate of the KFC clock.
> 
> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> Signed-off-by: Ben Gamari <ben@smart-cactus.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5422-cpus.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

This looks like a very-non-atomic way of handling a change. You added
opp tables to exynos5420 before so at that time they will be applied to
Odroid XU3 family which uses different CPU order. After that you are
fixing the tables to proper CPU order. Direct bisectability probably
won't be an issue because all of DTS would go to separate branch... but
the logic behind confuses.

I think this should be squashed into 3/8.

Best regards,
Krzysztof

> diff --git a/arch/arm/boot/dts/exynos5422-cpus.dtsi b/arch/arm/boot/dts/exynos5422-cpus.dtsi
> index b7f60c8..9a5131d 100644
> --- a/arch/arm/boot/dts/exynos5422-cpus.dtsi
> +++ b/arch/arm/boot/dts/exynos5422-cpus.dtsi
> @@ -20,8 +20,10 @@
>  	device_type = "cpu";
>  	compatible = "arm,cortex-a7";
>  	reg = <0x100>;
> +	clocks = <&clock CLK_KFC_CLK>;
>  	clock-frequency = <1000000000>;
>  	cci-control-port = <&cci_control0>;
> +	operating-points-v2 = <&cpu1_opp_table>;
>  };
>  
>  &cpu1 {
> @@ -30,6 +32,7 @@
>  	reg = <0x101>;
>  	clock-frequency = <1000000000>;
>  	cci-control-port = <&cci_control0>;
> +	operating-points-v2 = <&cpu1_opp_table>;
>  };
>  
>  &cpu2 {
> @@ -38,6 +41,7 @@
>  	reg = <0x102>;
>  	clock-frequency = <1000000000>;
>  	cci-control-port = <&cci_control0>;
> +	operating-points-v2 = <&cpu1_opp_table>;
>  };
>  
>  &cpu3 {
> @@ -46,14 +50,17 @@
>  	reg = <0x103>;
>  	clock-frequency = <1000000000>;
>  	cci-control-port = <&cci_control0>;
> +	operating-points-v2 = <&cpu1_opp_table>;
>  };
>  
>  &cpu4 {
>  	device_type = "cpu";
>  	compatible = "arm,cortex-a15";
>  	reg = <0x0>;
> +	clocks = <&clock CLK_ARM_CLK>;
>  	clock-frequency = <1800000000>;
>  	cci-control-port = <&cci_control1>;
> +	operating-points-v2 = <&cpu0_opp_table>;
>  };
>  
>  &cpu5 {
> @@ -62,6 +69,7 @@
>  	reg = <0x1>;
>  	clock-frequency = <1800000000>;
>  	cci-control-port = <&cci_control1>;
> +	operating-points-v2 = <&cpu0_opp_table>;
>  };
>  
>  &cpu6 {
> @@ -70,6 +78,7 @@
>  	reg = <0x2>;
>  	clock-frequency = <1800000000>;
>  	cci-control-port = <&cci_control1>;
> +	operating-points-v2 = <&cpu0_opp_table>;
>  };
>  
>  &cpu7 {
> @@ -78,4 +87,5 @@
>  	reg = <0x3>;
>  	clock-frequency = <1800000000>;
>  	cci-control-port = <&cci_control1>;
> +	operating-points-v2 = <&cpu0_opp_table>;
>  };
> 
