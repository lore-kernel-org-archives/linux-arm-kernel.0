From: john.holland@cellent-fs.de (John Holland)
Date: Fri, 19 Feb 2010 23:11:01 +0100
Subject: [PATCH] 2/3 kirkwood/sheeva: configure SoC SATA interface
In-Reply-To: <alpine.LFD.2.00.1002191618310.1946@xanadu.home>
References: <1266612938.8172.76.camel@oklahoma>
	<alpine.LFD.2.00.1002191618310.1946@xanadu.home>
Message-ID: <1266617461.8172.138.camel@oklahoma>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the kirkwood SATA SoC interface on the eSATA SheevaPlug.

Signed-off-by: John Holland <john.holland@cellent-fs.de>
--
diff -Naur linux-2.6-2.6.32/arch/arm/mach-kirkwood/sheevaplug-setup.c linux-2.6-2.6.32.new/arch/arm/mach-kirkwood/sheevaplug-setup.c
--- linux-2.6-2.6.32/arch/arm/mach-kirkwood/sheevaplug-setup.c	2010-02-19 19:11:30.714071286 +0100
+++ linux-2.6-2.6.32.new/arch/arm/mach-kirkwood/sheevaplug-setup.c	2010-02-19 19:13:51.910761448 +0100
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/ata_platform.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mv643xx_eth.h>
 #include <linux/gpio.h>
@@ -42,6 +43,10 @@
 	.phy_addr	= MV643XX_ETH_PHY_ADDR(0),
 };
 
+static struct mv_sata_platform_data sheeva_esata_sata_data = {
+	.n_ports	= 2,
+};
+
 static struct mvsdio_platform_data sheevaplug_mvsdio_data = {
 	/* unfortunately the CD signal has not been connected */
 };
@@ -91,6 +96,11 @@
 	kirkwood_ehci_init();
 
 	kirkwood_ge00_init(&sheevaplug_ge00_data);
+
+	/* honor lower power consumption for plugs with out eSATA */
+	if (machine_is_sheeva_esata())
+		kirkwood_sata_init(&sheeva_esata_sata_data);
+
 	kirkwood_sdio_init(&sheevaplug_mvsdio_data);
 
 	platform_device_register(&sheevaplug_leds);


-- 
John Holland

___________________________________________

Cellent Finance Solutions AG

Firmensitz: Calwer Stra?e 33, 70173 Stuttgart
Registergericht: Amtsgericht Stuttgart, HRB 720743
Vorstand: Thomas Wild
Vorsitzender des Aufsichtsrats: Rudolf Zipf
