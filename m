From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Feb 2012 19:36:12 +0000
Subject: [PATCH 15/17] ARM: sa11x0: assabet/neponest: create neponset device
 in assabet.c
In-Reply-To: <20120203193059.GF14129@n2100.arm.linux.org.uk>
References: <20120203193059.GF14129@n2100.arm.linux.org.uk>
Message-ID: <E1RtOvc-0001CW-IW@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The neponset board is a daughter board for the Assabet.  Create the
neponset platform device in assabet.c, where we don't have to wrap
it with machine_is_assabet() stuff.  We also create this device
dynamically rather than keeping it as a static device.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-sa1100/assabet.c  |   12 ++++++++
 arch/arm/mach-sa1100/neponset.c |   56 +++++++++------------------------------
 2 files changed, 25 insertions(+), 43 deletions(-)

diff --git a/arch/arm/mach-sa1100/assabet.c b/arch/arm/mach-sa1100/assabet.c
index e3805d4..f2030bc 100644
--- a/arch/arm/mach-sa1100/assabet.c
+++ b/arch/arm/mach-sa1100/assabet.c
@@ -197,6 +197,15 @@ static struct mcp_plat_data assabet_mcp_data = {
 	.sclk_rate	= 11981000,
 };
 
+#ifdef CONFIG_ASSABET_NEPONSET
+static struct resource neponset_resources[] = {
+	DEFINE_RES_MEM(0x10000000, 0x08000000),
+	DEFINE_RES_MEM(0x18000000, 0x04000000),
+	DEFINE_RES_MEM(0x40000000, SZ_8K),
+	DEFINE_RES_IRQ(IRQ_GPIO25),
+};
+#endif
+
 static void __init assabet_init(void)
 {
 	/*
@@ -247,6 +256,9 @@ static void __init assabet_init(void)
 #ifndef CONFIG_ASSABET_NEPONSET
 		printk( "Warning: Neponset detected but full support "
 			"hasn't been configured in the kernel\n" );
+#else
+		platform_device_register_simple("neponset", 0,
+			neponset_resources, ARRAY_SIZE(neponset_resources));
 #endif
 	}
 
diff --git a/arch/arm/mach-sa1100/neponset.c b/arch/arm/mach-sa1100/neponset.c
index 59223ba..2a9e1e2 100644
--- a/arch/arm/mach-sa1100/neponset.c
+++ b/arch/arm/mach-sa1100/neponset.c
@@ -27,6 +27,8 @@
 #define NEP_IRQ_SA1111	2
 #define NEP_IRQ_NR	3
 
+extern void sa1110_mb_disable(void);
+
 struct neponset_drvdata {
 	struct platform_device *sa1111;
 	struct platform_device *smc91x;
@@ -222,6 +224,13 @@ static int __devinit neponset_probe(struct platform_device *dev)
 		goto err_alloc;
 	}
 
+	if (WHOAMI != 0x11) {
+		dev_warn(&dev->dev, "Neponset board detected, but wrong ID: %02x\n",
+			 WHOAMI);
+		ret = -ENODEV;
+		goto err_alloc;
+	}
+
 	d = kzalloc(sizeof(*d), GFP_KERNEL);
 	if (!d) {
 		ret = -ENOMEM;
@@ -264,6 +273,9 @@ static int __devinit neponset_probe(struct platform_device *dev)
 
 	sa1100_register_uart_fns(&neponset_port_fns);
 
+	/* Ensure that the memory bus request/grant signals are setup */
+	sa1110_mb_disable();
+
 	/* Disable GPIO 0/1 drivers so the buttons work on the Assabet */
 	NCR_0 = NCR_GP01_OFF;
 
@@ -346,51 +358,9 @@ static struct platform_driver neponset_device_driver = {
 	},
 };
 
-static struct resource neponset_resources[] = {
-	DEFINE_RES_MEM(0x10000000, 0x08000000),
-	DEFINE_RES_MEM(0x18000000, 0x04000000),
-	DEFINE_RES_MEM(0x40000000, SZ_8K),
-	DEFINE_RES_IRQ(IRQ_GPIO25),
-};
-
-static struct platform_device neponset_device = {
-	.name		= "neponset",
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(neponset_resources),
-	.resource	= neponset_resources,
-};
-
-extern void sa1110_mb_disable(void);
-
 static int __init neponset_init(void)
 {
-	platform_driver_register(&neponset_device_driver);
-
-	/*
-	 * The Neponset is only present on the Assabet machine type.
-	 */
-	if (!machine_is_assabet())
-		return -ENODEV;
-
-	/*
-	 * Ensure that the memory bus request/grant signals are setup,
-	 * and the grant is held in its inactive state, whether or not
-	 * we actually have a Neponset attached.
-	 */
-	sa1110_mb_disable();
-
-	if (!machine_has_neponset()) {
-		printk(KERN_DEBUG "Neponset expansion board not present\n");
-		return -ENODEV;
-	}
-
-	if (WHOAMI != 0x11) {
-		printk(KERN_WARNING "Neponset board detected, but "
-			"wrong ID: %02x\n", WHOAMI);
-		return -ENODEV;
-	}
-
-	return platform_device_register(&neponset_device);
+	return platform_driver_register(&neponset_device_driver);
 }
 
 subsys_initcall(neponset_init);
-- 
1.7.4.4
