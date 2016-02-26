From: alim.akhtar@samsung.com (Alim Akhtar)
Date: Fri, 26 Feb 2016 09:35:01 +0530
Subject: [PATCH] arm64: dts: Add tmu node for exynos7
In-Reply-To: <56CE7DAC.4000803@samsung.com>
References: <1456370865-10086-1-git-send-email-pankaj.dubey@samsung.com>
 <56CE7DAC.4000803@samsung.com>
Message-ID: <56CFCEED.5080709@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 02/25/2016 09:36 AM, Krzysztof Kozlowski wrote:
> On 25.02.2016 12:27, Pankaj Dubey wrote:
>> From: Alim Akhtar <alim.akhtar@samsung.com>
>>
>> This patch adds tmu node, related temprature sensor and triping
>> point data for Atlas cpu core found on exynos7 SoC.
>>
>> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
>
> Yours Sob is missing.
>
> Cc-ed Lukasz Majewski.
>
Thanks
> Lukasz,
> Your review or ack would be appreciated.
>
>
>> ---
>>   .../boot/dts/exynos/exynos7-tmu-sensor-conf.dtsi   |   25 +++++++++
>>   .../arm64/boot/dts/exynos/exynos7-trip-points.dtsi |   55 ++++++++++++++++++++
>>   arch/arm64/boot/dts/exynos/exynos7.dtsi            |   20 +++++++
>>   3 files changed, 100 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/exynos/exynos7-tmu-sensor-conf.dtsi
>>   create mode 100644 arch/arm64/boot/dts/exynos/exynos7-trip-points.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/exynos/exynos7-tmu-sensor-conf.dtsi b/arch/arm64/boot/dts/exynos/exynos7-tmu-sensor-conf.dtsi
>> new file mode 100644
>> index 0000000..1d6dcf2
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/exynos/exynos7-tmu-sensor-conf.dtsi
>> @@ -0,0 +1,25 @@
>> +/*
>> + * Device tree sources for Exynos7 TMU sensor configuration
>> + *
>> + * Copyright (c) 2016 Samsung Electronics Co., Ltd.
>> + *		http://www.samsung.com
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + */
>> +
>> +#include <dt-bindings/thermal/thermal_exynos.h>
>> +
>> +#thermal-sensor-cells = <0>;
>> +samsung,tmu_gain = <9>;
>> +samsung,tmu_reference_voltage = <17>;
>> +samsung,tmu_noise_cancel_mode = <4>;
>> +samsung,tmu_efuse_value = <75>;
>> +samsung,tmu_min_efuse_value = <15>;
>> +samsung,tmu_max_efuse_value = <100>;
>> +samsung,tmu_first_point_trim = <25>;
>> +samsung,tmu_second_point_trim = <85>;
>> +samsung,tmu_default_temp_offset = <50>;
>> +samsung,tmu_cal_type = <TYPE_ONE_POINT_TRIMMING>;
>> diff --git a/arch/arm64/boot/dts/exynos/exynos7-trip-points.dtsi b/arch/arm64/boot/dts/exynos/exynos7-trip-points.dtsi
>> new file mode 100644
>> index 0000000..3970545
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/exynos/exynos7-trip-points.dtsi
>> @@ -0,0 +1,55 @@
>> +/*
>> + * Device tree sources for default Exynos7 thermal zone definition
>> + *
>> + * Copyright (c) 2016 Samsung Electronics Co., Ltd.
>> + *		http://www.samsung.com
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + */
>> +
>> +trips {
>> +	cpu-alert-0 {
>> +		temperature = <75000>; /* millicelsius */
>> +		hysteresis = <10000>; /* millicelsius */
>> +		type = "passive";
>> +	};
>> +	cpu-alert-1 {
>> +		temperature = <80000>; /* millicelsius */
>> +		hysteresis = <10000>; /* millicelsius */
>> +		type = "passive";
>> +	};
>> +	cpu-alert-2 {
>> +		temperature = <85000>; /* millicelsius */
>> +		hysteresis = <10000>; /* millicelsius */
>> +		type = "passive";
>> +	};
>> +	cpu-alert-3 {
>> +		temperature = <90000>; /* millicelsius */
>> +		hysteresis = <10000>; /* millicelsius */
>> +		type = "passive";
>> +	};
>> +	cpu-alert-4 {
>> +		temperature = <95000>; /* millicelsius */
>> +		hysteresis = <10000>; /* millicelsius */
>> +		type = "passive";
>> +	};
>> +	cpu-alert-5 {
>> +		temperature = <100000>; /* millicelsius */
>> +		hysteresis = <10000>; /* millicelsius */
>> +		type = "passive";
>> +	};
>> +	cpu-alert-6 {
>> +		temperature = <110000>; /* millicelsius */
>> +		hysteresis = <10000>; /* millicelsius */
>> +		type = "passive";
>> +	};
>> +	/* HW Trip point */
>
> The comment looks unnecessary, all of these are HW trip points, right?
>
Ok will remove, on this SoC, only THRES_LEVEL_RISE7 support THERM_TRIP, 
rest are used for thermal throttling via a cooling device like cpu-freq.
>> +	cpu-crit-0 {
>> +		temperature = <115000>; /* millicelsius */
>> +		hysteresis = <0>; /* millicelsius */
>> +		type = "critical";
>> +	};
>> +};
>> diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
>> index c662f98..fc9d130 100644
>> --- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
>> +++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
>> @@ -27,6 +27,7 @@
>>   		pinctrl6 = &pinctrl_fsys0;
>>   		pinctrl7 = &pinctrl_fsys1;
>>   		pinctrl8 = &pinctrl_bus1;
>> +		tmuctrl0 = &tmuctrl_0;
>
> Why the alias is needed?
>
This is kept to add mutli-instance support of tmu, later ISP and G3D 
will get added.
>>   	};
>>
>>   	cpus {
>> @@ -538,6 +539,25 @@
>>   			clocks = <&clock_peric0 PCLK_PWM>;
>>   			clock-names = "timers";
>>   		};
>> +
>> +		tmuctrl_0: tmu at 10060000 {
>> +			compatible = "samsung,exynos7-tmu";
>> +			reg = <0x10060000 0x200>;
>> +			interrupts = <0 108 0>;
>> +			clocks = <&clock_peris PCLK_TMU>,
>> +				 <&clock_peris SCLK_TMU>;
>> +			clock-names = "tmu_apbif", "tmu_sclk";
>> +			#include "exynos7-tmu-sensor-conf.dtsi"
>> +		};
>> +
>> +		thermal-zones {
>> +			atlas_thermal: atlas-thermal {
>
> The atlas is a Exynos7 specific codename. The name of node should be a
> general class of the device, so maybe:
> 	atlas_thermal: cluster0-thermal
> ?
>
sounds good to me..will add.

> Best regards,
> Krzysztof
>
