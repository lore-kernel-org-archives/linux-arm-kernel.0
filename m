From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri,  1 Jul 2011 10:57:32 +0900
Subject: [PATCH V2 3/8] ARM: EXYNOS4: Add support PM with external GIC
In-Reply-To: <1309485457-13305-1-git-send-email-kgene.kim@samsung.com>
References: <1309485457-13305-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1309485457-13305-4-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jaecheol Lee <jc.lee@samsung.com>

Signed-off-by: Jaecheol Lee <jc.lee@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos4/pm.c |   43 +++++++++++++++++++++++++++++++++++++------
 1 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-exynos4/pm.c b/arch/arm/mach-exynos4/pm.c
index 4d9ee97..9b5f3a5 100644
--- a/arch/arm/mach-exynos4/pm.c
+++ b/arch/arm/mach-exynos4/pm.c
@@ -154,6 +154,22 @@ static struct sleep_save exynos4_core_save[] = {
 	SAVE_ITEM(S5P_VA_GIC_DIST + 0x454),
 	SAVE_ITEM(S5P_VA_GIC_DIST + 0x458),
 	SAVE_ITEM(S5P_VA_GIC_DIST + 0x45C),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x460),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x464),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x468),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x46C),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x470),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x474),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x478),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x47C),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x480),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x484),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x488),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x48C),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x490),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x494),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x498),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x49C),
 
 	SAVE_ITEM(S5P_VA_GIC_DIST + 0x800),
 	SAVE_ITEM(S5P_VA_GIC_DIST + 0x804),
@@ -179,6 +195,22 @@ static struct sleep_save exynos4_core_save[] = {
 	SAVE_ITEM(S5P_VA_GIC_DIST + 0x854),
 	SAVE_ITEM(S5P_VA_GIC_DIST + 0x858),
 	SAVE_ITEM(S5P_VA_GIC_DIST + 0x85C),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x860),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x864),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x868),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x86C),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x870),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x874),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x878),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x87C),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x880),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x884),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x888),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x88C),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x890),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x894),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x898),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0x89C),
 
 	SAVE_ITEM(S5P_VA_GIC_DIST + 0xC00),
 	SAVE_ITEM(S5P_VA_GIC_DIST + 0xC04),
@@ -186,17 +218,16 @@ static struct sleep_save exynos4_core_save[] = {
 	SAVE_ITEM(S5P_VA_GIC_DIST + 0xC0C),
 	SAVE_ITEM(S5P_VA_GIC_DIST + 0xC10),
 	SAVE_ITEM(S5P_VA_GIC_DIST + 0xC14),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0xC18),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0xC1C),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0xC20),
+	SAVE_ITEM(S5P_VA_GIC_DIST + 0xC24),
+
 
 	SAVE_ITEM(S5P_VA_COMBINER_BASE + 0x000),
 	SAVE_ITEM(S5P_VA_COMBINER_BASE + 0x010),
 	SAVE_ITEM(S5P_VA_COMBINER_BASE + 0x020),
 	SAVE_ITEM(S5P_VA_COMBINER_BASE + 0x030),
-	SAVE_ITEM(S5P_VA_COMBINER_BASE + 0x040),
-	SAVE_ITEM(S5P_VA_COMBINER_BASE + 0x050),
-	SAVE_ITEM(S5P_VA_COMBINER_BASE + 0x060),
-	SAVE_ITEM(S5P_VA_COMBINER_BASE + 0x070),
-	SAVE_ITEM(S5P_VA_COMBINER_BASE + 0x080),
-	SAVE_ITEM(S5P_VA_COMBINER_BASE + 0x090),
 };
 
 static struct sleep_save exynos4_l2cc_save[] = {
-- 
1.7.1
