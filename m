From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 17 Oct 2018 14:36:21 +0200
Subject: [PATCH v2 3/6] clocksource: exynos_mct: Add arch_timer
 cooperation mode for ARM64
In-Reply-To: <20181015132652.3vanslay7xomtzqh@lakrids.cambridge.arm.com>
References: <20181015123112.9379-1-m.szyprowski@samsung.com>
 <CGME20181015123135eucas1p16a10ed68040141a714ab2977e2ad5e2d@eucas1p1.samsung.com>
 <20181015123112.9379-4-m.szyprowski@samsung.com>
 <20181015132652.3vanslay7xomtzqh@lakrids.cambridge.arm.com>
Message-ID: <20181017123622eucas1p14654c89a8590fd094d638b60ab9af8f0~eZY3j27rs0422004220eucas1p1M@eucas1p1.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 2018-10-15 15:26, Mark Rutland wrote:
> On Mon, Oct 15, 2018 at 02:31:09PM +0200, Marek Szyprowski wrote:
>> To get ARM Architected Timers working on Samsung Exynos SoCs, one has to
>> first configure and enable Exynos Multi-Core Timer, because they both
>> share some common hardware blocks.
> Could you please elaborate on what exactly is shared with the MCT?
>
> Architecturally, the OS shouldn't have to do anything to put the timers
> into a usable state. All instances should be fed (directly) from the
> system counter, which FW is tasked with configuring and enabling, and
> all other state is private to the instance.
>
> If we have to poke things to make them usable, that means we can't
> assume that it's always safe to use the timers or counters, as the
> architecture lets us, and I'd like to understand what the impact is.
>
> e.g. does this mean that there are windows where the counters don't
> tick?

Good question is always a helpful advice. I don't have such hardware
details and I've did my patches basing on what I've observed while
playing with the hardware.

I've checked again and I found that the only things that need to be
done to get ARM arch timer working are:

1. enable multi core timer clock,
2. set MCT_G_TCON_START (Timer enable) bit in MCT_G_TCON (Global timer
control) register.

Otherwise arch timer doesn't get any tick.

Changing CPUHP priorities nor any other MCT register writes are not
needed. It looks that they were leftovers from my older approaches
and I've kept them without really checking if they are needed in the
final version.

I will send a new simplified version of this patchset then.

> Are all the counters fed the same underlying counter value? ... or are
> those independent?

My summary above suggests that ARM architected timers are fed from the
physical counter, which is controlled by MCT registers.

> ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
