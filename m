From: sean@mess.org (Sean Young)
Date: Wed, 24 Aug 2011 20:26:40 +0100
Subject: [PATCH 1/2] Revert "[ARM] eSATA SheevaPlug: correlate MPP to SD CD
	and SD WP"
Message-ID: <1314214001-2731-1-git-send-email-sean@mess.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit d5b5746bed1023e4a55f96405422d3e51968fa43.

Neither SD WP nor SD CD are detected after this change on my eSATA
SheevaPlug.

Signed-off-by: Sean Young <sean@mess.org>
---
 arch/arm/mach-kirkwood/sheevaplug-setup.c |   26 ++------------------------
 1 files changed, 2 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-kirkwood/sheevaplug-setup.c b/arch/arm/mach-kirkwood/sheevaplug-setup.c
index 17de0bf..7ba2a08 100644
--- a/arch/arm/mach-kirkwood/sheevaplug-setup.c
+++ b/arch/arm/mach-kirkwood/sheevaplug-setup.c
@@ -51,11 +51,6 @@ static struct mvsdio_platform_data sheevaplug_mvsdio_data = {
 	/* unfortunately the CD signal has not been connected */
 };
 
-static struct mvsdio_platform_data sheeva_esata_mvsdio_data = {
-	.gpio_write_protect = 44, /* MPP44 used as SD write protect */
-	.gpio_card_detect = 47,	  /* MPP47 used as SD card detect */
-};
-
 static struct gpio_led sheevaplug_led_pins[] = {
 	{
 		.name			= "plug:red:misc",
@@ -91,26 +86,13 @@ static unsigned int sheevaplug_mpp_config[] __initdata = {
 	0
 };
 
-static unsigned int sheeva_esata_mpp_config[] __initdata = {
-	MPP29_GPIO,	/* USB Power Enable */
-	MPP44_GPIO,	/* SD Write Protect */
-	MPP47_GPIO,	/* SD Card Detect */
-	MPP49_GPIO,	/* LED Green */
-	0
-};
-
 static void __init sheevaplug_init(void)
 {
 	/*
 	 * Basic setup. Needs to be called early.
 	 */
 	kirkwood_init();
-
-	/* setup gpio pin select */
-	if (machine_is_sheeva_esata())
-		kirkwood_mpp_conf(sheeva_esata_mpp_config);
-	else
-		kirkwood_mpp_conf(sheevaplug_mpp_config);
+	kirkwood_mpp_conf(sheevaplug_mpp_config);
 
 	kirkwood_uart0_init();
 	kirkwood_nand_init(ARRAY_AND_SIZE(sheevaplug_nand_parts), 25);
@@ -126,11 +108,7 @@ static void __init sheevaplug_init(void)
 	if (machine_is_sheeva_esata())
 		kirkwood_sata_init(&sheeva_esata_sata_data);
 
-	/* enable sd wp and sd cd on plugs with esata */
-	if (machine_is_sheeva_esata())
-		kirkwood_sdio_init(&sheeva_esata_mvsdio_data);
-	else
-		kirkwood_sdio_init(&sheevaplug_mvsdio_data);
+	kirkwood_sdio_init(&sheevaplug_mvsdio_data);
 
 	platform_device_register(&sheevaplug_leds);
 }
-- 
1.7.2.5
