From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 23 Sep 2011 15:46:19 +0300
Subject: [PATCHv9 11/18] omap3+: add omap prm driver initialization
In-Reply-To: <1316781986-30642-1-git-send-email-t-kristo@ti.com>
References: <1316781986-30642-1-git-send-email-t-kristo@ti.com>
Message-ID: <1316781986-30642-12-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP PRM driver is initialized based on availability of PRM hwmods.
This patch will sequentially check for a list of known PRM hwmods and
will add an omap device if any is found.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/devices.c |   46 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 10adf66..d6750a4 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -419,6 +419,51 @@ static void omap_init_pmu(void)
 	platform_device_register(&omap_pmu_device);
 }
 
+#ifdef CONFIG_OMAP_PRM
+
+#include <linux/mfd/omap-prm.h>
+
+static const char * const omap_prm_devnames[] = {
+	"prm3xxx",
+	"prm4xxx",
+	NULL,
+};
+
+static void omap_init_prm(void)
+{
+	struct platform_device *pdev;
+	struct omap_hwmod *oh = NULL;
+	struct omap_prm_platform_config *pdata;
+	int i = 0;
+
+	while (!oh && omap_prm_devnames[i]) {
+		oh = omap_hwmod_lookup(omap_prm_devnames[i]);
+		i++;
+	}
+
+	if (!oh) {
+		pr_info("prm hwmod not available\n");
+		return;
+	}
+
+	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
+
+	if (!pdata) {
+		pr_err("%s: kzalloc failed\n", __func__);
+		return;
+	}
+
+	pdata->irq = oh->mpu_irqs[0].irq;
+	pdata->base = omap_hwmod_get_mpu_rt_va(oh);
+
+	pdev = omap_device_build(oh->name, -1, oh, pdata,
+		sizeof(*pdata), NULL, 0, 0);
+
+	WARN(IS_ERR(pdev), "Unable to build omap device for PRM\n");
+}
+#else
+static inline void omap_init_prm(void) { }
+#endif
 
 #if defined(CONFIG_CRYPTO_DEV_OMAP_SHAM) || defined(CONFIG_CRYPTO_DEV_OMAP_SHAM_MODULE)
 
@@ -687,6 +732,7 @@ static int __init omap2_init_devices(void)
 	omap_init_mbox();
 	omap_init_mcspi();
 	omap_init_pmu();
+	omap_init_prm();
 	omap_hdq_init();
 	omap_init_sti();
 	omap_init_sham();
-- 
1.7.4.1


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 
