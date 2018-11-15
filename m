From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Thu, 15 Nov 2018 23:46:55 +0100
Subject: [PATCH v2 0/2] clocksource/meson6_timer: implement ARM delay timer
Message-ID: <20181115224657.14736-1-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While trying to add support for the ARM TWD Timer and the ARM Global
Timer on Meson8, Meson8b and Meson8m2 (ARM Cortex-A5 and Cortex-A9 SoCs)
I did a review of the existing driver.
Unfortunately I found it hard to review because the pre-processor
#defines did not match the names from the public S805 datasheet. Thus
patch #1 adjusts these. No functional changes here, this is just
preparation work for patch #2.

Using the ARM Global Timer (drivers/clocksource/arm_global_timer.c)
would have given us a timer-based delay implementation (so udelay() and
friends would use the timer instead of using a loop-based delay
implementation). Unfortunately we can't use the ARM Global Timer yet
because it's input clock is derived from the CPU clock (which can change
once we enable CPU frequency scaling on these SoCs, for which I will be
sending patches in the near future).
Amlogic's 3.10 kernel uses Timer E as delay timer which (with the
current configuration) has a resolution of 1us. So patch #2 uses
register_current_timer_delay() to register Timer E as ARM delay timer
(which will be especially useful as we have to use udelay() when
changing the CPU clocks during DVFS).


Changes since v1 at [0]:
- convert the enums for the input clock (meson6_timera_input_clock and
  meson6_timere_input_clock) to simple #defines as these are register
  values and not something driver-internal. All other register values
  are #defines so it makes sense that these are #defines as well.


[0] https://patchwork.kernel.org/cover/10658591/


Martin Blumenstingl (2):
  clocksource: meson6_timer: use register names from the datasheet
  clocksource: meson6_timer: implement ARM delay timer

 drivers/clocksource/meson6_timer.c | 128 +++++++++++++++++++----------
 1 file changed, 85 insertions(+), 43 deletions(-)

-- 
2.19.1
