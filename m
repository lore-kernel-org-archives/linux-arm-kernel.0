From: LW@KARO-electronics.de (=?iso-8859-15?Q?Lothar_Wa=DFmann?=)
Date: Mon, 29 Nov 2010 10:25:34 +0100
Subject: [PATCH] prevent 'BUG: sleeping function called from invalid context'
	in arch_reset()
In-Reply-To: <20101126113255.GC27637@pengutronix.de>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1290754154-9428-4-git-send-email-shawn.guo@freescale.com>
	<19695.32386.279224.624305@ipc1.ka-ro>
	<20101126095733.GA27637@pengutronix.de>
	<19695.36407.793411.550458@ipc1.ka-ro>
	<20101126113255.GC27637@pengutronix.de>
Message-ID: <19699.29070.822244.938508@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch_reset() may be called from interrupt context (e.g. induced by
SYSRQ-B), thus clk_get() and clk_enable() must not be called from
within arch_reset(). Move these calls to mxc_arch_reset_init().

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
diff --git a/arch/arm/plat-mxc/system.c b/arch/arm/plat-mxc/system.c
index c3972c5..9b02251 100644
--- a/arch/arm/plat-mxc/system.c
+++ b/arch/arm/plat-mxc/system.c
@@ -53,11 +53,6 @@ void arch_reset(char mode, const char *cmd)
 	if (cpu_is_mx1()) {
 		wcr_enable = (1 << 0);
 	} else {
-		struct clk *clk;
-
-		clk = clk_get_sys("imx-wdt.0", NULL);
-		if (!IS_ERR(clk))
-			clk_enable(clk);
 		wcr_enable = (1 << 2);
 	}
 
@@ -78,5 +73,14 @@ void arch_reset(char mode, const char *cmd)
 
 void mxc_arch_reset_init(void __iomem *base)
 {
+	struct clk *clk;
+
 	wdog_base = base;
+
+	if (cpu_is_mx1())
+		return;
+
+	clk = clk_get_sys("imx-wdt.0", NULL);
+	if (!IS_ERR(clk))
+		clk_enable(clk);
 }


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
