From: julien.thierry@arm.com (Julien Thierry)
Date: Fri, 25 May 2018 10:49:24 +0100
Subject: [PATCH v4 18/26] irqchip/gic-v3: Do not overwrite PMR value
In-Reply-To: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
References: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1527241772-48007-19-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the architecture is using ICC_PMR_EL1 to mask IRQs, do not overwrite
that value.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 13d283d..fc477e2 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -226,6 +226,11 @@ static void gic_unmask_irq(struct irq_data *d)
 	gic_poke_irq(d, GICD_ISENABLER);
 }
 
+static inline bool arch_uses_gic_prios(void)
+{
+	return IS_ENABLED(CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS);
+}
+
 static int gic_irq_set_irqchip_state(struct irq_data *d,
 				     enum irqchip_irq_state which, bool val)
 {
@@ -404,6 +409,9 @@ static u32 gic_get_pribits(void)
 static bool gic_has_group0(void)
 {
 	u32 val;
+	u32 old_pmr;
+
+	old_pmr = gic_read_pmr();
 
 	/*
 	 * Let's find out if Group0 is under control of EL3 or not by
@@ -419,6 +427,8 @@ static bool gic_has_group0(void)
 	gic_write_pmr(BIT(8 - gic_get_pribits()));
 	val = gic_read_pmr();
 
+	gic_write_pmr(old_pmr);
+
 	return val != 0;
 }
 
@@ -580,7 +590,8 @@ static void gic_cpu_sys_reg_init(void)
 	group0 = gic_has_group0();
 
 	/* Set priority mask register */
-	write_gicreg(DEFAULT_PMR_VALUE, ICC_PMR_EL1);
+	if (!arch_uses_gic_prios())
+		write_gicreg(DEFAULT_PMR_VALUE, ICC_PMR_EL1);
 
 	/*
 	 * Some firmwares hand over to the kernel with the BPR changed from
-- 
1.9.1
