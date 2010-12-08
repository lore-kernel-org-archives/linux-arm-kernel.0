From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 07 Dec 2010 23:18:41 -0700
Subject: [PATCH 07/11] OMAP4: clockdomains: add OMAP4 PRCM data and OMAP4
	support
In-Reply-To: <20101208061657.30541.79824.stgit@twilight.localdomain>
References: <20101208061657.30541.79824.stgit@twilight.localdomain>
Message-ID: <20101208061840.30541.4572.stgit@twilight.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add PRCM partition, CM instance register address offset, and clockdomain
register address offset to each OMAP4 struct clockdomain record.  Add OMAP4
clockdomain code to use this new data to access registers properly.

While here, clean up some nearby clockdomain code to allocate auto variables
in my recollection of Linus's preferred style.

The autogeneration scripts have been updated.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Beno?t Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/clockdomain.c             |   75 ++++++++++++---
 arch/arm/mach-omap2/clockdomains44xx_data.c   |  121 +++++++++++++++----------
 arch/arm/mach-omap2/cm-regbits-34xx.h         |   11 ++
 arch/arm/mach-omap2/cminst44xx.c              |  105 ++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/clockdomain.h |   20 +++-
 5 files changed, 260 insertions(+), 72 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index b1a6908..f83a1d4 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -29,6 +29,9 @@
 #include "prm2xxx_3xxx.h"
 #include "prm-regbits-24xx.h"
 #include "cm2xxx_3xxx.h"
+#include "cm-regbits-34xx.h"
+#include "cminst44xx.h"
+#include "prcm44xx.h"
 
 #include <plat/clock.h>
 #include <plat/powerdomain.h>
@@ -245,13 +248,21 @@ static void _enable_hwsup(struct clockdomain *clkdm)
 
 	if (cpu_is_omap24xx())
 		bits = OMAP24XX_CLKSTCTRL_ENABLE_AUTO;
-	else if (cpu_is_omap34xx() || cpu_is_omap44xx())
+	else if (cpu_is_omap34xx())
 		bits = OMAP34XX_CLKSTCTRL_ENABLE_AUTO;
+	else if (cpu_is_omap44xx())
+		return omap4_cminst_clkdm_enable_hwsup(clkdm->prcm_partition,
+						       clkdm->cm_inst,
+						       clkdm->clkdm_offs);
 	else
 		BUG();
 
 	bits = bits << __ffs(clkdm->clktrctrl_mask);
 
+	/*
+	 * XXX clkstctrl_reg is known on OMAP2 - this clkdm
+	 * field is not needed
+	 */
 	v = __raw_readl(clkdm->clkstctrl_reg);
 	v &= ~(clkdm->clktrctrl_mask);
 	v |= bits;
@@ -271,21 +282,27 @@ static void _disable_hwsup(struct clockdomain *clkdm)
 {
 	u32 bits, v;
 
-	if (cpu_is_omap24xx()) {
+	if (cpu_is_omap24xx())
 		bits = OMAP24XX_CLKSTCTRL_DISABLE_AUTO;
-	} else if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
+	else if (cpu_is_omap34xx())
 		bits = OMAP34XX_CLKSTCTRL_DISABLE_AUTO;
-	} else {
+	else if (cpu_is_omap44xx())
+		return omap4_cminst_clkdm_disable_hwsup(clkdm->prcm_partition,
+							clkdm->cm_inst,
+							clkdm->clkdm_offs);
+	else
 		BUG();
-	}
 
 	bits = bits << __ffs(clkdm->clktrctrl_mask);
 
+	/*
+	 * XXX clkstctrl_reg is known on OMAP2 - this clkdm
+	 * field is not needed
+	 */
 	v = __raw_readl(clkdm->clkstctrl_reg);
 	v &= ~(clkdm->clktrctrl_mask);
 	v |= bits;
 	__raw_writel(v, clkdm->clkstctrl_reg);
-
 }
 
 /* Public functions */
@@ -723,14 +740,20 @@ int clkdm_clear_all_sleepdeps(struct clockdomain *clkdm)
  */
 static int omap2_clkdm_clktrctrl_read(struct clockdomain *clkdm)
 {
-	u32 v;
+	u32 v = 0;
 
 	if (!clkdm)
 		return -EINVAL;
 
-	v = __raw_readl(clkdm->clkstctrl_reg);
-	v &= clkdm->clktrctrl_mask;
-	v >>= __ffs(clkdm->clktrctrl_mask);
+	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
+		v = __raw_readl(clkdm->clkstctrl_reg);
+		v &= clkdm->clktrctrl_mask;
+		v >>= __ffs(clkdm->clktrctrl_mask);
+	} else if (cpu_is_omap44xx()) {
+		pr_warn("OMAP4 clockdomain: missing wakeup/sleep deps\n");
+	} else {
+		BUG();
+	}
 
 	return v;
 }
@@ -746,6 +769,8 @@ static int omap2_clkdm_clktrctrl_read(struct clockdomain *clkdm)
  */
 int omap2_clkdm_sleep(struct clockdomain *clkdm)
 {
+	u32 bits, v;
+
 	if (!clkdm)
 		return -EINVAL;
 
@@ -762,16 +787,22 @@ int omap2_clkdm_sleep(struct clockdomain *clkdm)
 		omap2_cm_set_mod_reg_bits(OMAP24XX_FORCESTATE_MASK,
 			    clkdm->pwrdm.ptr->prcm_offs, OMAP2_PM_PWSTCTRL);
 
-	} else if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
+	} else if (cpu_is_omap34xx()) {
 
-		u32 bits = (OMAP34XX_CLKSTCTRL_FORCE_SLEEP <<
-			 __ffs(clkdm->clktrctrl_mask));
+		bits = (OMAP34XX_CLKSTCTRL_FORCE_SLEEP <<
+			__ffs(clkdm->clktrctrl_mask));
 
-		u32 v = __raw_readl(clkdm->clkstctrl_reg);
+		v = __raw_readl(clkdm->clkstctrl_reg);
 		v &= ~(clkdm->clktrctrl_mask);
 		v |= bits;
 		__raw_writel(v, clkdm->clkstctrl_reg);
 
+	} else if (cpu_is_omap44xx()) {
+
+		omap4_cminst_clkdm_force_sleep(clkdm->prcm_partition,
+					       clkdm->cm_inst,
+					       clkdm->clkdm_offs);
+
 	} else {
 		BUG();
 	};
@@ -790,6 +821,8 @@ int omap2_clkdm_sleep(struct clockdomain *clkdm)
  */
 int omap2_clkdm_wakeup(struct clockdomain *clkdm)
 {
+	u32 bits, v;
+
 	if (!clkdm)
 		return -EINVAL;
 
@@ -806,16 +839,22 @@ int omap2_clkdm_wakeup(struct clockdomain *clkdm)
 		omap2_cm_clear_mod_reg_bits(OMAP24XX_FORCESTATE_MASK,
 			      clkdm->pwrdm.ptr->prcm_offs, OMAP2_PM_PWSTCTRL);
 
-	} else if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
+	} else if (cpu_is_omap34xx()) {
 
-		u32 bits = (OMAP34XX_CLKSTCTRL_FORCE_WAKEUP <<
-			 __ffs(clkdm->clktrctrl_mask));
+		bits = (OMAP34XX_CLKSTCTRL_FORCE_WAKEUP <<
+			__ffs(clkdm->clktrctrl_mask));
 
-		u32 v = __raw_readl(clkdm->clkstctrl_reg);
+		v = __raw_readl(clkdm->clkstctrl_reg);
 		v &= ~(clkdm->clktrctrl_mask);
 		v |= bits;
 		__raw_writel(v, clkdm->clkstctrl_reg);
 
+	} else if (cpu_is_omap44xx()) {
+
+		omap4_cminst_clkdm_force_wakeup(clkdm->prcm_partition,
+						clkdm->cm_inst,
+						clkdm->clkdm_offs);
+
 	} else {
 		BUG();
 	};
diff --git a/arch/arm/mach-omap2/clockdomains44xx_data.c b/arch/arm/mach-omap2/clockdomains44xx_data.c
index 7fc81f6..2d3d1ef 100644
--- a/arch/arm/mach-omap2/clockdomains44xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
@@ -34,14 +34,16 @@
 #include "cm2_44xx.h"
 #include "cm-regbits-44xx.h"
 #include "prm44xx.h"
+#include "prcm44xx.h"
 #include "prcm_mpu44xx.h"
 
 
 static struct clockdomain l4_cefuse_44xx_clkdm = {
 	.name		  = "l4_cefuse_clkdm",
 	.pwrdm		  = { .name = "cefuse_pwrdm" },
-	.clkstctrl_reg	  = OMAP4430_CM_CEFUSE_CLKSTCTRL,
-	.clktrctrl_mask	  = OMAP4430_CLKTRCTRL_MASK,
+	.prcm_partition	  = OMAP4430_CM2_PARTITION,
+	.cm_inst	  = OMAP4430_CM2_CEFUSE_INST,
+	.clkdm_offs	  = OMAP4430_CM2_CEFUSE_CEFUSE_CDOFFS,
 	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_HWSUP,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
@@ -49,8 +51,9 @@ static struct clockdomain l4_cefuse_44xx_clkdm = {
 static struct clockdomain l4_cfg_44xx_clkdm = {
 	.name		  = "l4_cfg_clkdm",
 	.pwrdm		  = { .name = "core_pwrdm" },
-	.clkstctrl_reg	  = OMAP4430_CM_L4CFG_CLKSTCTRL,
-	.clktrctrl_mask	  = OMAP4430_CLKTRCTRL_MASK,
+	.prcm_partition	  = OMAP4430_CM2_PARTITION,
+	.cm_inst	  = OMAP4430_CM2_CORE_INST,
+	.clkdm_offs	  = OMAP4430_CM2_CORE_L4CFG_CDOFFS,
 	.flags		  = CLKDM_CAN_HWSUP,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
@@ -58,8 +61,9 @@ static struct clockdomain l4_cfg_44xx_clkdm = {
 static struct clockdomain tesla_44xx_clkdm = {
 	.name		  = "tesla_clkdm",
 	.pwrdm		  = { .name = "tesla_pwrdm" },
-	.clkstctrl_reg	  = OMAP4430_CM_TESLA_CLKSTCTRL,
-	.clktrctrl_mask	  = OMAP4430_CLKTRCTRL_MASK,
+	.prcm_partition	  = OMAP4430_CM1_PARTITION,
+	.cm_inst	  = OMAP4430_CM1_TESLA_INST,
+	.clkdm_offs	  = OMAP4430_CM1_TESLA_TESLA_CDOFFS,
 	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
@@ -67,8 +71,9 @@ static struct clockdomain tesla_44xx_clkdm = {
 static struct clockdomain l3_gfx_44xx_clkdm = {
 	.name		  = "l3_gfx_clkdm",
 	.pwrdm		  = { .name = "gfx_pwrdm" },
-	.clkstctrl_reg	  = OMAP4430_CM_GFX_CLKSTCTRL,
-	.clktrctrl_mask	  = OMAP4430_CLKTRCTRL_MASK,
+	.prcm_partition	  = OMAP4430_CM2_PARTITION,
+	.cm_inst	  = OMAP4430_CM2_GFX_INST,
+	.clkdm_offs	  = OMAP4430_CM2_GFX_GFX_CDOFFS,
 	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
@@ -76,8 +81,9 @@ static struct clockdomain l3_gfx_44xx_clkdm = {
 static struct clockdomain ivahd_44xx_clkdm = {
 	.name		  = "ivahd_clkdm",
 	.pwrdm		  = { .name = "ivahd_pwrdm" },
-	.clkstctrl_reg	  = OMAP4430_CM_IVAHD_CLKSTCTRL,
-	.clktrctrl_mask	  = OMAP4430_CLKTRCTRL_MASK,
+	.prcm_partition	  = OMAP4430_CM2_PARTITION,
+	.cm_inst	  = OMAP4430_CM2_IVAHD_INST,
+	.clkdm_offs	  = OMAP4430_CM2_IVAHD_IVAHD_CDOFFS,
 	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
@@ -85,8 +91,9 @@ static struct clockdomain ivahd_44xx_clkdm = {
 static struct clockdomain l4_secure_44xx_clkdm = {
 	.name		  = "l4_secure_clkdm",
 	.pwrdm		  = { .name = "l4per_pwrdm" },
-	.clkstctrl_reg	  = OMAP4430_CM_L4SEC_CLKSTCTRL,
-	.clktrctrl_mask	  = OMAP4430_CLKTRCTRL_MASK,
+	.prcm_partition	  = OMAP4430_CM2_PARTITION,
+	.cm_inst	  = OMAP4430_CM2_L4PER_INST,
+	.clkdm_offs	  = OMAP4430_CM2_L4PER_L4SEC_CDOFFS,
 	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
@@ -94,8 +101,9 @@ static struct clockdomain l4_secure_44xx_clkdm = {
 static struct clockdomain l4_per_44xx_clkdm = {
 	.name		  = "l4_per_clkdm",
 	.pwrdm		  = { .name = "l4per_pwrdm" },
-	.clkstctrl_reg	  = OMAP4430_CM_L4PER_CLKSTCTRL,
-	.clktrctrl_mask	  = OMAP4430_CLKTRCTRL_MASK,
+	.prcm_partition	  = OMAP4430_CM2_PARTITION,
+	.cm_inst	  = OMAP4430_CM2_L4PER_INST,
+	.clkdm_offs	  = OMAP4430_CM2_L4PER_L4PER_CDOFFS,
 	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
@@ -103,8 +111,9 @@ static struct clockdomain l4_per_44xx_clkdm = {
 static struct clockdomain abe_44xx_clkdm = {
 	.name		  = "abe_clkdm",
 	.pwrdm		  = { .name = "abe_pwrdm" },
-	.clkstctrl_reg	  = OMAP4430_CM1_ABE_CLKSTCTRL,
-	.clktrctrl_mask	  = OMAP4430_CLKTRCTRL_MASK,
+	.prcm_partition	  = OMAP4430_CM1_PARTITION,
+	.cm_inst	  = OMAP4430_CM1_ABE_INST,
+	.clkdm_offs	  = OMAP4430_CM1_ABE_ABE_CDOFFS,
 	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
@@ -112,16 +121,18 @@ static struct clockdomain abe_44xx_clkdm = {
 static struct clockdomain l3_instr_44xx_clkdm = {
 	.name		  = "l3_instr_clkdm",
 	.pwrdm		  = { .name = "core_pwrdm" },
-	.clkstctrl_reg	  = OMAP4430_CM_L3INSTR_CLKSTCTRL,
-	.clktrctrl_mask	  = OMAP4430_CLKTRCTRL_MASK,
+	.prcm_partition	  = OMAP4430_CM2_PARTITION,
+	.cm_inst	  = OMAP4430_CM2_CORE_INST,
+	.clkdm_offs	  = OMAP4430_CM2_CORE_L3INSTR_CDOFFS,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
 static struct clockdomain l3_init_44xx_clkdm = {
 	.name		  = "l3_init_clkdm",
 	.pwrdm		  = { .name = "l3init_pwrdm" },
-	.clkstctrl_reg	  = OMAP4430_CM_L3INIT_CLKSTCTRL,
-	.clktrctrl_mask	  = OMAP4430_CLKTRCTRL_MASK,
+	.prcm_partition	  = OMAP4430_CM2_PARTITION,
+	.cm_inst	  = OMAP4430_CM2_L3INIT_INST,
+	.clkdm_offs	  = OMAP4430_CM2_L3INIT_L3INIT_CDOFFS,
 	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
@@ -129,8 +140,9 @@ static struct clockdomain l3_init_44xx_clkdm = {
 static struct clockdomain mpuss_44xx_clkdm = {
 	.name		  = "mpuss_clkdm",
 	.pwrdm		  = { .name = "mpu_pwrdm" },
-	.clkstctrl_reg	  = OMAP4430_CM_MPU_CLKSTCTRL,
-	.clktrctrl_mask	  = OMAP4430_CLKTRCTRL_MASK,
+	.prcm_partition	  = OMAP4430_CM1_PARTITION,
+	.cm_inst	  = OMAP4430_CM1_MPU_INST,
+	.clkdm_offs	  = OMAP4430_CM1_MPU_MPU_CDOFFS,
 	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_HWSUP,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
@@ -138,8 +150,9 @@ static struct clockdomain mpuss_44xx_clkdm = {
 static struct clockdomain mpu0_44xx_clkdm = {
 	.name		  = "mpu0_clkdm",
 	.pwrdm		  = { .name = "cpu0_pwrdm" },
-	.clkstctrl_reg	  = OMAP4430_CM_CPU0_CLKSTCTRL,
-	.clktrctrl_mask	  = OMAP4430_CLKTRCTRL_MASK,
+	.prcm_partition	  = OMAP4430_PRCM_MPU_PARTITION,
+	.cm_inst	  = OMAP4430_PRCM_MPU_CPU0_INST,
+	.clkdm_offs	  = OMAP4430_PRCM_MPU_CPU0_MPU_CDOFFS,
 	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_HWSUP,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
@@ -147,8 +160,9 @@ static struct clockdomain mpu0_44xx_clkdm = {
 static struct clockdomain mpu1_44xx_clkdm = {
 	.name		  = "mpu1_clkdm",
 	.pwrdm		  = { .name = "cpu1_pwrdm" },
-	.clkstctrl_reg	  = OMAP4430_CM_CPU1_CLKSTCTRL,
-	.clktrctrl_mask	  = OMAP4430_CLKTRCTRL_MASK,
+	.prcm_partition	  = OMAP4430_PRCM_MPU_PARTITION,
+	.cm_inst	  = OMAP4430_PRCM_MPU_CPU1_INST,
+	.clkdm_offs	  = OMAP4430_PRCM_MPU_CPU1_MPU_CDOFFS,
 	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_HWSUP,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
@@ -156,8 +170,9 @@ static struct clockdomain mpu1_44xx_clkdm = {
 static struct clockdomain l3_emif_44xx_clkdm = {
 	.name		  = "l3_emif_clkdm",
 	.pwrdm		  = { .name = "core_pwrdm" },
-	.clkstctrl_reg	  = OMAP4430_CM_MEMIF_CLKSTCTRL,
-	.clktrctrl_mask	  = OMAP4430_CLKTRCTRL_MASK,
+	.prcm_partition	  = OMAP4430_CM2_PARTITION,
+	.cm_inst	  = OMAP4430_CM2_CORE_INST,
+	.clkdm_offs	  = OMAP4430_CM2_CORE_MEMIF_CDOFFS,
 	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_HWSUP,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
@@ -165,8 +180,9 @@ static struct clockdomain l3_emif_44xx_clkdm = {
 static struct clockdomain l4_ao_44xx_clkdm = {
 	.name		  = "l4_ao_clkdm",
 	.pwrdm		  = { .name = "always_on_core_pwrdm" },
-	.clkstctrl_reg	  = OMAP4430_CM_ALWON_CLKSTCTRL,
-	.clktrctrl_mask	  = OMAP4430_CLKTRCTRL_MASK,
+	.prcm_partition	  = OMAP4430_CM2_PARTITION,
+	.cm_inst	  = OMAP4430_CM2_ALWAYS_ON_INST,
+	.clkdm_offs	  = OMAP4430_CM2_ALWAYS_ON_ALWON_CDOFFS,
 	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_HWSUP,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
@@ -174,8 +190,9 @@ static struct clockdomain l4_ao_44xx_clkdm = {
 static struct clockdomain ducati_44xx_clkdm = {
 	.name		  = "ducati_clkdm",
 	.pwrdm		  = { .name = "core_pwrdm" },
-	.clkstctrl_reg	  = OMAP4430_CM_DUCATI_CLKSTCTRL,
-	.clktrctrl_mask	  = OMAP4430_CLKTRCTRL_MASK,
+	.prcm_partition	  = OMAP4430_CM2_PARTITION,
+	.cm_inst	  = OMAP4430_CM2_CORE_INST,
+	.clkdm_offs	  = OMAP4430_CM2_CORE_DUCATI_CDOFFS,
 	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
@@ -183,8 +200,9 @@ static struct clockdomain ducati_44xx_clkdm = {
 static struct clockdomain l3_2_44xx_clkdm = {
 	.name		  = "l3_2_clkdm",
 	.pwrdm		  = { .name = "core_pwrdm" },
-	.clkstctrl_reg	  = OMAP4430_CM_L3_2_CLKSTCTRL,
-	.clktrctrl_mask	  = OMAP4430_CLKTRCTRL_MASK,
+	.prcm_partition	  = OMAP4430_CM2_PARTITION,
+	.cm_inst	  = OMAP4430_CM2_CORE_INST,
+	.clkdm_offs	  = OMAP4430_CM2_CORE_L3_2_CDOFFS,
 	.flags		  = CLKDM_CAN_HWSUP,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
@@ -192,8 +210,9 @@ static struct clockdomain l3_2_44xx_clkdm = {
 static struct clockdomain l3_1_44xx_clkdm = {
 	.name		  = "l3_1_clkdm",
 	.pwrdm		  = { .name = "core_pwrdm" },
-	.clkstctrl_reg	  = OMAP4430_CM_L3_1_CLKSTCTRL,
-	.clktrctrl_mask	  = OMAP4430_CLKTRCTRL_MASK,
+	.prcm_partition	  = OMAP4430_CM2_PARTITION,
+	.cm_inst	  = OMAP4430_CM2_CORE_INST,
+	.clkdm_offs	  = OMAP4430_CM2_CORE_L3_1_CDOFFS,
 	.flags		  = CLKDM_CAN_HWSUP,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
@@ -201,8 +220,9 @@ static struct clockdomain l3_1_44xx_clkdm = {
 static struct clockdomain l3_d2d_44xx_clkdm = {
 	.name		  = "l3_d2d_clkdm",
 	.pwrdm		  = { .name = "core_pwrdm" },
-	.clkstctrl_reg	  = OMAP4430_CM_D2D_CLKSTCTRL,
-	.clktrctrl_mask	  = OMAP4430_CLKTRCTRL_MASK,
+	.prcm_partition	  = OMAP4430_CM2_PARTITION,
+	.cm_inst	  = OMAP4430_CM2_CORE_INST,
+	.clkdm_offs	  = OMAP4430_CM2_CORE_D2D_CDOFFS,
 	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_HWSUP,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
@@ -210,8 +230,9 @@ static struct clockdomain l3_d2d_44xx_clkdm = {
 static struct clockdomain iss_44xx_clkdm = {
 	.name		  = "iss_clkdm",
 	.pwrdm		  = { .name = "cam_pwrdm" },
-	.clkstctrl_reg	  = OMAP4430_CM_CAM_CLKSTCTRL,
-	.clktrctrl_mask	  = OMAP4430_CLKTRCTRL_MASK,
+	.prcm_partition	  = OMAP4430_CM2_PARTITION,
+	.cm_inst	  = OMAP4430_CM2_CAM_INST,
+	.clkdm_offs	  = OMAP4430_CM2_CAM_CAM_CDOFFS,
 	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
@@ -219,8 +240,9 @@ static struct clockdomain iss_44xx_clkdm = {
 static struct clockdomain l3_dss_44xx_clkdm = {
 	.name		  = "l3_dss_clkdm",
 	.pwrdm		  = { .name = "dss_pwrdm" },
-	.clkstctrl_reg	  = OMAP4430_CM_DSS_CLKSTCTRL,
-	.clktrctrl_mask	  = OMAP4430_CLKTRCTRL_MASK,
+	.prcm_partition	  = OMAP4430_CM2_PARTITION,
+	.cm_inst	  = OMAP4430_CM2_DSS_INST,
+	.clkdm_offs	  = OMAP4430_CM2_DSS_DSS_CDOFFS,
 	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
@@ -228,8 +250,9 @@ static struct clockdomain l3_dss_44xx_clkdm = {
 static struct clockdomain l4_wkup_44xx_clkdm = {
 	.name		  = "l4_wkup_clkdm",
 	.pwrdm		  = { .name = "wkup_pwrdm" },
-	.clkstctrl_reg	  = OMAP4430_CM_WKUP_CLKSTCTRL,
-	.clktrctrl_mask	  = OMAP4430_CLKTRCTRL_MASK,
+	.prcm_partition	  = OMAP4430_PRM_PARTITION,
+	.cm_inst	  = OMAP4430_PRM_WKUP_CM_INST,
+	.clkdm_offs	  = OMAP4430_PRM_WKUP_CM_WKUP_CDOFFS,
 	.flags		  = CLKDM_CAN_HWSUP,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
@@ -237,8 +260,9 @@ static struct clockdomain l4_wkup_44xx_clkdm = {
 static struct clockdomain emu_sys_44xx_clkdm = {
 	.name		  = "emu_sys_clkdm",
 	.pwrdm		  = { .name = "emu_pwrdm" },
-	.clkstctrl_reg	  = OMAP4430_CM_EMU_CLKSTCTRL,
-	.clktrctrl_mask	  = OMAP4430_CLKTRCTRL_MASK,
+	.prcm_partition	  = OMAP4430_PRM_PARTITION,
+	.cm_inst	  = OMAP4430_PRM_EMU_CM_INST,
+	.clkdm_offs	  = OMAP4430_PRM_EMU_CM_EMU_CDOFFS,
 	.flags		  = CLKDM_CAN_HWSUP,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
@@ -246,8 +270,9 @@ static struct clockdomain emu_sys_44xx_clkdm = {
 static struct clockdomain l3_dma_44xx_clkdm = {
 	.name		  = "l3_dma_clkdm",
 	.pwrdm		  = { .name = "core_pwrdm" },
-	.clkstctrl_reg	  = OMAP4430_CM_SDMA_CLKSTCTRL,
-	.clktrctrl_mask	  = OMAP4430_CLKTRCTRL_MASK,
+	.prcm_partition	  = OMAP4430_CM2_PARTITION,
+	.cm_inst	  = OMAP4430_CM2_CORE_INST,
+	.clkdm_offs	  = OMAP4430_CM2_CORE_SDMA_CDOFFS,
 	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_HWSUP,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap2/cm-regbits-34xx.h
index cd9ff8b..b912759 100644
--- a/arch/arm/mach-omap2/cm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
@@ -798,4 +798,15 @@
 #define OMAP3430ES2_CLKACTIVITY_USBHOST_SHIFT		0
 #define OMAP3430ES2_CLKACTIVITY_USBHOST_MASK		(1 << 0)
 
+/*
+ *
+ */
+
+/* OMAP3XXX CM_CLKSTCTRL_*.CLKTRCTRL_* register bit values */
+#define OMAP34XX_CLKSTCTRL_DISABLE_AUTO		0x0
+#define OMAP34XX_CLKSTCTRL_FORCE_SLEEP		0x1
+#define OMAP34XX_CLKSTCTRL_FORCE_WAKEUP		0x2
+#define OMAP34XX_CLKSTCTRL_ENABLE_AUTO		0x3
+
+
 #endif
diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
index 2c0cad3..fa9d0b8 100644
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -26,6 +26,7 @@
 #include "cm2_44xx.h"
 #include "cm44xx.h"
 #include "cminst44xx.h"
+#include "cm-regbits-34xx.h"
 #include "cm-regbits-44xx.h"
 #include "prcm44xx.h"
 #include "prm44xx.h"
@@ -81,6 +82,110 @@ u32 omap4_cminst_rmw_inst_reg_bits(u32 mask, u32 bits, u8 part,
 	return v;
 }
 
+/*
+ *
+ */
+
+/**
+ * _clktrctrl_write - write @c to a CM_CLKSTCTRL.CLKTRCTRL register bitfield
+ * @c: CLKTRCTRL register bitfield (LSB = bit 0, i.e., unshifted)
+ * @part: PRCM partition ID that the CM_CLKSTCTRL register exists in
+ * @inst: CM instance register offset (*_INST macro)
+ * @cdoffs: Clockdomain register offset (*_CDOFFS macro)
+ *
+ * @c must be the unshifted value for CLKTRCTRL - i.e., this function
+ * will handle the shift itself.
+ */
+static void _clktrctrl_write(u8 c, u8 part, s16 inst, u16 cdoffs)
+{
+	u32 v;
+
+	v = omap4_cminst_read_inst_reg(part, inst, cdoffs + OMAP4_CM_CLKSTCTRL);
+	v &= ~OMAP4430_CLKTRCTRL_MASK;
+	v |= c << OMAP4430_CLKTRCTRL_SHIFT;
+	omap4_cminst_write_inst_reg(v, part, inst, cdoffs + OMAP4_CM_CLKSTCTRL);
+}
+
+/**
+ * omap4_cminst_is_clkdm_in_hwsup - is a clockdomain in hwsup idle mode?
+ * @part: PRCM partition ID that the CM_CLKSTCTRL register exists in
+ * @inst: CM instance register offset (*_INST macro)
+ * @cdoffs: Clockdomain register offset (*_CDOFFS macro)
+ *
+ * Returns true if the clockdomain referred to by (@part, @inst, @cdoffs)
+ * is in hardware-supervised idle mode, or 0 otherwise.
+ */
+bool omap4_cminst_is_clkdm_in_hwsup(u8 part, s16 inst, u16 cdoffs)
+{
+	u32 v;
+
+	v = omap4_cminst_read_inst_reg(part, inst, cdoffs + OMAP4_CM_CLKSTCTRL);
+	v &= OMAP4430_CLKTRCTRL_MASK;
+	v >>= OMAP4430_CLKTRCTRL_SHIFT;
+
+	return (v == OMAP34XX_CLKSTCTRL_ENABLE_AUTO) ? true : false;
+}
+
+/**
+ * omap4_cminst_clkdm_enable_hwsup - put a clockdomain in hwsup-idle mode
+ * @part: PRCM partition ID that the clockdomain registers exist in
+ * @inst: CM instance register offset (*_INST macro)
+ * @cdoffs: Clockdomain register offset (*_CDOFFS macro)
+ *
+ * Put a clockdomain referred to by (@part, @inst, @cdoffs) into
+ * hardware-supervised idle mode.  No return value.
+ */
+void omap4_cminst_clkdm_enable_hwsup(u8 part, s16 inst, u16 cdoffs)
+{
+	_clktrctrl_write(OMAP34XX_CLKSTCTRL_ENABLE_AUTO, part, inst, cdoffs);
+}
+
+/**
+ * omap4_cminst_clkdm_disable_hwsup - put a clockdomain in swsup-idle mode
+ * @part: PRCM partition ID that the clockdomain registers exist in
+ * @inst: CM instance register offset (*_INST macro)
+ * @cdoffs: Clockdomain register offset (*_CDOFFS macro)
+ *
+ * Put a clockdomain referred to by (@part, @inst, @cdoffs) into
+ * software-supervised idle mode, i.e., controlled manually by the
+ * Linux OMAP clockdomain code.  No return value.
+ */
+void omap4_cminst_clkdm_disable_hwsup(u8 part, s16 inst, u16 cdoffs)
+{
+	_clktrctrl_write(OMAP34XX_CLKSTCTRL_DISABLE_AUTO, part, inst, cdoffs);
+}
+
+/**
+ * omap4_cminst_clkdm_force_sleep - try to put a clockdomain into idle
+ * @part: PRCM partition ID that the clockdomain registers exist in
+ * @inst: CM instance register offset (*_INST macro)
+ * @cdoffs: Clockdomain register offset (*_CDOFFS macro)
+ *
+ * Put a clockdomain referred to by (@part, @inst, @cdoffs) into idle
+ * No return value.
+ */
+void omap4_cminst_clkdm_force_sleep(u8 part, s16 inst, u16 cdoffs)
+{
+	_clktrctrl_write(OMAP34XX_CLKSTCTRL_FORCE_SLEEP, part, inst, cdoffs);
+}
+
+/**
+ * omap4_cminst_clkdm_force_sleep - try to take a clockdomain out of idle
+ * @part: PRCM partition ID that the clockdomain registers exist in
+ * @inst: CM instance register offset (*_INST macro)
+ * @cdoffs: Clockdomain register offset (*_CDOFFS macro)
+ *
+ * Take a clockdomain referred to by (@part, @inst, @cdoffs) out of idle,
+ * waking it up.  No return value.
+ */
+void omap4_cminst_clkdm_force_wakeup(u8 part, s16 inst, u16 cdoffs)
+{
+	_clktrctrl_write(OMAP34XX_CLKSTCTRL_FORCE_WAKEUP, part, inst, cdoffs);
+}
+
+/*
+ *
+ */
 
 /**
  * omap4_cm_wait_module_ready - wait for a module to be in 'func' state
diff --git a/arch/arm/plat-omap/include/plat/clockdomain.h b/arch/arm/plat-omap/include/plat/clockdomain.h
index a5f8579..ec433c3 100644
--- a/arch/arm/plat-omap/include/plat/clockdomain.h
+++ b/arch/arm/plat-omap/include/plat/clockdomain.h
@@ -38,12 +38,6 @@
 #define OMAP24XX_CLKSTCTRL_DISABLE_AUTO		0x0
 #define OMAP24XX_CLKSTCTRL_ENABLE_AUTO		0x1
 
-/* OMAP3XXX CM_CLKSTCTRL_*.CLKTRCTRL_* register bit values */
-#define OMAP34XX_CLKSTCTRL_DISABLE_AUTO		0x0
-#define OMAP34XX_CLKSTCTRL_FORCE_SLEEP		0x1
-#define OMAP34XX_CLKSTCTRL_FORCE_WAKEUP		0x2
-#define OMAP34XX_CLKSTCTRL_ENABLE_AUTO		0x3
-
 /**
  * struct clkdm_autodep - clkdm deps to add when entering/exiting hwsup mode
  * @clkdm: clockdomain to add wkdep+sleepdep on - set name member only
@@ -94,11 +88,20 @@ struct clkdm_dep {
  * @clktrctrl_mask: CLKTRCTRL/AUTOSTATE field mask in CM_CLKSTCTRL reg
  * @flags: Clockdomain capability flags
  * @dep_bit: Bit shift of this clockdomain's PM_WKDEP/CM_SLEEPDEP bit
+ * @prcm_partition: (OMAP4 only) PRCM partition ID for this clkdm's registers
+ * @cm_inst: (OMAP4 only) CM instance register offset
+ * @clkdm_offs: (OMAP4 only) CM clockdomain register offset
  * @wkdep_srcs: Clockdomains that can be told to wake this powerdomain up
  * @sleepdep_srcs: Clockdomains that can be told to keep this clkdm from inact
  * @omap_chip: OMAP chip types that this clockdomain is valid on
  * @usecount: Usecount tracking
  * @node: list_head to link all clockdomains together
+ *
+ * @prcm_partition should be a macro from mach-omap2/prcm44xx.h (OMAP4 only)
+ * @cm_inst should be a macro ending in _INST from the OMAP4 CM instance
+ *     definitions (OMAP4 only)
+ * @clkdm_offs should be a macro ending in _CDOFFS from the OMAP4 CM instance
+ *     definitions (OMAP4 only)
  */
 struct clockdomain {
 	const char *name;
@@ -106,10 +109,15 @@ struct clockdomain {
 		const char *name;
 		struct powerdomain *ptr;
 	} pwrdm;
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 	void __iomem *clkstctrl_reg;
 	const u16 clktrctrl_mask;
+#endif
 	const u8 flags;
 	const u8 dep_bit;
+	const u8 prcm_partition;
+	const s16 cm_inst;
+	const u16 clkdm_offs;
 	struct clkdm_dep *wkdep_srcs;
 	struct clkdm_dep *sleepdep_srcs;
 	const struct omap_chip_id omap_chip;
