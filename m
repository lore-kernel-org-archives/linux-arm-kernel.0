From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 10 Nov 2009 23:21:54 +0000
Subject: [PATCH 2/4] S3C: Add NAND device platform data set call
In-Reply-To: <1257895316-9156-2-git-send-email-ben-linux@fluff.org>
References: <1257895316-9156-1-git-send-email-ben-linux@fluff.org>
	<1257895316-9156-2-git-send-email-ben-linux@fluff.org>
Message-ID: <1257895316-9156-3-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

---
 arch/arm/mach-s3c2410/mach-bast.c      |    8 +-
 arch/arm/mach-s3c2410/mach-qt2410.c    |    8 +-
 arch/arm/mach-s3c2412/mach-jive.c      |   11 ++--
 arch/arm/mach-s3c2412/mach-vstms.c     |   10 ++--
 arch/arm/mach-s3c2440/mach-anubis.c    |   12 ++--
 arch/arm/mach-s3c2440/mach-at2440evb.c |    8 +-
 arch/arm/mach-s3c2440/mach-mini2440.c  |    4 +-
 arch/arm/mach-s3c2440/mach-osiris.c    |   11 ++--
 arch/arm/mach-s3c2440/mach-rx3715.c    |    9 +--
 arch/arm/mach-s3c2442/mach-gta02.c     |    6 +-
 arch/arm/mach-s3c6410/mach-hmt.c       |    2 +-
 arch/arm/plat-s3c/dev-nand.c           |   97 ++++++++++++++++++++++++++++++++
 arch/arm/plat-s3c/include/plat/nand.h  |    8 +++
 arch/arm/plat-s3c24xx/common-smdk.c    |    2 +-
 14 files changed, 151 insertions(+), 45 deletions(-)

diff --git a/arch/arm/mach-s3c2410/mach-bast.c b/arch/arm/mach-s3c2410/mach-bast.c
index 647c9ad..c1219b1 100644
--- a/arch/arm/mach-s3c2410/mach-bast.c
+++ b/arch/arm/mach-s3c2410/mach-bast.c
@@ -247,7 +247,7 @@ static int chip0_map[] = { 1 };
 static int chip1_map[] = { 2 };
 static int chip2_map[] = { 3 };
 
-static struct mtd_partition bast_default_nand_part[] = {
+static struct mtd_partition __initdata bast_default_nand_part[] = {
 	[0] = {
 		.name	= "Boot Agent",
 		.size	= SZ_16K,
@@ -273,7 +273,7 @@ static struct mtd_partition bast_default_nand_part[] = {
  * socket.
 */
 
-static struct s3c2410_nand_set bast_nand_sets[] = {
+static struct s3c2410_nand_set __initdata bast_nand_sets[] = {
 	[0] = {
 		.name		= "SmartMedia",
 		.nr_chips	= 1,
@@ -323,7 +323,7 @@ static void bast_nand_select(struct s3c2410_nand_set *set, int slot)
 	__raw_writeb(tmp, BAST_VA_CTRL2);
 }
 
-static struct s3c2410_platform_nand bast_nand_info = {
+static struct s3c2410_platform_nand __initdata bast_nand_info = {
 	.tacls		= 30,
 	.twrph0		= 60,
 	.twrph1		= 60,
@@ -625,7 +625,6 @@ static void __init bast_map_io(void)
 
 	s3c24xx_register_clocks(bast_clocks, ARRAY_SIZE(bast_clocks));
 
-	s3c_device_nand.dev.platform_data = &bast_nand_info;
 	s3c_device_hwmon.dev.platform_data = &bast_hwmon_info;
 
 	s3c24xx_init_io(bast_iodesc, ARRAY_SIZE(bast_iodesc));
@@ -639,6 +638,7 @@ static void __init bast_init(void)
 	sysdev_register(&bast_pm_sysdev);
 
 	s3c_i2c0_set_platdata(&bast_i2c_info);
+	s3c_nand_set_platdata(&bast_nand_info);
 	s3c24xx_fb_set_platdata(&bast_fb_info);
 	platform_add_devices(bast_devices, ARRAY_SIZE(bast_devices));
 
diff --git a/arch/arm/mach-s3c2410/mach-qt2410.c b/arch/arm/mach-s3c2410/mach-qt2410.c
index 2cc9849..ab092bc 100644
--- a/arch/arm/mach-s3c2410/mach-qt2410.c
+++ b/arch/arm/mach-s3c2410/mach-qt2410.c
@@ -258,7 +258,7 @@ static struct platform_device *qt2410_devices[] __initdata = {
 	&qt2410_led,
 };
 
-static struct mtd_partition qt2410_nand_part[] = {
+static struct mtd_partition __initdata qt2410_nand_part[] = {
 	[0] = {
 		.name	= "U-Boot",
 		.size	= 0x30000,
@@ -286,7 +286,7 @@ static struct mtd_partition qt2410_nand_part[] = {
 	},
 };
 
-static struct s3c2410_nand_set qt2410_nand_sets[] = {
+static struct s3c2410_nand_set __initdata qt2410_nand_sets[] = {
 	[0] = {
 		.name		= "NAND",
 		.nr_chips	= 1,
@@ -299,7 +299,7 @@ static struct s3c2410_nand_set qt2410_nand_sets[] = {
  * chips and beyond.
  */
 
-static struct s3c2410_platform_nand qt2410_nand_info = {
+static struct s3c2410_platform_nand __initdata qt2410_nand_info = {
 	.tacls		= 20,
 	.twrph0		= 60,
 	.twrph1		= 20,
@@ -331,7 +331,7 @@ static void __init qt2410_map_io(void)
 
 static void __init qt2410_machine_init(void)
 {
-	s3c_device_nand.dev.platform_data = &qt2410_nand_info;
+	s3c_nand_set_platdata(&qt2410_nand_info);
 
 	switch (tft_type) {
 	case 'p': /* production */
diff --git a/arch/arm/mach-s3c2412/mach-jive.c b/arch/arm/mach-s3c2412/mach-jive.c
index 8df506e..c9fa3fc 100644
--- a/arch/arm/mach-s3c2412/mach-jive.c
+++ b/arch/arm/mach-s3c2412/mach-jive.c
@@ -96,7 +96,7 @@ static struct s3c2410_uartcfg jive_uartcfgs[] = {
  * 0x017d0000-0x02bd0000 : cramfs B
  * 0x02bd0000-0x03fd0000 : yaffs
  */
-static struct mtd_partition jive_imageA_nand_part[] = {
+static struct mtd_partition __initdata jive_imageA_nand_part[] = {
 
 #ifdef CONFIG_MACH_JIVE_SHOW_BOOTLOADER
 	/* Don't allow access to the bootloader from linux */
@@ -154,7 +154,7 @@ static struct mtd_partition jive_imageA_nand_part[] = {
         },
 };
 
-static struct mtd_partition jive_imageB_nand_part[] = {
+static struct mtd_partition __initdata jive_imageB_nand_part[] = {
 
 #ifdef CONFIG_MACH_JIVE_SHOW_BOOTLOADER
 	/* Don't allow access to the bootloader from linux */
@@ -213,7 +213,7 @@ static struct mtd_partition jive_imageB_nand_part[] = {
         },
 };
 
-static struct s3c2410_nand_set jive_nand_sets[] = {
+static struct s3c2410_nand_set __initdata jive_nand_sets[] = {
 	[0] = {
 		.name           = "flash",
 		.nr_chips       = 1,
@@ -222,7 +222,7 @@ static struct s3c2410_nand_set jive_nand_sets[] = {
 	},
 };
 
-static struct s3c2410_platform_nand jive_nand_info = {
+static struct s3c2410_platform_nand __initdata jive_nand_info = {
 	/* set taken from osiris nand timings, possibly still conservative */
 	.tacls		= 30,
 	.twrph0		= 55,
@@ -631,7 +631,8 @@ static void __init jive_machine_init(void)
 
 	s3c_pm_init();
 
-	s3c_device_nand.dev.platform_data = &jive_nand_info;
+	/** TODO - check that this is after the cmdline option! */
+	s3c_nand_set_platdata(&jive_nand_info);
 
 	/* initialise the spi */
 
diff --git a/arch/arm/mach-s3c2412/mach-vstms.c b/arch/arm/mach-s3c2412/mach-vstms.c
index 11e8ad4..a6ba591 100644
--- a/arch/arm/mach-s3c2412/mach-vstms.c
+++ b/arch/arm/mach-s3c2412/mach-vstms.c
@@ -76,7 +76,7 @@ static struct s3c2410_uartcfg vstms_uartcfgs[] __initdata = {
 	}
 };
 
-static struct mtd_partition vstms_nand_part[] = {
+static struct mtd_partition __initdata vstms_nand_part[] = {
 	[0] = {
 		.name	= "Boot Agent",
 		.size	= 0x7C000,
@@ -99,7 +99,7 @@ static struct mtd_partition vstms_nand_part[] = {
 	},
 };
 
-static struct s3c2410_nand_set vstms_nand_sets[] = {
+static struct s3c2410_nand_set __initdata vstms_nand_sets[] = {
 	[0] = {
 		.name		= "NAND",
 		.nr_chips	= 1,
@@ -112,7 +112,7 @@ static struct s3c2410_nand_set vstms_nand_sets[] = {
  * chips and beyond.
 */
 
-static struct s3c2410_platform_nand vstms_nand_info = {
+static struct s3c2410_platform_nand __initdata vstms_nand_info = {
 	.tacls		= 20,
 	.twrph0		= 60,
 	.twrph1		= 20,
@@ -143,8 +143,6 @@ static void __init vstms_fixup(struct machine_desc *desc,
 
 static void __init vstms_map_io(void)
 {
-	s3c_device_nand.dev.platform_data = &vstms_nand_info;
-
 	s3c24xx_init_io(vstms_iodesc, ARRAY_SIZE(vstms_iodesc));
 	s3c24xx_init_clocks(12000000);
 	s3c24xx_init_uarts(vstms_uartcfgs, ARRAY_SIZE(vstms_uartcfgs));
@@ -153,6 +151,8 @@ static void __init vstms_map_io(void)
 static void __init vstms_init(void)
 {
 	s3c_i2c0_set_platdata(NULL);
+	s3c_nand_set_platdata(&vstms_nand_info);
+
 	platform_add_devices(vstms_devices, ARRAY_SIZE(vstms_devices));
 }
 
diff --git a/arch/arm/mach-s3c2440/mach-anubis.c b/arch/arm/mach-s3c2440/mach-anubis.c
index 68f3870..5f5dccf 100644
--- a/arch/arm/mach-s3c2440/mach-anubis.c
+++ b/arch/arm/mach-s3c2440/mach-anubis.c
@@ -138,7 +138,7 @@ static int external_map[]   = { 2 };
 static int chip0_map[]      = { 0 };
 static int chip1_map[]      = { 1 };
 
-static struct mtd_partition anubis_default_nand_part[] = {
+static struct mtd_partition __initdata anubis_default_nand_part[] = {
 	[0] = {
 		.name	= "Boot Agent",
 		.size	= SZ_16K,
@@ -161,7 +161,7 @@ static struct mtd_partition anubis_default_nand_part[] = {
 	}
 };
 
-static struct mtd_partition anubis_default_nand_part_large[] = {
+static struct mtd_partition __initdata anubis_default_nand_part_large[] = {
 	[0] = {
 		.name	= "Boot Agent",
 		.size	= SZ_128K,
@@ -191,7 +191,7 @@ static struct mtd_partition anubis_default_nand_part_large[] = {
  * socket.
 */
 
-static struct s3c2410_nand_set anubis_nand_sets[] = {
+static struct s3c2410_nand_set __initdata anubis_nand_sets[] = {
 	[1] = {
 		.name		= "External",
 		.nr_chips	= 1,
@@ -233,7 +233,7 @@ static void anubis_nand_select(struct s3c2410_nand_set *set, int slot)
 	__raw_writeb(tmp, ANUBIS_VA_CTRL1);
 }
 
-static struct s3c2410_platform_nand anubis_nand_info = {
+static struct s3c2410_platform_nand __initdata anubis_nand_info = {
 	.tacls		= 25,
 	.twrph0		= 55,
 	.twrph1		= 40,
@@ -454,8 +454,6 @@ static void __init anubis_map_io(void)
 
 	s3c24xx_register_clocks(anubis_clocks, ARRAY_SIZE(anubis_clocks));
 
-	s3c_device_nand.dev.platform_data = &anubis_nand_info;
-
 	s3c24xx_init_io(anubis_iodesc, ARRAY_SIZE(anubis_iodesc));
 	s3c24xx_init_clocks(0);
 	s3c24xx_init_uarts(anubis_uartcfgs, ARRAY_SIZE(anubis_uartcfgs));
@@ -476,6 +474,8 @@ static void __init anubis_map_io(void)
 static void __init anubis_init(void)
 {
 	s3c_i2c0_set_platdata(NULL);
+	s3c_nand_set_platdata(&anubis_nand_info);
+
 	platform_add_devices(anubis_devices, ARRAY_SIZE(anubis_devices));
 
 	i2c_register_board_info(0, anubis_i2c_devs,
diff --git a/arch/arm/mach-s3c2440/mach-at2440evb.c b/arch/arm/mach-s3c2440/mach-at2440evb.c
index dfc7010..d73ef9a 100644
--- a/arch/arm/mach-s3c2440/mach-at2440evb.c
+++ b/arch/arm/mach-s3c2440/mach-at2440evb.c
@@ -96,7 +96,7 @@ static struct s3c2410_uartcfg at2440evb_uartcfgs[] __initdata = {
 
 /* NAND Flash on AT2440EVB board */
 
-static struct mtd_partition at2440evb_default_nand_part[] = {
+static struct mtd_partition __initdata at2440evb_default_nand_part[] = {
 	[0] = {
 		.name	= "Boot Agent",
 		.size	= SZ_256K,
@@ -114,7 +114,7 @@ static struct mtd_partition at2440evb_default_nand_part[] = {
 	},
 };
 
-static struct s3c2410_nand_set at2440evb_nand_sets[] = {
+static struct s3c2410_nand_set __initdata at2440evb_nand_sets[] = {
 	[0] = {
 		.name		= "nand",
 		.nr_chips	= 1,
@@ -123,7 +123,7 @@ static struct s3c2410_nand_set at2440evb_nand_sets[] = {
 	},
 };
 
-static struct s3c2410_platform_nand at2440evb_nand_info = {
+static struct s3c2410_platform_nand __initdata at2440evb_nand_info = {
 	.tacls		= 25,
 	.twrph0		= 55,
 	.twrph1		= 40,
@@ -216,7 +216,6 @@ static struct platform_device *at2440evb_devices[] __initdata = {
 
 static void __init at2440evb_map_io(void)
 {
-	s3c_device_nand.dev.platform_data = &at2440evb_nand_info;
 	s3c_device_sdi.name = "s3c2440-sdi";
 	s3c_device_sdi.dev.platform_data = &at2440evb_mci_pdata;
 
@@ -228,6 +227,7 @@ static void __init at2440evb_map_io(void)
 static void __init at2440evb_init(void)
 {
 	s3c24xx_fb_set_platdata(&at2440evb_fb_info);
+	s3c_nand_set_platdata(&at2440evb_nand_info);
 	s3c_i2c0_set_platdata(NULL);
 
 	platform_add_devices(at2440evb_devices, ARRAY_SIZE(at2440evb_devices));
diff --git a/arch/arm/mach-s3c2440/mach-mini2440.c b/arch/arm/mach-s3c2440/mach-mini2440.c
index 1c3382f..547d4fc 100644
--- a/arch/arm/mach-s3c2440/mach-mini2440.c
+++ b/arch/arm/mach-s3c2440/mach-mini2440.c
@@ -532,7 +532,6 @@ static void __init mini2440_map_io(void)
 	s3c24xx_init_clocks(12000000);
 	s3c24xx_init_uarts(mini2440_uartcfgs, ARRAY_SIZE(mini2440_uartcfgs));
 
-	s3c_device_nand.dev.platform_data = &mini2440_nand_info;
 	s3c_device_sdi.dev.platform_data = &mini2440_mmc_cfg;
 }
 
@@ -677,8 +676,11 @@ static void __init mini2440_init(void)
 		printk("\n");
 		s3c24xx_fb_set_platdata(&mini2440_fb_info);
 	}
+
 	s3c24xx_udc_set_platdata(&mini2440_udc_cfg);
+	s3c_nand_set_platdata(&mini2440_nand_info);
 	s3c_i2c0_set_platdata(NULL);
+
 	i2c_register_board_info(0, mini2440_i2c_devs,
 				ARRAY_SIZE(mini2440_i2c_devs));
 
diff --git a/arch/arm/mach-s3c2440/mach-osiris.c b/arch/arm/mach-s3c2440/mach-osiris.c
index 2105a41..468a0ea 100644
--- a/arch/arm/mach-s3c2440/mach-osiris.c
+++ b/arch/arm/mach-s3c2440/mach-osiris.c
@@ -148,7 +148,7 @@ static int external_map[]   = { 2 };
 static int chip0_map[]      = { 0 };
 static int chip1_map[]      = { 1 };
 
-static struct mtd_partition osiris_default_nand_part[] = {
+static struct mtd_partition __initdata osiris_default_nand_part[] = {
 	[0] = {
 		.name	= "Boot Agent",
 		.size	= SZ_16K,
@@ -171,7 +171,7 @@ static struct mtd_partition osiris_default_nand_part[] = {
 	}
 };
 
-static struct mtd_partition osiris_default_nand_part_large[] = {
+static struct mtd_partition __initdata osiris_default_nand_part_large[] = {
 	[0] = {
 		.name	= "Boot Agent",
 		.size	= SZ_128K,
@@ -201,7 +201,7 @@ static struct mtd_partition osiris_default_nand_part_large[] = {
  * socket.
 */
 
-static struct s3c2410_nand_set osiris_nand_sets[] = {
+static struct s3c2410_nand_set __initdata osiris_nand_sets[] = {
 	[1] = {
 		.name		= "External",
 		.nr_chips	= 1,
@@ -243,7 +243,7 @@ static void osiris_nand_select(struct s3c2410_nand_set *set, int slot)
 	__raw_writeb(tmp, OSIRIS_VA_CTRL0);
 }
 
-static struct s3c2410_platform_nand osiris_nand_info = {
+static struct s3c2410_platform_nand __initdata osiris_nand_info = {
 	.tacls		= 25,
 	.twrph0		= 60,
 	.twrph1		= 60,
@@ -377,8 +377,6 @@ static void __init osiris_map_io(void)
 
 	s3c24xx_register_clocks(osiris_clocks, ARRAY_SIZE(osiris_clocks));
 
-	s3c_device_nand.dev.platform_data = &osiris_nand_info;
-
 	s3c24xx_init_io(osiris_iodesc, ARRAY_SIZE(osiris_iodesc));
 	s3c24xx_init_clocks(0);
 	s3c24xx_init_uarts(osiris_uartcfgs, ARRAY_SIZE(osiris_uartcfgs));
@@ -408,6 +406,7 @@ static void __init osiris_init(void)
 	sysdev_register(&osiris_pm_sysdev);
 
 	s3c_i2c0_set_platdata(NULL);
+	s3c_nand_set_platdata(&osiris_nand_info);
 
 	s3c_cpufreq_setboard(&osiris_cpufreq);
 
diff --git a/arch/arm/mach-s3c2440/mach-rx3715.c b/arch/arm/mach-s3c2440/mach-rx3715.c
index bc8d8d1..d77b883 100644
--- a/arch/arm/mach-s3c2440/mach-rx3715.c
+++ b/arch/arm/mach-s3c2440/mach-rx3715.c
@@ -149,7 +149,7 @@ static struct s3c2410fb_mach_info rx3715_fb_info __initdata = {
 	.gpdup_mask =	0xffffffff,
 };
 
-static struct mtd_partition rx3715_nand_part[] = {
+static struct mtd_partition __initdata rx3715_nand_part[] = {
 	[0] = {
 		.name		= "Whole Flash",
 		.offset		= 0,
@@ -158,7 +158,7 @@ static struct mtd_partition rx3715_nand_part[] = {
 	}
 };
 
-static struct s3c2410_nand_set rx3715_nand_sets[] = {
+static struct s3c2410_nand_set __initdata rx3715_nand_sets[] = {
 	[0] = {
 		.name		= "Internal",
 		.nr_chips	= 1,
@@ -167,7 +167,7 @@ static struct s3c2410_nand_set rx3715_nand_sets[] = {
 	},
 };
 
-static struct s3c2410_platform_nand rx3715_nand_info = {
+static struct s3c2410_platform_nand __initdata rx3715_nand_info = {
 	.tacls		= 25,
 	.twrph0		= 50,
 	.twrph1		= 15,
@@ -186,8 +186,6 @@ static struct platform_device *rx3715_devices[] __initdata = {
 
 static void __init rx3715_map_io(void)
 {
-	s3c_device_nand.dev.platform_data = &rx3715_nand_info;
-
 	s3c24xx_init_io(rx3715_iodesc, ARRAY_SIZE(rx3715_iodesc));
 	s3c24xx_init_clocks(16934000);
 	s3c24xx_init_uarts(rx3715_uartcfgs, ARRAY_SIZE(rx3715_uartcfgs));
@@ -205,6 +203,7 @@ static void __init rx3715_init_machine(void)
 #endif
 	s3c_pm_init();
 
+	s3c_nand_set_platdata(&rx3715_nand_info);
 	s3c24xx_fb_set_platdata(&rx3715_fb_info);
 	platform_add_devices(rx3715_devices, ARRAY_SIZE(rx3715_devices));
 }
diff --git a/arch/arm/mach-s3c2442/mach-gta02.c b/arch/arm/mach-s3c2442/mach-gta02.c
index 0fb385b..f76d6ff 100644
--- a/arch/arm/mach-s3c2442/mach-gta02.c
+++ b/arch/arm/mach-s3c2442/mach-gta02.c
@@ -423,7 +423,7 @@ static struct i2c_board_info gta02_i2c_devs[] __initdata = {
 	},
 };
 
-static struct s3c2410_nand_set gta02_nand_sets[] = {
+static struct s3c2410_nand_set __initdata gta02_nand_sets[] = {
 	[0] = {
 		/*
 		 * This name is also hard-coded in the boot loaders, so
@@ -442,7 +442,7 @@ static struct s3c2410_nand_set gta02_nand_sets[] = {
  * data sheet (K5D2G13ACM-D075 MCP Memory).
  */
 
-static struct s3c2410_platform_nand gta02_nand_info = {
+static struct s3c2410_platform_nand __initdata gta02_nand_info = {
 	.tacls		= 0,
 	.twrph0		= 25,
 	.twrph1		= 15,
@@ -621,9 +621,9 @@ static void __init gta02_machine_init(void)
 #endif
 
 	s3c_device_usb.dev.platform_data = &gta02_usb_info;
-	s3c_device_nand.dev.platform_data = &gta02_nand_info;
 
 	s3c24xx_udc_set_platdata(&gta02_udc_cfg);
+	s3c_nand_set_platdata(&gta02_nand_info);
 	s3c_i2c0_set_platdata(NULL);
 
 	i2c_register_board_info(0, gta02_i2c_devs, ARRAY_SIZE(gta02_i2c_devs));
diff --git a/arch/arm/mach-s3c6410/mach-hmt.c b/arch/arm/mach-s3c6410/mach-hmt.c
index c574105..cdd4b53 100644
--- a/arch/arm/mach-s3c6410/mach-hmt.c
+++ b/arch/arm/mach-s3c6410/mach-hmt.c
@@ -250,7 +250,7 @@ static void __init hmt_machine_init(void)
 {
 	s3c_i2c0_set_platdata(NULL);
 	s3c_fb_set_platdata(&hmt_lcd_pdata);
-	s3c_device_nand.dev.platform_data = &hmt_nand_info;
+	s3c_nand_set_platdata(&hmt_nand_info);
 
 	gpio_request(S3C64XX_GPC(7), "usb power");
 	gpio_direction_output(S3C64XX_GPC(7), 0);
diff --git a/arch/arm/plat-s3c/dev-nand.c b/arch/arm/plat-s3c/dev-nand.c
index 4e53237..e771e77 100644
--- a/arch/arm/plat-s3c/dev-nand.c
+++ b/arch/arm/plat-s3c/dev-nand.c
@@ -9,8 +9,12 @@
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+
 #include <mach/map.h>
 #include <plat/devs.h>
+#include <plat/nand.h>
 
 static struct resource s3c_nand_resource[] = {
 	[0] = {
@@ -28,3 +32,96 @@ struct platform_device s3c_device_nand = {
 };
 
 EXPORT_SYMBOL(s3c_device_nand);
+
+/**
+ * s3c_nand_copy_set() - copy nand set data
+ * @set: The new structure, directly copied from the old.
+ *
+ * Copy all the fields from the NAND set field from what is probably __initdata
+ * to new kernel memory. The code returns 0 if the copy happened correctly or
+ * an error code for the calling function to display.
+ *
+ * Note, we currently do not try and look to see if we've already copied the
+ * data in a previous set.
+ */
+static int __init s3c_nand_copy_set(struct s3c2410_nand_set *set)
+{
+	void *ptr;
+	int size;
+
+	size = sizeof(struct mtd_partition) * set->nr_partitions;
+	if (size) {
+		ptr = kmemdup(set->partitions, size, GFP_KERNEL);
+		set->partitions = ptr;
+
+		if (!ptr)
+			return -ENOMEM;
+	}
+	
+	size = sizeof(int) * set->nr_chips;
+	if (size) {
+		ptr = kmemdup(set->nr_map, size, GFP_KERNEL);
+		set->nr_map = ptr;
+
+		if (!ptr)
+			return -ENOMEM;
+	}
+
+	if (set->ecc_layout) {
+		ptr = kmemdup(set->ecc_layout,
+			      sizeof(struct nand_ecclayout), GFP_KERNEL);
+		set->ecc_layout = ptr;
+
+		if (!ptr)
+			return -ENOMEM;
+	}
+	
+	return 0;
+}
+
+void __init s3c_nand_set_platdata(struct s3c2410_platform_nand *nand)
+{
+	struct s3c2410_platform_nand *npd;
+	int size;
+	int ret;
+
+	/* note, if we get a failure in allocation, we simply drop out of the
+	 * function. If there is so little memory available at initialisation
+	 * time then there is little chance the system is going to run.
+	 */ 
+
+	npd = kmemdup(nand, sizeof(struct s3c2410_platform_nand), GFP_KERNEL);
+	if (!npd) {
+		printk(KERN_ERR "%s: failed copying platform data\n", __func__);
+		return;
+	}
+
+	/* now see if we need to copy any of the nand set data */
+
+	size = sizeof(struct s3c2410_nand_set) * npd->nr_sets;
+	if (size) {
+		struct s3c2410_nand_set *from = npd->sets;
+		struct s3c2410_nand_set *to;
+		int i;
+
+		to = kmemdup(from, size, GFP_KERNEL);
+		npd->sets = to;	/* set, even if we failed */
+
+		if (!to) {
+			printk(KERN_ERR "%s: no memory for sets\n", __func__);
+			return;
+		}
+		
+		for (i = 0; i < npd->nr_sets; i++) {
+			ret = s3c_nand_copy_set(to);
+			if (!ret) {
+				printk(KERN_ERR "%s: failed to copy set %d\n",
+				__func__, i);
+				return;
+			}
+			to++;
+		}
+	}
+}
+
+EXPORT_SYMBOL_GPL(s3c_nand_set_platdata);
diff --git a/arch/arm/plat-s3c/include/plat/nand.h b/arch/arm/plat-s3c/include/plat/nand.h
index 18f9588..0659859 100644
--- a/arch/arm/plat-s3c/include/plat/nand.h
+++ b/arch/arm/plat-s3c/include/plat/nand.h
@@ -55,3 +55,11 @@ struct s3c2410_platform_nand {
 					       int chip);
 };
 
+/**
+ * s3c_nand_set_platdata() - register NAND platform data.
+ * @nand: The NAND platform data to register with s3c_device_nand.
+ *
+ * This function copies the given NAND platform data, @nand and registers
+ * it with the s3c_device_nand. This allows @nand to be __initdata.
+*/
+extern void s3c_nand_set_platdata(struct s3c2410_platform_nand *nand);
diff --git a/arch/arm/plat-s3c24xx/common-smdk.c b/arch/arm/plat-s3c24xx/common-smdk.c
index aa11986..9e0e20a 100644
--- a/arch/arm/plat-s3c24xx/common-smdk.c
+++ b/arch/arm/plat-s3c24xx/common-smdk.c
@@ -198,7 +198,7 @@ void __init smdk_machine_init(void)
 	if (machine_is_smdk2443())
 		smdk_nand_info.twrph0 = 50;
 
-	s3c_device_nand.dev.platform_data = &smdk_nand_info;
+	s3c_nand_set_platdata(&smdk_nand_info);
 
 	platform_add_devices(smdk_devs, ARRAY_SIZE(smdk_devs));
 
-- 
1.6.5
