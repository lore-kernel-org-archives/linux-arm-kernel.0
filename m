From: slash.tmp@free.fr (Mason)
Date: Fri, 27 Mar 2015 14:45:13 +0100
Subject: Cache line size definition in arch/arm/mm/Kconfig
In-Reply-To: <20150327120601.GB4019@n2100.arm.linux.org.uk>
References: <5512C7A4.3000302@free.fr> <5515423E.4020802@free.fr>
 <20150327120601.GB4019@n2100.arm.linux.org.uk>
Message-ID: <55155EE9.6020600@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/03/2015 13:06, Russell King - ARM Linux wrote:
> On Fri, Mar 27, 2015 at 12:42:54PM +0100, Mason wrote:
>> On 25/03/2015 15:35, Mason wrote:
>>
>>> AFAICT, L1 cache line size is specified in arch/arm/mm/Kconfig
>>>
>>> config ARM_L1_CACHE_SHIFT_6
>>>      bool
>>>      default y if CPU_V7
>>>      help
>>>        Setting ARM L1 cache line size to 64 Bytes.
>>>
>>> config ARM_L1_CACHE_SHIFT
>>>      int
>>>      default 6 if ARM_L1_CACHE_SHIFT_6
>>>      default 5
>>>
>>>
>>> I'm using a Cortex A9 MPCore. If I'm not mistaken, the cache line size
>>> is 32 bytes, even though this CPU is ARMv7.
>>>
>>> http://infocenter.arm.com/help/topic/com.arm.doc.ddi0388g/Caccifbd.html
>>>
>>>> The Cortex-A9 processor has separate instruction and data caches.
>>>> The caches have the following features:
>>>>
>>>>   Each cache can be disabled independently. See System Control Register.
>>>>   Both caches are 4-way set-associative.
>>>>   The cache line length is eight words.
>>>>   On a cache miss, critical word first filling of the cache is performed.
>>>>   You can configure the instruction and data caches independently during implementation to sizes of 16KB, 32KB, or 64KB.
>>>>   To reduce power consumption, the number of full cache reads is reduced by taking advantage of the sequential nature of many cache operations. If a cache read is sequential to the previous cache read, and the read is within the same cache line, only the data RAM set that was previously read is accessed.
>>>
>>> How do I set ARM_L1_CACHE_SHIFT_6 to 'n' in my platform Kconfig?
>>>
>>> Or perhaps I should "override" ARM_L1_CACHE_SHIFT to 5 (again in
>>> my platform Kconfig). I don't know the syntax to do that.
>>>
>>> Could someone point out the correct way?
>>
>> Would someone care to comment? :-)
>
> No :)

I'm glad that you've decided to disagree with yourself! :-)

> What you've found is the _static_ L1 cache line size setting, which is
> used at _compile_ time to align structures while building.  To allow
> maximum flexibility - and because there are 64-byte cache line ARMv7
> implementations around - we have decided that the _compile time_
> cache line size will be 64 bytes.

Right, I had a complete brain malfunction there. Compiler needs to be
told the cache line size to properly align relevant objects.

> As far as cache operations are concerned, they will know the correct
> cache line size for the CPU which they're running on, so the code
> will adapt.
>
> It has the side effect that some allocators also assume that the L1
> cache line size is 64 bytes.
>
> It's better to have a larger than necessary cache line size than a
> smaller one, because a larger one is automatically aligned to the
> smaller sizes.
>
> In other words, this is totally intentional.

I don't understand why I should not override ARM_L1_CACHE_SHIFT to 5
in my platform-specific Kconfig, since I know I have a 32-byte cache
line size?


Oh and while I have your attention ;-) I have alignment-related
questions about clocksource_mmio_init() (commit 442c8176d2) wrt
Thomas Gleixner's 369db4c952 patch. (I think the two patches
do not play nice.)

369db4c952 moved some struct clocksource fields around to group
hot fields in a single cache line at the beginning of the struct,
and marked the struct as cache aligned. This works as expected
with static structures.

However, I don't think it works as expected with dynamically
allocated struct clocksource. It seems to me (and I may very
well be wrong!) that struct clocksource_mmio should have the
clksrc field at the beginning of the struct, and we should
use an allocation function that returns cache aligned memory?

struct clocksource_mmio {
	struct clocksource clksrc;
	void __iomem *reg;
};

   cs = kmagic_cache_alloc(sizeof *cs, GFP_KERNEL);

That way clksrc would effectively be cache aligned, right?


One thing that caught me off-guard: when CONFIG_ARCH_CLOCKSOURCE_DATA
and CONFIG_CLOCKSOURCE_WATCHDOG are undefined, struct clocksource
weighs 80 bytes on a 32-bit system. I would expect the "reg" field
at the end to "fit in the hole", but in fact, gcc seems to "stretch"
struct clocksource before considering other fields. This may be a
bug in gcc's extension?

Regards.
