From: richard.zhao@freescale.com (Richard Zhao)
Date: Fri, 18 Feb 2011 13:47:29 +0800
Subject: [PATCH 1/1] ARM: imx53: correct Silicon Revision definition following
	fuse map
Message-ID: <1298008049-20352-1-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>

diff --git a/arch/arm/mach-mx5/cpu.c b/arch/arm/mach-mx5/cpu.c
index d40671d..95fd5f8 100644
--- a/arch/arm/mach-mx5/cpu.c
+++ b/arch/arm/mach-mx5/cpu.c
@@ -76,13 +76,25 @@ late_initcall(mx51_neon_fixup);
 static int get_mx53_srev(void)
 {
 	void __iomem *iim_base = MX51_IO_ADDRESS(MX53_IIM_BASE_ADDR);
-	u32 rev = readl(iim_base + IIM_SREV) & 0xff;
+	u32 reg = readl(iim_base + IIM_SREV) & 0xff;
+	int rev;
+
+	switch (reg) {
+	case 0x0:
+		rev = IMX_CHIP_REVISION_1_0;
+		break;
+	case 0x2:
+		rev = IMX_CHIP_REVISION_2_0;
+		break;
+	case 0x3:
+		rev = IMX_CHIP_REVISION_2_1;
+		break;
+	default:
+		rev = IMX_CHIP_REVISION_UNKNOWN;
+		break;
+	}
 
-	if (rev == 0x0)
-		return IMX_CHIP_REVISION_1_0;
-	else if (rev == 0x10)
-		return IMX_CHIP_REVISION_2_0;
-	return 0;
+	return rev;
 }
 
 /*
-- 
1.7.1
