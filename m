From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 24 Apr 2014 10:00:14 -0700
Subject: [PATCH v6 0/6] ARM: vdso gettimeofday using generic timer
 architecture
In-Reply-To: <535876D1.8040609@mentor.com>
References: <cover.1398213562.git.nathan_lynch@mentor.com>
 <53581865.2020601@codeaurora.org> <535876D1.8040609@mentor.com>
Message-ID: <5359431E.8050108@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/23/14 19:28, Nathan Lynch wrote:
> On 04/23/2014 02:45 PM, Stephen Boyd wrote:
>> On 04/22/14 17:48, Nathan Lynch wrote:
>>> Provide fast userspace implementations of gettimeofday and
>>> clock_gettime on systems that implement the generic timers extension
>>> defined in ARMv7.  This follows the example of arm64 in conception but
>>> significantly differs in some aspects of the implementation (C vs
>>> assembly, mainly).
>>>
>>> Clocks supported:
>>> - CLOCK_REALTIME
>>> - CLOCK_MONOTONIC
>>> - CLOCK_REALTIME_COARSE
>>> - CLOCK_MONOTONIC_COARSE
>>>
>>> This also provides clock_getres (as arm64 does).
>>>
>>> Note that while the high-precision realtime and monotonic clock
>>> support depends on the generic timers extension, support for
>>> clock_getres and coarse clocks is independent of the timer
>>> implementation and is provided unconditionally.
>> I think we'll need to rename the clocksource in arch_timer.c if we only
>> have an mmio architected timer to something like arch_mem_counter.
> I guess ARMv7 would allow you to have mmio without cp15 (AFAIK ARMv8
> does not).  I don't see any dts in arch/arm that contains an
> arm,armv7-timer-mem node without an arm,armv7-timer node, though.

I only know of an ARMv7 device that is like this but the support for it
isn't in linus' tree.

> If this is a practical concern, I think using
> CONFIG_ARCH_CLOCKSOURCE_DATA is perhaps a better way to communicate
> whether cp15 access is available.  That's how the x86 vdso, for example,
> decides between using HPET vs TSC etc.
>

I don't quite follow why it's any better than changing the string
because we only really care about using cp15. If we cared about using
cp15 vs mmio it might make sense.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
