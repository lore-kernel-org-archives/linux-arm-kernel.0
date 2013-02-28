From: apatel@apm.com (Anup Patel)
Date: Thu, 28 Feb 2013 16:31:08 +0530
Subject: [PATCH] arm64: add support for uart earlyprintk
Message-ID: <1362049268-26822-1-git-send-email-apatel@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Anup Patel <apatel@apm.com>
---
 arch/arm64/kernel/early_printk.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/kernel/early_printk.c b/arch/arm64/kernel/early_printk.c
index 7e320a2..62953ed 100644
--- a/arch/arm64/kernel/early_printk.c
+++ b/arch/arm64/kernel/early_printk.c
@@ -29,6 +29,21 @@ static void __iomem *early_base;
 static void (*printch)(char ch);
 
 /*
+ * UART (8250/16550) single character TX.
+ */
+static void uart_printch(char ch)
+{
+#define UART_LSR 	0x14
+#define UART_TX 	0x0
+
+	while (!(readl_relaxed(early_base + UART_LSR) & 0x20))
+		;
+	writeb_relaxed(ch, early_base + UART_TX);
+	while (!(readl_relaxed(early_base + UART_LSR) & 0x20))
+		;
+}
+
+/*
  * PL011 single character TX.
  */
 static void pl011_printch(char ch)
@@ -47,6 +62,7 @@ struct earlycon_match {
 
 static const struct earlycon_match earlycon_match[] __initconst = {
 	{ .name = "pl011", .printch = pl011_printch, },
+	{ .name = "uart", .printch = uart_printch, },
 	{}
 };
 
-- 
1.7.9.5

CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, 
is for the sole use of the intended recipient(s) and contains information
that is confidential and proprietary to Applied Micro Circuits Corporation or its subsidiaries. 
It is to be used solely for the purpose of furthering the parties' business relationship. 
All unauthorized review, use, disclosure or distribution is prohibited. 
If you are not the intended recipient, please contact the sender by reply e-mail 
and destroy all copies of the original message.
