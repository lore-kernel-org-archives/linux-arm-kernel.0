From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed,  4 Mar 2015 08:24:29 +0100
Subject: [PATCH] mfd: mt6397: Use set_irq_flags only on ARM
Message-ID: <1425453869-18482-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Continue the common pattern in MFD drivers and use set_irq_flags on ARM
and irq_set_noprobe on other architectures. This fixes compilation on
non ARM architecures.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---

Lee, feel free to squash this into the patch adding mt6397 core support.
Alternatively I could also add some Kconfig dependency to compile this
on ARM only if you are more comfortable with that.

 drivers/mfd/mt6397-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index b61c4eb..09bc780 100644
--- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -121,7 +121,11 @@ static int mt6397_irq_domain_map(struct irq_domain *d, unsigned int irq,
 	irq_set_chip_data(irq, mt6397);
 	irq_set_chip_and_handler(irq, &mt6397_irq_chip, handle_level_irq);
 	irq_set_nested_thread(irq, 1);
+#ifdef CONFIG_ARM
 	set_irq_flags(irq, IRQF_VALID);
+#else
+	irq_set_noprobe(irq);
+#endif
 
 	return 0;
 }
-- 
2.1.4
