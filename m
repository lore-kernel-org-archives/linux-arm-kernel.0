From: notasas@gmail.com (Grazvydas Ignotas)
Date: Sun, 10 Mar 2013 02:46:31 +0200
Subject: [PATCH] ARM: OMAP3: hwmod data: disable MIDLEMODE control for musb
Message-ID: <1362876391-6801-1-git-send-email-notasas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For some unknown reason, allowing hwmod to control MIDLEMODE causes
core_pwrdm to not hit idle states for musb in DM3730 at least.
I've verified that setting any MIDLEMODE value other than "force
standby" before enabling the device causes subsequent suspend
attempts to fail with core_pwrdm not entering idle states, even
if the driver is unloaded and "force standby" is restored before
suspend attempt.

Keeping the register set at force standby (reset value) makes it work
and device still functions properly. musb has driver-controlled
OTG_FORCESTDBY register that controls MSTANDBY signal, so perhaps
MIDLEMODE is not even needed? Note that TI PSP kernels also have
similar workarounds.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index ac7e03e..0388bba 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1666,11 +1666,15 @@ static struct omap_hwmod_class_sysconfig omap3xxx_usbhsotg_sysc = {
 	.rev_offs	= 0x0400,
 	.sysc_offs	= 0x0404,
 	.syss_offs	= 0x0408,
-	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_MIDLEMODE|
-			  SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
-			  SYSC_HAS_AUTOIDLE),
-	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
-			  MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMART),
+	/*
+	 * musb has MMIDLEMODE, but if we ever enable the device not in force
+	 * idle mode, core_pwrdm does not enter idle states at least on 36xx.
+	 * Note that musb also has OTG_FORCESTDBY register that the driver
+	 * uses to control MSTANDBY signal manually.
+	 */
+	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_ENAWAKEUP |
+			  SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
 
-- 
1.7.9.5
