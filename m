From: linux.amoon@gmail.com (Anand Moon)
Date: Wed, 11 May 2016 12:58:30 +0530
Subject: [PATCH] ARM: dts: exynos: Only Odroid XU3-family boards use DTSI
 with CPU thermal nodes
In-Reply-To: <5732C7DF.2080800@samsung.com>
References: <1462774789-15360-1-git-send-email-k.kozlowski@samsung.com>
 <CANAwSgT9SY3kj8+beMpc1xGoC=rMBSya+2v2dyZQp6ykH+V0=g@mail.gmail.com>
 <573198BE.6020900@samsung.com>
 <CANAwSgTy6p9AVmmOWATpSO1JqVbwE0v+y_y-RLd+32RnNJTA+Q@mail.gmail.com>
 <5731D764.8070007@samsung.com>
 <CANAwSgRsjdQh6ygT__5XcH8-cF9Ch+zbk8oupebwYzY1kCZu6g@mail.gmail.com>
 <5731EA1B.4070201@samsung.com>
 <CANAwSgQGhrBca7=Ow8+Hh9t0W9HWp=F43KR0Frfpx9fGngPSaw@mail.gmail.com>
 <5732C7DF.2080800@samsung.com>
Message-ID: <CANAwSgQHHE=USgjea4DpySC7T2+t7Ta8LuyL36cz3DpiyDgaWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 11 May 2016 at 11:19, Krzysztof Kozlowski <k.kozlowski@samsung.com> wrote:
> On 05/10/2016 09:45 PM, Anand Moon wrote:
>> Hi Krzysztof,
>>
>> Sorry I am not able to explain my self clearly.
>> But I have once gain tested these changes.
>>
>> Only could you append with following changes.
>> --------------------------------------------------------
>> +                               cpu_crit0: cpu-crit-0 {
>> +                                       temperature = <120000>; /*
>> millicelsius */
>> +                                       hysteresis = <5000>; /* millicelsius */
>> +                                       type = "critical";
>> +                               };
>> --------------------------------------------------------
>> hysteresis time help to adjust the present and past temperature inputs
>> before critical shutdown.
>
> I need more details why you want this patch. What is the point of
> hysteresis on critical trip point? When reaching this trip point the
> system shutdowns... there is nothing more to do, I think.

Ok you are correct and I am completely wrong, It dose not critical
temperate so easily.

>
> Best regards,
> Krzysztof
>

I have enable CONFIG_DYNAMIC_DEBUG and tested with following.

# echo 'module thermal_sys +fp' > /sys/kernel/debug/dynamic_debug/control

Below is the  output of console for stress testing.
[ 1728.744182] update_temperature: thermal thermal_zone3:
last_temperature=92000, current_temperature=92000
[ 1728.744211] thermal_zone_trip_update: thermal thermal_zone3:
Trip0[type=0,temp=85000]:trend=0,throttle=1
[ 1728.744231] thermal_zone_trip_update: thermal thermal_zone3:
Trip1[type=0,temp=103000]:trend=0,throttle=0
[ 1728.744248] thermal_zone_trip_update: thermal thermal_zone3:
Trip2[type=0,temp=110000]:trend=0,throttle=0
[ 1728.755227] update_temperature: thermal thermal_zone2:
last_temperature=86000, current_temperature=86000
[ 1728.755269] thermal_zone_trip_update: thermal thermal_zone2:
Trip0[type=0,temp=85000]:trend=0,throttle=1
[ 1728.755306] thermal_zone_trip_update: thermal thermal_zone2:
Trip1[type=0,temp=103000]:trend=0,throttle=0
[ 1728.755340] thermal_zone_trip_update: thermal thermal_zone2:
Trip2[type=0,temp=110000]:trend=0,throttle=0
[ 1728.964753] update_temperature: thermal thermal_zone0:
last_temperature=78000, current_temperature=83000
[ 1728.964782] thermal_zone_trip_update: thermal thermal_zone0:
Trip0[type=0,temp=50000]:trend=1,throttle=1
[ 1728.964797] get_target_state: thermal cooling_device0: cur_state=2
[ 1728.964810] thermal_zone_trip_update: thermal cooling_device0:
old_target=1, target=1
[ 1728.964837] thermal_zone_trip_update: thermal thermal_zone0:
Trip1[type=0,temp=60000]:trend=1,throttle=1
[ 1728.964850] get_target_state: thermal cooling_device0: cur_state=2
[ 1728.964861] thermal_zone_trip_update: thermal cooling_device0:
old_target=1, target=2
[ 1728.964875] thermal_cdev_update: thermal cooling_device0: zone0->target=1
[ 1728.964886] thermal_cdev_update: thermal cooling_device0: zone0->target=2
[ 1728.964897] thermal_cdev_update: thermal cooling_device0: zone0->target=2
[ 1728.964909] thermal_cdev_update: thermal cooling_device0: set to state 2
[ 1728.964925] thermal_zone_trip_update: thermal thermal_zone0:
Trip2[type=0,temp=70000]:trend=1,throttle=1
[ 1728.964937] get_target_state: thermal cooling_device0: cur_state=2
[ 1728.964948] thermal_zone_trip_update: thermal cooling_device0:
old_target=2, target=3
[ 1728.964962] thermal_cdev_update: thermal cooling_device0: zone0->target=1
[ 1728.964973] thermal_cdev_update: thermal cooling_device0: zone0->target=2
[ 1728.964983] thermal_cdev_update: thermal cooling_device0: zone0->target=3
[ 1728.965000] thermal_cdev_update: thermal cooling_device0: set to state 3
[ 1728.965019] thermal_zone_trip_update: thermal thermal_zone0:
Trip4[type=1,temp=70000]:trend=1,throttle=1

Ok I admit that thermal throttle is working correctly on my Odroid XU4.
Opps .... Sorry for the trouble.

Best Regards
-Anand Moon
