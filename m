From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Sun, 21 Aug 2016 03:27:45 -0400
Subject: [PATCH] ARM: EXYNOS: Clear OF_POPULATED flag from PMU node in IRQ
 init callback
Message-ID: <1471764465-2524-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Exynos PMU node is an interrupt, clock and PMU (Power Management Unit)
controller, and these functionalities are supported by different drivers
that matches the same compatible strings.

Since commit 15cc2ed6dcf9 ("of/irq: Mark initialised interrupt controllers
as populated") the OF core flags interrupt controllers registered with the
IRQCHIP_DECLARE() macro as OF_POPULATED, so platform devices with the same
compatible string as the interrupt controller will not be registered.

This prevents the PMU platform device to be registered so the Exynos PMU
driver is never probed. This breaks (among other things) Suspend-to-RAM.

Fix this by clearing the OF_POPULATED flag in the PMU IRQ init callback,
to allow the Exynos PMU platform driver to be probed. The patch is based
on Philipp Zabel's "ARM: imx6: mark GPC node as not populated after irq
init to probe pm domain driver".

Fixes: 15cc2ed6dcf9 ("of/irq: Mark initialised interrupt controllers as populated")
Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

This was tested on an Exynos5800 Peach Pi Chromebook with v4.8-rc2 +
Philipp's patch: https://patchwork.kernel.org/patch/9271361/

 arch/arm/mach-exynos/suspend.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
index 3750575c73c5..06332f626565 100644
--- a/arch/arm/mach-exynos/suspend.c
+++ b/arch/arm/mach-exynos/suspend.c
@@ -255,6 +255,12 @@ static int __init exynos_pmu_irq_init(struct device_node *node,
 		return -ENOMEM;
 	}
 
+	/*
+	 * Clear the OF_POPULATED flag set in of_irq_init so that
+	 * later the Exynos PMU platform device won't be skipped.
+	 */
+	of_node_clear_flag(node, OF_POPULATED);
+
 	return 0;
 }
 
-- 
2.5.5
