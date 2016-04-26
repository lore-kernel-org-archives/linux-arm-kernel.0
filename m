From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 26 Apr 2016 11:28:40 +1000
Subject: [PATCH 05/11] soc: renesas: rcar-sysc: Enable Clock Domain for I/O
 devices
In-Reply-To: <cover.1461632180.git.horms+renesas@verge.net.au>
References: <cover.1461632180.git.horms+renesas@verge.net.au>
Message-ID: <1c8c77f52d1037c61468539e1d68c44f9e710536.1461632180.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

On R-Car H3, some power areas (e.g. A3VP) contain I/O devices, which are
also part of the CPG/MSSR Clock Domain.
On all R-Car SoCs, devices in the "always-on" PM Domain are part of the
Clock Domain served by the CPG/MSSR or CPG/MSTP driver.

Hook up the CPG/MSTP or CPG/MSSR Clock Domain attach/detach callbacks to
enable power management using module clocks. Which callback to hook up
depends on the presence of device nodes compatible with
"renesas,cpg-mstp-clocks". This clears the path for a future migration
from the CPG/MSTP to the CPG/MSSR driver on R-Car H1 and
Gen2.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/soc/renesas/rcar-sysc.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index 4e760d63f2ab..0d49a25de740 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -9,6 +9,7 @@
  * for more details.
  */
 
+#include <linux/clk/renesas.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/mm.h>
@@ -217,6 +218,8 @@ static int rcar_sysc_pd_power_on(struct generic_pm_domain *genpd)
 	return rcar_sysc_power_up(&pd->ch);
 }
 
+static bool has_cpg_mstp;
+
 static void __init rcar_sysc_pd_setup(struct rcar_sysc_pd *pd)
 {
 	struct generic_pm_domain *genpd = &pd->genpd;
@@ -248,6 +251,18 @@ static void __init rcar_sysc_pd_setup(struct rcar_sysc_pd *pd)
 		gov = &pm_domain_always_on_gov;
 	}
 
+	if (!(pd->flags & (PD_CPU | PD_SCU))) {
+		/* Enable Clock Domain for I/O devices */
+		genpd->flags = GENPD_FLAG_PM_CLK;
+		if (has_cpg_mstp) {
+			genpd->attach_dev = cpg_mstp_attach_dev;
+			genpd->detach_dev = cpg_mstp_detach_dev;
+		} else {
+			genpd->attach_dev = cpg_mssr_attach_dev;
+			genpd->detach_dev = cpg_mssr_detach_dev;
+		}
+	}
+
 	genpd->power_off = rcar_sysc_pd_power_off;
 	genpd->power_on = rcar_sysc_pd_power_on;
 
@@ -294,6 +309,9 @@ static int __init rcar_sysc_pd_init(void)
 
 	info = match->data;
 
+	has_cpg_mstp = of_find_compatible_node(NULL, NULL,
+					       "renesas,cpg-mstp-clocks");
+
 	base = of_iomap(np, 0);
 	if (!base) {
 		pr_warn("%s: Cannot map regs\n", np->full_name);
-- 
2.7.0.rc3.207.g0ac5344
