From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 29 Apr 2013 15:58:37 +0200
Subject: [PATCH] mxs: icoll: Add function to register an interrupt as FIQ
 source
Message-ID: <1367243917-5177-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MXS, unlike other ARM platforms, has no way to make a FIQ from an
interrupt from a driver, without poking directly into the icoll.

Add an exported function to do this.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/mach-mxs/icoll.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/mach-mxs/icoll.c b/arch/arm/mach-mxs/icoll.c
index 8fb23af..1bb16da 100644
--- a/arch/arm/mach-mxs/icoll.c
+++ b/arch/arm/mach-mxs/icoll.c
@@ -16,6 +16,7 @@
  * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
+#include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/irq.h>
@@ -34,6 +35,7 @@
 #define HW_ICOLL_INTERRUPTn_SET(n)		(0x0124 + (n) * 0x10)
 #define HW_ICOLL_INTERRUPTn_CLR(n)		(0x0128 + (n) * 0x10)
 #define BM_ICOLL_INTERRUPTn_ENABLE		0x00000004
+#define BM_ICOLL_INTERRUPTn_FIQ_ENABLE		0x00000010
 #define BV_ICOLL_LEVELACK_IRQLEVELACK__LEVEL0	0x1
 
 #define ICOLL_NUM_IRQS		128
@@ -41,6 +43,15 @@
 static void __iomem *icoll_base = MXS_IO_ADDRESS(MXS_ICOLL_BASE_ADDR);
 static struct irq_domain *icoll_domain;
 
+void mxs_icoll_set_irq_fiq(unsigned int irq)
+{
+	struct irq_data *d = irq_get_irq_data(irq);
+
+	__raw_writel(BM_ICOLL_INTERRUPTn_FIQ_ENABLE,
+		     icoll_base + HW_ICOLL_INTERRUPTn_SET(d->hwirq));
+}
+EXPORT_SYMBOL(mxs_icoll_set_irq_fiq);
+
 static void icoll_ack_irq(struct irq_data *d)
 {
 	/*
-- 
1.8.1.2
