From: p.wilczek@samsung.com (Piotr Wilczek)
Date: Wed, 18 Dec 2013 13:09:10 +0100
Subject: [PATCH V2 7/8] serial: add Exynos specific serial driver
In-Reply-To: <1387368551-18958-1-git-send-email-p.wilczek@samsung.com>
References: <1386767259-15693-1-git-send-email-p.wilczek@samsung.com>
 <1387368551-18958-1-git-send-email-p.wilczek@samsung.com>
Message-ID: <1387368551-18958-8-git-send-email-p.wilczek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Piotr Wilczek <p.wilczek@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
Changes for V2:
 - none

 Makefile        |    1 +
 serial-exynos.c |   84 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)
 create mode 100644 serial-exynos.c

diff --git a/Makefile b/Makefile
index be2dbe1..6ae08a2 100644
--- a/Makefile
+++ b/Makefile
@@ -8,6 +8,7 @@ include Makefile.config
 
 CFLAGS+=-DUART_BASE=$(UART_BASE)
 CFLAGS+=-DNR_BANKS=$(NR_BANKS)
+CFLAGS+=-DUART_PORT=$(UART_PORT)
 
 BOARD_OBJ = board-$(MFG).o
 UART_OBJ = serial-$(UART).o
diff --git a/serial-exynos.c b/serial-exynos.c
new file mode 100644
index 0000000..3ba4fc9
--- /dev/null
+++ b/serial-exynos.c
@@ -0,0 +1,84 @@
+#include "types.h"
+#include "register.h"
+#include "serial.h"
+
+#define EXYNOS_BASE_UART	0x13800000
+#define TX_FIFO_FULL_MASK	(1 << 24)
+
+#define UART_BAUDRATE_115200	115200
+
+union br_rest {
+	unsigned short	slot;		/* udivslot */
+	unsigned char	value;		/* ufracval */
+};
+
+struct s5p_uart {
+	unsigned int	ulcon;
+	unsigned int	ucon;
+	unsigned int	ufcon;
+	unsigned int	umcon;
+	unsigned int	utrstat;
+	unsigned int	uerstat;
+	unsigned int	ufstat;
+	unsigned int	umstat;
+	unsigned char	utxh;
+	unsigned char	res1[3];
+	unsigned char	urxh;
+	unsigned char	res2[3];
+	unsigned int	ubrdiv;
+	union br_rest	rest;
+	unsigned char	res3[0xffd0];
+};
+
+static inline struct s5p_uart *s5p_get_base_uart(int dev_index)
+{
+	u32 offset = dev_index * sizeof(struct s5p_uart);
+	return (struct s5p_uart *)(EXYNOS_BASE_UART + offset);
+}
+
+static inline int s5p_uart_divslot(void)
+{
+	return 0;
+}
+
+static int serial_err_check(const int dev_index, int op)
+{
+	struct s5p_uart *const uart = s5p_get_base_uart(dev_index);
+	unsigned int mask;
+
+	/*
+	 * UERSTAT
+	 * Break Detect	[3]
+	 * Frame Err	[2] : receive operation
+	 * Parity Err	[1] : receive operation
+	 * Overrun Err	[0] : receive operation
+	 */
+	if (op)
+		mask = 0x8;
+	else
+		mask = 0xf;
+
+	return readl((unsigned int)&uart->uerstat) & mask;
+}
+
+/*
+ * Output a single byte to the serial port.
+ */
+void __putch(char c)
+{
+	const int dev_index = UART_PORT;
+
+	struct s5p_uart *const uart = s5p_get_base_uart(dev_index);
+
+	/* wait for room in the tx FIFO */
+	while ((readl((unsigned int)&uart->ufstat) & TX_FIFO_FULL_MASK)) {
+		if (serial_err_check(dev_index, 1))
+			return;
+	}
+
+	writeb(c, (unsigned int)&uart->utxh);
+
+	/* If \n, also do \r */
+	if (c == '\n')
+		__putch('\r');
+}
-- 
1.7.9.5
