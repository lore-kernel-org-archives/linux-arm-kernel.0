From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 4 Apr 2018 18:27:59 +0530
Subject: [PATCH] ARM: davinci: dm644x: remove unnecessary postcore_initcall()
Message-ID: <20180404125759.27061-1-nsekhar@ti.com>
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

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-davinci/board-dm644x-evm.c  | 5 +++++
 arch/arm/mach-davinci/board-neuros-osd2.c | 5 +++++
 arch/arm/mach-davinci/board-sffsdr.c      | 6 ++++++
 arch/arm/mach-davinci/davinci.h           | 1 +
 arch/arm/mach-davinci/dm644x.c            | 6 +-----
 5 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 95b55aae1366..d1a7239a80d6 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -768,6 +768,11 @@ static __init void davinci_evm_init(void)
 	struct clk *aemif_clk;
 	struct davinci_soc_info *soc_info = &davinci_soc_info;
 
+	ret = dm644x_init_devices();
+	if (ret)
+		pr_warn("%s: dm644x_init_devices() failed: %d\n",
+			__func__, ret);
+
 	ret = dm644x_gpio_register();
 	if (ret)
 		pr_warn("%s: GPIO init failed: %d\n", __func__, ret);
diff --git a/arch/arm/mach-davinci/board-neuros-osd2.c b/arch/arm/mach-davinci/board-neuros-osd2.c
index f2875770fbff..23f4f0b70752 100644
--- a/arch/arm/mach-davinci/board-neuros-osd2.c
+++ b/arch/arm/mach-davinci/board-neuros-osd2.c
@@ -174,6 +174,11 @@ static __init void davinci_ntosd2_init(void)
 	struct clk *aemif_clk;
 	struct davinci_soc_info *soc_info = &davinci_soc_info;
 
+	ret = dm644x_init_devices();
+	if (ret)
+		pr_warn("%s: dm644x_init_devices() failed: %d\n",
+			__func__, ret);
+
 	ret = dm644x_gpio_register();
 	if (ret)
 		pr_warn("%s: GPIO init failed: %d\n", __func__, ret);
diff --git a/arch/arm/mach-davinci/board-sffsdr.c b/arch/arm/mach-davinci/board-sffsdr.c
index 2922da9d1684..d9900d7c26d3 100644
--- a/arch/arm/mach-davinci/board-sffsdr.c
+++ b/arch/arm/mach-davinci/board-sffsdr.c
@@ -133,6 +133,12 @@ static void __init davinci_sffsdr_map_io(void)
 static __init void davinci_sffsdr_init(void)
 {
 	struct davinci_soc_info *soc_info = &davinci_soc_info;
+	int ret;
+
+	ret = dm644x_init_devices();
+	if (ret)
+		pr_warn("%s: dm644x_init_devices() failed: %d\n",
+			__func__, ret);
 
 	platform_add_devices(davinci_sffsdr_devices,
 			     ARRAY_SIZE(davinci_sffsdr_devices));
diff --git a/arch/arm/mach-davinci/davinci.h b/arch/arm/mach-davinci/davinci.h
index 270cef85750a..0ba37d68ecb4 100644
--- a/arch/arm/mach-davinci/davinci.h
+++ b/arch/arm/mach-davinci/davinci.h
@@ -104,6 +104,7 @@ int dm365_gpio_register(void);
 
 /* DM644x function declarations */
 void dm644x_init(void);
+int dm644x_init_devices(void);
 void dm644x_init_time(void);
 void dm644x_init_asp(void);
 int dm644x_init_video(struct vpfe_config *, struct vpbe_config *);
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index b409801649e1..da833290291b 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -961,14 +961,11 @@ int __init dm644x_init_video(struct vpfe_config *vpfe_cfg,
 	return 0;
 }
 
-static int __init dm644x_init_devices(void)
+int __init dm644x_init_devices(void)
 {
 	struct platform_device *edma_pdev;
 	int ret = 0;
 
-	if (!cpu_is_davinci_dm644x())
-		return 0;
-
 	edma_pdev = platform_device_register_full(&dm644x_edma_device);
 	if (IS_ERR(edma_pdev)) {
 		pr_warn("%s: Failed to register eDMA\n", __func__);
@@ -984,4 +981,3 @@ static int __init dm644x_init_devices(void)
 
 	return ret;
 }
-postcore_initcall(dm644x_init_devices);
-- 
2.16.2
