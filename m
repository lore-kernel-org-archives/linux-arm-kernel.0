From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Mon, 19 Oct 2015 14:19:33 +0100
Subject: [PATCHv4 07/12] arm64: Simplify NR_FIX_BTMAPS calculation
In-Reply-To: <1445260779-22242-1-git-send-email-suzuki.poulose@arm.com>
References: <1445260779-22242-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1445260779-22242-8-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Rutland <mark.rutland@arm.com>

We choose NR_FIX_BTMAPS such that each slot (NR_FIX_BTMAPS * PAGE_SIZE)
can address 256K.

Use division to derive NR_FIX_BTMAPS rather than defining it for each
page size.

Signed-off-by:  Mark Rutland <mark.rutland@arm.com>
Signed-off-by:  Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/fixmap.h |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
index 8b9884c..3097045 100644
--- a/arch/arm64/include/asm/fixmap.h
+++ b/arch/arm64/include/asm/fixmap.h
@@ -17,6 +17,7 @@
 
 #ifndef __ASSEMBLY__
 #include <linux/kernel.h>
+#include <linux/sizes.h>
 #include <asm/boot.h>
 #include <asm/page.h>
 
@@ -55,11 +56,7 @@ enum fixed_addresses {
 	 * Temporary boot-time mappings, used by early_ioremap(),
 	 * before ioremap() is functional.
 	 */
-#ifdef CONFIG_ARM64_64K_PAGES
-#define NR_FIX_BTMAPS		4
-#else
-#define NR_FIX_BTMAPS		64
-#endif
+#define NR_FIX_BTMAPS		(SZ_256K / PAGE_SIZE)
 #define FIX_BTMAPS_SLOTS	7
 #define TOTAL_FIX_BTMAPS	(NR_FIX_BTMAPS * FIX_BTMAPS_SLOTS)
 
-- 
1.7.9.5
