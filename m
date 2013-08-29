From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Thu, 29 Aug 2013 10:53:07 -0700
Subject: [PATCH RFC 0/3] clocksource/cadence_ttc: Handle frequency changes
Message-ID: <1377798790-28927-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I've asked Thomas and John before, what to do about a clocksource with
variable input frequency. It looks like the easiest and probably also
best solution is to just not use a timer with a variable frequency - as
John suggested.

I thought another option to get around removing this feature might be
to use clock notifiers and updating the timer's prescaler on the fly.
But that seems to become messy really fast and causes more problems in
cases multiple clocksources are available, since the clock notifier
might impose the driver's restrictions on the input clock, although it
is not even the currently used clocksource.

I have sketched out both approaches in two series.

The first one, which should directly follow this email, is to introduce
a new flag in the driver's DT bindings, which marks the input clock as
'unstable'. In case this flag is present, the timer does not register
itself as clocksource (and not as sched_clock either, of course).
The clockevent feature is not affected.

The second approach uses clock and PM notifiers to adjust the timer's
pre-scaler on frequency changes. As mentioned above, I didn't see a way
to find out whether the timer is the current clock source to not enforce
restrictions in case it is not.

I'm actually not fully convinced of either approach. So, please let me
know of better solutions, or how to make either approach acceptable.
If everything works well, I send out the second series as reply to this
cover letter. I have both series listed below. Both are based on
tip/timers/core.

	Thanks,
	S?ren


Approach 1, don't register as clocksource:
Soren Brinkmann (3):
  clocksource/cadence_ttc: Remove clocksource clock notifier
  clocksource/cadence_ttc: Make clocksource optional
  arm: dt: zynq: Mark TTC input clock as unstable

 .../bindings/timer/cadence,ttc-timer.txt           |  4 ++
 arch/arm/boot/dts/zynq-7000.dtsi                   |  2 +
 drivers/clocksource/cadence_ttc_timer.c            | 47 +---------------------
 3 files changed, 8 insertions(+), 45 deletions(-)

Approach 2, use notifiers to adjust:
Soren Brinkmann (1):
  clocksource/cadence_ttc: Overhaul clocksource frequency adjustment

 drivers/clocksource/cadence_ttc_timer.c | 141 +++++++++++++++++++++++++++-----
 1 file changed, 121 insertions(+), 20 deletions(-)

-- 
1.8.4
