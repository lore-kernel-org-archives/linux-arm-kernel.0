From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 18 Apr 2017 19:33:16 +0100
Subject: [PATCHv3 08/14] drivers/perf: arm_pmu: split cpu-local irq
 request/free
In-Reply-To: <CAMuHMdVV4qMyYTYN92TE4fsrxo66WK-Gd001YbJZok2txOH4ig@mail.gmail.com>
References: <1491899997-32210-1-git-send-email-mark.rutland@arm.com>
 <1491899997-32210-9-git-send-email-mark.rutland@arm.com>
 <CAMuHMdVV4qMyYTYN92TE4fsrxo66WK-Gd001YbJZok2txOH4ig@mail.gmail.com>
Message-ID: <20170418183316.GM17866@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 18, 2017 at 07:25:28PM +0200, Geert Uytterhoeven wrote:
> Hi Mark,

Hi Geert,

> On Tue, Apr 11, 2017 at 10:39 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> > Currently we have functions to request/free all IRQs for a given PMU.
> > While this works today, this won't work for ACPI, where we don't know
> > the full set of IRQs up front, and need to request them separately.
> >
> > To enable supporting ACPI, this patch splits out the cpu-local
> > request/free into new functions, allowing us to request/free individual
> > IRQs.
> >
> > As this makes it possible/necessary to request a PPI once per cpu, an
> > additional check is added to detect mismatched PPIs. This shouldn't
> > matter for the DT / platform case, as we check this when parsing.
> >
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Tested-by: Jeremy Linton <jeremy.linton@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> 
> This patch causes warnings during PSCI system suspend on R-Car Gen3.
> 
> On R-Car M3-W (Dual CA57):
> 
>     Disabling non-boot CPUs ...
>    +IRQ15 no longer affine to CPU1
>     CPU1: shutdown
>     psci: CPU1 killed.
> 
> On R-Car H3 (Quad CA57):
> 
>     Disabling non-boot CPUs ...
>    +IRQ15 no longer affine to CPU1
>     CPU1: shutdown
>     psci: CPU1 killed.
>    +IRQ16 no longer affine to CPU2
>     CPU2: shutdown
>     psci: CPU2 killed.
>    +IRQ17 no longer affine to CPU3
>     CPU3: shutdown
>     psci: CPU3 killed.
> 
> Unfortunately it can't be reverted easily.
> 
> Do you have any clue?

Not presently. I'm somewhat surprised that this patch would have that
effect -- I would imagine that the rework this is based on is more
likely to. e.g. commit:

  c09adab01e4aeecf ("drivers/perf: arm_pmu: split irq request from enable")

Just to check, you definitely don't see these warnings immediately prior
to applying this patch?

My best guess otherwise is that prior to this patch, the PMU IRQ
request was failing earlier, and we bailed out.

Can you dump a dmesg before and after this patch, and see if the arm_pmu
driver dumps anything?

Thanks,
Mark.
