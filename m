From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun, 25 Jun 2017 09:57:22 +0200
Subject: [PATCH] ARM: dts: exynos: Exynos5422 Odroid-XU* incomplete
 thermal-zones definition
In-Reply-To: <20170623210913.ugutgop7ratwolfy@inc028000032.lancs.ac.uk>
References: <20170623210913.ugutgop7ratwolfy@inc028000032.lancs.ac.uk>
Message-ID: <20170625075722.6thpjxdees5amxo5@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 23, 2017 at 10:09:14PM +0100, Willy Wolff wrote:
> Odroid XU*-familly boards has thermal sensors per A15 cores, but the actual
>  thermal-zones define only cooling-maps action for cpu0.
> 
> If the application is running on all cores but core4 (first core of the A15
>  cluster), the CPU can reach high temperature without any proper cooling
>  action.

Commit msg has weird paragraph indentation. Please write it as regular
commit, like others.

> 
> As already discus in prior mail, and on IRC, it's a quit big code
> duplication, but I don't found the write way to express that in a better
>  way.
> 
> The situation for this board is that we have multiple sensors, but
>  matching cooling devices for these sensors act for the same physical
>  device (FAN and A15 cluster, as each core of the cluster share the same
>  frequency).
> In fact, of-thermal.c:473:thermal_zone_of_sensor_register() can't use
> multiple sensors for one single thermal zone.
> This patch follow the path taken in arch/arm/boot/dts/qcom-apq8084.dtsi:97
> 
> I'm interested to extending the thermal driver, but it will takes time.
>  So this is a workaround before refactoring the driver.
> If somebody knows how to write it better, any advice and suggestions
> are more than welcome.

Skip all data irrelevant to the issue (like what is your interest,
discussions made on LKML or IRC). Just describe exactly what is the
problem (and maybe how it can be reproduced) and what is the solution.
You can mention what could be the optimal solution and why we cannot use
it now.

> 
> Also, the comment for cpu_alert4 in cooling-maps definition is not
> accurate, 11 steps for A15 correspond to 700MHz, not 600MHz.
> 
> Signed-off-by: Willy Wolff <willy.mh.wolff@gmail.com>
> ---
>  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 249 +++++++++++++++++++--
>  1 file changed, 231 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> index 05b9afdd6757..0759cc0812fb 100644
> --- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> +++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> @@ -64,22 +64,22 @@
>  			polling-delay-passive = <250>;
>  			polling-delay = <0>;
>  			trips {
> -				cpu_alert0: cpu-alert-0 {
> +				cpu0_alert0: cpu-alert-0 {
>  					temperature = <50000>; /* millicelsius */
>  					hysteresis = <5000>; /* millicelsius */
>  					type = "active";
>  				};
> -				cpu_alert1: cpu-alert-1 {
> +				cpu0_alert1: cpu-alert-1 {
>  					temperature = <60000>; /* millicelsius */
>  					hysteresis = <5000>; /* millicelsius */
>  					type = "active";
>  				};
> -				cpu_alert2: cpu-alert-2 {
> +				cpu0_alert2: cpu-alert-2 {
>  					temperature = <70000>; /* millicelsius */
>  					hysteresis = <5000>; /* millicelsius */
>  					type = "active";
>  				};
> -				cpu_crit0: cpu-crit-0 {
> +				cpu0_crit0: cpu-crit-0 {
>  					temperature = <120000>; /* millicelsius */
>  					hysteresis = <0>; /* millicelsius */
>  					type = "critical";
> @@ -88,14 +88,14 @@
>  				 * Exynos542x supports only 4 trip-points
>  				 * so for these polling mode is required.
>  				 * Start polling at temperature level of last
> -				 * interrupt-driven trip: cpu_alert2
> +				 * interrupt-driven trip: cpu0_alert2
>  				 */
> -				cpu_alert3: cpu-alert-3 {
> +				cpu0_alert3: cpu-alert-3 {
>  					temperature = <70000>; /* millicelsius */
>  					hysteresis = <10000>; /* millicelsius */
>  					type = "passive";
>  				};
> -				cpu_alert4: cpu-alert-4 {
> +				cpu0_alert4: cpu-alert-4 {
>  					temperature = <85000>; /* millicelsius */
>  					hysteresis = <10000>; /* millicelsius */
>  					type = "passive";
> @@ -104,43 +104,256 @@
>  			};
>  			cooling-maps {
>  				map0 {
> -					trip = <&cpu_alert0>;
> +					trip = <&cpu0_alert0>;
>  					cooling-device = <&fan0 0 1>;
>  				};
>  				map1 {
> -					trip = <&cpu_alert1>;
> +					trip = <&cpu0_alert1>;
>  					cooling-device = <&fan0 1 2>;
>  				};
>  				map2 {
> -					trip = <&cpu_alert2>;
> +					trip = <&cpu0_alert2>;
>  					cooling-device = <&fan0 2 3>;
>  				};
>  				/*
> -				 * When reaching cpu_alert3, reduce CPU
> +				 * When reaching cpu0_alert3, reduce CPU
>  				 * by 2 steps. On Exynos5422/5800 that would
>  				 * be: 1600 MHz and 1100 MHz.
>  				 */
>  				map3 {
> -					trip = <&cpu_alert3>;
> +					trip = <&cpu0_alert3>;
>  					cooling-device = <&cpu0 0 2>;
>  				};
>  				map4 {
> -					trip = <&cpu_alert3>;
> +					trip = <&cpu0_alert3>;
>  					cooling-device = <&cpu4 0 2>;
>  				};
>  
>  				/*
> -				 * When reaching cpu_alert4, reduce CPU
> -				 * further, down to 600 MHz (11 steps for big,
> +				 * When reaching cpu0_alert4, reduce CPU
> +				 * further, down to 600 MHz (12 steps for big,
>  				 * 7 steps for LITTLE).
>  				 */
>  				map5 {
> -					trip = <&cpu_alert4>;
> +					trip = <&cpu0_alert4>;
>  					cooling-device = <&cpu0 3 7>;
>  				};
>  				map6 {
> -					trip = <&cpu_alert4>;
> -					cooling-device = <&cpu4 3 11>;
> +					trip = <&cpu0_alert4>;
> +					cooling-device = <&cpu4 3 12>;
> +				};
> +			};
> +		};
> +		cpu1_thermal: cpu1-thermal {
> +			thermal-sensors = <&tmu_cpu1 0>;
> +			polling-delay-passive = <250>;
> +			polling-delay = <0>;
> +			trips {
> +				cpu1_alert0: cpu-alert-0 {
> +					temperature = <50000>;
> +					hysteresis = <5000>;
> +					type = "active";
> +				};
> +				cpu1_alert1: cpu-alert-1 {
> +					temperature = <60000>;
> +					hysteresis = <5000>;
> +					type = "active";
> +				};
> +				cpu1_alert2: cpu-alert-2 {
> +					temperature = <70000>;
> +					hysteresis = <5000>;
> +					type = "active";
> +				};
> +				cpu1_crit0: cpu-crit-0 {
> +					temperature = <120000>;
> +					hysteresis = <0>;
> +					type = "critical";
> +				};
> +
> +				cpu1_alert3: cpu-alert-3 {
> +					temperature = <70000>;
> +					hysteresis = <10000>; /* millicelsius */

You removed these comments in other cases so this should go away as
well.

Best regards,
Krzysztof
