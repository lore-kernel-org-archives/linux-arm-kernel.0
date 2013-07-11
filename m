From: shinya.kuribayashi.px@renesas.com (Shinya Kuribayashi)
Date: Thu, 11 Jul 2013 18:52:05 +0900
Subject: [PATCH 2/4] ARM: shmobile: smp-r8a7790: rename s/carescnt/rescnt/g
In-Reply-To: <51DE7FF4.5050800@renesas.com>
References: <20130710104151.20742.56398.sendpatchset@w520>
 <51DE7FF4.5050800@renesas.com>
Message-ID: <51DE8045.5070206@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I don't have strong opinion on this one.  Leave it to you.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
---
 arch/arm/mach-shmobile/smp-r8a7790.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-shmobile/smp-r8a7790.c b/arch/arm/mach-shmobile/smp-r8a7790.c
index 1ab4c04..e8c2636 100644
--- a/arch/arm/mach-shmobile/smp-r8a7790.c
+++ b/arch/arm/mach-shmobile/smp-r8a7790.c
@@ -36,18 +36,18 @@ enum { R8A7790_CLST_CA15, R8A7790_CLST_CA7, R8A7790_CLST_NR };
 
 static struct {
 	unsigned int cabar;
-	unsigned int carescnt;
-	unsigned int carescnt_magic;
+	unsigned int rescnt;
+	unsigned int rescnt_magic;
 } r8a7790_clst[R8A7790_CLST_NR] = {
 	[R8A7790_CLST_CA15] = {
 		.cabar = CA15BAR,
-		.carescnt = CA15RESCNT,
-		.carescnt_magic = 0xa5a50000,
+		.rescnt = CA15RESCNT,
+		.rescnt_magic = 0xa5a50000,
 	},
 	[R8A7790_CLST_CA7] = {
 		.cabar = CA7BAR,
-		.carescnt = CA7RESCNT,
-		.carescnt_magic = 0x5a5a0000,
+		.rescnt = CA7RESCNT,
+		.rescnt_magic = 0x5a5a0000,
 	},
 };
 
@@ -56,7 +56,7 @@ static struct {
 
 static void r8a7790_deassert_reset(unsigned int cpu)
 {
-	void __iomem *p, *carescnt;
+	void __iomem *p, *rescnt;
 	u32 bar, mask, magic;
 	unsigned int clst_id = r8a7790_clst_id(cpu);
 
@@ -68,16 +68,16 @@ static void r8a7790_deassert_reset(unsigned int cpu)
 
 	/* enable per-core clocks */
 	mask = BIT(3 - r8a7790_cpu_id(cpu));
-	magic = r8a7790_clst[clst_id].carescnt_magic;
-	carescnt = p + r8a7790_clst[clst_id].carescnt;
-	writel_relaxed((readl_relaxed(carescnt) & ~mask) | magic, carescnt);
+	magic = r8a7790_clst[clst_id].rescnt_magic;
+	rescnt = p + r8a7790_clst[clst_id].rescnt;
+	writel_relaxed((readl_relaxed(rescnt) & ~mask) | magic, rescnt);
 
 	iounmap(p);
 }
 
 static void r8a7790_assert_reset(unsigned int cpu)
 {
-	void __iomem *p, *carescnt;
+	void __iomem *p, *rescnt;
 	u32 mask, magic;
 	unsigned int clst_id = r8a7790_clst_id(cpu);
 
@@ -85,9 +85,9 @@ static void r8a7790_assert_reset(unsigned int cpu)
 
 	/* disable per-core clocks */
 	mask = BIT(3 - r8a7790_cpu_id(cpu));
-	magic = r8a7790_clst[clst_id].carescnt_magic;
-	carescnt = p + r8a7790_clst[clst_id].carescnt;
-	writel_relaxed((readl_relaxed(carescnt) | mask) | magic, carescnt);
+	magic = r8a7790_clst[clst_id].rescnt_magic;
+	rescnt = p + r8a7790_clst[clst_id].rescnt;
+	writel_relaxed((readl_relaxed(rescnt) | mask) | magic, rescnt);
 
 	iounmap(p);
 }
-- 
1.8.3.2
