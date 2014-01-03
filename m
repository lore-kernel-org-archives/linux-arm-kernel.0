From: michal.simek@xilinx.com (Michal Simek)
Date: Fri,  3 Jan 2014 11:10:58 +0100
Subject: [PATCH v1 13/24] serial: zynq: Add OF initialization support
In-Reply-To: <cover.1388743861.git.michal.simek@xilinx.com>
References: <cover.1388743861.git.michal.simek@xilinx.com>
Message-ID: <ed2fc1cbbc0e6c1aaab2bdf2bfa801ad3f794d46.1388743861.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add console selection from DTB which is enough to have
OF driven solution.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v1: None

 drivers/serial/serial_zynq.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/serial/serial_zynq.c b/drivers/serial/serial_zynq.c
index 9b24af2..3f7fcfa 100644
--- a/drivers/serial/serial_zynq.c
+++ b/drivers/serial/serial_zynq.c
@@ -6,12 +6,15 @@
  */

 #include <common.h>
+#include <fdtdec.h>
 #include <watchdog.h>
 #include <asm/io.h>
 #include <linux/compiler.h>
 #include <serial.h>
 #include <asm/arch/hardware.h>

+DECLARE_GLOBAL_DATA_PTR;
+
 #define ZYNQ_UART_SR_TXFULL	0x00000010 /* TX FIFO full */
 #define ZYNQ_UART_SR_RXEMPTY	0x00000002 /* RX FIFO empty */

@@ -191,6 +194,30 @@ DECLARE_PSSERIAL_FUNCTIONS(1);
 struct serial_device uart_zynq_serial1_device =
 	INIT_PSSERIAL_STRUCTURE(1, "ttyPS1");

+#ifdef CONFIG_OF_CONTROL
+__weak struct serial_device *default_serial_console(void)
+{
+	const void *blob = gd->fdt_blob;
+	int node;
+	unsigned int base_addr;
+
+	node = fdt_path_offset(blob, "serial0");
+	if (node < 0)
+		return NULL;
+
+	base_addr = fdtdec_get_addr(blob, node, "reg");
+	if (base_addr == FDT_ADDR_T_NONE)
+		return NULL;
+
+	if (base_addr == ZYNQ_SERIAL_BASEADDR0)
+		return &uart_zynq_serial0_device;
+
+	if (base_addr == ZYNQ_SERIAL_BASEADDR1)
+		return &uart_zynq_serial1_device;
+
+	return NULL;
+}
+#else
 __weak struct serial_device *default_serial_console(void)
 {
 #ifdef CONFIG_ZYNQ_SERIAL_BASEADDR0
@@ -203,6 +230,7 @@ __weak struct serial_device *default_serial_console(void)
 #endif
 	return NULL;
 }
+#endif

 void zynq_serial_initalize(void)
 {
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140103/215dae08/attachment.sig>
