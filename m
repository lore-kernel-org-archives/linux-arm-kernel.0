From: r.herring@freescale.com (Rob Herring)
Date: Fri, 16 Apr 2010 14:35:16 -0500
Subject: [RFC PATCH 02/10] mx51: convert AIPS bus setup to ioremap
Message-ID: <1271446524-26450-3-git-send-email-r.herring@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Rob Herring <r.herring@freescale.com>
---
 arch/arm/mach-mx5/cpu.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mx5/cpu.c b/arch/arm/mach-mx5/cpu.c
index 2d37785..283ab7e 100644
--- a/arch/arm/mach-mx5/cpu.c
+++ b/arch/arm/mach-mx5/cpu.c
@@ -15,8 +15,8 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/io.h>
 #include <mach/hardware.h>
-#include <asm/io.h>
 
 static int cpu_silicon_rev = -1;
 
@@ -78,21 +78,23 @@ static int __init post_cpu_init(void)
 	if (!cpu_is_mx51())
 		return 0;
 
-	base = MX51_IO_ADDRESS(MX51_AIPS1_BASE_ADDR);
+	base = ioremap(MX51_AIPS1_BASE_ADDR, SZ_4K);
 	__raw_writel(0x0, base + 0x40);
 	__raw_writel(0x0, base + 0x44);
 	__raw_writel(0x0, base + 0x48);
 	__raw_writel(0x0, base + 0x4C);
 	reg = __raw_readl(base + 0x50) & 0x00FFFFFF;
 	__raw_writel(reg, base + 0x50);
+	iounmap(base);
 
-	base = MX51_IO_ADDRESS(MX51_AIPS2_BASE_ADDR);
+	base = ioremap(MX51_AIPS2_BASE_ADDR, SZ_4K);
 	__raw_writel(0x0, base + 0x40);
 	__raw_writel(0x0, base + 0x44);
 	__raw_writel(0x0, base + 0x48);
 	__raw_writel(0x0, base + 0x4C);
 	reg = __raw_readl(base + 0x50) & 0x00FFFFFF;
 	__raw_writel(reg, base + 0x50);
+	iounmap(base);
 
 	return 0;
 }
-- 
1.6.0.4
