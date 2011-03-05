From: nm@ti.com (Nishanth Menon)
Date: Sat,  5 Mar 2011 20:59:19 +0530
Subject: [PATCH V3 16/19] OMAP3+: SR: disable spamming interrupts
In-Reply-To: <1299338962-5602-1-git-send-email-nm@ti.com>
References: <1299338962-5602-1-git-send-email-nm@ti.com>
Message-ID: <1299338962-5602-17-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At times with bad SR configurations, especially during silicon bring-ups,
we could get continuous spurious interrupts which end up hanging the
platform in the form of an ISR call for status bits that are
automatically enabled by the hardware without any software clearing
option.

If we detect scenarios where ISR was called without the corresponding
notification bit being set, instead of hanging up the system,
we will disable interrupt after noting the event in the system log
to try and keep system sanity and allow developer to debug and fix
the condition.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index f6e44a1..b1a7cfe 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -209,8 +209,16 @@ static irqreturn_t sr_interrupt(int irq, void *data)
 		value = irqstat_to_notifier_v2(status);
 	}
 
-	if (sr_class->notify)
-		sr_class->notify(sr_info->voltdm, value);
+	/* Attempt some resemblance of recovery! */
+	if (!value) {
+		dev_err(&sr_info->pdev->dev, "%s: Spurious interrupt!"
+			"status = 0x%08x. Disabling to prevent spamming!!\n",
+			__func__, status);
+		disable_irq_nosync(sr_info->irq);
+	} else {
+		if (sr_class->notify)
+			sr_class->notify(sr_info->voltdm, value);
+	}
 
 	return IRQ_HANDLED;
 }
-- 
1.7.1
