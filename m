From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Wed, 22 Sep 2010 09:42:15 +0200
Subject: [PATCH|RESEND] MX35: Fix bogus L2 cache settings
In-Reply-To: <1282054858-30050-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1282054858-30050-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <1285141335-4380-1-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Juergen Beisert <jbe@pengutronix.de>

i.MX35 CPUs marked with "MCIMX357CJQ5C M99V CTHA0943B" are coming with bogus
L2 cache settings. If these settings are kept unmodified prior enabling the L2
cache the CPU runs amok immediately when its enabled.

This fix should not hurt already working CPUs, as they are using the written
register value already.

Its currently unknown if its possible to detect the production lot from the
software to fix only affected CPUs.

Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 arch/arm/mach-mx3/mm.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/mm.c b/arch/arm/mach-mx3/mm.c
index 20e48c0..b4ffc53 100644
--- a/arch/arm/mach-mx3/mm.c
+++ b/arch/arm/mach-mx3/mm.c
@@ -110,6 +110,24 @@ void __init mx35_init_irq(void)
 static int mxc_init_l2x0(void)
 {
 	void __iomem *l2x0_base;
+	void __iomem *clkctl_base;
+/*
+ * First of all, we must repair broken chip settings. There are some
+ * i.MX35 CPUs in the wild, comming with bogus L2 cache settings. These
+ * misconfigured CPUs will run amok immediately when the L2 cache gets enabled.
+ * Workaraound is to setup the correct register setting prior enabling the
+ * L2 cache. This should not hurt already working CPUs, as they are using the
+ * same value
+ */
+#define L2_MEM_VAL 0x10
+
+	clkctl_base = ioremap(MX35_CLKCTL_BASE_ADDR, 4096);
+	if (clkctl_base != NULL) {
+		writel(0x00000515, clkctl_base + L2_MEM_VAL);
+		iounmap(clkctl_base);
+	} else {
+		pr_err("L2 cache: Cannot fix timing. Trying to continue without\n");
+	}
 
 	l2x0_base = ioremap(L2CC_BASE_ADDR, 4096);
 	if (IS_ERR(l2x0_base)) {
-- 
1.7.2.3
