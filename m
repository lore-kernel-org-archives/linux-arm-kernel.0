From: 21cnbao@gmail.com (Barry Song)
Date: Wed,  7 May 2014 15:08:21 +0800
Subject: [PATCH] ARM: prima2: rstc: fix some minor checkpatch issues
Message-ID: <1399446501-22346-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Xianglong Du <Xianglong.Du@csr.com>

this patch fixes the below minor issues:

WARNING: line over 80 characters
39: FILE: arch/arm/mach-prima2/rstc.c:39:
+                * Writing 1 to this bit resets corresponding block. Writing 0 to this

WARNING: line over 80 characters
41: FILE: arch/arm/mach-prima2/rstc.c:41:
+                * datasheet doesn't require explicit delay between the set and clear

WARNING: line over 80 characters
44: FILE: arch/arm/mach-prima2/rstc.c:44:
+               writel(readl(sirfsoc_rstc_base + (reset_bit / 32) * 4) | (1 << reset_bit),

WARNING: msleep < 20ms can sleep for up to 20ms; see Documentation/timers/timers-howto.txt
46: FILE: arch/arm/mach-prima2/rstc.c:46:
+               msleep(10);

WARNING: line over 80 characters
47: FILE: arch/arm/mach-prima2/rstc.c:47:
+               writel(readl(sirfsoc_rstc_base + (reset_bit / 32) * 4) & ~(1 << reset_bit),

WARNING: line over 80 characters
52: FILE: arch/arm/mach-prima2/rstc.c:52:
+                * Writing 1 to SET register resets corresponding block. Writing 1 to CLEAR

WARNING: line over 80 characters
54: FILE: arch/arm/mach-prima2/rstc.c:54:
+                * datasheet doesn't require explicit delay between the set and clear

WARNING: line over 80 characters
57: FILE: arch/arm/mach-prima2/rstc.c:57:
+               writel(1 << reset_bit, sirfsoc_rstc_base + (reset_bit / 32) * 8);

WARNING: msleep < 20ms can sleep for up to 20ms; see Documentation/timers/timers-howto.txt
58: FILE: arch/arm/mach-prima2/rstc.c:58:
+               msleep(10);

WARNING: line over 80 characters
59: FILE: arch/arm/mach-prima2/rstc.c:59:
+               writel(1 << reset_bit, sirfsoc_rstc_base + (reset_bit / 32) * 8 + 4);

total: 0 errors, 10 warnings, 120 lines checked

Signed-off-by: Xianglong Du <Xianglong.Du@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/mach-prima2/rstc.c |   34 ++++++++++++++++++++--------------
 1 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-prima2/rstc.c b/arch/arm/mach-prima2/rstc.c
index 4887a2a..3dffcb2 100644
--- a/arch/arm/mach-prima2/rstc.c
+++ b/arch/arm/mach-prima2/rstc.c
@@ -36,27 +36,33 @@ static int sirfsoc_reset_module(struct reset_controller_dev *rcdev,
 
 	if (of_device_is_compatible(rcdev->of_node, "sirf,prima2-rstc")) {
 		/*
-		 * Writing 1 to this bit resets corresponding block. Writing 0 to this
-		 * bit de-asserts reset signal of the corresponding block.
-		 * datasheet doesn't require explicit delay between the set and clear
-		 * of reset bit. it could be shorter if tests pass.
+		 * Writing 1 to this bit resets corresponding block.
+		 * Writing 0 to this bit de-asserts reset signal of the
+		 * corresponding block. datasheet doesn't require explicit
+		 * delay between the set and clear of reset bit. it could
+		 * be shorter if tests pass.
 		 */
-		writel(readl(sirfsoc_rstc_base + (reset_bit / 32) * 4) | (1 << reset_bit),
+		writel(readl(sirfsoc_rstc_base +
+			(reset_bit / 32) * 4) | (1 << reset_bit),
 			sirfsoc_rstc_base + (reset_bit / 32) * 4);
-		msleep(10);
-		writel(readl(sirfsoc_rstc_base + (reset_bit / 32) * 4) & ~(1 << reset_bit),
+		msleep(20);
+		writel(readl(sirfsoc_rstc_base +
+			(reset_bit / 32) * 4) & ~(1 << reset_bit),
 			sirfsoc_rstc_base + (reset_bit / 32) * 4);
 	} else {
 		/*
 		 * For MARCO and POLO
-		 * Writing 1 to SET register resets corresponding block. Writing 1 to CLEAR
-		 * register de-asserts reset signal of the corresponding block.
-		 * datasheet doesn't require explicit delay between the set and clear
-		 * of reset bit. it could be shorter if tests pass.
+		 * Writing 1 to SET register resets corresponding block.
+		 * Writing 1 to CLEAR register de-asserts reset signal of the
+		 * corresponding block.
+		 * datasheet doesn't require explicit delay between the set and
+		 * clear of reset bit. it could be shorter if tests pass.
 		 */
-		writel(1 << reset_bit, sirfsoc_rstc_base + (reset_bit / 32) * 8);
-		msleep(10);
-		writel(1 << reset_bit, sirfsoc_rstc_base + (reset_bit / 32) * 8 + 4);
+		writel(1 << reset_bit,
+			sirfsoc_rstc_base + (reset_bit / 32) * 8);
+		msleep(20);
+		writel(1 << reset_bit,
+			sirfsoc_rstc_base + (reset_bit / 32) * 8 + 4);
 	}
 
 	mutex_unlock(&rstc_lock);
-- 
1.7.0.4
