From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Fri, 13 Nov 2015 15:39:18 +0100
Subject: [PATCH] clocksource/drivers/tango-xtal: Replace code by
 clocksource_mmio_init
In-Reply-To: <5645F0D0.4060503@linaro.org>
References: <1447412292-841-1-git-send-email-daniel.lezcano@linaro.org>
 <5645D5A0.1000502@sigmadesigns.com> <5645F0D0.4060503@linaro.org>
Message-ID: <5645F616.9060707@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/11/2015 15:16, Daniel Lezcano wrote:
> On 11/13/2015 01:20 PM, Marc Gonzalez wrote:
>> On 13/11/2015 11:58, Daniel Lezcano wrote:
>>
>>> The current code to initialize, register and read the clocksource is
>>> already factored out in mmio.c via the clocksource_mmio_init function.
>>>
>>> Factor out the code with the clocksource_mmio_init function.
>>
>> The reason I didn't like clocksource_mmio_init() is because it exports
>> 4 generic accessors.
>>
>> I guess this function makes more sense when all platforms are using it,
>> in an ARCH_MULTIPLATFORM kernel. (Also the accessors are probably quite
>> small, so the waste is probably minimal.)
> 
> Right.
> 
>> In my opinion, defining struct clocksource_mmio with reg "outside"
>> struct clocksource leads to less efficient(1) and less clear(2) code.
>> 1) because of the padding from ____cacheline_aligned
>> 2) because of the container_of() gymnastics
> 
> I am not sure that would impact the cacheline.

I'm saying that, because of the alignment, the compiler has to make
"struct clocksource_mmio" bigger than a "struct clocksource" with one
more field, because of the padding required.

>> Should the reg field be considered "hot-path data"?
> 
> Yes.
> 
>> One problem with my patch: if some ports define CLKSRC_MMIO but
>> have lots of static struct clocksource, the extra reg field might
>> waste memory / worsen cache locality?
> 
> Yes. But the current situation is we have the base address always 
> defined in different drivers, so that won't change the situation too much.
> 
> The clocksource and the clock_event_device have some commons fields.
> 
> I am wondering if we can create a common structure for both containing 
> those fields and use them, as the network stack does with the routes, we 
> should have a common structure to deal with, without using the container of.
> 
> For example:
> 
> struct clockcommon {
> 	u32 mult;
> 	u32 shift;
> 	int rating;
> 	void __iomem *base;
> 	char *name;
> 	int irq;
> };
> 
> struct clocksource {
> 	struct clockcommon common; /* MUST be the first field */
> 	cycle_t (*read)(struct clocksource *cs);
> 	cycle_t mask;
> 	...
> };

According to my notes, commit 369db4c952 grouped hot-path data
into a single cache line (hence ____cacheline_aligned).

(AFAIR, ARMv7 ARCH_MULTIPLATFORM assumes CACHE_LINE=64)

Not sure how to make the two concepts (common base struct and
grouping hot data) play nicely, without wasting a lot of space
on padding.


> struct clockevent {
> 	struct clockcommon common; /* MUST be the first field */
> 	ktime_t next_event;
> 	...
> };
> 
> int clocksource_init(struct clockcommon *clock)
> {
> 	struct clocksource *clksrc = (struct clocksource *)clock;
> }
> 
> int clockevent_init(struct clockcommon *clock)
> {
> 	struct clockevent *clkevt = (struct clockevent *)clock;
> }
> 
> Hence we have the base address for both and we can remove the base@ from 
> all the drivers.
> 
> The good thing with the mmio is, as you mentioned, instead of having 
> multiple clocksource structure defined, we have just one allocated at 
> init time. The rest falls in the __init section and unloaded.
> 
> This approach is valid for the multiplatform and I believe all SoC will 
> migrate to it.
> 
>> Also, maybe the fields should be copied in ascending order?
