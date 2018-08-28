From: julien.thierry@arm.com (Julien Thierry)
Date: Tue, 28 Aug 2018 16:51:28 +0100
Subject: [PATCH v5 18/27] irqchip/gic-v3: Do not overwrite PMR value
In-Reply-To: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
References: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1535471497-38854-19-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the architecture is using ICC_PMR_EL1 to mask IRQs, do not overwrite
that value.

Tested-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index fef6688..162c49c 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -407,6 +407,9 @@ static u32 gic_get_pribits(void)
 static bool gic_has_group0(void)
 {
 	u32 val;
+	u32 old_pmr;
+
+	old_pmr = gic_read_pmr();

 	/*
 	 * Let's find out if Group0 is under control of EL3 or not by
@@ -422,6 +425,8 @@ static bool gic_has_group0(void)
 	gic_write_pmr(BIT(8 - gic_get_pribits()));
 	val = gic_read_pmr();

+	gic_write_pmr(old_pmr);
+
 	return val != 0;
 }

@@ -583,7 +588,8 @@ static void gic_cpu_sys_reg_init(void)
 	group0 = gic_has_group0();

 	/* Set priority mask register */
-	write_gicreg(DEFAULT_PMR_VALUE, ICC_PMR_EL1);
+	if (!gic_prio_masking_enabled())
+		write_gicreg(DEFAULT_PMR_VALUE, ICC_PMR_EL1);

 	/*
 	 * Some firmwares hand over to the kernel with the BPR changed from
--
1.9.1
