From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 20 Apr 2017 20:10:22 +0100
Subject: [PATCHv3 08/14] drivers/perf: arm_pmu: split cpu-local irq
 request/free
In-Reply-To: <CAMuHMdVs+JQ3-Lj=TyN5Zi9fAhJROuc7upgFKmCwXVaA8eb1WQ@mail.gmail.com>
References: <1491899997-32210-1-git-send-email-mark.rutland@arm.com>
 <1491899997-32210-9-git-send-email-mark.rutland@arm.com>
 <CAMuHMdVV4qMyYTYN92TE4fsrxo66WK-Gd001YbJZok2txOH4ig@mail.gmail.com>
 <20170418183316.GM17866@leverpostej>
 <CAMuHMdVs+JQ3-Lj=TyN5Zi9fAhJROuc7upgFKmCwXVaA8eb1WQ@mail.gmail.com>
Message-ID: <20170420191022.GB9795@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 18, 2017 at 08:57:04PM +0200, Geert Uytterhoeven wrote:
> On Tue, Apr 18, 2017 at 8:33 PM, Mark Rutland <mark.rutland@arm.com> wrote:

> > I'm somewhat surprised that this patch would have that
> > effect -- I would imagine that the rework this is based on is more
> > likely to. e.g. commit:
> >
> >   c09adab01e4aeecf ("drivers/perf: arm_pmu: split irq request from enable")
> 
> Bummer. You're right. It's actually due to that commit.

Ok; I understand what's happening, then.

FWIW, the warnings are benign, albeit annoying.

I'll have a go at cleaning this up.

> I searched in my gmail for a patch with the specific title, and blindly
> replied to the first match, not noticing that was not the right patch.
> Sorry for that.

No worries.

> On R-Car Gen3, there's no change in PMU related messages.
> Actual PMU messages are:
> 
>     hw perfevents: enabled with armv8_cortex_a57 PMU driver, 7
> counters available
>     hw perfevents: /soc/pmu_a53: failed to probe PMU!
>     hw perfevents: /soc/pmu_a53: failed to register PMU devices!
> 
> The last two are due to the CA53 cores being described in DT, but not
> enabled in the firmware.

Ok. 

> On SH-Mobile AG5 (sh73a0/kzm9g), it recently (not due to the bad commit)
> started printing:
> 
>    +hw perfevents: no interrupt-affinity property for /pmu, guessing.
>     hw perfevents: enabled with armv7_cortex_a9 PMU driver, 7 counters available
> 
> which looks related.

That's stating that the DTB doesn't provide a interrupt-affinity
property for the PMU nodem so the affinity is guessed based on the
logical CPU ordering, which is dodgy.

I can see that's missing in arch/arm/boot/dts/sh73a0.dtsi.

That should be easy to fix up, as per
arch/arm64/boot/dts/renesas/r8a7795.dtsi, assuming you're aware of which
IRQ corresponds to which CPU.

Thanks,
Mark.
