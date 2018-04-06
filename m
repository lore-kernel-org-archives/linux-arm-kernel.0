From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 6 Apr 2018 18:08:20 +0530
Subject: [PATCH v2] ARM: davinci: dm644x: remove unnecessary
 postcore_initcall()
Message-ID: <20180406123820.21679-1-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dm644x_init_devices() is unnecessarily implemented as a
postcore_initcall().

This does not cause any issues now, but creates issues when
converting to common clock framework where clocks themselves
become platform devices and are initialized later. Because of
this, device clock acquisition and runtime PM on that device
fails.

Move the call to .init_machine() callback along with rest of
platform device's registration.

While at it, convert it to return void since return value is
ignored by caller anyway.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
v2:
drop unnecessary error messages per comment from David.

 arch/arm/mach-davinci/board-dm644x-evm.c  |  2 ++
 arch/arm/mach-davinci/board-neuros-osd2.c |  2 ++
 arch/arm/mach-davinci/board-sffsdr.c      |  2 ++
 arch/arm/mach-davinci/davinci.h           |  1 +
 arch/arm/mach-davinci/dm644x.c            | 13 +++----------
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 95b55aae1366..5bf024784738 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -768,6 +768,8 @@ static __init void davinci_evm_init(void)
 	struct clk *aemif_clk;
 	struct davinci_soc_info *soc_info = &davinci_soc_info;
 
+	dm644x_init_devices();
+
 	ret = dm644x_gpio_register();
 	if (ret)
 		pr_warn("%s: GPIO init failed: %d\n", __func__, ret);
diff --git a/arch/arm/mach-davinci/board-neuros-osd2.c b/arch/arm/mach-davinci/board-neuros-osd2.c
index f2875770fbff..0b13237e63f2 100644
--- a/arch/arm/mach-davinci/board-neuros-osd2.c
+++ b/arch/arm/mach-davinci/board-neuros-osd2.c
@@ -174,6 +174,8 @@ static __init void davinci_ntosd2_init(void)
 	struct clk *aemif_clk;
 	struct davinci_soc_info *soc_info = &davinci_soc_info;
 
+	dm644x_init_devices();
+
 	ret = dm644x_gpio_register();
 	if (ret)
 		pr_warn("%s: GPIO init failed: %d\n", __func__, ret);
diff --git a/arch/arm/mach-davinci/board-sffsdr.c b/arch/arm/mach-davinci/board-sffsdr.c
index 2922da9d1684..e7c1728b0833 100644
--- a/arch/arm/mach-davinci/board-sffsdr.c
+++ b/arch/arm/mach-davinci/board-sffsdr.c
@@ -134,6 +134,8 @@ static __init void davinci_sffsdr_init(void)
 {
 	struct davinci_soc_info *soc_info = &davinci_soc_info;
 
+	dm644x_init_devices();
+
 	platform_add_devices(davinci_sffsdr_devices,
 			     ARRAY_SIZE(davinci_sffsdr_devices));
 	sffsdr_init_i2c();
diff --git a/arch/arm/mach-davinci/davinci.h b/arch/arm/mach-davinci/davinci.h
index 270cef85750a..376cdd51ce9d 100644
--- a/arch/arm/mach-davinci/davinci.h
+++ b/arch/arm/mach-davinci/davinci.h
@@ -104,6 +104,7 @@ int dm365_gpio_register(void);
 
 /* DM644x function declarations */
 void dm644x_init(void);
+void dm644x_init_devices(void);
 void dm644x_init_time(void);
 void dm644x_init_asp(void);
 int dm644x_init_video(struct vpfe_config *, struct vpbe_config *);
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index b409801649e1..a2e8586c8a6d 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -961,19 +961,14 @@ int __init dm644x_init_video(struct vpfe_config *vpfe_cfg,
 	return 0;
 }
 
-static int __init dm644x_init_devices(void)
+void __init dm644x_init_devices(void)
 {
 	struct platform_device *edma_pdev;
-	int ret = 0;
-
-	if (!cpu_is_davinci_dm644x())
-		return 0;
+	int ret;
 
 	edma_pdev = platform_device_register_full(&dm644x_edma_device);
-	if (IS_ERR(edma_pdev)) {
+	if (IS_ERR(edma_pdev))
 		pr_warn("%s: Failed to register eDMA\n", __func__);
-		return PTR_ERR(edma_pdev);
-	}
 
 	platform_device_register(&dm644x_mdio_device);
 	platform_device_register(&dm644x_emac_device);
@@ -982,6 +977,4 @@ static int __init dm644x_init_devices(void)
 	if (ret)
 		pr_warn("%s: watchdog init failed: %d\n", __func__, ret);
 
-	return ret;
 }
-postcore_initcall(dm644x_init_devices);
-- 
2.16.2
