From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 17 Feb 2017 10:28:00 +0000
Subject: [PATCH 1/5] arm64: dts: Add basic DT to support Spreadtrum's
 SP9860G
In-Reply-To: <20170217072839.GA8767@spreadtrum.com>
References: <1487063952-7113-1-git-send-email-chunyan.zhang@spreadtrum.com>
 <1487063952-7113-2-git-send-email-chunyan.zhang@spreadtrum.com>
 <CAPKp9ub35nL8gc_TKx02pSHHNwBhiMacWL=CuEmNGnecWikfGQ@mail.gmail.com>
 <20170217072839.GA8767@spreadtrum.com>
Message-ID: <b5940598-f3e7-b2c5-9914-7bcbe3471f9e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 17/02/17 07:28, Chunyan Zhang wrote:
> Hi Sudeep,
> 
> On ?,  2? 14, 2017 at 04:44:53?? +0000, Sudeep Holla wrote:
>> On Tue, Feb 14, 2017 at 9:19 AM, Chunyan Zhang
>> <chunyan.zhang@spreadtrum.com> wrote:

[..]

>>
>>> +       idle-states{
>>> +               entry-method = "arm,psci";
>>> +
>>> +               CORE_PD: core_pd {
>>> +                       compatible = "arm,idle-state";
>>> +                       entry-latency-us = <1000>;
>>> +                       exit-latency-us = <700>;
>>> +                       min-residency-us = <2500>;
>>> +                       local-timer-stop;
>>> +                       arm,psci-suspend-param = <0x00010002>;
>>> +               };
>>> +
>>> +               CLUSTER_PD: cluster_pd {
>>> +                       compatible = "arm,idle-state";
>>> +                       entry-latency-us = <1000>;
>>> +                       exit-latency-us = <1000>;
>>> +                       min-residency-us = <3000>;
>>> +                       local-timer-stop;
>>> +                       arm,psci-suspend-param = <0x01010003>;
>>> +               };
>>> +
>>> +               DEEP_SLEEP: deep_sleep {
>>> +                       compatible = "arm,idle-state";
>>> +                       wakeup-latency-us = <0xffffffff>;
>>
>> A value > 4294 seconds(i.e >1 hour) seems suspicious.
>> Are you working around the firmware issue with high latency value so
>> that it's never entered ? Why not remove advertising the state from DT.
>>
> 
> Haved checked with related colleagues, this node 'deep_sleep' was not for working
> around any firmware issue, but was a trick utilization of idle subsystem, and that

Really ? Any latency greater few milliseconds are sounds useless. I
still don't understand what you mean by "trick utilization of idle
subsystem".

> was definitely not elegant, the author indeed intendly didn't want CPU entered this
> state, I will remove this node therefore.

It's quick and dirty "HACK* to retain and advertise the state but
ensure it's never entered and obstruct the boot. It's not a trick to
exploit any idle subsystem utilization.

>  
>> Can you get me the dump of:
>> grep "" /sys/devices/system/cpu/cpu*/cpuidle/state*/{time,usage}
>>
> 
> FYI: https://www.irccloud.com/pastebin/XyEMLzfq/
> 

As expected, state3(deep_sleep) is never entered.

-- 
Regards,
Sudeep
