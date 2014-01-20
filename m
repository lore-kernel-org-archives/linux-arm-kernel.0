From: arno@natisbad.org (Arnaud Ebalard)
Date: Mon, 20 Jan 2014 21:14:13 +0100
Subject: [PATCH] ARM: mvebu: fix compilation warning on Armada 370 (i.e.
 non-SMP)
Message-ID: <87r48276ne.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following appears during compilation for an Armada 370 target
because 'irq_controller_lock' is used only when CONFIG_SMP is enabled:

  drivers/irqchip/irq-armada-370-xp.c:62:8: warning: 'irq_controller_lock' defined but not used [-Wunused-variable]

Fix that warning by protecting declaration via an #ifdef.

Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
 drivers/irqchip/irq-armada-370-xp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index 433cc8568dec..499c5070f841 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -59,7 +59,9 @@
 #define PCI_MSI_DOORBELL_END                    (32)
 #define PCI_MSI_DOORBELL_MASK                   0xFFFF0000
 
+#ifdef CONFIG_SMP
 static DEFINE_RAW_SPINLOCK(irq_controller_lock);
+#endif
 
 static void __iomem *per_cpu_int_base;
 static void __iomem *main_int_base;
-- 
1.8.5.2
