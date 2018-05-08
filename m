From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Tue,  8 May 2018 10:10:46 +0200
Subject: [PATCH 4.16 48/52] irqchip/qcom: Fix check for spurious interrupts
In-Reply-To: <20180508073928.058320984@linuxfoundation.org>
References: <20180508073928.058320984@linuxfoundation.org>
Message-ID: <20180508073934.885061518@linuxfoundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Agustin Vega-Frias <agustinv@codeaurora.org>

commit 1bc2463cee92ef0e2034c813d5e511adeb58b5fd upstream.

When the interrupts for a combiner span multiple registers it must be
checked if any interrupts have been asserted on each register before
checking for spurious interrupts.

Checking each register seperately leads to false positive warnings.

[ tglx: Massaged changelog ]

Fixes: f20cc9b00c7b ("irqchip/qcom: Add IRQ combiner driver")
Signed-off-by: Agustin Vega-Frias <agustinv@codeaurora.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: timur at codeaurora.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: stable at vger.kernel.org
Link: https://lkml.kernel.org/r/1525184090-26143-1-git-send-email-agustinv at codeaurora.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/irqchip/qcom-irq-combiner.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/irqchip/qcom-irq-combiner.c
+++ b/drivers/irqchip/qcom-irq-combiner.c
@@ -1,4 +1,4 @@
-/* Copyright (c) 2015-2016, The Linux Foundation. All rights reserved.
+/* Copyright (c) 2015-2018, The Linux Foundation. All rights reserved.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 and
@@ -68,7 +68,7 @@ static void combiner_handle_irq(struct i
 
 		bit = readl_relaxed(combiner->regs[reg].addr);
 		status = bit & combiner->regs[reg].enabled;
-		if (!status)
+		if (bit && !status)
 			pr_warn_ratelimited("Unexpected IRQ on CPU%d: (%08x %08lx %p)\n",
 					    smp_processor_id(), bit,
 					    combiner->regs[reg].enabled,
