From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 22 Feb 2016 09:31:02 +0100
Subject: [PATCH] ARM: ux500: fix ureachable iounmap()
Message-ID: <1456129862-3918-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The code was executing a return with a pointer before reaching
iounmap().

Reported-by: David Binderman <dcb314@hotmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC folks: I have no other Ux500 patches queued, so can
you please apply this patch directly for-next somewhere,
thanks.
---
 arch/arm/mach-ux500/cpu-db8500.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index a0ffaad1fb61..a557955472ea 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -76,17 +76,19 @@ static struct arm_pmu_platdata db8500_pmu_platdata = {
 static const char *db8500_read_soc_id(void)
 {
 	void __iomem *uid;
+	const char *retstr;
 
 	uid = ioremap(U8500_BB_UID_BASE, 0x20);
 	if (!uid)
 		return NULL;
 	/* Throw these device-specific numbers into the entropy pool */
 	add_device_randomness(uid, 0x14);
-	return kasprintf(GFP_KERNEL, "%08x%08x%08x%08x%08x",
+	retstr = kasprintf(GFP_KERNEL, "%08x%08x%08x%08x%08x",
 			 readl((u32 *)uid+0),
 			 readl((u32 *)uid+1), readl((u32 *)uid+2),
 			 readl((u32 *)uid+3), readl((u32 *)uid+4));
 	iounmap(uid);
+	return retstr;
 }
 
 static struct device * __init db8500_soc_device_init(void)
-- 
2.4.3
