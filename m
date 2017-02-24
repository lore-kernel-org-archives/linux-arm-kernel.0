From: anurupvasu@gmail.com (Anurup M)
Date: Fri, 24 Feb 2017 08:41:10 +0530
Subject: [PATCH v4 08/11] drivers: perf: hisi: use poll method to avoid
 L3C counter overflow
In-Reply-To: <20170221120927.GF300@arm.com>
References: <1487530263-42643-1-git-send-email-anurup.m@huawei.com>
 <20170220110942.GF9003@leverpostej> <20170221120927.GF300@arm.com>
Message-ID: <58AFA44E.2060401@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 21 February 2017 05:39 PM, Will Deacon wrote:
> On Mon, Feb 20, 2017 at 11:09:43AM +0000, Mark Rutland wrote:
>> On Sun, Feb 19, 2017 at 01:51:03PM -0500, Anurup M wrote:
>>> The L3 cache PMU use N-N SPI interrupt which has no support
>>> in kernel mainline.
>> Could you elaborate on what you mean by this?
>>
>> I don't understand what is meant here. How exactly are the interrupts
>> wired up in HW, and what exactly is not supported by Linux?
>>
>>> So use hrtimer to poll and update event
>>> counter to avoid overflow condition for L3 cache PMU.
>>> A interval of 10 seconds is used for the hrtimer.
>>> The time interval can be configured in the sysfs.
>> I'm not too keen on giving userspace the ability to control this, since
>> it gives an awful lot of rope for userspace to tie around itself.
> Agreed. I'd also go a step further and say that for PMUs with either
> terminally broken interrupts (like this one) or just missing interrupts
> (like the CPU PMU on raspberry pi iirc), then the perf core should take
> care of an hrtimer in an attempt to generate samples often enough. We
> already have PERF_PMU_CAP_NO_INTERRUPT, but it currently just disables
> sampling events.
>
> The fiddly part is knowing how to program the timer, and I think you'd
> need the PMU driver to provide an upper-bound on events per nanosecond.
> I'm pretty sure that would be highly unreliable (especially for shared
> resources such as the L3), at which point, is it worth the hassle?

Agreed, it is difficult for user to arrive at a interval for the shared 
resource
like L3 cache. So I shall remove this facility exposed to user.

Shall use a realistic and safer upper bound as hrtimer interval for the 
uncore
units which do not support IRQ.

Thanks,
Anuurp

> Will
