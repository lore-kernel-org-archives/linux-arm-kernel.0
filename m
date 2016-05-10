From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 10 May 2016 10:15:58 +0200
Subject: [PATCH] ARM: dts: exynos: Only Odroid XU3-family boards use DTSI
 with CPU thermal nodes
In-Reply-To: <CANAwSgT9SY3kj8+beMpc1xGoC=rMBSya+2v2dyZQp6ykH+V0=g@mail.gmail.com>
References: <1462774789-15360-1-git-send-email-k.kozlowski@samsung.com>
 <CANAwSgT9SY3kj8+beMpc1xGoC=rMBSya+2v2dyZQp6ykH+V0=g@mail.gmail.com>
Message-ID: <573198BE.6020900@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/10/2016 08:43 AM, Anand Moon wrote:
> Hi Krzysztof ,
> 
> On 9 May 2016 at 11:49, Krzysztof Kozlowski <k.kozlowski@samsung.com> wrote:
>> Include the CPU thermal nodes directly in Odroid XU3-family common DTS
>> because it is the only user of it. Keeping it in separate DTSI node does
>> not bring benefits because:
>> 1. It is not re-usable on other non-fan boards (fan is referenced),
>> 2. It won't be re-used on future Odroid XU board because different
>>    CPU cluster behavior.
>>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> ---
>>  arch/arm/boot/dts/exynos5422-cpu-thermal.dtsi      | 103 ---------------------
>>  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  94 ++++++++++++++++++-
>>  2 files changed, 92 insertions(+), 105 deletions(-)
>>  delete mode 100644 arch/arm/boot/dts/exynos5422-cpu-thermal.dtsi
>>
>> diff --git a/arch/arm/boot/dts/exynos5422-cpu-thermal.dtsi b/arch/arm/boot/dts/exynos5422-cpu-thermal.dtsi
>> deleted file mode 100644
>> index 3e4c4ad96d63..000000000000
>> --- a/arch/arm/boot/dts/exynos5422-cpu-thermal.dtsi
>> +++ /dev/null
>> @@ -1,103 +0,0 @@
>> -/*
>> - * Device tree sources for Exynos5422 thermal zone
>> - *
>> - * Copyright (c) 2015 Lukasz Majewski <l.majewski@samsung.com>
>> - *                     Anand Moon <linux.amoon@gmail.com>
>> - *
>> - * This program is free software; you can redistribute it and/or modify
>> - * it under the terms of the GNU General Public License version 2 as
>> - * published by the Free Software Foundation.
>> - *
>> - */
>> -
>> -#include <dt-bindings/thermal/thermal.h>
>> -
>> -/ {
>> -       thermal-zones {
>> -               cpu0_thermal: cpu0-thermal {
>> -                       thermal-sensors = <&tmu_cpu0 0>;
>> -                       polling-delay-passive = <250>;
>> -                       polling-delay = <0>;
>> -                       trips {
>> -                               cpu_alert0: cpu-alert-0 {
>> -                                       temperature = <50000>; /* millicelsius */
>> -                                       hysteresis = <5000>; /* millicelsius */
>> -                                       type = "active";
>> -                               };
>> -                               cpu_alert1: cpu-alert-1 {
>> -                                       temperature = <60000>; /* millicelsius */
>> -                                       hysteresis = <5000>; /* millicelsius */
>> -                                       type = "active";
>> -                               };
>> -                               cpu_alert2: cpu-alert-2 {
>> -                                       temperature = <70000>; /* millicelsius */
>> -                                       hysteresis = <5000>; /* millicelsius */
>> -                                       type = "active";
>> -                               };
>> -                               cpu_crit0: cpu-crit-0 {
>> -                                       temperature = <120000>; /* millicelsius */
>> -                                       hysteresis = <0>; /* millicelsius */
>> -                                       type = "critical";
>> -                               };
>> -                               /*
>> -                                * Exyunos542x support only 4 trip-points
>> -                                * so for these polling mode is required.
>> -                                * Start polling at temperature level of last
>> -                                * interrupt-driven trip: cpu_alert2
>> -                                */
>> -                               cpu_alert3: cpu-alert-3 {
>> -                                       temperature = <70000>; /* millicelsius */
>> -                                       hysteresis = <10000>; /* millicelsius */
>> -                                       type = "passive";
>> -                               };
>> -                               cpu_alert4: cpu-alert-4 {
>> -                                       temperature = <85000>; /* millicelsius */
>> -                                       hysteresis = <10000>; /* millicelsius */
>> -                                       type = "passive";
>> -                               };
>> -
>> -                       };
>> -                       cooling-maps {
>> -                               map0 {
>> -                                    trip = <&cpu_alert0>;
>> -                                    cooling-device = <&fan0 0 1>;
>> -                               };
>> -                               map1 {
>> -                                    trip = <&cpu_alert1>;
>> -                                    cooling-device = <&fan0 1 2>;
>> -                               };
>> -                               map2 {
>> -                                    trip = <&cpu_alert2>;
>> -                                    cooling-device = <&fan0 2 3>;
>> -                               };
>> -                               /*
>> -                                * When reaching cpu_alert3, reduce CPU
>> -                                * by 2 steps. On Exynos5422/5800 that would
>> -                                * be: 1500 MHz and 1100 MHz.
>> -                                */
>> -                               map3 {
>> -                                    trip = <&cpu_alert3>;
>> -                                    cooling-device = <&cpu0 0 2>;
>> -                               };
>> -                               map4 {
>> -                                    trip = <&cpu_alert3>;
>> -                                    cooling-device = <&cpu4 0 2>;
>> -                               };
>> -
>> -                               /*
>> -                                * When reaching cpu_alert4, reduce CPU
>> -                                * further, down to 600 MHz (11 steps for big,
>> -                                * 7 steps for LITTLE).
>> -                                */
>> -                               map5 {
>> -                                    trip = <&cpu_alert4>;
>> -                                    cooling-device = <&cpu0 3 7>;
>> -                               };
>> -                               map6 {
>> -                                    trip = <&cpu_alert4>;
>> -                                    cooling-device = <&cpu4 3 11>;
>> -                               };
>> -                       };
>> -               };
>> -       };
>> -};
>> diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
>> index 2a4e10bc8801..ff05041835e5 100644
>> --- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
>> +++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
>> @@ -1,9 +1,11 @@
>>  /*
>>   * Hardkernel Odroid XU3 board device tree source
>>   *
>> - * Copyright (c) 2014 Collabora Ltd.
>>   * Copyright (c) 2013 Samsung Electronics Co., Ltd.
>>   *             http://www.samsung.com
>> + * Copyright (c) 2014 Collabora Ltd.
>> + * Copyright (c) 2015 Lukasz Majewski <l.majewski@samsung.com>
>> + *                    Anand Moon <linux.amoon@gmail.com>
>>   *
>>   * This program is free software; you can redistribute it and/or modify
>>   * it under the terms of the GNU General Public License version 2 as
>> @@ -16,7 +18,6 @@
>>  #include <dt-bindings/sound/samsung-i2s.h>
>>  #include "exynos5800.dtsi"
>>  #include "exynos5422-cpus.dtsi"
>> -#include "exynos5422-cpu-thermal.dtsi"
>>
>>  / {
>>         memory {
>> @@ -54,6 +55,95 @@
>>                 #cooling-cells = <2>;
>>                 cooling-levels = <0 130 170 230>;
>>         };
>> +
>> +       thermal-zones {
>> +               cpu0_thermal: cpu0-thermal {
>> +                       thermal-sensors = <&tmu_cpu0 0>;
>> +                       polling-delay-passive = <250>;
>> +                       polling-delay = <0>;
>> +                       trips {
>> +                               cpu_alert0: cpu-alert-0 {
>> +                                       temperature = <50000>; /* millicelsius */
>> +                                       hysteresis = <5000>; /* millicelsius */
>> +                                       type = "active";
>> +                               };
>> +                               cpu_alert1: cpu-alert-1 {
>> +                                       temperature = <60000>; /* millicelsius */
>> +                                       hysteresis = <5000>; /* millicelsius */
>> +                                       type = "active";
>> +                               };
>> +                               cpu_alert2: cpu-alert-2 {
>> +                                       temperature = <70000>; /* millicelsius */
>> +                                       hysteresis = <5000>; /* millicelsius */
>> +                                       type = "active";
>> +                               };
>> +                               cpu_crit0: cpu-crit-0 {
>> +                                       temperature = <120000>; /* millicelsius */
>> +                                       hysteresis = <0>; /* millicelsius */
>> +                                       type = "critical";
>> +                               };
>> +                               /*
>> +                                * Exynos542x supports only 4 trip-points
>> +                                * so for these polling mode is required.
>> +                                * Start polling at temperature level of last
>> +                                * interrupt-driven trip: cpu_alert2
>> +                                */
>> +                               cpu_alert3: cpu-alert-3 {
>> +                                       temperature = <70000>; /* millicelsius */
>> +                                       hysteresis = <10000>; /* millicelsius */
>> +                                       type = "passive";
>> +                               };
>> +                               cpu_alert4: cpu-alert-4 {
>> +                                       temperature = <85000>; /* millicelsius */
>> +                                       hysteresis = <10000>; /* millicelsius */
>> +                                       type = "passive";
>> +                               };
>> +
>> +                       };
>> +                       cooling-maps {
>> +                               map0 {
>> +                                    trip = <&cpu_alert0>;
>> +                                    cooling-device = <&fan0 0 1>;
>> +                               };
>> +                               map1 {
>> +                                    trip = <&cpu_alert1>;
>> +                                    cooling-device = <&fan0 1 2>;
>> +                               };
>> +                               map2 {
>> +                                    trip = <&cpu_alert2>;
>> +                                    cooling-device = <&fan0 2 3>;
>> +                               };
>> +                               /*
>> +                                * When reaching cpu_alert3, reduce CPU
>> +                                * by 2 steps. On Exynos5422/5800 that would
>> +                                * be: 1500 MHz and 1100 MHz.
>> +                                */
>> +                               map3 {
>> +                                    trip = <&cpu_alert3>;
>> +                                    cooling-device = <&cpu0 0 2>;
>> +                               };
>> +                               map4 {
>> +                                    trip = <&cpu_alert3>;
>> +                                    cooling-device = <&cpu4 0 2>;
>> +                               };
>> +
>> +                               /*
>> +                                * When reaching cpu_alert4, reduce CPU
>> +                                * further, down to 600 MHz (11 steps for big,
>> +                                * 7 steps for LITTLE).
>> +                                */
>> +                               map5 {
>> +                                    trip = <&cpu_alert4>;
>> +                                    cooling-device = <&cpu0 3 7>;
>> +                               };
>> +                               map6 {
>> +                                    trip = <&cpu_alert4>;
>> +                                    cooling-device = <&cpu4 3 11>;
>> +                               };
>> +                       };
>> +               };
>> +       };
>> +
>>  };
>>
>>  &bus_wcore {
>> --
>> 1.9.1
>>
> 
> Could you defer this patch, during my testing with pm-qa from linaro.
> 
> git://git.linaro.org/tools/pm-qa.git
> 
> When their is running of thermal test case cpu usage reaches around
> 300+ percentage
> and some time's the Odroid XU4 hang down.
> -------------------------------------------------------------------------
> [ 1028.056619] CPU4: shutdown
> [ 1148.510372] IRQ54 no longer affine to CPU5
> [ 1148.511864] CPU5: shutdown
> [ 1268.921073] IRQ55 no longer affine to CPU6
> [ 1268.922564] CPU6: shutdown
> [ 1389.271930] cpu cpu4: Failed to find opp_table: -19
> [ 1389.301668] IRQ56 no longer affine to CPU7
> [ 1389.303132] CPU7: shutdown
> [ 1510.538424] cpu cpu4: opp_list_debug_create_link: Failed to create link
> [ 1510.543762] cpu cpu4: _add_opp_dev: Failed to register opp debugfs (-12)
> [ 1510.550625] cpu cpu7: opp_list_debug_create_link: Failed to create link
> [ 1510.557037] cpu cpu7: _add_opp_dev: Failed to register opp debugfs (-12)
> [ 1510.664649] cpu cpu5: cpufreq_init: failed to get clk: -2
> [ 1510.720567] cpu cpu6: cpufreq_init: failed to get clk: -2
> [ 1510.788280] cpu cpu7: cpufreq_init: failed to get clk: -2
> root at odroidxu4l:/home/odroid/study/linaro/pm-qa# killall heat_cpu
> 
> -------------------------------------------------------------------------
> And some time I observed that the board will poweroff on reaching
> temperature 120 degree C.
> when I am compiling the kernel with or above. make -j8
> -------------------------------------------------------------------------
> root at odroidxu4l:~#  * Starting NTP server ntpd                           [ OK ]
> saned disabled; edit /etc/default/saned
> [ 4118.924470] thermal thermal_zone3: critical temperature reached(121
> C),shutting down
> [ 4119.014327] thermal thermal_zone3: critical temperature reached(121
> C),shutting down
> 
> Broadcast message from root at odroidxu4l
>         (unknown) at 20:41 ...
> 
> The system is going down for power off NOW!
> 
> Broadcast message from root at odroidxu4l
>         (unknown) at 20:41 ...
> 
> The system is going down for power off NOW!
> [ 4119.431386] thermal thermal_zone3: critical temperature reached(121
> C),shutting down
> [ 4120.206709] thermal thermal_zone3: critical temperature reached(120
> C),shutting down
> 
> Broadcast message from root at odroidxu4l
>         (unknown) at 20:41 ...
> 
> The system is going down for power off NOW!
> wait-for-state stop/waiting
> [ 4157.574406] reboo
> 
> U-Boot 2016.03-00665-g563d8d9-dirty (Apr 04 2016 - 22:27:07 +0930) for
> ODROID-XU3
> 
> CPU:   Exynos5422 @ 800 MHz
> Model: Odroid XU3 based on EXYNOS5422
> Board: Odroid XU3 based on EXYNOS5422
> Type:  xu4
> DRAM:  2 GiB
> MMC:   EXYNOS DWMMC: 0, EXYNOS DWMMC: 1
> *** Warning - bad CRC, using default environment
> -------------------------------------------------------------------------
> Once the thermal issue is fixed we can redo this changes.

I am sorry but I do not understand.
1. Are you saying that my patch causes the issue?
2. Are you saying that I should not send some patches because of
conflicting work? (that would be peculiar...)
3. Are you saying that I should not apply this patch to me tree because
of conflicting work?
4. Other?

Best regards.
Krzysztof
