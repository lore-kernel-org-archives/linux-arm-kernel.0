From: festevam@gmail.com (Fabio Estevam)
Date: Tue,  1 Oct 2013 00:21:13 -0300
Subject: [PATCH 2/3] ARM: mach-imx: mm-imx5: Retrieve tzic base address from dt
In-Reply-To: <1380597674-31122-1-git-send-email-festevam@gmail.com>
References: <1380597674-31122-1-git-send-email-festevam@gmail.com>
Message-ID: <1380597674-31122-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

As mx53 is a dt-only SoC, we should retrieve the tzic base address from the 
device tree, instead of using the old MX53_IO_ADDRESS method.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/mm-imx5.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/mm-imx5.c b/arch/arm/mach-imx/mm-imx5.c
index eb3cce3..2cafcf0 100644
--- a/arch/arm/mach-imx/mm-imx5.c
+++ b/arch/arm/mach-imx/mm-imx5.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/clk.h>
 #include <linux/pinctrl/machine.h>
+#include <linux/of_address.h>
 
 #include <asm/mach/map.h>
 
@@ -100,7 +101,14 @@ void __init mx51_init_irq(void)
 
 void __init mx53_init_irq(void)
 {
-	tzic_init_irq(MX53_IO_ADDRESS(MX53_TZIC_BASE_ADDR));
+	struct device_node *np;
+	void __iomem *base;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx53-tzic");
+	base = of_iomap(np, 0);
+	WARN_ON(!base);
+
+	tzic_init_irq(base);
 }
 
 static struct sdma_platform_data imx51_sdma_pdata __initdata = {
-- 
1.8.1.2
