From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 24 Feb 2015 10:55:59 +0100
Subject: [RFC PATCH 0/3] genirq: mixing IRQF_NO_SUSPEND and wakeup sources on
 shared IRQs
Message-ID: <1424771762-16343-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I put the IRQF_NO_SUSPEND_SAFE/IRQF_TIMER_SIBLING_OK/WHATEVER_NAME_YOU_CHOOSE
debate aside to concentrate on another problem pointed out by Rafael and
Mark: the fact that we cannot mix IRQF_NO_SUSPEND and wakeup sources on
a shared IRQ line.

This is because the wakeup code is prevailing the IRQF_NO_SUSPEND case
and will trigger a system wakeup as soon as the IRQ line is tagged as a
wakeup source.

This series propose an approach to deal with such cases by doing the
following:
1/ Prevent any system wakeup when at least one of the IRQ user has set
   the IRQF_NO_SUSPEND flag
2/ Adapt IRQ handlers so that they can safely be called in suspended
   state
3/ Let drivers decide when the system should be woken up

Let me know what you think of this approach.

Thanks,

Boris

Boris Brezillon (3):
  genirq: prevent system wakeup when dealing with IRQF_NO_SUSPEND IRQs
  genirq: add helper functions to deal with wakeup on shared
    IRQF_NO_SUSPEND IRQs
  rtc: at91sam9: properly act when IRQ handler is called in suspended
    state

 drivers/rtc/rtc-at91sam9.c | 62 ++++++++++++++++++++++++++++++++++++++--------
 include/linux/interrupt.h  |  3 +++
 kernel/irq/manage.c        | 16 ++++++++++++
 kernel/irq/pm.c            |  9 ++++++-
 4 files changed, 78 insertions(+), 12 deletions(-)

-- 
1.9.1
