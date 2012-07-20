From: linux@prisktech.co.nz (Tony Prisk)
Date: Sat, 21 Jul 2012 02:39:43 +1200
Subject: [PATCH] ARM: vt8500: Minor updates to platform drivers for devicetree
 support
Message-ID: <1342795183-7942-1-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Updated the vt8500-rtc and vt8500-uart platform drivers for
devicetree support.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
 .../devicetree/bindings/rtc/vt8500-rtc.txt         |   14 ++++++++++++++
 .../devicetree/bindings/tty/serial/vt8500-uart.txt |   14 ++++++++++++++
 drivers/rtc/rtc-vt8500.c                           |    8 ++++++++
 drivers/tty/serial/vt8500_serial.c                 |    8 ++++++++
 4 files changed, 44 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/vt8500-rtc.txt
 create mode 100644 Documentation/devicetree/bindings/tty/serial/vt8500-uart.txt

diff --git a/Documentation/devicetree/bindings/rtc/vt8500-rtc.txt b/Documentation/devicetree/bindings/rtc/vt8500-rtc.txt
new file mode 100644
index 0000000..8cf6ce1
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/vt8500-rtc.txt
@@ -0,0 +1,14 @@
+* SPEAr RTC
+
+Required properties:
+- compatible : "via,vt8500-rtc"
+- reg : Address range of the rtc registers
+- interrupt: Should contain the rtc interrupt number
+
+Example:
+
+	rtc at d8100000 {
+		compatible = "via,vt8500-rtc";
+		reg = <0xd8100000 0x2c>;
+		interrupts = <48>;
+	};
diff --git a/Documentation/devicetree/bindings/tty/serial/vt8500-uart.txt b/Documentation/devicetree/bindings/tty/serial/vt8500-uart.txt
new file mode 100644
index 0000000..745070a
--- /dev/null
+++ b/Documentation/devicetree/bindings/tty/serial/vt8500-uart.txt
@@ -0,0 +1,14 @@
+* VIA/Wondermedia Universal Asynchronous Receiver/Transmitter (UART)
+
+Required properties:
+- compatible: Should be "via,vt8500-uart"
+- reg: Should contain registers location and length
+- interrupts: Should contain interrupt
+
+Example:
+	uart0: serial at d8200000 {
+		compatible = "via,vt8500-uart";
+		reg = <0xd8200000 0x1040>;
+		interrupts = <32>;
+	};
+
diff --git a/drivers/rtc/rtc-vt8500.c b/drivers/rtc/rtc-vt8500.c
index 9e94fb1..2f155c2 100644
--- a/drivers/rtc/rtc-vt8500.c
+++ b/drivers/rtc/rtc-vt8500.c
@@ -23,6 +23,7 @@
 #include <linux/bcd.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 
 /*
  * Register definitions
@@ -302,12 +303,18 @@ static int __devexit vt8500_rtc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id vt8500_rtc_ids[] = {
+	{ .compatible = "via,vt8500-rtc", },
+	{}
+};
+
 static struct platform_driver vt8500_rtc_driver = {
 	.probe		= vt8500_rtc_probe,
 	.remove		= __devexit_p(vt8500_rtc_remove),
 	.driver		= {
 		.name	= "vt8500-rtc",
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(vt8500_rtc_ids),
 	},
 };
 
@@ -317,3 +324,4 @@ MODULE_AUTHOR("Alexey Charkov <alchark@gmail.com>");
 MODULE_DESCRIPTION("VIA VT8500 SoC Realtime Clock Driver (RTC)");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:vt8500-rtc");
+MODULE_DEVICE_TABLE(of, vt8500_rtc_ids);
diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
index 2be006f..bd20b4e 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -34,6 +34,7 @@
 #include <linux/slab.h>
 #include <linux/clk.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
 
 /*
  * UART Register offsets
@@ -603,12 +604,18 @@ static int __devexit vt8500_serial_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id vt8500_uart_ids[] = {
+	{ .compatible = "via,vt8500-uart", },
+	{}
+};
+
 static struct platform_driver vt8500_platform_driver = {
 	.probe  = vt8500_serial_probe,
 	.remove = __devexit_p(vt8500_serial_remove),
 	.driver = {
 		.name = "vt8500_serial",
 		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(vt8500_uart_ids),
 	},
 };
 
@@ -643,3 +650,4 @@ module_exit(vt8500_serial_exit);
 MODULE_AUTHOR("Alexey Charkov <alchark@gmail.com>");
 MODULE_DESCRIPTION("Driver for vt8500 serial device");
 MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(of, vt8500_uart_ids);
-- 
1.7.2.5
