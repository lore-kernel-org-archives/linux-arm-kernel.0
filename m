From: xuwei5@hisilicon.com (Wei Xu)
Date: Thu, 28 Dec 2017 21:14:03 +0000
Subject: [PATCH v2] arm64: dts: Hi3660: Fix up psci state id
In-Reply-To: <5A3CD23C.3080307@hisilicon.com>
References: <1513069954-22827-1-git-send-email-leo.yan@linaro.org>
 <5A3CD23C.3080307@hisilicon.com>
Message-ID: <5A455E9B.9010703@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Leo,

On 2017/12/22 9:37, Wei Xu wrote:
> Hi Leo,
> 
> On 2017/12/12 9:12, Leo Yan wrote:
>> Thanks a lot for Vincent Guittot careful work to find bug for 'CPU_NAP'
>> idle state.  From ftrace log we can observe CA73 CPUs can be easily
>> waken up from 'CPU_NAP' state but the 'waken up' CPUs doesn't handle
>> anything and sleep again; so there have tons of trace events for CA73
>> CPUs entering and exiting idle state.
>>
>> On Hi3660 CA73 has retention state 'CPU_NAP' for CPU idle, this state we
>> set its psci parameter as '0x0000001' and from this parameter it can
>> calculate state id is 1.  Unfortunately ARM trusted firmware (ARM-TF)
>> takes 1 as a invalid value for state id, so the CPU cannot enter idle
>> state and directly bail out to kernel.
>>
>> We want to create good practice for psci parameters platform definition,
>> so review the psci specification. The spec "ARM Power State Coordination
>> Interface - Platform Design Document (ARM DEN 0022D)" recommends state
>> ID in chapter "6.5 Recommended StateID Encoding".  The recommended power
>> state IDs can be presented by below listed values; and it divides into
>> three fields, every field can use 4 bits to present power states
>> corresponding to core level, cluster level and system level:
>>   0: Run
>>   1: Standby
>>   2: Retention
>>   3: Powerdown
>>
>> This commit changes psci parameter to compliance with the suggested
>> state ID in the doc.  Except we change 'CPU_NAP' state psci parameter
>> to '0x0000002', this commit also changes 'CPU_SLEEP' and 'CLUSTER_SLEEP'
>> state parameters to '0x0010003' and '0x1010033' respectively.
>>
>> Credits to Daniel, Sudeep and Soby for suggestion and consolidation.
>>
>> Cc: Vincent Guittot <vincent.guittot@linaro.org>
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>> Cc: Soby Mathew <Soby.Mathew@arm.com>
>> Signed-off-by: Leo Yan <leo.yan@linaro.org>
>> ---
> 
> Applied into hisilicon dt tree.
> Thanks!

Sorry, since this patch is still under discussion,
I will drop it firstly.
Thanks!

Best Regards,
Wei

> 
> Best Regards,
> Wei
> 
>>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
>> index ab0b95b..99d5a46 100644
>> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
>> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
>> @@ -147,7 +147,7 @@
>>  
>>  			CPU_NAP: cpu-nap {
>>  				compatible = "arm,idle-state";
>> -				arm,psci-suspend-param = <0x0000001>;
>> +				arm,psci-suspend-param = <0x0000002>;
>>  				entry-latency-us = <7>;
>>  				exit-latency-us = <2>;
>>  				min-residency-us = <15>;
>> @@ -156,7 +156,7 @@
>>  			CPU_SLEEP: cpu-sleep {
>>  				compatible = "arm,idle-state";
>>  				local-timer-stop;
>> -				arm,psci-suspend-param = <0x0010000>;
>> +				arm,psci-suspend-param = <0x0010003>;
>>  				entry-latency-us = <40>;
>>  				exit-latency-us = <70>;
>>  				min-residency-us = <3000>;
>> @@ -165,7 +165,7 @@
>>  			CLUSTER_SLEEP_0: cluster-sleep-0 {
>>  				compatible = "arm,idle-state";
>>  				local-timer-stop;
>> -				arm,psci-suspend-param = <0x1010000>;
>> +				arm,psci-suspend-param = <0x1010033>;
>>  				entry-latency-us = <500>;
>>  				exit-latency-us = <5000>;
>>  				min-residency-us = <20000>;
>> @@ -174,7 +174,7 @@
>>  			CLUSTER_SLEEP_1: cluster-sleep-1 {
>>  				compatible = "arm,idle-state";
>>  				local-timer-stop;
>> -				arm,psci-suspend-param = <0x1010000>;
>> +				arm,psci-suspend-param = <0x1010033>;
>>  				entry-latency-us = <1000>;
>>  				exit-latency-us = <5000>;
>>  				min-residency-us = <20000>;
>>
