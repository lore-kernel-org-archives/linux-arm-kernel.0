From: avictor.za@gmail.com (Andrew Victor)
Date: Tue, 22 Sep 2009 11:47:43 +0200
Subject: [AT91] Fix AC97 breakage
Message-ID: <cd73a99e0909220247i71a2084fu9153002a358be1f1@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix AC97 build breakage with converting to the shared AT91/AVR32 AC97 driver:
  struct atmel_ac97_data  -> struct ac97c_platform_data
  CONFIG_SND_AT91_AC97 -> CONFIG_SND_ATMEL_AC97C

Signed-off-by: Andrew Victor <linux@maxim.org.za>


diff -urN linux-2.6.31-git.orig/arch/arm/mach-at91/at91cap9_devices.c
linux-2.6.31-git/arch/arm/mach-at91/at91cap9_devices.c
--- linux-2.6.31-git.orig/arch/arm/mach-at91/at91cap9_devices.c	2009-06-10
05:05:27.000000000 +0200
+++ linux-2.6.31-git/arch/arm/mach-at91/at91cap9_devices.c	2009-09-22
11:26:36.000000000 +0200
@@ -771,9 +771,9 @@
  *  AC97
  * -------------------------------------------------------------------- */

-#if defined(CONFIG_SND_AT91_AC97) || defined(CONFIG_SND_AT91_AC97_MODULE)
+#if defined(CONFIG_SND_ATMEL_AC97C) || defined(CONFIG_SND_ATMEL_AC97C_MODULE)
 static u64 ac97_dmamask = DMA_BIT_MASK(32);
-static struct atmel_ac97_data ac97_data;
+static struct ac97c_platform_data ac97_data;

 static struct resource ac97_resources[] = {
 	[0] = {
@@ -789,7 +789,7 @@
 };

 static struct platform_device at91cap9_ac97_device = {
-	.name		= "ac97c",
+	.name		= "atmel_ac97c",
 	.id		= 1,
 	.dev		= {
 				.dma_mask		= &ac97_dmamask,
@@ -800,7 +800,7 @@
 	.num_resources	= ARRAY_SIZE(ac97_resources),
 };

-void __init at91_add_device_ac97(struct atmel_ac97_data *data)
+void __init at91_add_device_ac97(struct ac97c_platform_data *data)
 {
 	if (!data)
 		return;
@@ -818,7 +818,7 @@
 	platform_device_register(&at91cap9_ac97_device);
 }
 #else
-void __init at91_add_device_ac97(struct atmel_ac97_data *data) {}
+void __init at91_add_device_ac97(struct ac97c_platform_data *data) {}
 #endif


diff -urN linux-2.6.31-git.orig/arch/arm/mach-at91/board-cap9adk.c
linux-2.6.31-git/arch/arm/mach-at91/board-cap9adk.c
--- linux-2.6.31-git.orig/arch/arm/mach-at91/board-cap9adk.c	2009-06-10
05:05:27.000000000 +0200
+++ linux-2.6.31-git/arch/arm/mach-at91/board-cap9adk.c	2009-09-22
11:13:35.000000000 +0200
@@ -364,7 +364,7 @@
 /*
  * AC97
  */
-static struct atmel_ac97_data cap9adk_ac97_data = {
+static struct ac97c_platform_data cap9adk_ac97_data = {
 //	.reset_pin	= ... not connected
 };

diff -urN linux-2.6.31-git.orig/arch/arm/mach-at91/board-neocore926.c
linux-2.6.31-git/arch/arm/mach-at91/board-neocore926.c
--- linux-2.6.31-git.orig/arch/arm/mach-at91/board-neocore926.c	2009-06-10
05:05:27.000000000 +0200
+++ linux-2.6.31-git/arch/arm/mach-at91/board-neocore926.c	2009-09-22
11:14:18.000000000 +0200
@@ -340,7 +340,7 @@
 /*
  * AC97
  */
-static struct atmel_ac97_data neocore926_ac97_data = {
+static struct ac97c_platform_data neocore926_ac97_data = {
 	.reset_pin	= AT91_PIN_PA13,
 };
