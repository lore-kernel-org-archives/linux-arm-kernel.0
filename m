From: james.morse@arm.com (James Morse)
Date: Fri, 04 Aug 2017 17:57:15 +0100
Subject: [PATCH 0/3] interrupted single step fixes
In-Reply-To: <515dfb90-5313-fe6c-673b-a25da43e186e@redhat.com>
References: <20170803151533.29438-1-james.morse@arm.com>
 <515dfb90-5313-fe6c-673b-a25da43e186e@redhat.com>
Message-ID: <5984A76B.4040807@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pratyush,

On 04/08/17 13:49, Pratyush Anand wrote:
> On Thursday 03 August 2017 08:45 PM, James Morse wrote:
>> Enable CONFIG_SAMPLE_HW_BREAKPOINT, then:
>>> insmod data_breakpoint.ko ksym=__sysrq_enabled
>>> cat /proc/sys/kernel/sysrq
>> With mainline you will hit the watchpoint forever, Pratyush's patches
>> reduce this to ~10 times. These patches reduce that to the expected
>> once.
> 
> So, when you say that it reduce to ~10 times with my patches, did you use all
> patches ie 1-4 or only 1-3. 1-3 is just the preparation and 4 was my actual
> solution. I had seen only once (which is expected) with all(1-4) of my patches.

Yes, your patches 1-3 were fixing <something> in perf to cause us to step the
watchpoint, and 4&5 disabled/re-enabled IRQs in the interrupted context when we
do the step.


> In my understanding, you have used 1-3 of mine and then replaced my 4th patch
> with your patches in this series.If I understood correctly then, now we can
> handle IRQ between breakpoint and step handler, I think thats good.

For use with your example, yes, but I think these fix the existing
hwbreakpoint/kgdb users. (unless none of this has ever worked?)

(I still haven't put together a test for kgdb)


> Only concern
> seems that how does this approach behave when we put a hardware breakpoint on a
> ISR called between breakpoint and step exception.

Yes, this won't work because the IRQ:breakpoint occurs while the debug hardware
is already in use to step the first breakpoint. (but this only works today
because we take breakpoints 10s of times)

It looks like this is an important use-case for perf... this is more complicated
than just surviving an IRQ during single step.

I think ignore these patches, I'll try and come up with a way to get that
'nested' case working too. Will's suggestion of separating what we do for perf
and user space may make this easier[0].



Thanks,

James


[0] https://www.spinics.net/lists/arm-kernel/msg594339.html
