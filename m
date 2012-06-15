From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 15 Jun 2012 16:33:54 +0300
Subject: [PATCH] ARM: OMAP2: twl-common: Fix compiler warning
Message-ID: <1339767234-25323-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the kernel is built only for OMAP2 the following warning will show up:

arch/arm/mach-omap2/twl-common.c:52: warning: ?twl_set_voltage? defined but not used
arch/arm/mach-omap2/twl-common.c:58: warning: ?twl_get_voltage? defined but not used

The twl_set/get_voltage callbacks only used when OMAP3/4 is selected.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
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
1.7.8.6
