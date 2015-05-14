From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 14 May 2015 18:12:47 +0200
Subject: [PATCH 03/10] ARM: ux500: remap BB offset dynamically
Message-ID: <1431619967-14930-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of relying on static maps, remap the BB chip ID
offset dynamically.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/cpu-db8500.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 391d329a7e88..0b3ebbf38702 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -104,14 +104,18 @@ static struct arm_pmu_platdata db8500_pmu_platdata = {
 
 static const char *db8500_read_soc_id(void)
 {
-	void __iomem *uid = __io_address(U8500_BB_UID_BASE);
+	void __iomem *uid;
 
+	uid = ioremap(U8500_BB_UID_BASE, 0x20);
+	if (!uid)
+		return NULL;
 	/* Throw these device-specific numbers into the entropy pool */
 	add_device_randomness(uid, 0x14);
 	return kasprintf(GFP_KERNEL, "%08x%08x%08x%08x%08x",
 			 readl((u32 *)uid+0),
 			 readl((u32 *)uid+1), readl((u32 *)uid+2),
 			 readl((u32 *)uid+3), readl((u32 *)uid+4));
+	iounmap(uid);
 }
 
 static struct device * __init db8500_soc_device_init(void)
-- 
1.9.3
