From: john.holland@cellent-fs.de (John Holland)
Date: Fri, 19 Feb 2010 21:55:38 +0100
Subject: RFC patch set - kirkwood/sheeva - enable eSATA port
Message-ID: <1266612938.8172.76.camel@oklahoma>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi there,

included are two patches. The first enables Kconfig and basic board
support for the eSATA version of the SheevaPlug found at
http://www.newit.co.uk/store/index.php?main_page=index&cPath=3. No, I
have no affiliation. The second enables the SATA interfaces on the SoC
to allow eSATA visibility.

I'm opening a discussion to help us decide if the first patch is
necessary. Please keep in mind, I also have a third non-disclosed patch
that enables SD WP/CD on the same hardware: I have seen that the SoC MPP
is also connected to the SD card interface.

http://plugcomputer.org/data/docs/Sheeva-PowerPlug-V1.3-GTI-090906.pdf

Please pardon my git ignorance, but I couldn't find any guidelines
forcing me to use it here.

diff -Naur linux-2.6-2.6.32/arch/arm/mach-kirkwood/Kconfig linux-2.6-2.6.32.new/arch/arm/mach-kirkwood/Kconfig
--- linux-2.6-2.6.32/arch/arm/mach-kirkwood/Kconfig	2009-12-03 04:51:21.000000000 +0100
+++ linux-2.6-2.6.32.new/arch/arm/mach-kirkwood/Kconfig	2010-02-19 18:49:14.099872716 +0100
@@ -32,6 +32,12 @@
 	  Say 'Y' here if you want your kernel to support the
 	  Marvell SheevaPlug Reference Board.
 
+config MACH_ESATA_SHEEVAPLUG
+	bool "Marvell eSATA SheevaPlug Reference Board"
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  Marvell eSATA SheevaPlug Reference Board.
+
 config MACH_TS219
 	bool "QNAP TS-119 and TS-219 Turbo NAS"
 	help
diff -Naur linux-2.6-2.6.32/arch/arm/mach-kirkwood/Makefile linux-2.6-2.6.32.new/arch/arm/mach-kirkwood/Makefile
--- linux-2.6-2.6.32/arch/arm/mach-kirkwood/Makefile	2009-12-03 04:51:21.000000000 +0100
+++ linux-2.6-2.6.32.new/arch/arm/mach-kirkwood/Makefile	2010-02-19 18:49:14.099872716 +0100
@@ -5,6 +5,7 @@
 obj-$(CONFIG_MACH_RD88F6281)		+= rd88f6281-setup.o
 obj-$(CONFIG_MACH_MV88F6281GTW_GE)	+= mv88f6281gtw_ge-setup.o
 obj-$(CONFIG_MACH_SHEEVAPLUG)		+= sheevaplug-setup.o
+obj-$(CONFIG_MACH_ESATA_SHEEVAPLUG)	+= sheevaplug-setup.o
 obj-$(CONFIG_MACH_TS219)		+= ts219-setup.o
 obj-$(CONFIG_MACH_OPENRD_BASE)		+= openrd_base-setup.o
 
diff -Naur linux-2.6-2.6.32/arch/arm/mach-kirkwood/sheevaplug-setup.c linux-2.6-2.6.32.new/arch/arm/mach-kirkwood/sheevaplug-setup.c
--- linux-2.6-2.6.32/arch/arm/mach-kirkwood/sheevaplug-setup.c	2009-12-03 04:51:21.000000000 +0100
+++ linux-2.6-2.6.32.new/arch/arm/mach-kirkwood/sheevaplug-setup.c	2010-02-19 18:49:47.403810163 +0100
@@ -96,6 +96,7 @@
 	platform_device_register(&sheevaplug_leds);
 }
 
+#ifdef CONFIG_MACH_SHEEVAPLUG
 MACHINE_START(SHEEVAPLUG, "Marvell SheevaPlug Reference Board")
 	/* Maintainer: shadi Ammouri <shadi@marvell.com> */
 	.phys_io	= KIRKWOOD_REGS_PHYS_BASE,
@@ -106,3 +107,16 @@
 	.init_irq	= kirkwood_init_irq,
 	.timer		= &kirkwood_timer,
 MACHINE_END
+#endif
+
+#ifdef CONFIG_MACH_ESATA_SHEEVAPLUG
+MACHINE_START(ESATA_SHEEVAPLUG, "Marvell eSATA SheevaPlug Reference Board")
+	.phys_io	= KIRKWOOD_REGS_PHYS_BASE,
+	.io_pg_offst	= ((KIRKWOOD_REGS_VIRT_BASE) >> 18) & 0xfffc,
+	.boot_params	= 0x00000100,
+	.init_machine	= sheevaplug_init,
+	.map_io		= kirkwood_map_io,
+	.init_irq	= kirkwood_init_irq,
+	.timer		= &kirkwood_timer,
+MACHINE_END
+#endif

This to allows people to choose the hardware they want to configure in
u-boot, depending on the application: using the hardware for something
intolerant of "wasted" energy. And leads to the following...

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


For completeness, these patches do require a current
arm/tools/mach-types.


During my excursions with the new hardware, it was pointed out that the
Sheeva u-boot 3.4.19 does not properly initialize the SoC SATA ports
disallowing further usage; indifferent to the above patches. The "net"
http://plugcomputer.org/plugforum/index.php?topic=927.0 told me to use
u-boot 3.4.19 intended for the openrd hardware, and it worked.



-- 
John Holland

___________________________________________

Cellent Finance Solutions AG

Firmensitz: Calwer Stra?e 33, 70173 Stuttgart
Registergericht: Amtsgericht Stuttgart, HRB 720743
Vorstand: Thomas Wild
Vorsitzender des Aufsichtsrats: Rudolf Zipf
