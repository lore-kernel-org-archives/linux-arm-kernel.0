From: klimov.linux@gmail.com (Alexey Klimov)
Date: Tue, 28 Jul 2015 17:20:01 +0300
Subject: [RFC PATCH 0/3] clocksource: exynos_mct: allow mct to use 64-bit
 counter from coprocessor
In-Reply-To: <20150728130225.GB15213@leverpostej>
References: <1438032507.17734.46.camel@gmail.com>
 <20150728130225.GB15213@leverpostej>
Message-ID: <CALW4P++9dgHcFStP4f8Y1oifWjNm6SUNRZJbF4OJXNqZQz=Hyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 28, 2015 at 4:02 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Mon, Jul 27, 2015 at 10:28:27PM +0100, Alexey Klimov wrote:
>> Hi all,
>>
>> year(s) ago it was discovered that MCT timer and ARM architectured
>> timer
>> are the same hardware with different interface. Here [1].
>
> Are they actually interfaces to the same timer, or are they just fed by
> the same system counter?

Good question goes to Samsung maintainers.
I can find unanswered mail thread:
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/258576.html
Let me quote Kukjin: " Basically the two blocks are connected and the
arch timer uses the count value from MCT for reference"

>> I followed mail-list discussions about removing MCT and using arch
>> timer for Exynos5-based SoCs but things aren't moving at least latest
>> upstream kernel on odroid-xu3 will use MCT as default timers.
>> Maybe the reason are some power-management related things that very
>> specific to Samsung. I don't know.
>>
>>
>> Idea of this draft patchset comes from Doug patches when he tried to
>> optimize read of 64-bit counter located in mmio. [2]
>> Why not using cp15 counter instead if possible?
>
> If they're the same device, then you can simply use the architected
> timer, and gain all the benefits without additional code. That could
> give you additional benefits (e.g. VDSO support).

Right. I like the idea to use arch_timer. Odroid-xu3 works fine with it.
Looks like Samsung have some games with power management stuff that
can't be opened/told and they use MCT that works well for their needs.
This draft patchset is only about little speedup of MCT operations
that still here and used.

To start arch timer we may need to initialize G_TCON register in MCT
like it's done in Xen:
http://xenbits.xen.org/gitweb/?p=xen.git;a=blob;f=xen/arch/arm/platforms/exynos5.c;h=79e3a5faf9fa6f37d99040f85c6dccbd9312c856;hb=HEAD
in exynos5_init_time(). I guess not all bootloaders properly
initialize MCT on Exynos5 boards.

If addition of similar platform callback and enable of arch_timer are
steps in right direction I can take a look on it.
Or as suggested in one mail thread: if MCT is present in DT then MCT
driver lookup arch_timer in dt, find it, initialize G_TCON reg and
gives up to allow arch_timer to do it job (in that case we need to
init MCT before arch timer).

>> Previous numbers for 1000000 gettimeofday() calls from userspace
>> are about 1 ms. With this patches we have 0.5 ms or even better.
>> So twice as fast.
>>
>> Just as matter of interest i tried to perform 2000000 sched_yield()
>> calls from userspace. I see around 20% speedup with patches applied.
>>
>> I tried to use hackbench but it's hard to feel the difference, maybe
>> speedup is 0.5% but with bad fluctuation.
>>
>> Everything is tested on odroid-xu3.
>> Looks like Cortex-A9 based Samsung SoCs (odroid-u2, odroid-x) don't
>> have arch timer.
>>
>> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014
>> -May/256943.html
>> [2] https://lkml.org/lkml/2014/6/20/431
>>
>>
>>
>> Current code created with such assumptions:
>> -- don't want to insert huge refactoring in MCT code;
>> -- target platform only ARMv7 Exynos5-based SoC that works in 32-bit
>> mode so i don't want to build described functionality on ARM64.
>
> For arm64 the generic timer is mandatory, and I can't imagine a case
> where we wouldn't use it in preference.

Yep. That's why probably MCT isn't used on arm64.

>> Currently i'm trying to patch odroid-xu3 DT only.
>> -- firmware on odroid-xu3 is broken and secondary cores start
>> in SVC mode instead of HYP mode. Maybe i can remove check for hyp mode;
>> -- in addition instead of DT property I may parse PFR regs and find
>> Generic Timer Extension there.
>
> ID_PFR1.GenTimer only tells you whether or not the generic timer is
> implemented in the CPU, not how it's wired up (e.g. whether it shares
> the system counter with the MCT), so I don't think it tells you anything
> useful.
>
> Thanks,
> Mark.

Yep, just only one of the initial points to understand is it any use trying.
Thanks.

Best regards,
Klimov Alexey
