From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Fri, 27 Jan 2012 14:05:53 +0000
Subject: oprofile and ARM A9 hardware counter
In-Reply-To: <20120127135646.GE2347@mudshark.cambridge.arm.com> (Will Deacon's
 message of "Fri, 27 Jan 2012 13:56:46 +0000")
References: <CAMsRxfLcO0eM8mkKUZcR8X6SG-MMRFasRK7hQCT-3-NuKN_+1g@mail.gmail.com>
 <CACVXFVPDdyKf5TffT4OMt+tKeB09TU2RcvcyBV45hAK0qw+GEg@mail.gmail.com>
 <CAMsRxfJK9kcFkV=itJHpzuOXoZQkmjj1wh8Y789D3iOVstPMyQ@mail.gmail.com>
 <CAMsRxfKPm0dEaKDeSZQ=6jkpo4MeS=0XF6TsCj+BV54WbW_LtA@mail.gmail.com>
 <CACVXFVMgk7ykSX3GjzCNvUU0zMzNvGGuZMBpxBf7NRVk9EM7ig@mail.gmail.com>
 <CAMsRxfJWjwznJYujSvr0DfhNxtnJDVdfjXXpx34HUDBRtMvjqw@mail.gmail.com>
 <20120127121311.GB2347@mudshark.cambridge.arm.com>
 <yw1x1uqlnw1o.fsf@unicorn.mansr.com>
 <20120127132826.GD2347@mudshark.cambridge.arm.com>
 <yw1xwr8dmf56.fsf@unicorn.mansr.com>
 <20120127135646.GE2347@mudshark.cambridge.arm.com>
Message-ID: <yw1xsjj1me9q.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will Deacon <will.deacon@arm.com> writes:

> On Fri, Jan 27, 2012 at 01:47:01PM +0000, M?ns Rullg?rd wrote:
>> Will Deacon <will.deacon@arm.com> writes:
>> 
>> > Mans,
>> >
>> > On Fri, Jan 27, 2012 at 12:56:35PM +0000, M?ns Rullg?rd wrote:
>> >> Will Deacon <will.deacon@arm.com> writes:
>> >> > Did this lead anywhere in the end? It seems as though Ming Lei has a working
>> >> > setup but Stephane is unable to replicate it, despite applying the necessary
>> >> > patches and trying an updated bootloader.
>> >> 
>> >> With the patches listed above plus the one in [1], I get PMU interrupts.
>> >> However, unless I restrict the profiled process to one CPU
>> >> (taskset 1 perf record ...), I get a panic in armpmu_event_update() with
>> >> the 'event' argument being null when called from armv7pmu_handle_irq().
>> >> 
>> >> [1] http://article.gmane.org/gmane.linux.ports.arm.omap/69696
>> >
>> > Great, thanks for trying this out. Which version of the kernel were you
>> > using? I fixed a bunch of NULL pointer derefs. during the 3.2 window, but if
>> > you were using an -rc kernel you have have hit one of them.
>> 
>> This was with the Linaro tilt-3.2 kernel from
>> git://git.linaro.org/landing-teams/working/ti/kernel.git, commit
>> 73e2c294444f209d281f7cd10b52b53b087e74f1.  Maybe one of the many patches
>> it has on top of 3.2 is to blame.
>
> Perhaps, or (more likely) the interrupt affinity for the CTI isn't working
> properly and the interrupt is always delivered to CPU0. I'll keep this in
> mind in case we get any more reports like this.

It works whichever CPU I pin it to (i.e. taskset 2 also works).

FWIW, my /proc/interrupts looks like this when perf is running:

           CPU0       CPU1
 29:   25238127    1409121       GIC  twd
 33:    4586197          0       GIC  arm-pmu
 34:          0    4744550       GIC  arm-pmu
 39:          0          0       GIC  TWL6030-PIH
 41:          0          0       GIC  l3-dbg-irq
 42:          0          0       GIC  l3-app-irq
 43:          0          0       GIC  prcm
 44:        141          0       GIC  DMA
[...]

-- 
M?ns Rullg?rd
mans at mansr.com
