From: arno@natisbad.org (Arnaud Ebalard)
Date: Mon, 20 Jan 2014 22:52:05 +0100
Subject: [PATCHv2] ARM: mvebu: fix compilation warning on Armada 370 (i.e.
 non-SMP)
Message-ID: <87txcy8goq.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following appears during compilation for an Armada 370 target
because 'irq_controller_lock' is used only when CONFIG_SMP is
enabled:

 drivers/irqchip/irq-armada-370-xp.c:62:8: warning: 'irq_controller_lock' defined but not used [-Wunused-variable]

Fix that warning by moving declaration of 'irq_controller_lock'
inside existing #ifdef.

Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---

Changes since v1:
 - moved declaration inside existing #ifdef as suggested by Arnd,
   instead of adding a new one.

 drivers/irqchip/irq-armada-370-xp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index 433cc8568dec..9300bc32784e 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -59,8 +59,6 @@
 #define PCI_MSI_DOORBELL_END                    (32)
 #define PCI_MSI_DOORBELL_MASK                   0xFFFF0000
 
-static DEFINE_RAW_SPINLOCK(irq_controller_lock);
-
 static void __iomem *per_cpu_int_base;
 static void __iomem *main_int_base;
 static struct irq_domain *armada_370_xp_mpic_domain;
@@ -239,6 +237,8 @@ static inline int armada_370_xp_msi_init(struct device_node *node,
 #endif
 
 #ifdef CONFIG_SMP
+static DEFINE_RAW_SPINLOCK(irq_controller_lock);
+
 static int armada_xp_set_affinity(struct irq_data *d,
 				  const struct cpumask *mask_val, bool force)
 {
-- 
1.8.5.2
