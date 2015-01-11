From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 11 Jan 2015 12:40:05 +0100
Subject: [PATCH 0/5] clocksource: sun5i: Support parent clock rate changes
Message-ID: <1420976410-7826-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The Allwinner HS timers have the AHB clock as their parent
clock. Since this clock is shared with other devices, we could very
well have another driver requesting a rate change of that clock,
making our timer change frequency at the same time.

This is especially true on the A31, where the DMA controller needs to
do such a rate change, making the HS timer unreliable at the time on
the A31.

This serie makes some cleanups and implements clock notifiers to be
able to reflect such rate changes and make sure that the timer is
always working.

Maxime

Maxime Ripard (5):
  clocksource: sun5i: Switch to request_irq
  clocksource: sun5i: Use of_io_request_and_map
  clocksource: sun5i: Remove sched_clock
  clocksource: sun5i: Refactor the current code
  clocksource: sun5i: Add clock notifiers

 drivers/clocksource/timer-sun5i.c | 306 +++++++++++++++++++++++++++++---------
 1 file changed, 232 insertions(+), 74 deletions(-)

-- 
2.2.1
