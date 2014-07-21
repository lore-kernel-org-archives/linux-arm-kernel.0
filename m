From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 21 Jul 2014 11:13:24 +1000
Subject: linux-next: manual merge of the samsung tree with the arm-soc tree
Message-ID: <20140721111324.1f5ed9b2@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

Today's linux-next merge of the samsung tree got a conflict in
arch/arm/mach-exynos/pm.c between commit 7310d99ffcd1 ("ARM: EXYNOS:
Fix build breakge with PM_SLEEP=n") from the arm-soc tree and commit
66df3ce29804 ("ARM: EXYNOS: Refactored code for using PMU address via
DT") from the samsung tree.

I fixed it up (the code modified by the latter was moved by the former,
so I applied the following patch to the new file) and can carry the fix
as necessary (no action is required).

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 21 Jul 2014 11:11:17 +1000
Subject: [PATCH] ARM: EXYNOS: fixup for code movement

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/arm/mach-exynos/platsmp.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 8b66a9e02b87..1e43b53d23b7 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -43,7 +43,7 @@ extern void exynos4_secondary_startup(void);
  */
 void exynos_cpu_power_down(int cpu)
 {
-	__raw_writel(0, EXYNOS_ARM_CORE_CONFIGURATION(cpu));
+	pmu_raw_writel(0, EXYNOS_ARM_CORE_CONFIGURATION(cpu));
 }
 
 /**
@@ -54,8 +54,8 @@ void exynos_cpu_power_down(int cpu)
  */
 void exynos_cpu_power_up(int cpu)
 {
-	__raw_writel(S5P_CORE_LOCAL_PWR_EN,
-		     EXYNOS_ARM_CORE_CONFIGURATION(cpu));
+	pmu_raw_writel(S5P_CORE_LOCAL_PWR_EN,
+		       EXYNOS_ARM_CORE_CONFIGURATION(cpu));
 }
 
 /**
@@ -65,7 +65,7 @@ void exynos_cpu_power_up(int cpu)
  */
 int exynos_cpu_power_state(int cpu)
 {
-	return (__raw_readl(EXYNOS_ARM_CORE_STATUS(cpu)) &
+	return (pmu_raw_readl(EXYNOS_ARM_CORE_STATUS(cpu)) &
 			S5P_CORE_LOCAL_PWR_EN);
 }
 
@@ -75,7 +75,7 @@ int exynos_cpu_power_state(int cpu)
  */
 void exynos_cluster_power_down(int cluster)
 {
-	__raw_writel(0, EXYNOS_COMMON_CONFIGURATION(cluster));
+	pmu_raw_writel(0, EXYNOS_COMMON_CONFIGURATION(cluster));
 }
 
 /**
@@ -84,8 +84,8 @@ void exynos_cluster_power_down(int cluster)
  */
 void exynos_cluster_power_up(int cluster)
 {
-	__raw_writel(S5P_CORE_LOCAL_PWR_EN,
-		     EXYNOS_COMMON_CONFIGURATION(cluster));
+	pmu_raw_writel(S5P_CORE_LOCAL_PWR_EN,
+		       EXYNOS_COMMON_CONFIGURATION(cluster));
 }
 
 /**
@@ -95,7 +95,7 @@ void exynos_cluster_power_up(int cluster)
  */
 int exynos_cluster_power_state(int cluster)
 {
-	return (__raw_readl(EXYNOS_COMMON_STATUS(cluster)) &
+	return (pmu_raw_readl(EXYNOS_COMMON_STATUS(cluster)) &
 			S5P_CORE_LOCAL_PWR_EN);
 }
 
-- 
2.0.1


-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140721/733fad21/attachment.sig>
