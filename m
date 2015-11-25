From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Nov 2015 16:37:49 +0100
Subject: [PATCH 1/7] clk: mmp: stop using platform headers
In-Reply-To: <1448465875-435039-1-git-send-email-arnd@arndb.de>
References: <1448465875-435039-1-git-send-email-arnd@arndb.de>
Message-ID: <1448465875-435039-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mmp clock drivers currently hardcode the physical addresses for
the clock registers. This is generally a bad idea, and it also gets in
the way of multiplatform builds, which make the platform header files
inaccessible to device drivers.

To work around the header file problem, this patch changes the calling
convention so the three mmp clock drivers get initialized with the base
addresses as arguments from the platform code.

It would still be useful to have a larger rework of the clock drivers,
with DT integration to let the clocks actually be probed automatically,
and the base addresses passed as DT properties. I am unsure if anyone
is still interested in the mmp platform, so it is possible that this
won't happen.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Chao Xie <chao.xie@marvell.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 arch/arm/mach-mmp/clock-mmp2.c   |  4 +++-
 arch/arm/mach-mmp/clock-pxa168.c |  4 +++-
 arch/arm/mach-mmp/clock-pxa910.c |  4 +++-
 arch/arm/mach-mmp/common.h       |  3 ---
 arch/arm/mach-mmp/mmp2.c         |  5 ++++-
 arch/arm/mach-mmp/pxa168.c       |  5 ++++-
 arch/arm/mach-mmp/pxa910.c       |  6 +++++-
 drivers/clk/mmp/clk-mmp2.c       | 12 ++++++------
 drivers/clk/mmp/clk-pxa168.c     | 12 ++++++------
 drivers/clk/mmp/clk-pxa910.c     | 14 +++++++-------
 include/linux/clk/mmp.h          | 17 +++++++++++++++++
 11 files changed, 58 insertions(+), 28 deletions(-)
 create mode 100644 include/linux/clk/mmp.h

diff --git a/arch/arm/mach-mmp/clock-mmp2.c b/arch/arm/mach-mmp/clock-mmp2.c
index 53d77cbd6000..6847c49bbb39 100644
--- a/arch/arm/mach-mmp/clock-mmp2.c
+++ b/arch/arm/mach-mmp/clock-mmp2.c
@@ -4,6 +4,7 @@
 #include <linux/list.h>
 #include <linux/io.h>
 #include <linux/clk.h>
+#include <linux/clk/mmp.h>
 
 #include <mach/addr-map.h>
 
@@ -105,7 +106,8 @@ static struct clk_lookup mmp2_clkregs[] = {
 	INIT_CLKREG(&clk_sdh3, "sdhci-pxav3.3", "PXA-SDHCLK"),
 };
 
-void __init mmp2_clk_init(void)
+void __init mmp2_clk_init(phys_addr_t mpmu_phys, phys_addr_t apmu_phys,
+			  phys_addr_t apbc_phys)
 {
 	clkdev_add_table(ARRAY_AND_SIZE(mmp2_clkregs));
 }
diff --git a/arch/arm/mach-mmp/clock-pxa168.c b/arch/arm/mach-mmp/clock-pxa168.c
index c572f219ae26..bfa54bb16449 100644
--- a/arch/arm/mach-mmp/clock-pxa168.c
+++ b/arch/arm/mach-mmp/clock-pxa168.c
@@ -4,6 +4,7 @@
 #include <linux/list.h>
 #include <linux/io.h>
 #include <linux/clk.h>
+#include <linux/clk/mmp.h>
 
 #include <mach/addr-map.h>
 
@@ -85,7 +86,8 @@ static struct clk_lookup pxa168_clkregs[] = {
 	INIT_CLKREG(&clk_rtc, "sa1100-rtc", NULL),
 };
 
-void __init pxa168_clk_init(void)
+void __init pxa168_clk_init(phys_addr_t mpmu_phys, phys_addr_t apmu_phys,
+			    phys_addr_t apbc_phys)
 {
 	clkdev_add_table(ARRAY_AND_SIZE(pxa168_clkregs));
 }
diff --git a/arch/arm/mach-mmp/clock-pxa910.c b/arch/arm/mach-mmp/clock-pxa910.c
index 379e1df61c70..ef7d3dbc8731 100644
--- a/arch/arm/mach-mmp/clock-pxa910.c
+++ b/arch/arm/mach-mmp/clock-pxa910.c
@@ -4,6 +4,7 @@
 #include <linux/list.h>
 #include <linux/io.h>
 #include <linux/clk.h>
+#include <linux/clk/mmp.h>
 
 #include <mach/addr-map.h>
 
@@ -61,7 +62,8 @@ static struct clk_lookup pxa910_clkregs[] = {
 	INIT_CLKREG(&clk_rtc, "sa1100-rtc", NULL),
 };
 
-void __init pxa910_clk_init(void)
+void __init pxa910_clk_init(phys_addr_t mpmu_phys, phys_addr_t apmu_phys,
+			    phys_addr_t apbc_phys, phys_addr_t apbcp_phys)
 {
 	clkdev_add_table(ARRAY_AND_SIZE(pxa910_clkregs));
 }
diff --git a/arch/arm/mach-mmp/common.h b/arch/arm/mach-mmp/common.h
index cf445bae6d77..7453a90c34bd 100644
--- a/arch/arm/mach-mmp/common.h
+++ b/arch/arm/mach-mmp/common.h
@@ -5,6 +5,3 @@ extern void timer_init(int irq);
 
 extern void __init mmp_map_io(void);
 extern void mmp_restart(enum reboot_mode, const char *);
-extern void __init pxa168_clk_init(void);
-extern void __init pxa910_clk_init(void);
-extern void __init mmp2_clk_init(void);
diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
index a70b5530bd42..c8914ef21f7f 100644
--- a/arch/arm/mach-mmp/mmp2.c
+++ b/arch/arm/mach-mmp/mmp2.c
@@ -9,6 +9,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#include <linux/clk/mmp.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -111,7 +112,9 @@ static int __init mmp2_init(void)
 		mfp_init_base(MFPR_VIRT_BASE);
 		mfp_init_addr(mmp2_addr_map);
 		pxa_init_dma(IRQ_MMP2_DMA_RIQ, 16);
-		mmp2_clk_init();
+		mmp2_clk_init(APB_PHYS_BASE + 0x50000,
+			      AXI_PHYS_BASE + 0x82800,
+			      APB_PHYS_BASE + 0x15000);
 	}
 
 	return 0;
diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
index 144e997624c0..53f21554ae63 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -13,6 +13,7 @@
 #include <linux/list.h>
 #include <linux/io.h>
 #include <linux/clk.h>
+#include <linux/clk/mmp.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/mv_usb.h>
 
@@ -56,7 +57,9 @@ static int __init pxa168_init(void)
 		mfp_init_base(MFPR_VIRT_BASE);
 		mfp_init_addr(pxa168_mfp_addr_map);
 		pxa_init_dma(IRQ_PXA168_DMA_INT0, 32);
-		pxa168_clk_init();
+		pxa168_clk_init(APB_PHYS_BASE + 0x50000,
+				AXI_PHYS_BASE + 0x82800,
+				APB_PHYS_BASE + 0x15000);
 	}
 
 	return 0;
diff --git a/arch/arm/mach-mmp/pxa910.c b/arch/arm/mach-mmp/pxa910.c
index eb57ee196842..545404261327 100644
--- a/arch/arm/mach-mmp/pxa910.c
+++ b/arch/arm/mach-mmp/pxa910.c
@@ -7,6 +7,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#include <linux/clk/mmp.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -97,7 +98,10 @@ static int __init pxa910_init(void)
 		mfp_init_base(MFPR_VIRT_BASE);
 		mfp_init_addr(pxa910_mfp_addr_map);
 		pxa_init_dma(IRQ_PXA910_DMA_INT0, 32);
-		pxa910_clk_init();
+		pxa910_clk_init(APB_PHYS_BASE + 0x50000,
+				AXI_PHYS_BASE + 0x82800,
+				APB_PHYS_BASE + 0x15000,
+				APB_PHYS_BASE + 0x3b000);
 	}
 
 	return 0;
diff --git a/drivers/clk/mmp/clk-mmp2.c b/drivers/clk/mmp/clk-mmp2.c
index 09d2832fbd78..38931dbd1eff 100644
--- a/drivers/clk/mmp/clk-mmp2.c
+++ b/drivers/clk/mmp/clk-mmp2.c
@@ -9,6 +9,7 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
@@ -16,8 +17,6 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 
-#include <mach/addr-map.h>
-
 #include "clk.h"
 
 #define APBC_RTC	0x0
@@ -73,7 +72,8 @@ static const char *sdh_parent[] = {"pll1_4", "pll2", "usb_pll", "pll1"};
 static const char *disp_parent[] = {"pll1", "pll1_16", "pll2", "vctcxo"};
 static const char *ccic_parent[] = {"pll1_2", "pll1_16", "vctcxo"};
 
-void __init mmp2_clk_init(void)
+void __init mmp2_clk_init(phys_addr_t mpmu_phys, phys_addr_t apmu_phys,
+			  phys_addr_t apbc_phys)
 {
 	struct clk *clk;
 	struct clk *vctcxo;
@@ -81,19 +81,19 @@ void __init mmp2_clk_init(void)
 	void __iomem *apmu_base;
 	void __iomem *apbc_base;
 
-	mpmu_base = ioremap(APB_PHYS_BASE + 0x50000, SZ_4K);
+	mpmu_base = ioremap(mpmu_phys, SZ_4K);
 	if (mpmu_base == NULL) {
 		pr_err("error to ioremap MPMU base\n");
 		return;
 	}
 
-	apmu_base = ioremap(AXI_PHYS_BASE + 0x82800, SZ_4K);
+	apmu_base = ioremap(apmu_phys, SZ_4K);
 	if (apmu_base == NULL) {
 		pr_err("error to ioremap APMU base\n");
 		return;
 	}
 
-	apbc_base = ioremap(APB_PHYS_BASE + 0x15000, SZ_4K);
+	apbc_base = ioremap(apbc_phys, SZ_4K);
 	if (apbc_base == NULL) {
 		pr_err("error to ioremap APBC base\n");
 		return;
diff --git a/drivers/clk/mmp/clk-pxa168.c b/drivers/clk/mmp/clk-pxa168.c
index 93e967c0f972..0dd83fb950c9 100644
--- a/drivers/clk/mmp/clk-pxa168.c
+++ b/drivers/clk/mmp/clk-pxa168.c
@@ -9,6 +9,7 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
@@ -16,8 +17,6 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 
-#include <mach/addr-map.h>
-
 #include "clk.h"
 
 #define APBC_RTC	0x28
@@ -66,7 +65,8 @@ static const char *disp_parent[] = {"pll1_2", "pll1_12"};
 static const char *ccic_parent[] = {"pll1_2", "pll1_12"};
 static const char *ccic_phy_parent[] = {"pll1_6", "pll1_12"};
 
-void __init pxa168_clk_init(void)
+void __init pxa168_clk_init(phys_addr_t mpmu_phys, phys_addr_t apmu_phys,
+			    phys_addr_t apbc_phys)
 {
 	struct clk *clk;
 	struct clk *uart_pll;
@@ -74,19 +74,19 @@ void __init pxa168_clk_init(void)
 	void __iomem *apmu_base;
 	void __iomem *apbc_base;
 
-	mpmu_base = ioremap(APB_PHYS_BASE + 0x50000, SZ_4K);
+	mpmu_base = ioremap(mpmu_phys, SZ_4K);
 	if (mpmu_base == NULL) {
 		pr_err("error to ioremap MPMU base\n");
 		return;
 	}
 
-	apmu_base = ioremap(AXI_PHYS_BASE + 0x82800, SZ_4K);
+	apmu_base = ioremap(apmu_phys, SZ_4K);
 	if (apmu_base == NULL) {
 		pr_err("error to ioremap APMU base\n");
 		return;
 	}
 
-	apbc_base = ioremap(APB_PHYS_BASE + 0x15000, SZ_4K);
+	apbc_base = ioremap(apbc_phys, SZ_4K);
 	if (apbc_base == NULL) {
 		pr_err("error to ioremap APBC base\n");
 		return;
diff --git a/drivers/clk/mmp/clk-pxa910.c b/drivers/clk/mmp/clk-pxa910.c
index 993abcdb32cc..e1d2ce22cdf1 100644
--- a/drivers/clk/mmp/clk-pxa910.c
+++ b/drivers/clk/mmp/clk-pxa910.c
@@ -9,6 +9,7 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
@@ -16,8 +17,6 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 
-#include <mach/addr-map.h>
-
 #include "clk.h"
 
 #define APBC_RTC	0x28
@@ -64,7 +63,8 @@ static const char *disp_parent[] = {"pll1_2", "pll1_12"};
 static const char *ccic_parent[] = {"pll1_2", "pll1_12"};
 static const char *ccic_phy_parent[] = {"pll1_6", "pll1_12"};
 
-void __init pxa910_clk_init(void)
+void __init pxa910_clk_init(phys_addr_t mpmu_phys, phys_addr_t apmu_phys,
+			    phys_addr_t apbc_phys, phys_addr_t apbcp_phys)
 {
 	struct clk *clk;
 	struct clk *uart_pll;
@@ -73,25 +73,25 @@ void __init pxa910_clk_init(void)
 	void __iomem *apbcp_base;
 	void __iomem *apbc_base;
 
-	mpmu_base = ioremap(APB_PHYS_BASE + 0x50000, SZ_4K);
+	mpmu_base = ioremap(mpmu_phys, SZ_4K);
 	if (mpmu_base == NULL) {
 		pr_err("error to ioremap MPMU base\n");
 		return;
 	}
 
-	apmu_base = ioremap(AXI_PHYS_BASE + 0x82800, SZ_4K);
+	apmu_base = ioremap(apmu_phys, SZ_4K);
 	if (apmu_base == NULL) {
 		pr_err("error to ioremap APMU base\n");
 		return;
 	}
 
-	apbcp_base = ioremap(APB_PHYS_BASE + 0x3b000, SZ_4K);
+	apbcp_base = ioremap(apbcp_phys, SZ_4K);
 	if (apbcp_base == NULL) {
 		pr_err("error to ioremap APBC extension base\n");
 		return;
 	}
 
-	apbc_base = ioremap(APB_PHYS_BASE + 0x15000, SZ_4K);
+	apbc_base = ioremap(apbc_phys, SZ_4K);
 	if (apbc_base == NULL) {
 		pr_err("error to ioremap APBC base\n");
 		return;
diff --git a/include/linux/clk/mmp.h b/include/linux/clk/mmp.h
new file mode 100644
index 000000000000..607321fa2c2b
--- /dev/null
+++ b/include/linux/clk/mmp.h
@@ -0,0 +1,17 @@
+#ifndef __CLK_MMP_H
+#define __CLK_MMP_H
+
+#include <linux/types.h>
+
+extern void pxa168_clk_init(phys_addr_t mpmu_phys,
+			    phys_addr_t apmu_phys,
+			    phys_addr_t apbc_phys);
+extern void pxa910_clk_init(phys_addr_t mpmu_phys,
+			    phys_addr_t apmu_phys,
+			    phys_addr_t apbc_phys,
+			    phys_addr_t apbcp_phys);
+extern void mmp2_clk_init(phys_addr_t mpmu_phys,
+			  phys_addr_t apmu_phys,
+			  phys_addr_t apbc_phys);
+
+#endif
-- 
2.1.0.rc2
