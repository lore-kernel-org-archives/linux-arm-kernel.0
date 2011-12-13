From: manjunath.hadli@ti.com (Manjunath Hadli)
Date: Tue, 13 Dec 2011 16:53:33 +0530
Subject: [PATCH v5 09/11] davinci: dm644x: move vpfe init from soc to board
 specific files
In-Reply-To: <1323775415-24504-1-git-send-email-manjunath.hadli@ti.com>
References: <1323775415-24504-1-git-send-email-manjunath.hadli@ti.com>
Message-ID: <1323775415-24504-10-git-send-email-manjunath.hadli@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move all vpfe platform device registrations to the board specific
file like the rest of the devices, and have all of them together.

This would remove the  restriction of inclusion and registration of
vpfe platform devices for non-vpfe boards.

Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>
---
 arch/arm/mach-davinci/board-dm644x-evm.c |    3 +--
 arch/arm/mach-davinci/davinci.h          |    2 +-
 arch/arm/mach-davinci/dm644x.c           |   29 +++++++++++++++++------------
 3 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index fbd3856..8884125 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -624,8 +624,6 @@ static struct davinci_uart_config uart_config __initdata = {
 static void __init
 davinci_evm_map_io(void)
 {
-	/* setup input configuration for VPFE input devices */
-	dm644x_set_vpfe_config(&dm644xevm_capture_cfg);
 	dm644x_init();
 }
 
@@ -697,6 +695,7 @@ static __init void davinci_evm_init(void)
 	evm_init_i2c();
 
 	davinci_setup_mmc(0, &dm6446evm_mmc_config);
+	dm644x_init_video(&dm644xevm_capture_cfg);
 
 	davinci_serial_init(&uart_config);
 	dm644x_init_asp(&dm644x_evm_snd_data);
diff --git a/arch/arm/mach-davinci/davinci.h b/arch/arm/mach-davinci/davinci.h
index 06ed38a..13cb029 100644
--- a/arch/arm/mach-davinci/davinci.h
+++ b/arch/arm/mach-davinci/davinci.h
@@ -81,7 +81,7 @@ void dm365_set_vpfe_config(struct vpfe_config *cfg);
 /* DM644x function declarations */
 void __init dm644x_init(void);
 void __init dm644x_init_asp(struct snd_platform_data *pdata);
-void dm644x_set_vpfe_config(struct vpfe_config *cfg);
+int __init dm644x_init_video(struct vpfe_config *);
 
 /* DM646x function declarations */
 void __init dm646x_init(void);
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 1d9be87..6c034fd 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -659,11 +659,6 @@ static struct platform_device dm644x_vpfe_dev = {
 	},
 };
 
-void dm644x_set_vpfe_config(struct vpfe_config *cfg)
-{
-	dm644x_vpfe_dev.dev.platform_data = cfg;
-}
-
 /*----------------------------------------------------------------------*/
 
 static struct map_desc dm644x_io_desc[] = {
@@ -792,14 +787,28 @@ void __init dm644x_init(void)
 	davinci_map_sysmod();
 }
 
+static struct platform_device *dm644x_video_devices[] __initdata = {
+	&dm644x_vpss_device,
+	&dm644x_ccdc_dev,
+	&dm644x_vpfe_dev,
+};
+
+int __init dm644x_init_video(struct vpfe_config *vpfe_cfg)
+{
+	dm644x_vpfe_dev.dev.platform_data = vpfe_cfg;
+	/* Add ccdc clock aliases */
+	clk_add_alias("master", dm644x_ccdc_dev.name, "vpss_master", NULL);
+	clk_add_alias("slave", dm644x_ccdc_dev.name, "vpss_slave", NULL);
+	platform_add_devices(dm644x_video_devices,
+				ARRAY_SIZE(dm644x_video_devices));
+	return 0;
+}
+
 static int __init dm644x_init_devices(void)
 {
 	if (!cpu_is_davinci_dm644x())
 		return 0;
 
-	/* Add ccdc clock aliases */
-	clk_add_alias("master", dm644x_ccdc_dev.name, "vpss_master", NULL);
-	clk_add_alias("slave", dm644x_ccdc_dev.name, "vpss_slave", NULL);
 	platform_device_register(&dm644x_edma_device);
 
 	platform_device_register(&dm644x_mdio_device);
@@ -807,10 +816,6 @@ static int __init dm644x_init_devices(void)
 	clk_add_alias(NULL, dev_name(&dm644x_mdio_device.dev),
 		      NULL, &dm644x_emac_device.dev);
 
-	platform_device_register(&dm644x_vpss_device);
-	platform_device_register(&dm644x_ccdc_dev);
-	platform_device_register(&dm644x_vpfe_dev);
-
 	return 0;
 }
 postcore_initcall(dm644x_init_devices);
-- 
1.6.2.4
