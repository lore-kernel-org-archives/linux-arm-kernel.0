From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 17 Jul 2015 21:33:25 +0200
Subject: [PATCH 0/3] clocksource: at91: Remove irq handler when clock event is
 unused
Message-ID: <1437161608-26782-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IRQ handlers for the clockevent on at91 (pit or system timer) are shared.
The following patch in linux-rt was removing those when they are unused:
http://git.kernel.org/cgit/linux/kernel/git/rt/linux-rt-devel.git/commit/?id=227cd21851456fb08e87f5a35e0e51280a9fd439

Unfortunately, they bitrotted over time and actually break the at91rm9200 (the
irq gets removed but never requested again) and gives warning on all the other
at91 platforms.

The following patches replace the mentionned patch and are based on
clockevents/4.3 to be applied after the switch to the 'set-state' interface.

Alexandre Belloni (3):
  clocksource: atmel-st: Remove irq handler when clock event is unused
  clocksource: atmel-pit: drop at91sam926x_pit_common_init
  clocksource: atmel-pit: Remove irq handler when clock event is unused

 drivers/clocksource/timer-atmel-pit.c | 134 +++++++++++++++++-----------------
 drivers/clocksource/timer-atmel-st.c  |  43 +++++++++--
 2 files changed, 102 insertions(+), 75 deletions(-)

-- 
2.1.4
