From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 18 Apr 2017 20:57:04 +0200
Subject: [PATCHv3 08/14] drivers/perf: arm_pmu: split cpu-local irq
 request/free
In-Reply-To: <20170418183316.GM17866@leverpostej>
References: <1491899997-32210-1-git-send-email-mark.rutland@arm.com>
 <1491899997-32210-9-git-send-email-mark.rutland@arm.com>
 <CAMuHMdVV4qMyYTYN92TE4fsrxo66WK-Gd001YbJZok2txOH4ig@mail.gmail.com>
 <20170418183316.GM17866@leverpostej>
Message-ID: <CAMuHMdVs+JQ3-Lj=TyN5Zi9fAhJROuc7upgFKmCwXVaA8eb1WQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Tue, Apr 18, 2017 at 8:33 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>> On Tue, Apr 11, 2017 at 10:39 AM, Mark Rutland <mark.rutland@arm.com> wrote:
>> > Currently we have functions to request/free all IRQs for a given PMU.
>> > While this works today, this won't work for ACPI, where we don't know
>> > the full set of IRQs up front, and need to request them separately.
>> >
>> > To enable supporting ACPI, this patch splits out the cpu-local
>> > request/free into new functions, allowing us to request/free individual
>> > IRQs.
>> >
>> > As this makes it possible/necessary to request a PPI once per cpu, an
>> > additional check is added to detect mismatched PPIs. This shouldn't
>> > matter for the DT / platform case, as we check this when parsing.
>> >
>> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
>> > Tested-by: Jeremy Linton <jeremy.linton@arm.com>
>> > Cc: Will Deacon <will.deacon@arm.com>
>>
>> This patch causes warnings during PSCI system suspend on R-Car Gen3.
>>
>> On R-Car M3-W (Dual CA57):
>>
>>     Disabling non-boot CPUs ...
>>    +IRQ15 no longer affine to CPU1
>>     CPU1: shutdown
>>     psci: CPU1 killed.
>>
>> On R-Car H3 (Quad CA57):
>>
>>     Disabling non-boot CPUs ...
>>    +IRQ15 no longer affine to CPU1
>>     CPU1: shutdown
>>     psci: CPU1 killed.
>>    +IRQ16 no longer affine to CPU2
>>     CPU2: shutdown
>>     psci: CPU2 killed.
>>    +IRQ17 no longer affine to CPU3
>>     CPU3: shutdown
>>     psci: CPU3 killed.
>>
>> Unfortunately it can't be reverted easily.
>>
>> Do you have any clue?
>
> Not presently. I'm somewhat surprised that this patch would have that
> effect -- I would imagine that the rework this is based on is more
> likely to. e.g. commit:
>
>   c09adab01e4aeecf ("drivers/perf: arm_pmu: split irq request from enable")

Bummer. You're right. It's actually due to that commit.

I searched in my gmail for a patch with the specific title, and blindly
replied to the first match, not noticing that was not the right patch.
Sorry for that.

> Just to check, you definitely don't see these warnings immediately prior
> to applying this patch?
>
> My best guess otherwise is that prior to this patch, the PMU IRQ
> request was failing earlier, and we bailed out.
>
> Can you dump a dmesg before and after this patch, and see if the arm_pmu
> driver dumps anything?

On R-Car Gen3, there's no change in PMU related messages.
Actual PMU messages are:

    hw perfevents: enabled with armv8_cortex_a57 PMU driver, 7
counters available
    hw perfevents: /soc/pmu_a53: failed to probe PMU!
    hw perfevents: /soc/pmu_a53: failed to register PMU devices!

The last two are due to the CA53 cores being described in DT, but not
enabled in the firmware.

On SH-Mobile AG5 (sh73a0/kzm9g), it recently (not due to the bad commit)
started printing:

   +hw perfevents: no interrupt-affinity property for /pmu, guessing.
    hw perfevents: enabled with armv7_cortex_a9 PMU driver, 7 counters available

which looks related.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
