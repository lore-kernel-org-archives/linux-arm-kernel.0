From: alex.bluesman.smirnov@gmail.com (Alexander Smirnov)
Date: Wed, 20 Jun 2012 15:52:50 +0400
Subject: RF231 transceiver on at91sam9g20ek board
Message-ID: <CAJmB2rDxv45OP4otn7rmQcpzCvLujKm0j9_OqNW6PoyHuarTLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi folks,

I'm the developer of the IEEE 802.15.4 kernel branch, and currently
I've faced with the problem regarding mach-at91 arch and hope you can
advise me.

I've been working with at86rf231 transceiver (RF231 extender)
connected via SPI to at91sam9g20ek board. The driver works and tested
for kernels up to 3.1 version (versions 3.2-latest haven't ever been
tested yet).
Several days ago I've ported the IEEE802.15.4 stack to the latest
kernel and see some strange things: RF231 interrupt handler is
permanently pulled right after driver's probe method (the RF231 chip
is in disabled mode, so it can't generate interrupts at that moment).
Also I've noticed that each ENTER key pressing in minicom generates a
new interrupt. It looks like somebody else uses the same pin/pins for
its needs...

Do you have any ideas what can be changed since 3.1 kernel that this
problem arose.

Thanks a lot for your time!

The driver code is in the attachments.
The platform RF231 code is following:

diff --git a/arch/arm/mach-at91/board-sam9g20ek.c
b/arch/arm/mach-at91/board-sam9g20ek.c
index 8923ec9..b2126e0 100644
--- a/arch/arm/mach-at91/board-sam9g20ek.c
+++ b/arch/arm/mach-at91/board-sam9g20ek.c
@@ -25,6 +25,7 @@
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/at73c213.h>
+#include <linux/spi/at86rf230.h>
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
 #include <linux/clk.h>
@@ -102,6 +103,12 @@ static struct at91_udc_data __initdata ek_udc_data = {
 /*
  * SPI devices.
  */
+static struct at86rf230_platform_data rf230_pdata = {
+       .rstn   = AT91_PIN_PB10,
+       .slp_tr = AT91_PIN_PB11,
+       .dig2   = AT91_PIN_PB12,
+};
+
 static struct spi_board_info ek_spi_devices[] = {
 #if !(defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_AT91))
        {       /* DataFlash chip */
@@ -118,6 +125,16 @@ static struct spi_board_info ek_spi_devices[] = {
                .bus_num        = 0,
        },
 #endif
+#if defined(CONFIG_IEEE802154_AT86RF230)
+       {
+               .modalias       = "at86rf230",
+               .chip_select    = 3,
+               .max_speed_hz   = 3 * 1000 * 1000,
+               .bus_num        = 1,
+               .irq            = AT91_PIN_PB13,
+               .platform_data  = &rf230_pdata,
+       },
+#endif
 #endif
 };

With best regards,
Alexander Smirnov
-------------- next part --------------
A non-text attachment was scrubbed...
Name: at86rf230.c
Type: text/x-csrc
Size: 23107 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120620/a7d3ec16/attachment-0001.bin>
