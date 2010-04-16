From: r.herring@freescale.com (Rob Herring)
Date: Fri, 16 Apr 2010 14:35:17 -0500
Subject: [RFC PATCH 03/10] mx51: convert iomux and wdog to ioremap
Message-ID: <1271446524-26450-4-git-send-email-r.herring@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Rob Herring <r.herring@freescale.com>
---
 arch/arm/mach-mx5/mm.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mx5/mm.c b/arch/arm/mach-mx5/mm.c
index b7677ef..9c9ae3b 100644
--- a/arch/arm/mach-mx5/mm.c
+++ b/arch/arm/mach-mx5/mm.c
@@ -13,6 +13,7 @@
 
 #include <linux/mm.h>
 #include <linux/init.h>
+#include <linux/io.h>
 
 #include <asm/mach/map.h>
 
@@ -59,9 +60,14 @@ static struct map_desc mxc_io_desc[] __initdata = {
  */
 void __init mx51_map_io(void)
 {
+	void __iomem *base;
+
 	mxc_set_cpu_type(MXC_CPU_MX51);
-	mxc_iomux_v3_init(MX51_IO_ADDRESS(MX51_IOMUXC_BASE_ADDR));
-	mxc_arch_reset_init(MX51_IO_ADDRESS(MX51_WDOG_BASE_ADDR));
+
+	base = ioremap(MX51_IOMUXC_BASE_ADDR, SZ_4K);
+	mxc_iomux_v3_init(base);
+	base = ioremap(MX51_WDOG_BASE_ADDR, SZ_4K);
+	mxc_arch_reset_init(base);
 	iotable_init(mxc_io_desc, ARRAY_SIZE(mxc_io_desc));
 }
 
-- 
1.6.0.4
