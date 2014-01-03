From: michal.simek@xilinx.com (Michal Simek)
Date: Fri,  3 Jan 2014 11:10:57 +0100
Subject: [PATCH v1 12/24] zynq: serial: Simplify serial driver initialization
In-Reply-To: <cover.1388743861.git.michal.simek@xilinx.com>
References: <cover.1388743861.git.michal.simek@xilinx.com>
Message-ID: <c6aeee6f11da2ddc59a883e3a72b35c16ebdf8c9.1388743861.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagannadha Sutradharudu Teki <jagannadha.sutradharudu-teki@xilinx.com>

Define both serial uarts in the driver and return
default uart based on board configuration.

- Move baseaddresses to hardware.h
- Define default baudrate and clock values

Signed-off-by: Jagannadha Sutradharudu Teki <jaganna@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v1: None

 arch/arm/include/asm/arch-zynq/hardware.h |  2 ++
 drivers/serial/serial_zynq.c              | 34 ++++++++++++++++++-------------
 include/configs/zynq.h                    |  9 +++-----
 3 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/arch/arm/include/asm/arch-zynq/hardware.h b/arch/arm/include/asm/arch-zynq/hardware.h
index cd69677..b1a7775 100644
--- a/arch/arm/include/asm/arch-zynq/hardware.h
+++ b/arch/arm/include/asm/arch-zynq/hardware.h
@@ -7,6 +7,8 @@
 #ifndef _ASM_ARCH_HARDWARE_H
 #define _ASM_ARCH_HARDWARE_H

+#define ZYNQ_SERIAL_BASEADDR0		0xE0000000
+#define ZYNQ_SERIAL_BASEADDR1		0xE0001000
 #define ZYNQ_SYS_CTRL_BASEADDR		0xF8000000
 #define ZYNQ_DEV_CFG_APB_BASEADDR	0xF8007000
 #define ZYNQ_SCU_BASEADDR		0xF8F00000
diff --git a/drivers/serial/serial_zynq.c b/drivers/serial/serial_zynq.c
index ff28f3c..9b24af2 100644
--- a/drivers/serial/serial_zynq.c
+++ b/drivers/serial/serial_zynq.c
@@ -10,6 +10,7 @@
 #include <asm/io.h>
 #include <linux/compiler.h>
 #include <serial.h>
+#include <asm/arch/hardware.h>

 #define ZYNQ_UART_SR_TXFULL	0x00000010 /* TX FIFO full */
 #define ZYNQ_UART_SR_RXEMPTY	0x00000002 /* RX FIFO empty */
@@ -33,13 +34,23 @@ struct uart_zynq {
 };

 static struct uart_zynq *uart_zynq_ports[2] = {
-#ifdef CONFIG_ZYNQ_SERIAL_BASEADDR0
-	[0] = (struct uart_zynq *)CONFIG_ZYNQ_SERIAL_BASEADDR0,
+	[0] = (struct uart_zynq *)ZYNQ_SERIAL_BASEADDR0,
+	[1] = (struct uart_zynq *)ZYNQ_SERIAL_BASEADDR1,
+};
+
+#if !defined(CONFIG_ZYNQ_SERIAL_BAUDRATE0)
+# define CONFIG_ZYNQ_SERIAL_BAUDRATE0	CONFIG_BAUDRATE
 #endif
-#ifdef CONFIG_ZYNQ_SERIAL_BASEADDR1
-	[1] = (struct uart_zynq *)CONFIG_ZYNQ_SERIAL_BASEADDR1,
+#if !defined(CONFIG_ZYNQ_SERIAL_BAUDRATE1)
+# define CONFIG_ZYNQ_SERIAL_BAUDRATE1	CONFIG_BAUDRATE
+#endif
+
+#if !defined(CONFIG_ZYNQ_SERIAL_CLOCK0)
+# define CONFIG_ZYNQ_SERIAL_CLOCK0	50000000
+#endif
+#if !defined(CONFIG_ZYNQ_SERIAL_CLOCK1)
+# define CONFIG_ZYNQ_SERIAL_CLOCK1	50000000
 #endif
-};

 struct uart_zynq_params {
 	u32 baudrate;
@@ -47,14 +58,10 @@ struct uart_zynq_params {
 };

 static struct uart_zynq_params uart_zynq_ports_param[2] = {
-#if defined(CONFIG_ZYNQ_SERIAL_BAUDRATE0) && defined(CONFIG_ZYNQ_SERIAL_CLOCK0)
 	[0].baudrate = CONFIG_ZYNQ_SERIAL_BAUDRATE0,
 	[0].clock = CONFIG_ZYNQ_SERIAL_CLOCK0,
-#endif
-#if defined(CONFIG_ZYNQ_SERIAL_BAUDRATE1) && defined(CONFIG_ZYNQ_SERIAL_CLOCK1)
 	[1].baudrate = CONFIG_ZYNQ_SERIAL_BAUDRATE1,
 	[1].clock = CONFIG_ZYNQ_SERIAL_CLOCK1,
-#endif
 };

 /* Set up the baud rate in gd struct */
@@ -186,20 +193,19 @@ struct serial_device uart_zynq_serial1_device =

 __weak struct serial_device *default_serial_console(void)
 {
+#ifdef CONFIG_ZYNQ_SERIAL_BASEADDR0
 	if (uart_zynq_ports[0])
 		return &uart_zynq_serial0_device;
+#endif
+#ifdef CONFIG_ZYNQ_SERIAL_BASEADDR1
 	if (uart_zynq_ports[1])
 		return &uart_zynq_serial1_device;
-
+#endif
 	return NULL;
 }

 void zynq_serial_initalize(void)
 {
-#ifdef CONFIG_ZYNQ_SERIAL_BASEADDR0
 	serial_register(&uart_zynq_serial0_device);
-#endif
-#ifdef CONFIG_ZYNQ_SERIAL_BASEADDR1
 	serial_register(&uart_zynq_serial1_device);
-#endif
 }
diff --git a/include/configs/zynq.h b/include/configs/zynq.h
index 3938b54..6632223 100644
--- a/include/configs/zynq.h
+++ b/include/configs/zynq.h
@@ -32,16 +32,13 @@
 #define CONFIG_SYS_BAUDRATE_TABLE  \
 	{300, 600, 1200, 2400, 4800, 9600, 19200, 38400, 57600, 115200, 230400}

-/* Zynq Serial driver */
-#define CONFIG_ZYNQ_SERIAL
-#define CONFIG_ZYNQ_SERIAL_BASEADDR0	0xE0001000
-#define CONFIG_ZYNQ_SERIAL_BAUDRATE0	CONFIG_BAUDRATE
-#define CONFIG_ZYNQ_SERIAL_CLOCK0	50000000
-
 /* DCC driver */
 #if defined(CONFIG_ZYNQ_DCC)
 # define CONFIG_ARM_DCC
 # define CONFIG_CPU_V6 /* Required by CONFIG_ARM_DCC */
+#else
+# define CONFIG_ZYNQ_SERIAL_BASEADDR1
+# define CONFIG_ZYNQ_SERIAL
 #endif

 /* Ethernet driver */
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140103/ca8e0736/attachment-0001.sig>
