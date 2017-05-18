From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 18 May 2017 10:07:36 +0200
Subject: [PATCH v3 0/4] irqchip: armada-370-xp: remove IRQ_NOAUTOEN workaround
Message-ID: <1495094860-24709-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is the third version of a patch series initially posted in
October 2015, under the title:

  [PATCH 0/5] Fix regression introduced by set_irq_flags() removal

at the time, the regression was worked around in commit
353d6d6c82e5d2533ba22e7f9fb081582bf50dc2 ("irqchip/armada-370-xp: Fix
regression by clearing IRQ_NOAUTOEN") and this series brings the
proper fix for the original issue, while reverting the work around.

Changes since v2:

 - Rebased on top of v4.12-rc1.

Changes since v1:

 - Rebased on top of v4.10.

 - Patch "kernel: irq: implement is_enabled_percpu_irq()" dropped,
   since it has been merged upstream as commit
   f0cb32207307e9d7b3ee8117078b7a37f8d0166e ("genirq: Implement
   irq_percpu_is_enabled()")

 - Patch "irqchip: armada-370-xp: prepare additions to
   armada_xp_mpic_secondary_init()" dropped, since similar changes
   were merged as part of the overall CPU hotplug rework.

 - Patches "irqchip: armada-370-xp: re-order register definitions" and
   "irqchip: armada-370-xp: document the overall driver logic" moved
   at the beginning of the series.

 - Acked-by added on "irqchip: armada-370-xp: re-order register
   definitions" and "irqchip: armada-370-xp: document the overall
   driver logic"

 - In patch "irqchip: armada-370-xp: document the overall driver
   logic", fix minor presentation detail in the ASCII art diagram.

 - In patch "irqchip: armada-370-xp: re-enable per-CPU interrupts at
   resume time":

   - Move the per-CPU interrupt re-enabling logic for secondary cores
     into a utility function armada_xp_mpic_reenable_percpu() called
     by both armada_xp_mpic_starting_cpu() and
     mpic_cascaded_starting_cpu().

   - Instead of iterating on all IRQs and filtering the per-CPU ones,
     only iterate on the first ARMADA_370_XP_MAX_PER_CPU_IRQS, which
     are the only per-CPU ones. Suggested by Gr?gory Clement.

   - Use the irq_percpu_is_enabled() API, which was the one actually
     merged, instead of the one originally proposed in the v1 of this
     series.

 - Addition of a patch reverting the work around.

Thanks,

Thomas

Thomas Petazzoni (4):
  irqchip: armada-370-xp: re-order register definitions
  irqchip: armada-370-xp: document the overall driver logic
  irqchip: armada-370-xp: re-enable per-CPU interrupts at resume time
  Revert "irqchip/armada-370-xp: Fix regression by clearing
    IRQ_NOAUTOEN"

 drivers/irqchip/irq-armada-370-xp.c | 146 +++++++++++++++++++++++++++++++-----
 1 file changed, 129 insertions(+), 17 deletions(-)

-- 
2.7.4
