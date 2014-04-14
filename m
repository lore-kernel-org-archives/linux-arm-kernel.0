From: nm@ti.com (Nishanth Menon)
Date: Mon, 14 Apr 2014 11:25:13 -0500
Subject: [PATCH 02/15] bus: omap_l3_noc: switch over to relaxed variants of
 readl/writel
In-Reply-To: <1397492726-17203-1-git-send-email-nm@ti.com>
References: <1397492726-17203-1-git-send-email-nm@ti.com>
Message-ID: <1397492726-17203-4-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we use __raw_readl and writel in this driver, however, there
is no strict sequencing needs for this driver, hence we should be good
with the relaxed variants.

While at it, simplify address computation using variables for register.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/bus/omap_l3_noc.c |   26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/bus/omap_l3_noc.c b/drivers/bus/omap_l3_noc.c
index 1eb6d85..0d346e6 100644
--- a/drivers/bus/omap_l3_noc.c
+++ b/drivers/bus/omap_l3_noc.c
@@ -55,6 +55,7 @@ static irqreturn_t l3_interrupt_handler(int irq, void *_l3)
 	int err_src = 0;
 	u32 std_err_main, err_reg, clear, masterid;
 	void __iomem *base, *l3_targ_base;
+	void __iomem *l3_targ_stderr, *l3_targ_slvofslsb, *l3_targ_mstaddr;
 	char *target_name, *master_name = "UN IDENTIFIED";
 
 	/* Get the Type of interrupt */
@@ -66,8 +67,8 @@ static irqreturn_t l3_interrupt_handler(int irq, void *_l3)
 		 * to determine the source
 		 */
 		base = l3->l3_base[i];
-		err_reg = __raw_readl(base + l3_flagmux[i] +
-					+ L3_FLAGMUX_REGERR0 + (inttype << 3));
+		err_reg = readl_relaxed(base + l3_flagmux[i] +
+					L3_FLAGMUX_REGERR0 + (inttype << 3));
 
 		/* Get the corresponding error and analyse */
 		if (err_reg) {
@@ -76,10 +77,14 @@ static irqreturn_t l3_interrupt_handler(int irq, void *_l3)
 
 			/* Read the stderrlog_main_source from clk domain */
 			l3_targ_base = base + *(l3_targ[i] + err_src);
-			std_err_main =  __raw_readl(l3_targ_base +
-					L3_TARG_STDERRLOG_MAIN);
-			masterid = __raw_readl(l3_targ_base +
-					L3_TARG_STDERRLOG_MSTADDR);
+			l3_targ_stderr = l3_targ_base + L3_TARG_STDERRLOG_MAIN;
+			l3_targ_slvofslsb = l3_targ_base +
+					    L3_TARG_STDERRLOG_SLVOFSLSB;
+			l3_targ_mstaddr = l3_targ_base +
+					  L3_TARG_STDERRLOG_MSTADDR;
+
+			std_err_main = readl_relaxed(l3_targ_stderr);
+			masterid = readl_relaxed(l3_targ_mstaddr);
 
 			switch (std_err_main & CUSTOM_ERROR) {
 			case STANDARD_ERROR:
@@ -87,12 +92,10 @@ static irqreturn_t l3_interrupt_handler(int irq, void *_l3)
 					l3_targ_inst_name[i][err_src];
 				WARN(true, "L3 standard error: TARGET:%s@address 0x%x\n",
 					target_name,
-					__raw_readl(l3_targ_base +
-						L3_TARG_STDERRLOG_SLVOFSLSB));
+					readl_relaxed(l3_targ_slvofslsb));
 				/* clear the std error log*/
 				clear = std_err_main | CLEAR_STDERR_LOG;
-				writel(clear, l3_targ_base +
-					L3_TARG_STDERRLOG_MAIN);
+				writel_relaxed(clear, l3_targ_stderr);
 				break;
 
 			case CUSTOM_ERROR:
@@ -107,8 +110,7 @@ static irqreturn_t l3_interrupt_handler(int irq, void *_l3)
 					master_name, target_name);
 				/* clear the std error log*/
 				clear = std_err_main | CLEAR_STDERR_LOG;
-				writel(clear, l3_targ_base +
-					L3_TARG_STDERRLOG_MAIN);
+				writel_relaxed(clear, l3_targ_stderr);
 				break;
 
 			default:
-- 
1.7.9.5
