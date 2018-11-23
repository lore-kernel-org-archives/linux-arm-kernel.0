From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Fri, 23 Nov 2018 20:40:28 +0100
Subject: [PATCH v2 0/2] clocksource/meson6_timer: implement ARM delay timer
In-Reply-To: <a83b92fb-5950-01b8-521d-7b05939dce3a@linaro.org>
References: <20181115224657.14736-1-martin.blumenstingl@googlemail.com>
 <5ff1a888-cce2-8fd8-a98e-14c3d7c33acf@linaro.org>
 <CAFBinCDSLEAzJVVgFxKhN3LCUwgC3Rrr=4ZhtHCdvqEPBLWbJA@mail.gmail.com>
 <a83b92fb-5950-01b8-521d-7b05939dce3a@linaro.org>
Message-ID: <CAFBinCA+htBGeT3SfTdCivmKpq3bBF7vAvR-OWqnwO-rgXx22w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2018 at 7:15 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 22/11/2018 23:12, Martin Blumenstingl wrote:
> > Hi Daniel,
> >
> > On Sun, Nov 18, 2018 at 2:27 AM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 15/11/2018 23:46, Martin Blumenstingl wrote:
> >>> While trying to add support for the ARM TWD Timer and the ARM Global
> >>> Timer on Meson8, Meson8b and Meson8m2 (ARM Cortex-A5 and Cortex-A9 SoCs)
> >>> I did a review of the existing driver.
> >>> Unfortunately I found it hard to review because the pre-processor
> >>> #defines did not match the names from the public S805 datasheet. Thus
> >>> patch #1 adjusts these. No functional changes here, this is just
> >>> preparation work for patch #2.
> >>>
> >>> Using the ARM Global Timer (drivers/clocksource/arm_global_timer.c)
> >>> would have given us a timer-based delay implementation (so udelay() and
> >>> friends would use the timer instead of using a loop-based delay
> >>> implementation). Unfortunately we can't use the ARM Global Timer yet
> >>> because it's input clock is derived from the CPU clock (which can change
> >>> once we enable CPU frequency scaling on these SoCs, for which I will be
> >>> sending patches in the near future).
> >>> Amlogic's 3.10 kernel uses Timer E as delay timer which (with the
> >>> current configuration) has a resolution of 1us. So patch #2 uses
> >>> register_current_timer_delay() to register Timer E as ARM delay timer
> >>> (which will be especially useful as we have to use udelay() when
> >>> changing the CPU clocks during DVFS).
> >>>
> >>>
> >>> Changes since v1 at [0]:
> >>> - convert the enums for the input clock (meson6_timera_input_clock and
> >>>   meson6_timere_input_clock) to simple #defines as these are register
> >>>   values and not something driver-internal. All other register values
> >>>   are #defines so it makes sense that these are #defines as well.
> >>>
> >>>
> >>> [0] https://patchwork.kernel.org/cover/10658591/
> >>>
> >>>
> >>> Martin Blumenstingl (2):
> >>>   clocksource: meson6_timer: use register names from the datasheet
> >>>   clocksource: meson6_timer: implement ARM delay timer
> >>>
> >>>  drivers/clocksource/meson6_timer.c | 128 +++++++++++++++++++----------
> >>>  1 file changed, 85 insertions(+), 43 deletions(-)
> >>
> >> Both applied, thanks!
> > thank you for taking my patches
> >
> > I have one question more: can you please push these patches to a
> > repository/branch which is included in -next?
> > I'm asking because I'd like to send patches that enable CPU frequency
> > scaling on Meson8, Meson8b and Meson8m2. The code to change the CPU
> > clock calls udelay(), which (in this special case) needs a delay timer
> > to work properly (we can't use jiffies as we're using udelay() *while*
> > changing the CPU clock).
>
> branch pushed [1], should appear in linux-next very soon.
awesome, thank you!


Regards
Martin
