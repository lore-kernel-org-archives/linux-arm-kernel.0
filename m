From: t-kristo@ti.com (Tero Kristo)
Date: Mon, 31 Mar 2014 18:15:47 +0300
Subject: [PATCH 08/55] ARM: DRA7: PRM: add voltage processor check behind a
 prm_feature flag
In-Reply-To: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
References: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Message-ID: <1396278994-12624-9-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is done in attempt to get rid of cpu_is_X calls from the PRM core.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/prm.h     |    1 +
 arch/arm/mach-omap2/prm44xx.c |    4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index fd5123e..8d40a5d 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -29,6 +29,7 @@ int of_prcm_init(void);
  * PRM_HAS_VOLTAGE: has voltage domains
  */
 #define PRM_HAS_IO_WAKEUP	(1 << 0)
+#define PRM_HAS_VOLTAGE		(1 << 1)
 
 #ifndef __ASSEMBLER__
 enum {
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 18fae1dd..fb05abc 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -624,7 +624,7 @@ static int omap4_pwrdm_wait_transition(struct powerdomain *pwrdm)
 static int omap4_check_vcvp(void)
 {
 	/* No VC/VP on dra7xx devices */
-	if (soc_is_dra7xx())
+	if (!(prm_features & PRM_HAS_VOLTAGE))
 		return 0;
 
 	return 1;
@@ -664,6 +664,8 @@ static struct prm_ll_data omap44xx_prm_ll_data = {
 
 int __init omap44xx_prm_init(u16 cpu_type)
 {
+	if (cpu_type != PRM_DRA7)
+		prm_features |= PRM_HAS_VOLTAGE;
 	if (cpu_type == PRM_OMAP4)
 		prm_features |= PRM_HAS_IO_WAKEUP;
 
-- 
1.7.9.5
