From: anup.patel@linaro.org (Anup Patel)
Date: Fri,  1 Mar 2013 11:30:26 +0530
Subject: [PATCH] arm64: add support for 8250/16550 earlyprintk
Message-ID: <1362117626-2076-1-git-send-email-anup.patel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for using earlyprintk with 8250/16550 UART ports.

The 8250/16550 UART can either have 8-bit or 32-bit aligned registers which is HW vendor dependent.

Kernel args for 8-bit aligned regs: earlyprintk=uart8250-8bit,<phys_address>

Kernel args for 32-bit aligned regs: earlyprintk=uart8250-16bit,<phys_address>

Signed-off-by: Anup Patel <anup.patel@linaro.org>
---
 arch/arm64/kernel/early_printk.c |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/kernel/early_printk.c b/arch/arm64/kernel/early_printk.c
index 7e320a2..d57f300 100644
--- a/arch/arm64/kernel/early_printk.c
+++ b/arch/arm64/kernel/early_printk.c
@@ -24,11 +24,32 @@
 #include <linux/io.h>
 
 #include <linux/amba/serial.h>
+#include <uapi/linux/serial_reg.h>
 
 static void __iomem *early_base;
 static void (*printch)(char ch);
 
 /*
+ * 8250/16550 (8-bit aligned registers) single character TX.
+ */
+static void uart8250_8bit_printch(char ch)
+{
+	while (!(readb_relaxed(early_base + UART_LSR) & UART_LSR_THRE))
+		;
+	writeb_relaxed(ch, early_base + UART_TX);
+}
+
+/*
+ * 8250/16550 (32-bit aligned registers) single character TX.
+ */
+static void uart8250_32bit_printch(char ch)
+{
+	while (!(readl_relaxed(early_base + (UART_LSR << 2)) & UART_LSR_THRE))
+		;
+	writel_relaxed(ch, early_base + (UART_TX << 2));
+}
+
+/*
  * PL011 single character TX.
  */
 static void pl011_printch(char ch)
@@ -47,6 +68,8 @@ struct earlycon_match {
 
 static const struct earlycon_match earlycon_match[] __initconst = {
 	{ .name = "pl011", .printch = pl011_printch, },
+	{ .name = "uart8250-8bit", .printch = uart8250_8bit_printch, },
+	{ .name = "uart8250-32bit", .printch = uart8250_32bit_printch, },
 	{}
 };
 
-- 
1.7.9.5
