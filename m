From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 21 Sep 2011 23:17:46 +0800
Subject: [PATCH v2 2/3] ARM: CSR: PM: save/restore irq status in suspend cycle
In-Reply-To: <1316618267-4348-1-git-send-email-21cnbao@gmail.com>
References: <1316618267-4348-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1316618267-4348-3-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <baohua.song@csr.com>

SiRFprimaII will lose power in deepsleep mode except rtc, pmu and sdram
self-refresh. So IRQ controller will lose status in suspend cyle.
This patch saves irq mask/level registers while suspending and restore
them while resuming.

Signed-off-by: Barry Song <baohua.song@csr.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-prima2/irq.c |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-prima2/irq.c b/arch/arm/mach-prima2/irq.c
index cf80a72..d93ceef 100644
--- a/arch/arm/mach-prima2/irq.c
+++ b/arch/arm/mach-prima2/irq.c
@@ -14,6 +14,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/irqdomain.h>
+#include <linux/syscore_ops.h>
 
 #define SIRFSOC_INT_RISC_MASK0          0x0018
 #define SIRFSOC_INT_RISC_MASK1          0x001C
@@ -73,3 +74,42 @@ void __init sirfsoc_of_irq_init(void)
 
 	sirfsoc_irq_init();
 }
+
+struct sirfsoc_irq_status {
+	u32 mask0;
+	u32 mask1;
+	u32 level0;
+	u32 level1;
+};
+
+static struct sirfsoc_irq_status sirfsoc_irq_st;
+
+static int sirfsoc_irq_suspend(void)
+{
+	sirfsoc_irq_st.mask0 = readl_relaxed(sirfsoc_intc_base + SIRFSOC_INT_RISC_MASK0);
+	sirfsoc_irq_st.mask1 = readl_relaxed(sirfsoc_intc_base + SIRFSOC_INT_RISC_MASK1);
+	sirfsoc_irq_st.level0 = readl_relaxed(sirfsoc_intc_base + SIRFSOC_INT_RISC_LEVEL0);
+	sirfsoc_irq_st.level1 = readl_relaxed(sirfsoc_intc_base + SIRFSOC_INT_RISC_LEVEL1);
+
+	return 0;
+}
+
+static void sirfsoc_irq_resume(void)
+{
+	writel_relaxed(sirfsoc_irq_st.mask0, sirfsoc_intc_base + SIRFSOC_INT_RISC_MASK0);
+	writel_relaxed(sirfsoc_irq_st.mask1, sirfsoc_intc_base + SIRFSOC_INT_RISC_MASK1);
+	writel_relaxed(sirfsoc_irq_st.level0, sirfsoc_intc_base + SIRFSOC_INT_RISC_LEVEL0);
+	writel_relaxed(sirfsoc_irq_st.level1, sirfsoc_intc_base + SIRFSOC_INT_RISC_LEVEL1);
+}
+
+static struct syscore_ops sirfsoc_irq_syscore_ops = {
+	.suspend	= sirfsoc_irq_suspend,
+	.resume		= sirfsoc_irq_resume,
+};
+
+static int __init sirfsoc_irq_pm_init(void)
+{
+	register_syscore_ops(&sirfsoc_irq_syscore_ops);
+	return 0;
+}
+device_initcall(sirfsoc_irq_pm_init);
-- 
1.7.0.4
