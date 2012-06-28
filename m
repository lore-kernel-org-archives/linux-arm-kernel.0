From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 28 Jun 2012 13:49:52 +0300
Subject: [PATCH] ARM: OMAP2: twl-common: fix compiler warnings
Message-ID: <1340880592-21700-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP2 does not use the external voltage controller code for TWL, and
thus OMAP2 only compilation generates following warnings:

arch/arm/mach-omap2/twl-common.c:51: warning: 'twl_set_voltage' defined but not used
arch/arm/mach-omap2/twl-common.c:57: warning: 'twl_get_voltage' defined but not used

This patch moves the code in question behind ARCH specific flags and
eliminates these warnings.

Reported-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/twl-common.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
index 119d5a9..5447c13 100644
--- a/arch/arm/mach-omap2/twl-common.c
+++ b/arch/arm/mach-omap2/twl-common.c
@@ -48,6 +48,7 @@ static struct i2c_board_info __initdata omap4_i2c1_board_info[] = {
 	},
 };
 
+#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
 static int twl_set_voltage(void *data, int target_uV)
 {
 	struct voltagedomain *voltdm = (struct voltagedomain *)data;
@@ -59,6 +60,7 @@ static int twl_get_voltage(void *data)
 	struct voltagedomain *voltdm = (struct voltagedomain *)data;
 	return voltdm_get_voltage(voltdm);
 }
+#endif
 
 void __init omap_pmic_init(int bus, u32 clkrate,
 			   const char *pmic_type, int pmic_irq,
-- 
1.7.4.1
