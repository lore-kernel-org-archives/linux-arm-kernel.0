From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 18 May 2010 20:18:59 -0600
Subject: [PATCH 18/22] OMAP4 powerdomain: Fix pwrsts flags for ALWAYS ON
	domains
In-Reply-To: <20100519021800.19716.8938.stgit@localhost.localdomain>
References: <20100519021800.19716.8938.stgit@localhost.localdomain>
Message-ID: <20100519021858.19716.11617.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajendra Nayak <rnayak@ti.com>

The pwrsts flag for ALWAYS ON domains like always_on_core_pwrdm
and wkup_pwrdm is wrongly populated with the define for a
powerdomain power state, instead of the allowable state
bitfields.
This causes a few api's to fail sensing invalid pwrst
requested.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/powerdomains44xx.h        |    4 ++--
 arch/arm/plat-omap/include/plat/powerdomain.h |    1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomains44xx.h b/arch/arm/mach-omap2/powerdomains44xx.h
index e002d42..ad5a265 100644
--- a/arch/arm/mach-omap2/powerdomains44xx.h
+++ b/arch/arm/mach-omap2/powerdomains44xx.h
@@ -130,7 +130,7 @@ static struct powerdomain wkup_44xx_pwrdm = {
 	.name		  = "wkup_pwrdm",
 	.prcm_offs	  = OMAP4430_PRM_WKUP_MOD,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
-	.pwrsts		  = PWRDM_POWER_ON,
+	.pwrsts		  = PWRSTS_ON,
 	.banks		  = 1,
 	.pwrsts_mem_ret	= {
 		[0] = PWRDM_POWER_OFF,	/* wkup_bank */
@@ -286,7 +286,7 @@ static struct powerdomain always_on_core_44xx_pwrdm = {
 	.name		  = "always_on_core_pwrdm",
 	.prcm_offs	  = OMAP4430_PRM_ALWAYS_ON_MOD,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
-	.pwrsts		  = PWRDM_POWER_ON,
+	.pwrsts		  = PWRSTS_ON,
 };
 
 /* cefuse_44xx_pwrdm: Customer efuse controller power domain */
diff --git a/arch/arm/plat-omap/include/plat/powerdomain.h b/arch/arm/plat-omap/include/plat/powerdomain.h
index d82b2c0..e7cc7e6 100644
--- a/arch/arm/plat-omap/include/plat/powerdomain.h
+++ b/arch/arm/plat-omap/include/plat/powerdomain.h
@@ -31,6 +31,7 @@
 #define PWRDM_MAX_PWRSTS	4
 
 /* Powerdomain allowable state bitfields */
+#define PWRSTS_ON		(1 << PWRDM_POWER_ON)
 #define PWRSTS_OFF_ON		((1 << PWRDM_POWER_OFF) | \
 				 (1 << PWRDM_POWER_ON))
 
