From: j.braam@homeautomationeurope.com (Jurgen Braam)
Date: Thu, 14 Apr 2011 17:29:57 +0200
Subject: i.MX27 SPI tx fifo underrun
Message-ID: <io73tm$1e5$1@dough.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Folks,

while trying to write to an at25 eeprom connected via SPI on an i.MX27, 
I ran into a TX FIFO underrun. In spi_imx_isr() the variable 
spi_imx->txfifo gets rather large as a result of an unsigned integer 
underflow, resulting in a feels-like-endless loop.

The following patch fixes the problem in our case:

--- a/drivers/spi/spi_imx.c
+++ b/drivers/spi/spi_imx.c
@@ -407,7 +407,7 @@ static void __maybe_unused spi_imx0_4_reset(struct 
spi_imx_data *spi_imx)
  }

  #define MX27_INTREG_RR         (1 << 4)
-#define MX27_INTREG_TEEN       (1 << 9)
+#define MX27_INTREG_TSHFEEN    (1 << 12)
  #define MX27_INTREG_RREN       (1 << 13)

  #define MX27_CSPICTRL_POL      (1 << 5)
@@ -424,7 +424,7 @@ static void __maybe_unused mx27_intctrl(struct 
spi_imx_data *spi_imx, int enable
         unsigned int val = 0;

         if (enable & MXC_INT_TE)
-               val |= MX27_INTREG_TEEN;
+               val |= MX27_INTREG_TSHFEEN;
         if (enable & MXC_INT_RR)
                 val |= MX27_INTREG_RREN;


The i.MX27 manual states you have to wait for a TSHFE interrupt or poll 
the XCH bit. The i.MX31 manual for instance says to wait for a TC 
interrupt or poll XCH. The app flow of both docs never mention waiting 
for the TE interrupt.

Maybe the MX1_INTREG_TEEN and/or MX31_INTREG_TEEN refs need to be 
changed as well? Anybody know if this is true? Comments?

grtz,
   Jurgen
