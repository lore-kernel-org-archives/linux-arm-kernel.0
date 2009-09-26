From: mikpe@it.uu.se (Mikael Pettersson)
Date: Sat, 26 Sep 2009 21:53:21 +0200
Subject: [PATCH 1/2] n2100: support assigning XINT1 to UART
Message-ID: <19134.28977.5491.323804@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Thecus n2100 has a jumper which determines if the XINT1
interrupt line is connected to the second UHCI controller
(position J3) or the serial console UART (position J4).

In position J3 (default) the second UHCI controller is fully
operational, allowing low-speed USB devices to be connected
to any of the three USB ports. However, the UART has to be
polled by a high-frequency timer, causing CPU overheads.

In position J4 the second UHCI controller is not operational,
causing low-speed USB devices to only work when connected to
the front USB port. On the other hand, the UART polling timer
is eliminated, resulting in reduced CPU overheads. This is
especially important for tickless systems.

This patch adds a compile-time option allowing the kernel to
be configured appropriately for the J3 or J4 cases.

(This could possibly be handled by a kernel boot option instead,
but I opted for a much simpler compile-time option for now.)

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
---
 arch/arm/mach-iop32x/Kconfig |   21 +++++++++++++++++++++
 arch/arm/mach-iop32x/n2100.c |   15 +++++++++++++--
 2 files changed, 34 insertions(+), 2 deletions(-)

diff -rupN linux-2.6.31/arch/arm/mach-iop32x/Kconfig linux-2.6.31.arm-n2100-1-xint1-uart/arch/arm/mach-iop32x/Kconfig
--- linux-2.6.31/arch/arm/mach-iop32x/Kconfig	2008-07-14 10:22:36.000000000 +0200
+++ linux-2.6.31.arm-n2100-1-xint1-uart/arch/arm/mach-iop32x/Kconfig	2009-09-26 13:39:20.000000000 +0200
@@ -43,4 +43,25 @@ config MACH_EM7210
 
 endmenu
 
+config N2100_XINT1_UART
+	bool "Support assigning Thecus n2100 XINT1 to UART"
+	depends on MACH_N2100 && NO_HZ
+	help
+	  The Thecus n2100 has a jumper which determines if the XINT1
+	  interrupt line is connected to the second UHCI controller
+	  (position J3) or the serial console UART (position J4).
+
+	  In position J3 (default) the second UHCI controller is fully
+	  operational, allowing low-speed USB devices to be connected
+	  to any of the three USB ports. However, the UART has to be
+	  polled by a high-frequency timer, causing CPU overheads.
+
+	  In position J4 the second UHCI controller is not operational,
+	  causing low-speed USB devices to only work when connected to
+	  the front USB port. On the other hand, the UART polling timer
+	  is eliminated, resulting in reduced CPU overheads. This is
+	  especially important for tickless systems.
+
+	  Say Y if tickless operation is important for you.
+
 endif
diff -rupN linux-2.6.31/arch/arm/mach-iop32x/n2100.c linux-2.6.31.arm-n2100-1-xint1-uart/arch/arm/mach-iop32x/n2100.c
--- linux-2.6.31/arch/arm/mach-iop32x/n2100.c	2008-12-25 15:54:13.000000000 +0100
+++ linux-2.6.31.arm-n2100-1-xint1-uart/arch/arm/mach-iop32x/n2100.c	2009-09-26 13:49:18.000000000 +0200
@@ -43,6 +43,17 @@
 #include <mach/time.h>
 
 /*
+ * N2100 IRQ assignments depend on XINT1 jumper.
+ */
+#ifdef CONFIG_N2100_XINT1_UART
+#define N2100_UART_IRQ		IRQ_IOP32X_XINT1
+#define N2100_VT6212_INTA_IRQ	-1	/* disabled */
+#else
+#define N2100_UART_IRQ		0	/* uses polling timer */
+#define N2100_VT6212_INTA_IRQ	IRQ_IOP32X_XINT1
+#endif
+
+/*
  * N2100 timer tick configuration.
  */
 static void __init n2100_timer_init(void)
@@ -95,7 +106,7 @@ n2100_pci_map_irq(struct pci_dev *dev, u
 		irq = IRQ_IOP32X_XINT2;
 	} else if (PCI_SLOT(dev->devfn) == 4 && pin == 1) {
 		/* VT6212 INTA */
-		irq = IRQ_IOP32X_XINT1;
+		irq = N2100_VT6212_INTA_IRQ;
 	} else if (PCI_SLOT(dev->devfn) == 4 && pin == 2) {
 		/* VT6212 INTB */
 		irq = IRQ_IOP32X_XINT0;
@@ -177,7 +188,7 @@ static struct plat_serial8250_port n2100
 	{
 		.mapbase	= N2100_UART,
 		.membase	= (char *)N2100_UART,
-		.irq		= 0,
+		.irq		= N2100_UART_IRQ,
 		.flags		= UPF_SKIP_TEST,
 		.iotype		= UPIO_MEM,
 		.regshift	= 0,
