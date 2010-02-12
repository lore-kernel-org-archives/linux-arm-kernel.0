From: tony@atomide.com (Tony Lindgren)
Date: Thu, 11 Feb 2010 16:51:52 -0800
Subject: [PATCH 19/19] OMAP4: MCPDM: Register McPDM platform device
In-Reply-To: <20100212004844.24958.29506.stgit@baageli.muru.com>
References: <20100212004844.24958.29506.stgit@baageli.muru.com>
Message-ID: <20100212005152.24958.2531.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jorge Eduardo Candelaria <x0107209@ti.com>

Add platform device for McPDM interface in OMAP4 and register
its memory and irq resources.

Signed-off-by: Jorge Eduardo Candelaria <x0107209@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/devices.c |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index 59f92c8..3a3e357 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -28,6 +28,7 @@
 #include <plat/menelaus.h>
 #include <plat/mcbsp.h>
 #include <plat/dsp_common.h>
+#include <plat/omap44xx.h>
 
 #if	defined(CONFIG_OMAP_DSP) || defined(CONFIG_OMAP_DSP_MODULE)
 
@@ -192,6 +193,41 @@ void omap_mcbsp_register_board_cfg(struct omap_mcbsp_platform_data *config,
 
 /*-------------------------------------------------------------------------*/
 
+#if defined(CONFIG_SND_OMAP_SOC_MCPDM) || \
+		defined(CONFIG_SND_OMAP_SOC_MCPDM_MODULE)
+
+static struct resource mcpdm_resources[] = {
+	{
+		.name		= "mcpdm_mem",
+		.start		= OMAP44XX_MCPDM_BASE,
+		.end		= OMAP44XX_MCPDM_BASE + SZ_4K,
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.name		= "mcpdm_irq",
+		.start		= INT_44XX_MCPDM_IRQ,
+		.end		= INT_44XX_MCPDM_IRQ,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device omap_mcpdm_device = {
+	.name		= "omap-mcpdm",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(mcpdm_resources),
+	.resource	= mcpdm_resources,
+};
+
+static void omap_init_mcpdm(void)
+{
+	(void) platform_device_register(&omap_mcpdm_device);
+}
+#else
+static inline void omap_init_mcpdm(void) {}
+#endif
+
+/*-------------------------------------------------------------------------*/
+
 #if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE) || \
 	defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
 
@@ -385,6 +421,7 @@ static int __init omap_init_devices(void)
 	omap_init_dsp();
 	omap_init_kp();
 	omap_init_rng();
+	omap_init_mcpdm();
 	omap_init_uwire();
 	omap_init_wdt();
 	return 0;
