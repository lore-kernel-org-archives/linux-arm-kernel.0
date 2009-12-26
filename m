From: maz@misterjones.org (Marc Zyngier)
Date: Sat, 26 Dec 2009 21:25:50 +0100
Subject: [PATCH 4/4] pxa/zeus: provide power-source information when APM is
	enabled
In-Reply-To: <1261859150-17335-4-git-send-email-maz@misterjones.org>
References: <1261859150-17335-1-git-send-email-maz@misterjones.org>
	<1261859150-17335-2-git-send-email-maz@misterjones.org>
	<1261859150-17335-3-git-send-email-maz@misterjones.org>
	<1261859150-17335-4-git-send-email-maz@misterjones.org>
Message-ID: <1261859150-17335-5-git-send-email-maz@misterjones.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marc Zyngier <maz@misterjones.org>
---
 arch/arm/mach-pxa/zeus.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
index 7ddd265..e1c9b1a 100644
--- a/arch/arm/mach-pxa/zeus.c
+++ b/arch/arm/mach-pxa/zeus.c
@@ -25,6 +25,7 @@
 #include <linux/mtd/physmap.h>
 #include <linux/i2c.h>
 #include <linux/i2c/pca953x.h>
+#include <linux/apm-emulation.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -626,6 +627,25 @@ static void zeus_power_off(void)
 	pxa27x_cpu_suspend(PWRMODE_DEEPSLEEP);
 }
 
+#ifdef CONFIG_APM_EMULATION
+static void zeus_get_power_status(struct apm_power_info *info)
+{
+	/* Power supply is always present */
+	info->ac_line_status	= APM_AC_ONLINE;
+	info->battery_status	= APM_BATTERY_STATUS_NOT_PRESENT;
+	info->battery_flag	= APM_BATTERY_FLAG_NOT_PRESENT;
+}
+
+static inline void zeus_setup_apm(void)
+{
+	apm_get_power_status = zeus_get_power_status;
+}
+#else
+static inline void zeus_setup_apm(void)
+{
+}
+#endif
+
 static int zeus_get_pcb_info(struct i2c_client *client, unsigned gpio,
 			     unsigned ngpio, void *context)
 {
@@ -747,6 +767,7 @@ static void __init zeus_init(void)
 	MSC1 = (MSC1 & 0xffff0000) | dm9000_msc;
 
 	pm_power_off = zeus_power_off;
+	zeus_setup_apm();
 
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(zeus_pin_config));
 
-- 
1.6.5.7
