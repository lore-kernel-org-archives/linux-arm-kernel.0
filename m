From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 20 Sep 2011 14:49:13 +0200
Subject: [PATCH 1/4] ARM i.MX avic: add handle_irq function
In-Reply-To: <1316522956-28530-1-git-send-email-s.hauer@pengutronix.de>
References: <1316522956-28530-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1316522956-28530-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/plat-mxc/avic.c                |   13 +++++++++++++
 arch/arm/plat-mxc/include/mach/common.h |   10 ++++++++++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/avic.c b/arch/arm/plat-mxc/avic.c
index 55d2534..4d68c5a 100644
--- a/arch/arm/plat-mxc/avic.c
+++ b/arch/arm/plat-mxc/avic.c
@@ -116,6 +116,19 @@ static struct mxc_irq_chip mxc_avic_chip = {
 #endif
 };
 
+asmlinkage void __exception_irq_entry avic_handle_irq(struct pt_regs *regs)
+{
+	u32 nivector;
+
+	do {
+		nivector = __raw_readl(avic_base + AVIC_NIVECSR) >> 16;
+		if (nivector == 0xffff)
+			break;
+
+		handle_IRQ(nivector, regs);
+	} while (1);
+}
+
 /*
  * This function initializes the AVIC hardware and disables all the
  * interrupts. It registers the interrupt enable and disable functions
diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
index 4e3d978..8de0d0c 100644
--- a/arch/arm/plat-mxc/include/mach/common.h
+++ b/arch/arm/plat-mxc/include/mach/common.h
@@ -72,4 +72,14 @@ extern void mxc_arch_reset_init(void __iomem *);
 extern void mx51_efikamx_reset(void);
 extern int mx53_revision(void);
 extern int mx53_display_revision(void);
+
+void avic_handle_irq(struct pt_regs *);
+
+#define mx1_handle_irq avic_handle_irq
+#define mx21_handle_irq avic_handle_irq
+#define mx25_handle_irq avic_handle_irq
+#define mx27_handle_irq avic_handle_irq
+#define mx31_handle_irq avic_handle_irq
+#define mx35_handle_irq avic_handle_irq
+
 #endif
-- 
1.7.6.3
