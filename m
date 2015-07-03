From: davidcdueck@googlemail.com (David Dueck)
Date: Fri,  3 Jul 2015 17:28:41 +0200
Subject: [PATCH RFC 0/2] RT-Preempt on SAMA5
Message-ID: <1435937323-16913-1-git-send-email-davidcdueck@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

RT-Preempt crashes early at boot on SAMA5. The reason is that
drivers/clk/at91/* is using interrupts very early, before kthreadd is up.

Just making those IRQF_NOTHREAD is not an option as the handlers are taking
spin locks.

Perhaps we can have some discussion on how to go on with this.
Is there some problem if we just do not use interrupts here anymore?
(at least for the clocks that are needed very early)

The patches are on top of the RT patches for 4.0. The second
patch might not be needed if we just drop the RT patch that touches
the PIT code.

David Dueck (2):
  at91: make using irqs for clock handling optional
  at91: use request_irq/free_irq instead of setup_irq/remove_irq

 drivers/clk/Kconfig                   |  1 +
 drivers/clk/at91/Kconfig              |  4 ++
 drivers/clk/at91/clk-main.c           | 34 ++++++++++++++++
 drivers/clk/at91/clk-master.c         | 11 +++++
 drivers/clk/at91/clk-pll.c            | 11 ++++-
 drivers/clk/at91/clk-system.c         | 11 +++++
 drivers/clk/at91/clk-utmi.c           | 10 +++++
 drivers/clk/at91/pmc.c                |  6 +++
 drivers/clocksource/timer-atmel-pit.c | 76 ++++++++++++++++++-----------------
 9 files changed, 127 insertions(+), 37 deletions(-)
 create mode 100644 drivers/clk/at91/Kconfig

-- 
2.4.4
