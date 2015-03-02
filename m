From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 02 Mar 2015 14:09:57 +0100
Subject: [PATCH] ARM: at91: remove NEED_MACH_IO_H
Message-ID: <2695765.t2RUmlZpTO@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mach/io.h header on at91 is used to support a nonstandard I/O space
window for the cf card driver. This changes the driver to use pci_ioremap_io
in order to have the standard location, and then removes the custom
mach/io.h.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
----
I've found this patch in an old git tree of mine. I think it's still needed,
but see for yourselves.

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4db6c803eaf2..b2798e25829a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -351,7 +351,6 @@ config ARCH_AT91
 	select ARCH_REQUIRE_GPIOLIB
 	select CLKDEV_LOOKUP
 	select IRQ_DOMAIN
-	select NEED_MACH_IO_H if PCCARD
 	select PINCTRL
 	select PINCTRL_AT91
 	select USE_OF
diff --git a/arch/arm/mach-at91/include/mach/io.h b/arch/arm/mach-at91/include/mach/io.h
deleted file mode 100644
index 2d9ca0455745..000000000000
--- a/arch/arm/mach-at91/include/mach/io.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/*
- * arch/arm/mach-at91/include/mach/io.h
- *
- *  Copyright (C) 2003 SAN People
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-#ifndef __ASM_ARCH_IO_H
-#define __ASM_ARCH_IO_H
-
-#define IO_SPACE_LIMIT		0xFFFFFFFF
-#define __io(a)			__typesafe_io(a)
-
-#endif
diff --git a/drivers/pcmcia/at91_cf.c b/drivers/pcmcia/at91_cf.c
index bfb799c7b343..a2b677a8abb5 100644
--- a/drivers/pcmcia/at91_cf.c
+++ b/drivers/pcmcia/at91_cf.c
@@ -318,12 +318,10 @@ static int at91_cf_probe(struct platform_device *pdev)
 		cf->socket.pci_irq = nr_irqs + 1;
 
 	/* pcmcia layer only remaps "real" memory not iospace */
-	cf->socket.io_offset = (unsigned long) devm_ioremap(&pdev->dev,
-					cf->phys_baseaddr + CF_IO_PHYS, SZ_2K);
-	if (!cf->socket.io_offset) {
-		status = -ENXIO;
+	cf->socket.io_offset = 0;
+	status = pci_ioremap_io(0, cf->phys_baseaddr + CF_IO_PHYS);
+	if (status)
 		goto fail0a;
-	}
 
 	/* reserve chip-select regions */
 	if (!devm_request_mem_region(&pdev->dev, io->start, resource_size(io), "at91_cf")) {
