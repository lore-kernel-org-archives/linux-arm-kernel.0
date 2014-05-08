From: robherring2@gmail.com (Rob Herring)
Date: Thu,  8 May 2014 17:23:40 -0500
Subject: [PATCH 3/6] serial: earlycon: add DT support
In-Reply-To: <1399587823-17701-1-git-send-email-robherring2@gmail.com>
References: <1399587823-17701-1-git-send-email-robherring2@gmail.com>
Message-ID: <1399587823-17701-4-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

This adds the infrastructure to generic earlycon for earlycon setup
using DT. The actual setup is not enabled until a following commit to
add the FDT parsing.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tty/serial/earlycon.c     | 27 +++++++++++++++++++++++++++
 include/asm-generic/vmlinux.lds.h |  4 +++-
 include/linux/serial_core.h       |  6 ++++++
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index c92e830..021fe5f 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/serial_core.h>
+#include <linux/mod_devicetable.h>
 
 #ifdef CONFIG_FIX_EARLYCON_MEM
 #include <asm/fixmap.h>
@@ -32,6 +33,9 @@ static struct earlycon_device early_console_dev = {
 	.con = &early_con,
 };
 
+static const struct of_device_id __earlycon_of_table_sentinel
+	__used __section(__earlycon_of_table_end);
+
 static void __iomem * __init earlycon_map(unsigned long paddr, size_t size)
 {
 	void __iomem *base;
@@ -142,3 +146,26 @@ int __init setup_earlycon(char *buf, const char *match,
 	register_console(early_console_dev.con);
 	return 0;
 }
+
+int __init of_setup_earlycon(unsigned long addr,
+			     int (*setup)(struct earlycon_device *, const char *))
+{
+	int err;
+	struct uart_port *port = &early_console_dev.port;
+
+	port->iotype = UPIO_MEM;
+	port->mapbase = addr;
+	port->uartclk = BASE_BAUD * 16;
+	port->membase = earlycon_map(addr, SZ_4K);
+
+	early_console_dev.con->data = &early_console_dev;
+	err = setup(&early_console_dev, NULL);
+	if (err < 0)
+		return err;
+	if (!early_console_dev.con->write)
+		return -ENODEV;
+
+
+	register_console(early_console_dev.con);
+	return 0;
+}
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 120ccb9..f5249c4 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -129,6 +129,7 @@
 #define CLK_OF_TABLES()		OF_TABLE(CONFIG_COMMON_CLK, clk)
 #define RESERVEDMEM_OF_TABLES()	OF_TABLE(CONFIG_OF_RESERVED_MEM, reservedmem)
 #define CPU_METHOD_OF_TABLES()	OF_TABLE(CONFIG_SMP, cpu_method)
+#define EARLYCON_OF_TABLES()	OF_TABLE(CONFIG_SERIAL_EARLYCON, earlycon)
 
 #define KERNEL_DTB()							\
 	STRUCT_ALIGN();							\
@@ -458,7 +459,8 @@
 	CLKSRC_OF_TABLES()						\
 	CPU_METHOD_OF_TABLES()						\
 	KERNEL_DTB()							\
-	IRQCHIP_OF_MATCH_TABLE()
+	IRQCHIP_OF_MATCH_TABLE()					\
+	EARLYCON_OF_TABLES()
 
 #define INIT_TEXT							\
 	*(.init.text)							\
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 7a15b5b..5bbb809 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -294,6 +294,9 @@ struct earlycon_device {
 int setup_earlycon(char *buf, const char *match,
 		   int (*setup)(struct earlycon_device *, const char *));
 
+extern int of_setup_earlycon(unsigned long addr,
+			     int (*setup)(struct earlycon_device *, const char *));
+
 #define EARLYCON_DECLARE(name, func) \
 static int __init name ## _setup_earlycon(char *buf) \
 { \
@@ -301,6 +304,9 @@ static int __init name ## _setup_earlycon(char *buf) \
 } \
 early_param("earlycon", name ## _setup_earlycon);
 
+#define OF_EARLYCON_DECLARE(name, compat, fn)				\
+	_OF_DECLARE(earlycon, name, compat, fn, void *)
+
 struct uart_port *uart_get_console(struct uart_port *ports, int nr,
 				   struct console *c);
 void uart_parse_options(char *options, int *baud, int *parity, int *bits,
-- 
1.9.1
