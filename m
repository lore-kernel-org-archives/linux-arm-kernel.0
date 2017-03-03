From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 3 Mar 2017 18:50:06 -0300
Subject: [PATCH] ARM: dts: exynos: Use thermal fuse value for thermal zone
 0 on Exynos5420
In-Reply-To: <20170211201456.27974-1-krzk@kernel.org>
References: <20170211201456.27974-1-krzk@kernel.org>
Message-ID: <252f9e32-ff2c-a1ce-3c98-6383a1148e02@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 02/11/2017 05:14 PM, Krzysztof Kozlowski wrote:
> In Odroid XU3 Lite board, the temperature levels reported for thermal
> zone 0 were weird. In warm room:
> 	/sys/class/thermal/thermal_zone0/temp:32000
> 	/sys/class/thermal/thermal_zone1/temp:51000
> 	/sys/class/thermal/thermal_zone2/temp:55000
> 	/sys/class/thermal/thermal_zone3/temp:54000
> 	/sys/class/thermal/thermal_zone4/temp:51000
> 
> Sometimes after booting the value was even equal to ambient temperature
> which is highly unlikely to be a real temperature of sensor in SoC.
> 
> The thermal sensor's calibration (trimming) is based on fused values.
> In case of the board above, the fused values are: 35, 52, 43, 58 and 43
> (corresponding to each TMU device).  However driver defined a minimum value
> for fused data as 40 and for smaller values it was using a hard-coded 55
> instead.  This lead to mapping data from sensor to wrong temperatures
> for thermal zone 0.
> 
> Various vendor 3.10 trees (Hardkernel's based on Samsung LSI, Artik 10)
> do not impose any limits on fused values.  Since we do not have any
> knowledge about these limits, use 0 as a minimum accepted fused value.
> This should essentially allow accepting any reasonable fused value thus
> behaving like vendor driver.
> 
> The exynos5420-tmu-sensor-conf.dtsi is copied directly from existing
> exynso4412 with one change - the samsung,tmu_min_efuse_value.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Testing on other Exynos542x boards is much appreciated. Especially I
> wonder what efuse values are there.

I tested on both Exynos5422 Odroid XU4 and Exynos5800 Peach Pi boards.

The temperatures levels reported for these two boards on a warm room are:

Odroid XU4

# cat /sys/class/thermal/thermal_zone*/temp
50000
50000
54000
51000
48000

Peach Pi

# cat /sys/class/thermal/thermal_zone*/temp
42000
44000
27000 <-- weird value for thermal zone 2 like zone 0 in your XU3 lite
45000
45000

And the efuse values for the TMU devices are:

Odroid XU4

TMU0 = 45
TMU1 = 44
TMU2 = 44
TMU3 = 46
TMU3 = 46

Peach Pi

TMU0 = 44
TMU1 = 46
TMU2 = 36
TMU3 = 53
TMU3 = 46

The fused value for TMU2 is < 40 so that explains the weird temperature
level for thermal zone 2 in Peach. So after your patch, makes more sense:

# cat /sys/class/thermal/thermal_zone*/temp
41000
42000
45000
43000
43000

I wonder though if 0 is the best value or if we should just lower more
to cover the used e-fuse values in Exynos5 boards. But as you said,
we have no knowledge about these limits...

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
