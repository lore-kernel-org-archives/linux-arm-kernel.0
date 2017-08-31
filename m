From: dietmar.eggemann@arm.com (Dietmar Eggemann)
Date: Thu, 31 Aug 2017 11:36:07 +0100
Subject: [PATCH 2/4] arm: dts: exynos: add exynos5420 cpu
 capacity-dmips-mhz information
In-Reply-To: <20170830202650.mdlxy2c3uwuq5vde@kozik-lap>
References: <20170830144120.9312-1-dietmar.eggemann@arm.com>
 <20170830144120.9312-3-dietmar.eggemann@arm.com>
 <20170830202650.mdlxy2c3uwuq5vde@kozik-lap>
Message-ID: <94c1d6c6-655a-2a63-1f01-06ac45990388@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/08/17 21:26, Krzysztof Kozlowski wrote:
> On Wed, Aug 30, 2017 at 03:41:18PM +0100, Dietmar Eggemann wrote:
>> The following 'capacity-dmips-mhz' dt property values are used:
>>
>> Cortex-A15: 1024, Cortex-A7: 539
>>
>> They have been derived from the cpu_efficiency values:
>>
>> Cortex-A15: 3891, Cortex-A7: 2048
>>
>> by scaling them so that the Cortex-A15s (big cores) use 1024.
>>
>> The cpu_efficiency values were originally derived from the "Big.LITTLE
>> Processing with ARM Cortex?-A15 & Cortex-A7" white paper
>> (http://www.cl.cam.ac.uk/~rdm34/big.LITTLE.pdf). Table 1 lists 1.9x
>> (3891/2048) as the Cortex-A15 vs Cortex-A7 performance ratio for the
>> Dhrystone benchmark.
>>
>> The following platforms are affected once cpu-invariant accounting
>> support is re-connected to the task scheduler:
>>
>> arndale-octa, peach-pi, peach-pit, smdk5420
>>
>> The patch has been tested on Samsung Chromebook 2 13" (peach-pi, Exynos
>> 5800).
>>
>> $ cat /sys/devices/system/cpu/cpu*/cpu_capacity
>> 1024
>> 1024
>> 1024
>> 1024
>> 389
>> 389
>> 389
>> 389
> 
> I am missing something... shouldn't this be 539? Or is it scaled with
> the clock-frequency (1 GHz) value?

Yeah, the capacity-dmips-mhz dt value of 539 for the little cpus is
scaled by 1.3/1.8 (max cpu capacity/ system wide max cpu capacity):

539 * 1.3/1.8 = 389

This max cpu capacity scaling is part of both solutions, the 'cpu
capacity-dmips-mhz' and the 'cpu_efficiency/clock-frequency dt property'
one.

The (original*) cpu capacity on a heterogeneous platform expresses uArch
and max cpu frequency differences between the (logical) cpus of the
system.

* not further reduced by rt and/or irq pressure.

[...]
