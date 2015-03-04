From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  4 Mar 2015 20:33:07 +0100
Subject: [RFC PATCH 13/18] ARM: msm: rename conflicting symbols
In-Reply-To: <1425497592-1831064-1-git-send-email-arnd@arndb.de>
References: <1425497592-1831064-1-git-send-email-arnd@arndb.de>
Message-ID: <1425497592-1831064-14-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Each MSM SoC implementation defines the same set of platform device
structures to be used by the respective board file. Linking them
together fails because of conflicting symbols, so we need to
rename them by adding the name of the soc as the prefix.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-msm/board-halibut.c     | 12 +++----
 arch/arm/mach-msm/board-msm7x30.c     | 18 +++++-----
 arch/arm/mach-msm/board-qsd8x50.c     | 20 +++++------
 arch/arm/mach-msm/board-trout-mmc.c   |  4 +--
 arch/arm/mach-msm/board-trout-panel.c |  6 ++--
 arch/arm/mach-msm/board-trout.c       | 12 +++----
 arch/arm/mach-msm/common.h            | 10 ++++--
 arch/arm/mach-msm/devices-msm7x00.c   | 40 ++++++++++-----------
 arch/arm/mach-msm/devices-msm7x30.c   | 12 +++----
 arch/arm/mach-msm/devices-qsd8x50.c   | 30 ++++++++--------
 arch/arm/mach-msm/devices.h           | 67 ++++++++++++++++++++---------------
 11 files changed, 122 insertions(+), 109 deletions(-)

diff --git a/arch/arm/mach-msm/board-halibut.c b/arch/arm/mach-msm/board-halibut.c
index 1b6d64196631..106a2fd23017 100644
--- a/arch/arm/mach-msm/board-halibut.c
+++ b/arch/arm/mach-msm/board-halibut.c
@@ -59,12 +59,12 @@ static struct platform_device smc91x_device = {
 
 static struct platform_device *devices[] __initdata = {
 	&msm_clock_7x01a,
-	&msm_device_gpio_7201,
-	&msm_device_uart3,
-	&msm_device_smd,
-	&msm_device_nand,
-	&msm_device_hsusb,
-	&msm_device_i2c,
+	&msm7x00_device_gpio_7201,
+	&msm7x00_device_uart3,
+	&msm7x00_device_smd,
+	&msm7x00_device_nand,
+	&msm7x00_device_hsusb,
+	&msm7x00_device_i2c,
 	&smc91x_device,
 };
 
diff --git a/arch/arm/mach-msm/board-msm7x30.c b/arch/arm/mach-msm/board-msm7x30.c
index 295d7c03e53f..95e0cdde23a7 100644
--- a/arch/arm/mach-msm/board-msm7x30.c
+++ b/arch/arm/mach-msm/board-msm7x30.c
@@ -123,14 +123,14 @@ static struct msm_gpiomux_config msm7x30_gpiomux_configs[MSM7X30_GPIOMUX_NGPIOS]
 
 static struct platform_device *devices[] __initdata = {
 	&msm_clock_7x30,
-	&msm_device_gpio_7x30,
+	&msm7x30_device_gpio_7x30,
 #if defined(CONFIG_SERIAL_MSM)
-        &msm_device_uart2,
+        &msm7x30_device_uart2,
 #endif
-	&msm_device_smd,
-	&msm_device_otg,
-	&msm_device_hsusb,
-	&msm_device_hsusb_host,
+	&msm7x30_device_smd,
+	&msm7x30_device_otg,
+	&msm7x30_device_hsusb,
+	&msm7x30_device_hsusb_host,
 };
 
 #define SMSM_FAKE_IRQ (0xff)
@@ -194,9 +194,9 @@ static void __init msm7x30_init(void)
 {
 	gpiomux_init(msm7x30_gpiomux_configs,
 		     ARRAY_SIZE(msm7x30_gpiomux_configs));
-	msm_device_otg.dev.platform_data = &msm_otg_pdata;
-	msm_device_hsusb.dev.parent = &msm_device_otg.dev;
-	msm_device_hsusb_host.dev.parent = &msm_device_otg.dev;
+	msm7x30_device_otg.dev.platform_data = &msm_otg_pdata;
+	msm7x30_device_hsusb.dev.parent = &msm7x30_device_otg.dev;
+	msm7x30_device_hsusb_host.dev.parent = &msm7x30_device_otg.dev;
 
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 }
diff --git a/arch/arm/mach-msm/board-qsd8x50.c b/arch/arm/mach-msm/board-qsd8x50.c
index 7bd36b9908c8..9b7cd93541f9 100644
--- a/arch/arm/mach-msm/board-qsd8x50.c
+++ b/arch/arm/mach-msm/board-qsd8x50.c
@@ -125,12 +125,12 @@ static struct msm_otg_platform_data msm_otg_pdata = {
 
 static struct platform_device *devices[] __initdata = {
 	&msm_clock_8x50,
-	&msm_device_gpio_8x50,
-	&msm_device_uart3,
-	&msm_device_smd,
-	&msm_device_otg,
-	&msm_device_hsusb,
-	&msm_device_hsusb_host,
+	&qsd8x50_device_gpio_8x50,
+	&qsd8x50_device_uart3,
+	&qsd8x50_device_smd,
+	&qsd8x50_device_otg,
+	&qsd8x50_device_hsusb,
+	&qsd8x50_device_hsusb_host,
 };
 
 static struct msm_mmc_gpio sdc1_gpio_cfg[] = {
@@ -218,7 +218,7 @@ static void __init qsd8x50_init_mmc(void)
 		return;
 	}
 
-	msm_add_sdcc(1, &qsd8x50_sdc1_data, 0, 0);
+	qsd8x50_add_sdcc(1, &qsd8x50_sdc1_data, 0, 0);
 }
 
 #define SMSM_FAKE_IRQ (0xff)
@@ -286,9 +286,9 @@ static void __init qsd8x50_init(void)
 {
 	gpiomux_init(qsd8x50_gpiomux_configs,
 		     ARRAY_SIZE(qsd8x50_gpiomux_configs));
-	msm_device_otg.dev.platform_data = &msm_otg_pdata;
-	msm_device_hsusb.dev.parent = &msm_device_otg.dev;
-	msm_device_hsusb_host.dev.parent = &msm_device_otg.dev;
+	qsd8x50_device_otg.dev.platform_data = &msm_otg_pdata;
+	qsd8x50_device_hsusb.dev.parent = &qsd8x50_device_otg.dev;
+	qsd8x50_device_hsusb_host.dev.parent = &qsd8x50_device_otg.dev;
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 	qsd8x50_init_mmc();
 }
diff --git a/arch/arm/mach-msm/board-trout-mmc.c b/arch/arm/mach-msm/board-trout-mmc.c
index 2474bba71c8b..608d86b171c4 100644
--- a/arch/arm/mach-msm/board-trout-mmc.c
+++ b/arch/arm/mach-msm/board-trout-mmc.c
@@ -194,8 +194,8 @@ int __init trout_init_mmc(unsigned int sys_rev)
 	irq_set_irq_wake(TROUT_GPIO_TO_INT(TROUT_GPIO_SDMC_CD_N), 1);
 
 	if (!opt_disable_sdcard)
-		msm_add_sdcc(2, &trout_sdslot_data,
-			     TROUT_GPIO_TO_INT(TROUT_GPIO_SDMC_CD_N), 0);
+		msm7x00_add_sdcc(2, &trout_sdslot_data,
+				 TROUT_GPIO_TO_INT(TROUT_GPIO_SDMC_CD_N), 0);
 	else
 		printk(KERN_INFO "trout: SD-Card interface disabled\n");
 	return 0;
diff --git a/arch/arm/mach-msm/board-trout-panel.c b/arch/arm/mach-msm/board-trout-panel.c
index 77b0a26f897f..e06c4f309fda 100644
--- a/arch/arm/mach-msm/board-trout-panel.c
+++ b/arch/arm/mach-msm/board-trout-panel.c
@@ -282,11 +282,11 @@ int __init trout_init_panel(void)
 			pr_err("trout_init_panel: set clock rate failed\n");
 	}
 
-	rc = platform_device_register(&msm_device_mdp);
+	rc = platform_device_register(&msm7x00_device_mdp);
 	if (rc)
 		return rc;
-	msm_device_mddi0.dev.platform_data = &mddi_pdata;
-	return platform_device_register(&msm_device_mddi0);
+	msm7x00_device_mddi0.dev.platform_data = &mddi_pdata;
+	return platform_device_register(&msm7x00_device_mddi0);
 }
 
 device_initcall(trout_init_panel);
diff --git a/arch/arm/mach-msm/board-trout.c b/arch/arm/mach-msm/board-trout.c
index e1c6e8528150..9737e43a2887 100644
--- a/arch/arm/mach-msm/board-trout.c
+++ b/arch/arm/mach-msm/board-trout.c
@@ -38,12 +38,12 @@ extern int trout_init_mmc(unsigned int);
 
 static struct platform_device *devices[] __initdata = {
 	&msm_clock_7x01a,
-	&msm_device_gpio_7201,
-	&msm_device_uart3,
-	&msm_device_smd,
-	&msm_device_nand,
-	&msm_device_hsusb,
-	&msm_device_i2c,
+	&msm7x00_device_gpio_7201,
+	&msm7x00_device_uart3,
+	&msm7x00_device_smd,
+	&msm7x00_device_nand,
+	&msm7x00_device_hsusb,
+	&msm7x00_device_i2c,
 };
 
 static void __init trout_init_early(void)
diff --git a/arch/arm/mach-msm/common.h b/arch/arm/mach-msm/common.h
index 3c5214057657..1e7d3e0518fe 100644
--- a/arch/arm/mach-msm/common.h
+++ b/arch/arm/mach-msm/common.h
@@ -30,8 +30,12 @@ extern void msm_add_devices(void);
 extern void msm_init_irq(void);
 extern void msm_init_vic(uint8_t *irq_to_smsm, int nr);
 extern void msm_init_gpio(void);
-extern int msm_add_sdcc(unsigned int controller,
-			struct msm_mmc_platform_data *plat,
-			unsigned int stat_irq, unsigned long stat_irq_flags);
+extern int msm7x00_add_sdcc(unsigned int controller,
+			    struct msm_mmc_platform_data *plat,
+			    unsigned int stat_irq, unsigned long stat_irq_flags);
+
+extern int qsd8x50_add_sdcc(unsigned int controller,
+			    struct msm_mmc_platform_data *plat,
+			    unsigned int stat_irq, unsigned long stat_irq_flags);
 
 #endif
diff --git a/arch/arm/mach-msm/devices-msm7x00.c b/arch/arm/mach-msm/devices-msm7x00.c
index 1bac32b690cf..b7308e7a301b 100644
--- a/arch/arm/mach-msm/devices-msm7x00.c
+++ b/arch/arm/mach-msm/devices-msm7x00.c
@@ -112,7 +112,7 @@ static struct resource msm_gpio_resources[] = {
 	},
 };
 
-struct platform_device msm_device_gpio_7201 = {
+struct platform_device msm7x00_device_gpio_7201 = {
 	.name	= "gpio-msm-7201",
 	.num_resources	= ARRAY_SIZE(msm_gpio_resources),
 	.resource	= msm_gpio_resources,
@@ -160,21 +160,21 @@ static struct resource resources_uart3[] = {
 	},
 };
 
-struct platform_device msm_device_uart1 = {
+struct platform_device msm7x00_device_uart1 = {
 	.name	= "msm_serial",
 	.id	= 0,
 	.num_resources	= ARRAY_SIZE(resources_uart1),
 	.resource	= resources_uart1,
 };
 
-struct platform_device msm_device_uart2 = {
+struct platform_device msm7x00_device_uart2 = {
 	.name	= "msm_serial",
 	.id	= 1,
 	.num_resources	= ARRAY_SIZE(resources_uart2),
 	.resource	= resources_uart2,
 };
 
-struct platform_device msm_device_uart3 = {
+struct platform_device msm7x00_device_uart3 = {
 	.name	= "msm_serial",
 	.id	= 2,
 	.num_resources	= ARRAY_SIZE(resources_uart3),
@@ -194,7 +194,7 @@ static struct resource resources_i2c[] = {
 	},
 };
 
-struct platform_device msm_device_i2c = {
+struct platform_device msm7x00_device_i2c = {
 	.name		= "msm_i2c",
 	.id		= 0,
 	.num_resources	= ARRAY_SIZE(resources_i2c),
@@ -214,7 +214,7 @@ static struct resource resources_hsusb[] = {
 	},
 };
 
-struct platform_device msm_device_hsusb = {
+struct platform_device msm7x00_device_hsusb = {
 	.name		= "msm_hsusb",
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(resources_hsusb),
@@ -237,7 +237,7 @@ static struct resource resources_nand[] = {
 	},
 };
 
-struct platform_device msm_device_nand = {
+struct platform_device msm7x00_device_nand = {
 	.name		= "msm_nand",
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(resources_nand),
@@ -252,7 +252,7 @@ static struct resource resources_smd[] = {
 	DEFINE_RES_IRQ(INT_A9_M2A_5),
 };
 
-struct platform_device msm_device_smd = {
+struct platform_device msm7x00_device_smd = {
 	.name		= "msm7x00_smd",
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(resources_smd),
@@ -395,7 +395,7 @@ static struct resource resources_sdc4[] = {
 	},
 };
 
-struct platform_device msm_device_sdc1 = {
+struct platform_device msm7x00_device_sdc1 = {
 	.name		= "msm_sdcc",
 	.id		= 1,
 	.num_resources	= ARRAY_SIZE(resources_sdc1),
@@ -405,7 +405,7 @@ struct platform_device msm_device_sdc1 = {
 	},
 };
 
-struct platform_device msm_device_sdc2 = {
+struct platform_device msm7x00_device_sdc2 = {
 	.name		= "msm_sdcc",
 	.id		= 2,
 	.num_resources	= ARRAY_SIZE(resources_sdc2),
@@ -415,7 +415,7 @@ struct platform_device msm_device_sdc2 = {
 	},
 };
 
-struct platform_device msm_device_sdc3 = {
+struct platform_device msm7x00_device_sdc3 = {
 	.name		= "msm_sdcc",
 	.id		= 3,
 	.num_resources	= ARRAY_SIZE(resources_sdc3),
@@ -425,7 +425,7 @@ struct platform_device msm_device_sdc3 = {
 	},
 };
 
-struct platform_device msm_device_sdc4 = {
+struct platform_device msm7x00_device_sdc4 = {
 	.name		= "msm_sdcc",
 	.id		= 4,
 	.num_resources	= ARRAY_SIZE(resources_sdc4),
@@ -436,13 +436,13 @@ struct platform_device msm_device_sdc4 = {
 };
 
 static struct platform_device *msm_sdcc_devices[] __initdata = {
-	&msm_device_sdc1,
-	&msm_device_sdc2,
-	&msm_device_sdc3,
-	&msm_device_sdc4,
+	&msm7x00_device_sdc1,
+	&msm7x00_device_sdc2,
+	&msm7x00_device_sdc3,
+	&msm7x00_device_sdc4,
 };
 
-int __init msm_add_sdcc(unsigned int controller,
+int __init msm7x00_add_sdcc(unsigned int controller,
 			struct msm_mmc_platform_data *plat,
 			unsigned int stat_irq, unsigned long stat_irq_flags)
 {
@@ -493,7 +493,7 @@ static struct resource resources_mddi1[] = {
 	},
 };
 
-struct platform_device msm_device_mddi0 = {
+struct platform_device msm7x00_device_mddi0 = {
 	.name = "msm_mddi",
 	.id = 0,
 	.num_resources = ARRAY_SIZE(resources_mddi0),
@@ -503,7 +503,7 @@ struct platform_device msm_device_mddi0 = {
 	},
 };
 
-struct platform_device msm_device_mddi1 = {
+struct platform_device msm7x00_device_mddi1 = {
 	.name = "msm_mddi",
 	.id = 1,
 	.num_resources = ARRAY_SIZE(resources_mddi1),
@@ -527,7 +527,7 @@ static struct resource resources_mdp[] = {
 	},
 };
 
-struct platform_device msm_device_mdp = {
+struct platform_device msm7x00_device_mdp = {
 	.name = "msm_mdp",
 	.id = 0,
 	.num_resources = ARRAY_SIZE(resources_mdp),
diff --git a/arch/arm/mach-msm/devices-msm7x30.c b/arch/arm/mach-msm/devices-msm7x30.c
index f4ff40caac27..2d36c54b9523 100644
--- a/arch/arm/mach-msm/devices-msm7x30.c
+++ b/arch/arm/mach-msm/devices-msm7x30.c
@@ -93,7 +93,7 @@ static struct resource msm_gpio_resources[] = {
 	},
 };
 
-struct platform_device msm_device_gpio_7x30 = {
+struct platform_device msm7x30_device_gpio_7x30 = {
 	.name	= "gpio-msm-7x30",
 	.num_resources	= ARRAY_SIZE(msm_gpio_resources),
 	.resource	= msm_gpio_resources,
@@ -113,7 +113,7 @@ static struct resource resources_uart2[] = {
 	},
 };
 
-struct platform_device msm_device_uart2 = {
+struct platform_device msm7x30_device_uart2 = {
 	.name	= "msm_serial",
 	.id	= 1,
 	.num_resources	= ARRAY_SIZE(resources_uart2),
@@ -125,7 +125,7 @@ static struct resource resources_smd[] = {
 	DEFINE_RES_IRQ(INT_A9_M2A_5),
 };
 
-struct platform_device msm_device_smd = {
+struct platform_device msm7x30_device_smd = {
 	.name   	= "msm_smd",
 	.id     	= -1,
 	.num_resources	= ARRAY_SIZE(resources_smd),
@@ -145,7 +145,7 @@ static struct resource resources_otg[] = {
 	},
 };
 
-struct platform_device msm_device_otg = {
+struct platform_device msm7x30_device_otg = {
 	.name		= "msm_otg",
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(resources_otg),
@@ -168,7 +168,7 @@ static struct resource resources_hsusb[] = {
 	},
 };
 
-struct platform_device msm_device_hsusb = {
+struct platform_device msm7x30_device_hsusb = {
 	.name		= "msm_hsusb",
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(resources_hsusb),
@@ -192,7 +192,7 @@ static struct resource resources_hsusb_host[] = {
 	},
 };
 
-struct platform_device msm_device_hsusb_host = {
+struct platform_device msm7x30_device_hsusb_host = {
 	.name		= "msm_hsusb_host",
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(resources_hsusb_host),
diff --git a/arch/arm/mach-msm/devices-qsd8x50.c b/arch/arm/mach-msm/devices-qsd8x50.c
index 5dcf17a24d70..5f280467f207 100644
--- a/arch/arm/mach-msm/devices-qsd8x50.c
+++ b/arch/arm/mach-msm/devices-qsd8x50.c
@@ -103,7 +103,7 @@ static struct resource msm_gpio_resources[] = {
 	},
 };
 
-struct platform_device msm_device_gpio_8x50 = {
+struct platform_device qsd8x50_device_gpio_8x50 = {
 	.name	= "gpio-msm-8x50",
 	.num_resources	= ARRAY_SIZE(msm_gpio_resources),
 	.resource	= msm_gpio_resources,
@@ -123,7 +123,7 @@ static struct resource resources_uart3[] = {
 	},
 };
 
-struct platform_device msm_device_uart3 = {
+struct platform_device qsd8x50_device_uart3 = {
 	.name	= "msm_serial",
 	.id	= 2,
 	.num_resources	= ARRAY_SIZE(resources_uart3),
@@ -135,7 +135,7 @@ static struct resource resources_smd[] = {
 	DEFINE_RES_IRQ(INT_A9_M2A_5),
 };
 
-struct platform_device msm_device_smd = {
+struct platform_device qsd8x50_device_smd = {
 	.name		= "msm_smd",
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(resources_smd),
@@ -155,7 +155,7 @@ static struct resource resources_otg[] = {
 	},
 };
 
-struct platform_device msm_device_otg = {
+struct platform_device qsd8x50_device_otg = {
 	.name		= "msm_otg",
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(resources_otg),
@@ -178,7 +178,7 @@ static struct resource resources_hsusb[] = {
 	},
 };
 
-struct platform_device msm_device_hsusb = {
+struct platform_device qsd8x50_device_hsusb = {
 	.name		= "msm_hsusb",
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(resources_hsusb),
@@ -202,7 +202,7 @@ static struct resource resources_hsusb_host[] = {
 	},
 };
 
-struct platform_device msm_device_hsusb_host = {
+struct platform_device qsd8x50_device_hsusb_host = {
 	.name		= "msm_hsusb_host",
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(resources_hsusb_host),
@@ -349,7 +349,7 @@ static struct resource resources_sdc4[] = {
 	},
 };
 
-struct platform_device msm_device_sdc1 = {
+struct platform_device qsd8x50_device_sdc1 = {
 	.name		= "msm_sdcc",
 	.id		= 1,
 	.num_resources	= ARRAY_SIZE(resources_sdc1),
@@ -359,7 +359,7 @@ struct platform_device msm_device_sdc1 = {
 	},
 };
 
-struct platform_device msm_device_sdc2 = {
+struct platform_device qsd8x50_device_sdc2 = {
 	.name		= "msm_sdcc",
 	.id		= 2,
 	.num_resources	= ARRAY_SIZE(resources_sdc2),
@@ -369,7 +369,7 @@ struct platform_device msm_device_sdc2 = {
 	},
 };
 
-struct platform_device msm_device_sdc3 = {
+struct platform_device qsd8x50_device_sdc3 = {
 	.name		= "msm_sdcc",
 	.id		= 3,
 	.num_resources	= ARRAY_SIZE(resources_sdc3),
@@ -379,7 +379,7 @@ struct platform_device msm_device_sdc3 = {
 	},
 };
 
-struct platform_device msm_device_sdc4 = {
+struct platform_device qsd8x50_device_sdc4 = {
 	.name		= "msm_sdcc",
 	.id		= 4,
 	.num_resources	= ARRAY_SIZE(resources_sdc4),
@@ -390,13 +390,13 @@ struct platform_device msm_device_sdc4 = {
 };
 
 static struct platform_device *msm_sdcc_devices[] __initdata = {
-	&msm_device_sdc1,
-	&msm_device_sdc2,
-	&msm_device_sdc3,
-	&msm_device_sdc4,
+	&qsd8x50_device_sdc1,
+	&qsd8x50_device_sdc2,
+	&qsd8x50_device_sdc3,
+	&qsd8x50_device_sdc4,
 };
 
-int __init msm_add_sdcc(unsigned int controller,
+int __init qsd8x50_add_sdcc(unsigned int controller,
 			struct msm_mmc_platform_data *plat,
 			unsigned int stat_irq, unsigned long stat_irq_flags)
 {
diff --git a/arch/arm/mach-msm/devices.h b/arch/arm/mach-msm/devices.h
index dccefad9f9b9..81d86b32647a 100644
--- a/arch/arm/mach-msm/devices.h
+++ b/arch/arm/mach-msm/devices.h
@@ -16,35 +16,44 @@
 #ifndef __ARCH_ARM_MACH_MSM_DEVICES_H
 #define __ARCH_ARM_MACH_MSM_DEVICES_H
 
-extern struct platform_device msm_device_gpio_7201;
-extern struct platform_device msm_device_gpio_7x30;
-extern struct platform_device msm_device_gpio_8x50;
-
-extern struct platform_device msm_device_uart1;
-extern struct platform_device msm_device_uart2;
-extern struct platform_device msm_device_uart3;
-
-extern struct platform_device msm8960_device_uart_gsbi2;
-extern struct platform_device msm8960_device_uart_gsbi5;
-
-extern struct platform_device msm_device_sdc1;
-extern struct platform_device msm_device_sdc2;
-extern struct platform_device msm_device_sdc3;
-extern struct platform_device msm_device_sdc4;
-
-extern struct platform_device msm_device_hsusb;
-extern struct platform_device msm_device_otg;
-extern struct platform_device msm_device_hsusb_host;
-
-extern struct platform_device msm_device_i2c;
-
-extern struct platform_device msm_device_smd;
-
-extern struct platform_device msm_device_nand;
-
-extern struct platform_device msm_device_mddi0;
-extern struct platform_device msm_device_mddi1;
-extern struct platform_device msm_device_mdp;
+extern struct platform_device msm7x00_device_gpio_7201;
+extern struct platform_device msm7x30_device_gpio_7x30;
+extern struct platform_device qsd8x50_device_gpio_8x50;
+
+extern struct platform_device msm7x00_device_uart1;
+extern struct platform_device msm7x00_device_uart2;
+extern struct platform_device msm7x00_device_uart3;
+extern struct platform_device msm7x30_device_uart2;
+extern struct platform_device qsd8x50_device_uart3;
+
+extern struct platform_device msm7x00_device_sdc1;
+extern struct platform_device msm7x00_device_sdc2;
+extern struct platform_device msm7x00_device_sdc3;
+extern struct platform_device msm7x00_device_sdc4;
+extern struct platform_device qsd8x50_device_sdc1;
+extern struct platform_device qsd8x50_device_sdc2;
+extern struct platform_device qsd8x50_device_sdc3;
+extern struct platform_device qsd8x50_device_sdc4;
+
+extern struct platform_device msm7x00_device_hsusb;
+extern struct platform_device msm7x30_device_hsusb;
+extern struct platform_device msm7x30_device_otg;
+extern struct platform_device msm7x30_device_hsusb_host;
+extern struct platform_device qsd8x50_device_hsusb;
+extern struct platform_device qsd8x50_device_otg;
+extern struct platform_device qsd8x50_device_hsusb_host;
+
+extern struct platform_device msm7x00_device_i2c;
+
+extern struct platform_device msm7x00_device_nand;
+
+extern struct platform_device msm7x00_device_smd;
+extern struct platform_device msm7x30_device_smd;
+extern struct platform_device qsd8x50_device_smd;
+
+extern struct platform_device msm7x00_device_mddi0;
+extern struct platform_device msm7x00_device_mddi1;
+extern struct platform_device msm7x00_device_mdp;
 
 extern struct platform_device msm_clock_7x01a;
 extern struct platform_device msm_clock_7x30;
-- 
2.1.0.rc2
