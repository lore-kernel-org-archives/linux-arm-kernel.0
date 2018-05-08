From: gregkh@linuxfoundation.org (gregkh at linuxfoundation.org)
Date: Tue, 08 May 2018 09:23:06 +0200
Subject: Patch "irqchip/qcom: Fix check for spurious interrupts" has been
 added to the 4.16-stable tree
Message-ID: <15257641864146@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This is a note to let you know that I've just added the patch titled

    irqchip/qcom: Fix check for spurious interrupts

to the 4.16-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     irqchip-qcom-fix-check-for-spurious-interrupts.patch
and it can be found in the queue-4.16 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


>From 1bc2463cee92ef0e2034c813d5e511adeb58b5fd Mon Sep 17 00:00:00 2001
From: Agustin Vega-Frias <agustinv@codeaurora.org>
Date: Tue, 1 May 2018 10:14:50 -0400
Subject: irqchip/qcom: Fix check for spurious interrupts

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


Patches currently in stable-queue which might be from agustinv at codeaurora.org are

queue-4.16/irqchip-qcom-fix-check-for-spurious-interrupts.patch
