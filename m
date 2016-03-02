From: tony@atomide.com (Tony Lindgren)
Date: Tue,  1 Mar 2016 17:55:02 -0800
Subject: [PATCH] ARM: OMAP2+: Use srst_udelay for USB on dm814x
Message-ID: <1456883702-32377-1-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without this booting t410 can fail randomly with no output
depending on the .config options chosen. Enabling debug_ll
causes the problem to go away. I narrowed this down to USB
by disabling one module at a time.

Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
index 39736ad..df83277 100644
--- a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
@@ -582,9 +582,11 @@ static struct omap_hwmod_ocp_if dm81xx_alwon_l3_slow__gpmc = {
 	.user		= OCP_USER_MPU,
 };
 
+/* USB needs udelay 1 after reset at least on hp t410, use 2 for margin */
 static struct omap_hwmod_class_sysconfig dm81xx_usbhsotg_sysc = {
 	.rev_offs	= 0x0,
 	.sysc_offs	= 0x10,
+	.srst_udelay	= 2,
 	.sysc_flags	= SYSC_HAS_SIDLEMODE | SYSC_HAS_MIDLEMODE |
 				SYSC_HAS_SOFTRESET,
 	.idlemodes	= SIDLE_SMART | MSTANDBY_FORCE | MSTANDBY_SMART,
-- 
2.7.0
