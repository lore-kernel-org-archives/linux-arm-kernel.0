From: rric@kernel.org (Robert Richter)
Date: Thu, 13 Aug 2015 16:47:55 +0200
Subject: [PATCH v2 3/5] irqchip,
 gicv3: Workaround for Cavium ThunderX erratum 23154
In-Reply-To: <1439477277-6157-1-git-send-email-rric@kernel.org>
References: <1439477277-6157-1-git-send-email-rric@kernel.org>
Message-ID: <1439477277-6157-4-git-send-email-rric@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robert Richter <rrichter@cavium.com>

This patch implements Cavium ThunderX erratum 23154.

The gicv3 of ThunderX requires a modified version for reading the IAR
status to ensure data synchronization. Since this is in the fast-path
and called with each interrupt, runtime patching is used using jump
label patching for smallest overhead (no-op). This is the same
technique as used for tracepoints.

v2:
 * implement code in a single asm() to keep instruction sequence
 * added comment to the code that explains the erratum
 * apply workaround also if running as guest, thus check MIDR

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 drivers/irqchip/irq-gic-v3.c | 45 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 1a91902be0b1..2f80a11621a0 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -107,7 +107,7 @@ static void gic_redist_wait_for_rwp(void)
 }
 
 /* Low level accessors */
-static u64 __maybe_unused gic_read_iar(void)
+static u64 gic_read_iar_common(void)
 {
 	u64 irqstat;
 
@@ -115,6 +115,38 @@ static u64 __maybe_unused gic_read_iar(void)
 	return irqstat;
 }
 
+/*
+ * Cavium ThunderX erratum 23154
+ *
+ * The gicv3 of ThunderX requires a modified version for reading the
+ * IAR status to ensure data synchronization (access to icc_iar1_el1
+ * is not sync'ed before and after).
+ */
+static u64 gic_read_iar_cavium_thunderx(void)
+{
+	u64 irqstat;
+
+	asm volatile(
+		"nop;nop;nop;nop\n\t"
+		"nop;nop;nop;nop\n\t"
+		"mrs_s %0, " __stringify(ICC_IAR1_EL1) "\n\t"
+		"nop;nop;nop;nop"
+		: "=r" (irqstat));
+	mb();
+
+	return irqstat;
+}
+
+struct static_key is_cavium_thunderx = STATIC_KEY_INIT_FALSE;
+
+static u64 __maybe_unused gic_read_iar(void)
+{
+	if (static_key_false(&is_cavium_thunderx))
+		return gic_read_iar_common();
+	else
+		return gic_read_iar_cavium_thunderx();
+}
+
 static void __maybe_unused gic_write_pmr(u64 val)
 {
 	asm volatile("msr_s " __stringify(ICC_PMR_EL1) ", %0" : : "r" (val));
@@ -766,8 +798,19 @@ static const struct irq_domain_ops gic_irq_domain_ops = {
 	.free = gic_irq_domain_free,
 };
 
+static void gicv3_enable_cavium_thunderx(void *data)
+{
+	static_key_slow_inc(&is_cavium_thunderx);
+}
+
 static const struct gic_capabilities gicv3_errata[] = {
 	{
+		.desc		= "GIC: Cavium erratum 23154",
+		.iidr		= 0xa100034c,	/* ThunderX pass 1.x */
+		.iidr_mask	= 0xffff0fff,
+		.init		= gicv3_enable_cavium_thunderx,
+	},
+	{
 	}
 };
 
-- 
2.1.1
