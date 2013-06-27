From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 27 Jun 2013 11:54:47 +0200
Subject: [PATCH v2] pinctrl: elaborate a bit on arrangements in doc
Message-ID: <1372326887-6497-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This elaborates a bit on the pin control and pin muxing
logic vs GPIO arangements in the hardware.

Inspired by some drawings in a mail from Christian Ruppert.
Both arrangements are confirmed to exist in practice.

Cc: Rob Landley <rob@landley.net>
Cc: Christian Ruppert <christian.ruppert@abilis.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Cut down to two arrangements that I *know* exist in reality.
- Reword, rehash, rinse, repeat...
---
 Documentation/pinctrl.txt | 69 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 63 insertions(+), 6 deletions(-)

diff --git a/Documentation/pinctrl.txt b/Documentation/pinctrl.txt
index c5948c7..62f3f2f 100644
--- a/Documentation/pinctrl.txt
+++ b/Documentation/pinctrl.txt
@@ -795,18 +795,75 @@ special GPIO-handler is registered.
 GPIO mode pitfalls
 ==================
 
-Sometime the developer may be confused by a datasheet talking about a pin
-being possible to set into "GPIO mode". It appears that what hardware
-engineers mean with "GPIO mode" is not necessarily the use case that is
-implied in the kernel interface <linux/gpio.h>: a pin that you grab from
-kernel code and then either listen for input or drive high/low to
-assert/deassert some external line.
+Due to the naming conventions used by hardware engineers, where "GPIO"
+is taken to mean different things than what the kernel does, the developer
+may be confused by a datasheet talking about a pin being possible to set
+into "GPIO mode". It appears that what hardware engineers mean with
+"GPIO mode" is not necessarily the use case that is implied in the kernel
+interface <linux/gpio.h>: a pin that you grab from kernel code and then
+either listen for input or drive high/low to assert/deassert some
+external line.
 
 Rather hardware engineers think that "GPIO mode" means that you can
 software-control a few electrical properties of the pin that you would
 not be able to control if the pin was in some other mode, such as muxed in
 for a device.
 
+The GPIO portions of a pin and its relation to a certain pin controller
+configuration and muxing logic can be constructed in several ways. Here
+are three examples:
+
+(A)
+                       pin config
+                       logic regs
+                       |               +- SPI
+     Physical pins --- pad --- pinmux -+- I2C
+                               |       +- mmc
+                               |       +- GPIO
+                               pin
+                               multiplex
+                               logic
+
+Here some electrical properties of the pin can be configured no matter if the
+pin is used for GPIO or not. After multiplexing GPIO onto the pin, you can
+also drive it high/low from a certain bitset named "GPIO". Or the line can be
+controlled by a certain peripheral, while still applying desired pin config
+properties. GPIO functionality is thus orthogonal to any other device using the
+pad/pin.
+
+In this arrangement the registers for the GPIO portions of the pin controller
+are likely to reside in a separate memory range only intended for GPIO
+driving, and the register range dealing with pin config and pin multiplexing
+get placed into a different memory range and a separate section of the data
+sheet.
+
+(B)
+
+                       pin config
+                       logic regs
+                       |               +- SPI
+     Physical pins --- pad --- pinmux -+- I2C
+                       |       |       +- mmc
+                       |       |
+                       GPIO    pin
+                               multiplex
+                               logic
+
+In this arrangement, the GPIO functionality can always be enabled, such that
+e.g. a GPIO input can be used to "spy" on the SPI/I2C/MMC signal while it is
+pulsed out. It is likely possible to disrupt the traffic on the pin by doing
+wrong things on the GPIO block, as it is never really disconnected. It is
+likely that the GPIO, pin config and pin multiplex registers are placed into
+the same memory range and the same section of the data sheet.
+
+From a kernel point of view, however, these are different aspects of the
+hardware and shall be put into different subsystems.
+
+Electrical properties of the pin such as biasing and drive strength
+may be placed at some pin-specific register in all cases or as part
+of the GPIO register in case (B) especially. This doesn't mean that such
+properties necessarily pertain to what the Linux kernel calls "GPIO".
+
 Example: a pin is usually muxed in to be used as a UART TX line. But during
 system sleep, we need to put this pin into "GPIO mode" and ground it.
 
-- 
1.7.11.3
