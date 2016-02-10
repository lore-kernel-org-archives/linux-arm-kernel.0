From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Tue,  9 Feb 2016 22:54:24 -0300
Subject: [PATCH v2 0/3] lpc32xx clockevent: Support periodic mode and ARM
 delay timer
Message-ID: <1455069267-4784-1-git-send-email-ezequiel@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset introduces periodic timer mode. As was discussed on v1,
the current implementation (MR0=1, PR=ticks) is not suitable for
implementing a periodoc timer mode.

This can be seen with a very simple test, by counting the number of
interrupts during 1-second.

Implementing the periodic timer mode with MR0=1, PR=ticks_per_jiffy
results in half the expected number of interrupts (CONFIG_HZ=100):

(See: http://git.infradead.org/users/ezequielg/linux/shortlog/refs/heads/lpc32xx_periodic_with_pr)

$ cat /proc/interrupts | grep clockevent && sleep 1 && cat /proc/interrupts | grep clockevent
 16:        846  nvic_irq  13 Edge      lpc3220 clockevent
 16:        900  nvic_irq  13 Edge      lpc3220 clockevent

On the other side, with this patchset the number of interrupts
is closer to the expected:

$ cat /proc/interrupts | grep clockevent && sleep 1 && cat /proc/interrupts | grep clockevent
 16:       1580  nvic_irq  13 Edge      lpc3220 clockevent
 16:       1688  nvic_irq  13 Edge      lpc3220 clockevent

Therefore, the first patch switches the timer one-shot implementation
to use PR=0 and MR0=ticks. The second patch implements periodic mode
using this.

The last patch adds support for the ARM delay timer, which is used
for udelay and also to skip the delay loop calibration.

Ezequiel Garcia (3):
  clocksource/drivers/lpc32xx: Don't use the prescaler counter for
    clockevents
  clocksource/drivers/lpc32xx: Support periodic mode
  clocksource/drivers/lpc32xx: Support timer-based ARM delay

 drivers/clocksource/Kconfig        |  1 +
 drivers/clocksource/time-lpc32xx.c | 66 ++++++++++++++++++++++++++++++--------
 2 files changed, 54 insertions(+), 13 deletions(-)

-- 
2.7.0
