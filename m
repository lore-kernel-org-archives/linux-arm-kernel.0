From: tony@atomide.com (Tony Lindgren)
Date: Tue, 13 Jan 2015 15:13:53 -0800
Subject: [PATCH 3/7] ARM: OMAP2+: Fix ti81xx devtype
In-Reply-To: <1421190837-4692-1-git-send-email-tony@atomide.com>
References: <1421190837-4692-1-git-send-email-tony@atomide.com>
Message-ID: <1421190837-4692-4-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Otherwise we get error "Cannot detect omap type!" and many
things can fail with following:

Unhandled fault: imprecise external abort (0xc06) at 0xc6031fb0

This is because the omap_type is being used to set up th SoC
specific functions for omaps.

Cc: Brian Hutchinson <b.hutchman@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/control.h | 4 ++++
 arch/arm/mach-omap2/id.c      | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index a3c0133..0fba6d1 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -53,6 +53,7 @@
 #define OMAP343X_CONTROL_GENERAL_WKUP	0xa60
 
 /* TI81XX spefic control submodules */
+#define TI81XX_CONTROL_DEVBOOT		0x040
 #define TI81XX_CONTROL_DEVCONF		0x600
 
 /* Control register offsets - read/write with omap_ctrl_{read,write}{bwl}() */
@@ -246,6 +247,9 @@
 #define OMAP3_PADCONF_SAD2D_MSTANDBY   0x250
 #define OMAP3_PADCONF_SAD2D_IDLEACK    0x254
 
+/* TI81XX CONTROL_DEVBOOT register offsets */
+#define TI81XX_CONTROL_STATUS		(TI81XX_CONTROL_DEVBOOT + 0x000)
+
 /* TI81XX CONTROL_DEVCONF register offsets */
 #define TI81XX_CONTROL_DEVICE_ID	(TI81XX_CONTROL_DEVCONF + 0x000)
 
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index c25feba..2a2f4d5 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -56,6 +56,8 @@ int omap_type(void)
 
 	if (cpu_is_omap24xx()) {
 		val = omap_ctrl_readl(OMAP24XX_CONTROL_STATUS);
+	} else if (cpu_is_ti81xx()) {
+		val = omap_ctrl_readl(TI81XX_CONTROL_STATUS);
 	} else if (soc_is_am33xx() || soc_is_am43xx()) {
 		val = omap_ctrl_readl(AM33XX_CONTROL_STATUS);
 	} else if (cpu_is_omap34xx()) {
-- 
2.1.4
