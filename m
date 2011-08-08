From: rajeshwari.s@samsung.com (Rajeshwari Shinde)
Date: Mon, 08 Aug 2011 14:17:54 +0530
Subject: RFC[PATCH 4/6] ARM: S5P64X0: Populate default platform data for SDHCI
	devices
In-Reply-To: <1312793277-18689-1-git-send-email-rajeshwari.s@samsung.com>
References: <1312793277-18689-1-git-send-email-rajeshwari.s@samsung.com>
Message-ID: <1312793277-18689-5-git-send-email-rajeshwari.s@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch populates the default platform data required by
SDHCI devices for S5P6440 and S5P6450.

Signed-off-by: Rajeshwari Shinde <rajeshwari.s@samsung.com>
---
 arch/arm/mach-s5p64x0/cpu.c                |    9 +++++
 arch/arm/plat-samsung/include/plat/sdhci.h |   50 ++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5p64x0/cpu.c b/arch/arm/mach-s5p64x0/cpu.c
index a5c0095..1b2063c 100644
--- a/arch/arm/mach-s5p64x0/cpu.c
+++ b/arch/arm/mach-s5p64x0/cpu.c
@@ -38,6 +38,7 @@
 #include <plat/s5p6440.h>
 #include <plat/s5p6450.h>
 #include <plat/adc-core.h>
+#include <plat/sdhci.h>
 
 /* Initial IO mappings */
 
@@ -109,6 +110,10 @@ void __init s5p6440_map_io(void)
 	/* initialize any device information early */
 	s3c_adc_setname("s3c64xx-adc");
 
+	s5p64x0_default_sdhci0();
+	s5p64x0_default_sdhci1();
+	s5p6440_default_sdhci2();
+
 	iotable_init(s5p64x0_iodesc, ARRAY_SIZE(s5p64x0_iodesc));
 	iotable_init(s5p6440_iodesc, ARRAY_SIZE(s5p6440_iodesc));
 }
@@ -118,6 +123,10 @@ void __init s5p6450_map_io(void)
 	/* initialize any device information early */
 	s3c_adc_setname("s3c64xx-adc");
 
+	s5p64x0_default_sdhci0();
+	s5p64x0_default_sdhci1();
+	s5p6450_default_sdhci2();
+
 	iotable_init(s5p64x0_iodesc, ARRAY_SIZE(s5p64x0_iodesc));
 	iotable_init(s5p6450_iodesc, ARRAY_SIZE(s5p6450_iodesc));
 }
diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h b/arch/arm/plat-samsung/include/plat/sdhci.h
index 058e096..dde13aa 100644
--- a/arch/arm/plat-samsung/include/plat/sdhci.h
+++ b/arch/arm/plat-samsung/include/plat/sdhci.h
@@ -126,6 +126,10 @@ extern void exynos4_setup_sdhci0_cfg_gpio(struct platform_device *, int w);
 extern void exynos4_setup_sdhci1_cfg_gpio(struct platform_device *, int w);
 extern void exynos4_setup_sdhci2_cfg_gpio(struct platform_device *, int w);
 extern void exynos4_setup_sdhci3_cfg_gpio(struct platform_device *, int w);
+extern void s5p64x0_setup_sdhci0_cfg_gpio(struct platform_device *, int w);
+extern void s5p64x0_setup_sdhci1_cfg_gpio(struct platform_device *, int w);
+extern void s5p6440_setup_sdhci2_cfg_gpio(struct platform_device *, int w);
+extern void s5p6450_setup_sdhci2_cfg_gpio(struct platform_device *, int w);
 
 /* S3C2416 SDHCI setup */
 
@@ -390,4 +394,50 @@ static inline void exynos4_default_sdhci3(void) { }
 
 #endif /* CONFIG_EXYNOS4_SETUP_SDHCI */
 
+/* S5P64X0 SDHCI setup */
+#ifdef CONFIG_S5P64X0_SETUP_SDHCI
+extern void s5p64x0_setup_sdhci_cfg_card(struct platform_device *dev,
+						void __iomem *r,
+						struct mmc_ios *ios,
+						struct mmc_card *card);
+
+static inline void s5p64x0_default_sdhci0(void)
+{
+#ifdef CONFIG_S3C_DEV_HSMMC
+	s3c_hsmmc0_def_platdata.cfg_gpio = s5p64x0_setup_sdhci0_cfg_gpio;
+	s3c_hsmmc0_def_platdata.cfg_card = s5p64x0_setup_sdhci_cfg_card;
+#endif /* CONFIG_S3C_DEV_HSMMC */
+}
+
+static inline void s5p64x0_default_sdhci1(void)
+{
+#ifdef CONFIG_S3C_DEV_HSMMC1
+	s3c_hsmmc1_def_platdata.cfg_gpio = s5p64x0_setup_sdhci1_cfg_gpio;
+	s3c_hsmmc1_def_platdata.cfg_card = s5p64x0_setup_sdhci_cfg_card;
+#endif /* CONFIG_S3C_DEV_HSMMC1 */
+}
+
+static inline void s5p6440_default_sdhci2(void)
+{
+#ifdef CONFIG_S3C_DEV_HSMMC2
+	s3c_hsmmc2_def_platdata.cfg_gpio = s5p6440_setup_sdhci2_cfg_gpio;
+	s3c_hsmmc2_def_platdata.cfg_card = s5p64x0_setup_sdhci_cfg_card;
+#endif /* CONFIG_S3C_DEV_HSMMC2 */
+}
+
+static inline void s5p6450_default_sdhci2(void)
+{
+#ifdef CONFIG_S3C_DEV_HSMMC2
+	s3c_hsmmc2_def_platdata.cfg_gpio = s5p6450_setup_sdhci2_cfg_gpio;
+	s3c_hsmmc2_def_platdata.cfg_card = s5p64x0_setup_sdhci_cfg_card;
+#endif /* CONFIG_S3C_DEV_HSMMC2 */
+}
+
+#else
+static inline void s5p64x0_default_sdhci0(void) { }
+static inline void s5p64x0_default_sdhci1(void) { }
+static inline void s5p6440_default_sdhci2(void) { }
+static inline void s5p6450_default_sdhci2(void) { }
+#endif /* CONFIG_S5P64X0_SETUP_SDHCI */
+
 #endif /* __PLAT_S3C_SDHCI_H */
-- 
1.7.4.4
