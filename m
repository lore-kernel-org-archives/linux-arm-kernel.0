From: ping.bai@nxp.com (Bai Ping)
Date: Fri,  2 Feb 2018 16:06:27 +0800
Subject: [PATCH v2] ARM: imx: Improve the soc revision calculation flow
Message-ID: <1517558787-12858-1-git-send-email-ping.bai@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On our i.MX6 SOC, the DIGPROG register is used for representing the
SOC ID and silicon revision. The revision has two part: MAJOR and
MINOR. each is represented in 8 bits in the register.

bits [15:8]: reflect the MAJOR part of the revision;
bits [7:0]: reflect the MINOR part of the revision;

In our linux kernel, the soc revision is represented in 8 bits.
MAJOR part and MINOR each occupy 4 bits.

previous method does NOT take care about the MAJOR part in DIGPROG
register. So reformat the revision read from the HW to be compatible
with the revision format used in kernel.

Signed-off-by: Bai Ping <ping.bai@nxp.com>
---
v2:
 - remove redundant line
 - use u8 instead of u16 for 'major_part'&'minor_part' variables
---
 arch/arm/mach-imx/anatop.c | 56 ++++++++++++++++------------------------------
 1 file changed, 19 insertions(+), 37 deletions(-)

diff --git a/arch/arm/mach-imx/anatop.c b/arch/arm/mach-imx/anatop.c
index 649a84c..61f3d94 100644
--- a/arch/arm/mach-imx/anatop.c
+++ b/arch/arm/mach-imx/anatop.c
@@ -1,5 +1,6 @@
 /*
  * Copyright (C) 2013-2015 Freescale Semiconductor, Inc.
+ * Copyright 2017-2018 NXP.
  *
  * The code contained herein is licensed under the GNU General Public
  * License. You may obtain a copy of the GNU General Public License
@@ -116,6 +117,7 @@ void __init imx_init_revision_from_anatop(void)
 	unsigned int revision;
 	u32 digprog;
 	u16 offset = ANADIG_DIGPROG;
+	u8 major_part, minor_part;
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-anatop");
 	anatop_base = of_iomap(np, 0);
@@ -127,45 +129,25 @@ void __init imx_init_revision_from_anatop(void)
 	digprog = readl_relaxed(anatop_base + offset);
 	iounmap(anatop_base);
 
-	switch (digprog & 0xff) {
-	case 0:
-		/*
-		 * For i.MX6QP, most of the code for i.MX6Q can be resued,
-		 * so internally, we identify it as i.MX6Q Rev 2.0
-		 */
-		if (digprog >> 8 & 0x01)
-			revision = IMX_CHIP_REVISION_2_0;
-		else
-			revision = IMX_CHIP_REVISION_1_0;
-		break;
-	case 1:
-		revision = IMX_CHIP_REVISION_1_1;
-		break;
-	case 2:
-		revision = IMX_CHIP_REVISION_1_2;
-		break;
-	case 3:
-		revision = IMX_CHIP_REVISION_1_3;
-		break;
-	case 4:
-		revision = IMX_CHIP_REVISION_1_4;
-		break;
-	case 5:
-		/*
-		 * i.MX6DQ TO1.5 is defined as Rev 1.3 in Data Sheet, marked
-		 * as 'D' in Part Number last character.
-		 */
-		revision = IMX_CHIP_REVISION_1_5;
-		break;
-	default:
+	/*
+	 * On i.MX7D digprog value match linux version format, so
+	 * it needn't map again and we can use register value directly.
+	 */
+	if (of_device_is_compatible(np, "fsl,imx7d-anatop")) {
+		revision = digprog & 0xff;
+	} else {
 		/*
-		 * Fail back to return raw register value instead of 0xff.
-		 * It will be easy to know version information in SOC if it
-		 * can't be recognized by known version. And some chip's (i.MX7D)
-		 * digprog value match linux version format, so it needn't map
-		 * again and we can use register value directly.
+		 * MAJOR: [15:8], the major silicon revison;
+		 * MINOR: [7: 0], the minor silicon revison;
+		 *
+		 * please refer to the i.MX RM for the detailed
+		 * silicon revison bit define.
+		 * format the major part and minor part to match the
+		 * linux kernel soc version format.
 		 */
-		revision = digprog & 0xff;
+		major_part = (digprog >> 8) & 0xf;
+		minor_part = digprog & 0xf;
+		revision = ((major_part + 1) << 4) | minor_part;
 	}
 
 	mxc_set_cpu_type(digprog >> 16 & 0xff);
-- 
1.9.1
