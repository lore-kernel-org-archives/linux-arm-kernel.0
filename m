From: martin.ereth@arcor.de (Martin Ereth)
Date: Fri, 04 Jun 2010 23:58:58 +0200
Subject: [PATCH 2.6.35-rc1] arm/mach-at91: Different crystal frequencies on
	AT91SAM9263 evaluation kit
Message-ID: <4C097722.7060704@arcor.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Ereth <martin.ereth@arcor.de>

On newer evaluation boards for AT91SAM9263 Atmel changed the crystal where the
frequency of the processor is derived from. They changed it from 16.36766 MHz
to 18.432 MHz because it is easier to connect a gps receiver.

Using the wrong crystal frequency during board initialization results in the
wrong frequency of the processor which leads to strange characters on a serial
console.

With this patch the user is able to choose the crystal installed on his board.

Signed-off-by: Martin Ereth <martin.ereth@arcor.de>
---

Please be patient, this is my first patch. If I do things wrong
please tell me. What is the next step? Thanks.

diff -rupN linux-2.6.35-rc1-vanilla/arch/arm/mach-at91/board-sam9263ek.c linux-2.6.35-rc1/arch/arm/mach-at91/board-sam9263ek.c
--- linux-2.6.35-rc1-vanilla/arch/arm/mach-at91/board-sam9263ek.c       2010-06-04 15:40:55.000000000 +0200
+++ linux-2.6.35-rc1/arch/arm/mach-at91/board-sam9263ek.c       2010-06-04 16:43:18.000000000 +0200
@@ -54,8 +54,8 @@

  static void __init ek_map_io(void)
  {
-       /* Initialize processor: 16.367 MHz crystal */
-       at91sam9263_initialize(16367660);
+       /* Initialize processor: 16.36766 MHz or 18.432 MHz crystal */
+       at91sam9263_initialize(AT91SAM9263_CRYSTAL_HZ);

         /* DBGU on ttyS0. (Rx & Tx only) */
         at91_register_uart(0, 0, 0);
diff -rupN linux-2.6.35-rc1-vanilla/arch/arm/mach-at91/include/mach/at91sam9263.h linux-2.6.35-rc1/arch/arm/mach-at91/include/mach/at91sam9263.h
--- linux-2.6.35-rc1-vanilla/arch/arm/mach-at91/include/mach/at91sam9263.h      2010-06-04 15:40:55.000000000 +0200
+++ linux-2.6.35-rc1/arch/arm/mach-at91/include/mach/at91sam9263.h      2010-06-04 16:51:56.000000000 +0200
@@ -123,5 +123,13 @@
  #define AT91SAM9263_DMAC_BASE  0x00800000      /* DMA Controller */
  #define AT91SAM9263_UHP_BASE   0x00a00000      /* USB Host controller */

+/*
+ * Crystals.
+ */
+#if defined(CONFIG_HAVE_AT91SAM9263_CRYSTAL_16367660)
+#define AT91SAM9263_CRYSTAL_HZ 16367660
+#else /* CONFIG_HAVE_AT91SAM9263_CRYSTAL_18432000 */
+#define AT91SAM9263_CRYSTAL_HZ 18432000
+#endif

  #endif
diff -rupN linux-2.6.35-rc1-vanilla/arch/arm/mach-at91/Kconfig linux-2.6.35-rc1/arch/arm/mach-at91/Kconfig
--- linux-2.6.35-rc1-vanilla/arch/arm/mach-at91/Kconfig 2010-06-04 15:40:55.000000000 +0200
+++ linux-2.6.35-rc1/arch/arm/mach-at91/Kconfig 2010-06-04 16:22:19.000000000 +0200
@@ -448,6 +448,25 @@ config MTD_NAND_ATMEL_BUSWIDTH_16
           On AT91SAM926x boards both types of NAND flash can be present
           (8 and 16 bit data bus width).

+if MACH_AT91SAM9263EK
+
+choice
+       prompt "Choose crystal frequency on your board"
+
+config HAVE_AT91SAM9263_CRYSTAL_16367660
+       bool "16.36766 MHz"
+       help
+         Select this if you have a 16.36766 MHz crystal on your board.
+
+config HAVE_AT91SAM9263_CRYSTAL_18432000
+       bool "18.432 MHz"
+       help
+         Select this if you have a 18.432 MHz crystal on your board.
+
+endchoice
+
+endif
+
  # ----------------------------------------------------------

  comment "AT91 Feature Selections"
