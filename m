From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 26 Aug 2014 16:03:34 +0100
Subject: [PATCH 1/2] GICv3: refactor gic_enable_redist to support both
 enabling and disabling
In-Reply-To: <1409065415-20176-1-git-send-email-sudeep.holla@arm.com>
References: <1409065415-20176-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1409065415-20176-2-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sudeep Holla <sudeep.holla@arm.com>

Currently gic_enable_redist configures the redistributors to never
assert WakeRequest signal. However when powering down the processors
with wake-up enabled(i.e suspend), we need to configure it to assert
that signal.

This patch extends gic_enable_redist so that the redistributor can be
configure to assert WakeRequest and hold interrupts as pending. This is
useful in suspending the processors.

This patch also adds check to make sure GICR_WAKER is accessible when
configuring it.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
[maz: removed reference to GICD_CTLR.DS and added read-back of
      GICR_WAKER to check that it is not RAZ/WI]
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 57eaa5a0b1e3..37062ba6704b 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -155,7 +155,7 @@ static void gic_enable_sre(void)
 		pr_err("GIC: unable to set SRE (disabled at EL2), panic ahead\n");
 }
 
-static void gic_enable_redist(void)
+static void gic_enable_redist(bool enable)
 {
 	void __iomem *rbase;
 	u32 count = 1000000;	/* 1s! */
@@ -163,20 +163,30 @@ static void gic_enable_redist(void)
 
 	rbase = gic_data_rdist_rd_base();
 
-	/* Wake up this CPU redistributor */
 	val = readl_relaxed(rbase + GICR_WAKER);
-	val &= ~GICR_WAKER_ProcessorSleep;
+	if (enable)
+		/* Wake up this CPU redistributor */
+		val &= ~GICR_WAKER_ProcessorSleep;
+	else
+		val |= GICR_WAKER_ProcessorSleep;
 	writel_relaxed(val, rbase + GICR_WAKER);
 
-	while (readl_relaxed(rbase + GICR_WAKER) & GICR_WAKER_ChildrenAsleep) {
-		count--;
-		if (!count) {
-			pr_err_ratelimited("redist didn't wake up...\n");
-			return;
-		}
+	if (!enable) {		/* Check that GICR_WAKER is writeable */
+		val = readl_relaxed(rbase + GICR_WAKER);
+		if (!(val & GICR_WAKER_ProcessorSleep))
+			return;	/* No PM support in this redistributor */
+	}
+
+	while (count--) {
+		val = readl_relaxed(rbase + GICR_WAKER);
+		if (enable ^ (val & GICR_WAKER_ChildrenAsleep))
+			break;
 		cpu_relax();
 		udelay(1);
 	};
+	if (!count)
+		pr_err_ratelimited("redistributor failed to %s...\n",
+				   enable ? "wakeup" : "sleep");
 }
 
 /*
@@ -381,7 +391,7 @@ static void gic_cpu_init(void)
 	if (gic_populate_rdist())
 		return;
 
-	gic_enable_redist();
+	gic_enable_redist(true);
 
 	rbase = gic_data_rdist_sgi_base();
 
-- 
1.8.3.2
