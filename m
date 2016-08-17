From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 17 Aug 2016 09:46:28 +0900
Subject: [PATCH 5/7] arm64: dts: exynos: Add dts files for Samsung
 Exynos5433 64bit SoC
In-Reply-To: <20160816175149.GA14206@kozik-lap>
References: <1471328843-26653-1-git-send-email-cw00.choi@samsung.com>
 <1471329328-26842-1-git-send-email-cw00.choi@samsung.com>
 <CGME20160816102954epcas1p4480c2a31fc4bd51c396517a272c44b2c@epcas1p4.samsung.com>
 <6afa2f9c-147a-89d1-1806-b465c5a18c95@samsung.com>
 <57B30E2E.3090506@samsung.com> <20160816175149.GA14206@kozik-lap>
Message-ID: <57B3B3E4.4020500@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 2016? 08? 17? 02:51, Krzysztof Kozlowski wrote:
> On Tue, Aug 16, 2016 at 09:59:26PM +0900, Chanwoo Choi wrote:
>>>> diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi
>>>> new file mode 100644
>>>> index 000000000000..175121db367e
>>>> --- /dev/null
>>>> +++ b/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi
>>>> @@ -0,0 +1,306 @@
>>>> +/*
>>>> + * Device tree sources for Exynos5433 thermal zone
>>>> + *
>>>> + * Copyright (c) 2016 Chanwoo Choi <cw00.choi@samsung.com>
>>>> + *
>>>> + * This program is free software; you can redistribute it and/or modify
>>>> + * it under the terms of the GNU General Public License version 2 as
>>>> + * published by the Free Software Foundation.
>>>> + */
>>>> +
>>>> +#include <dt-bindings/thermal/thermal.h>
>>>> +
>>>> +/ {
>>>> +thermal-zones {
>>>> +	atlas0_thermal: atlas0-thermal {
>>>> +		thermal-sensors = <&tmu_atlas0>;
>>>> +		polling-delay-passive = <0>;
>>>> +		polling-delay = <0>;
>>>> +		trips {
>>>> +			atlas0_alert_0: atlas0-alert-0 {
>>>> +				temperature = <50000>;	/* millicelsius */
>>>> +				hysteresis = <1000>;	/* millicelsius */
>>>> +				type = "active";
>>>> +			};
>>>> +			atlas0_alert_1: atlas0-alert-1 {
>>>> +				temperature = <55000>;	/* millicelsius */
>>>> +				hysteresis = <1000>;	/* millicelsius */
>>>> +				type = "active";
>>>> +			};
>>>> +			atlas0_alert_2: atlas0-alert-2 {
>>>> +				temperature = <60000>;	/* millicelsius */
>>>> +				hysteresis = <1000>;	/* millicelsius */
>>>> +				type = "active";
>>>> +			};
>>>> +			atlas0_alert_3: atlas0-alert-3 {
>>>> +				temperature = <70000>;	/* millicelsius */
>>>> +				hysteresis = <1000>;	/* millicelsius */
>>>> +				type = "active";
>>>> +			};
>>>> +			atlas0_alert_4: atlas0-alert-4 {
>>>> +				temperature = <80000>;	/* millicelsius */
>>>> +				hysteresis = <1000>;	/* millicelsius */
>>>> +				type = "active";
>>>> +			};
>>>> +			atlas0_alert_5: atlas0-alert-5 {
>>>> +				temperature = <90000>;	/* millicelsius */
>>>> +				hysteresis = <1000>;	/* millicelsius */
>>>> +				type = "active";
>>>> +			};
>>>> +			atlas0_alert_6: atlas0-alert-6 {
>>>> +				temperature = <95000>;	/* millicelsius */
>>>> +				hysteresis = <1000>;	/* millicelsius */
>>>> +				type = "active";
>>>> +			};
>>>
>>> No critical trip? I think it might be useful to shutdown the system in a
>>> user-friendly way.
>>
>> When I use the critical trip, the following event occur[1].
>> But, I guess that this temperature is not correct temperature
>> because after completing the kernel booting, the temperature of big.LITTLE/G3D
>> are normal when checking the /sys/class/thermal/thermal_zoneX/temp right after booting.
>> - Maintain a uniform temperature(38 ~ 45 millicelsius) right after kernel booting.
>>
>> I guess that the critical interrupt may occur before initializing the exynos tmu.
>> But, I don't spend the many time to check the exynos-tmu.c driver.
>>
>> [1]
>> [  445.122122] thermal thermal_zone0: critical temperature reached(108 C),shutting down
>> [  445.122399] exynos-tmu 10060000.tmu: Temperature sensor ID: 0xa
>> [  445.122588] exynos-tmu 10060000.tmu: Calibration type is 2-point calibration
>> [  445.127942] reboot: Failed to start orderly shutdown: forcing the issue
>> [  445.134586] Emergency Sync complete
>> [    1.097954] reboot: Power down
> 
> I understand. Apparently the exynos-tmu driver needs some fixes for
> this race. Skipping critical then makes sense.
> 
>>
>>>
>>>> +		};
>>>> +
>>>> +		cooling-maps {
>>>> +			map0 {
>>>> +				/* Set maximum frequency as 1800MHz  */
>>>> +				trip = <&atlas0_alert_0>;
>>>> +				cooling-device = <&cpu4 1 1>;
>>>
>>> Out of curiosity: why choosing specific cooling level (so quite fast
>>> the device will slow down) instead of letting cooling framework to
>>> decide how much to cool? Any particular reason behind this?
>>
>> This cooling level is just default value in cooling-maps.
>> This value is able to overwrite on dts file. 
>>
>> And the thermal subsystem support the cpu cooling features
>> with 'cooling-maps'.
>>
>> Also, when I tested the performance and stress test
>> with GLBenchmark, the temperature of big.LITTLE cores/G3D
>> reach easily the critical temperature with 8 online cores.
>> So, I add the cooling level aggressively to protect
>> the system fault of CPU and GPU and to maintain
>> the system state.
> 
> I was asking why you do not let cooling framework decide which cooling
> level to use but instead you force a specific cooling level. Maybe code
> will be a better example. Why not use:
> 			map0 {
> 				/* Set maximum frequency as 1800MHz  */
> 				trip = <&atlas0_alert_0>;
> 				cooling-device = <&cpu4 0 1>;
> 			}
> 			map1 {
> 				/* Set maximum frequency as 1700MHz  */
> 				trip = <&atlas0_alert_1>;
> 				cooling-device = <&cpu4 1 2>;
> 			};
> 
> For higher frequencies it makes even more sense:
> 			map6 {
> 				/* Set maximum frequency as 800MHz  */
> 				trip = <&atlas0_alert_6>;
> 				cooling-device = <&cpu4 7 11>;
> 			};
> 
> which allows the system to use suitable cooling level to maintain the
> balance between performance and temperature dissipance, instead of some
> fixed cooling level which might not be accurate to the system load.

Ah. I misunderstand of your question. OK. I'll expand the range of
cooling level as you suggested.

Best Regards,
Chanwoo Choi
