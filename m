From: john.holland@cellent-fs.de (John Holland)
Date: Fri, 19 Feb 2010 23:11:04 +0100
Subject: [PATCH] 3/3 kirkwood/sheeva: correlate MPP to SD CD and SD WP
In-Reply-To: <alpine.LFD.2.00.1002191618310.1946@xanadu.home>
References: <1266612938.8172.76.camel@oklahoma>
	<alpine.LFD.2.00.1002191618310.1946@xanadu.home>
Message-ID: <1266617464.8172.139.camel@oklahoma>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Accept SD CD and SD WP in accordance to
http://plugcomputer.org/data/docs/Sheeva-PowerPlug-V1.3-GTI-090906.pdf
on MPP 47 and 44 respectively on the eSATA SheevaPlug

Signed-off-by: John Holland <john.holland@cellent-fs.de>
--
diff -Naur linux-2.6-2.6.32/arch/arm/mach-kirkwood/sheevaplug-setup.c linux-2.6-2.6.32.new/arch/arm/mach-kirkwood/sheevaplug-setup.c
--- linux-2.6-2.6.32/arch/arm/mach-kirkwood/sheevaplug-setup.c	2010-02-19 19:15:49.643951762 +0100
+++ linux-2.6-2.6.32.new/arch/arm/mach-kirkwood/sheevaplug-setup.c	2010-02-19 19:18:13.249598152 +0100
@@ -51,6 +51,11 @@
 	/* unfortunately the CD signal has not been connected */
 };
 
+static struct mvsdio_platform_data sheeva_esata_mvsdio_data = {
+	.gpio_write_protect = 44, /* MPP44 used as SD write protect */
+	.gpio_card_detect = 47,	  /* MPP47 used as SD card detect */
+};
+
 static struct gpio_led sheevaplug_led_pins[] = {
 	{
 		.name			= "plug:green:health",
@@ -79,13 +84,26 @@
 	0
 };
 
+static unsigned int sheeva_esata_mpp_config[] __initdata = {
+	MPP29_GPIO,	/* USB Power Enable */
+	MPP44_GPIO,	/* SD Write Protect */
+	MPP47_GPIO,	/* SD Card Detect */
+	MPP49_GPIO,	/* LED Green */
+	0
+};
+
 static void __init sheevaplug_init(void)
 {
 	/*
 	 * Basic setup. Needs to be called early.
 	 */
 	kirkwood_init();
-	kirkwood_mpp_conf(sheevaplug_mpp_config);
+
+	/* setup gpio pin select */
+	if (machine_is_sheeva_esata())
+		kirkwood_mpp_conf(sheeva_esata_mpp_config);
+	else
+		kirkwood_mpp_conf(sheevaplug_mpp_config);
 
 	kirkwood_uart0_init();
 	kirkwood_nand_init(ARRAY_AND_SIZE(sheevaplug_nand_parts), 25);
@@ -101,7 +119,11 @@
 	if (machine_is_sheeva_esata())
 		kirkwood_sata_init(&sheeva_esata_sata_data);
 
-	kirkwood_sdio_init(&sheevaplug_mvsdio_data);
+ 	/* enable sd wp and sd cd on plugs with esata */
+ 	if (machine_is_sheeva_esata())
+ 		kirkwood_sdio_init(&sheeva_esata_mvsdio_data);
+ 	else
+ 		kirkwood_sdio_init(&sheevaplug_mvsdio_data);
 
 	platform_device_register(&sheevaplug_leds);
 }

Although this has not yet been thoroughly tested, it has no noticeable
adverse effects.

-- 
John Holland

___________________________________________

Cellent Finance Solutions AG

Firmensitz: Calwer Stra?e 33, 70173 Stuttgart
Registergericht: Amtsgericht Stuttgart, HRB 720743
Vorstand: Thomas Wild
Vorsitzender des Aufsichtsrats: Rudolf Zipf
