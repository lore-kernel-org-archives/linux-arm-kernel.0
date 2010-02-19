From: john.holland@cellent-fs.de (John Holland)
Date: Fri, 19 Feb 2010 23:10:58 +0100
Subject: [PATCH] 1/3 kirkwood/sheeva: basic board support
In-Reply-To: <alpine.LFD.2.00.1002191618310.1946@xanadu.home>
References: <1266612938.8172.76.camel@oklahoma>
	<alpine.LFD.2.00.1002191618310.1946@xanadu.home>
Message-ID: <1266617458.8172.137.camel@oklahoma>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow basic eSATA SheevaPlug board configuration and build.

Signed-off-by: John Holland <john.holland@cellent-fs.de>
--
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


-- 
John Holland

___________________________________________

Cellent Finance Solutions AG

Firmensitz: Calwer Stra?e 33, 70173 Stuttgart
Registergericht: Amtsgericht Stuttgart, HRB 720743
Vorstand: Thomas Wild
Vorsitzender des Aufsichtsrats: Rudolf Zipf
