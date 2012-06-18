From: monstr@monstr.eu (Michal Simek)
Date: Mon, 18 Jun 2012 13:30:05 +0200
Subject: [RFC PATCH 2/8] ARM: gic: Export gic_raise_softirq function for
 kernel modules
In-Reply-To: <1340019011-18642-1-git-send-email-monstr@monstr.eu>
References: <1340019011-18642-1-git-send-email-monstr@monstr.eu>
Message-ID: <1340019011-18642-3-git-send-email-monstr@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This function can be used by device driver for raising
software irqs. For example AMP(remoteproc) on Zynq.

Signed-off-by: Michal Simek <monstr@monstr.eu>
---
 arch/arm/common/gic.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index 4003cc2..b8e7202 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -22,6 +22,7 @@
  * As such, the enable set/clear, pending set/clear and active bit
  * registers are banked per-cpu for these sources.
  */
+#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/err.h>
@@ -753,6 +754,7 @@ void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 	/* this always happens on GIC0 */
 	writel_relaxed(map << 16 | irq, gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
 }
+EXPORT_SYMBOL(gic_raise_softirq);
 #endif
 
 #ifdef CONFIG_OF
-- 
1.7.0.4
