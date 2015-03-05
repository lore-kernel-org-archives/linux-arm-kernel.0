From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu,  5 Mar 2015 13:11:18 +0100
Subject: [PATCH v2 1/9] ARM: at91: remove NEED_MACH_IO_H
In-Reply-To: <1425557486-3534-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1425557486-3534-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1425557486-3534-2-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

The mach/io.h header on at91 is used to support a nonstandard I/O space
window for the cf card driver. This changes the driver to use pci_ioremap_io
in order to have the standard location, and then removes the custom
mach/io.h.

[alexandre.belloni at free-electrons.com: Added PCI dependency]
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig                     |  1 -
 arch/arm/mach-at91/Kconfig           |  1 +
 arch/arm/mach-at91/include/mach/io.h | 27 ---------------------------
 drivers/pcmcia/Kconfig               |  1 +
 drivers/pcmcia/at91_cf.c             | 13 +++++++------
 5 files changed, 9 insertions(+), 34 deletions(-)
 delete mode 100644 arch/arm/mach-at91/include/mach/io.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9f1f09a2bc9b..e7ce6612bc42 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -361,7 +361,6 @@ config ARCH_AT91
 	select ARCH_REQUIRE_GPIOLIB
 	select CLKDEV_LOOKUP
 	select IRQ_DOMAIN
-	select NEED_MACH_IO_H if PCCARD
 	select PINCTRL
 	select PINCTRL_AT91
 	select USE_OF
diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index c74a44324e5b..7ecde7de69da 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -81,6 +81,7 @@ config SOC_AT91RM9200
 	select CPU_ARM920T
 	select GENERIC_CLOCKEVENTS
 	select HAVE_AT91_USB_CLK
+	select MIGHT_HAVE_PCI
 
 config SOC_AT91SAM9
 	bool "AT91SAM9"
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
diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
index 3bb49252a098..075d5cd4c5ab 100644
--- a/drivers/pcmcia/Kconfig
+++ b/drivers/pcmcia/Kconfig
@@ -278,6 +278,7 @@ config BFIN_CFPCMCIA
 
 config AT91_CF
 	tristate "AT91 CompactFlash Controller"
+	depends on PCI
 	depends on PCMCIA && ARCH_AT91
 	depends on !ARCH_MULTIPLATFORM
 	help
diff --git a/drivers/pcmcia/at91_cf.c b/drivers/pcmcia/at91_cf.c
index bfb799c7b343..e7775a41ae5d 100644
--- a/drivers/pcmcia/at91_cf.c
+++ b/drivers/pcmcia/at91_cf.c
@@ -317,13 +317,14 @@ static int at91_cf_probe(struct platform_device *pdev)
 	} else
 		cf->socket.pci_irq = nr_irqs + 1;
 
-	/* pcmcia layer only remaps "real" memory not iospace */
-	cf->socket.io_offset = (unsigned long) devm_ioremap(&pdev->dev,
-					cf->phys_baseaddr + CF_IO_PHYS, SZ_2K);
-	if (!cf->socket.io_offset) {
-		status = -ENXIO;
+	/*
+	 * pcmcia layer only remaps "real" memory not iospace
+	 * io_offset is set to 0x10000 to avoid the check in static_find_io().
+	 * */
+	cf->socket.io_offset = 0x10000;
+	status = pci_ioremap_io(0x10000, cf->phys_baseaddr + CF_IO_PHYS);
+	if (status)
 		goto fail0a;
-	}
 
 	/* reserve chip-select regions */
 	if (!devm_request_mem_region(&pdev->dev, io->start, resource_size(io), "at91_cf")) {
-- 
2.1.0
