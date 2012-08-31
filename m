From: castet.matthieu@free.fr (Matthieu CASTET)
Date: Fri, 31 Aug 2012 11:21:56 +0200
Subject: [PATCH] hvc_dcc : add support to armv4 and armv5 core
Message-ID: <1346404916-27616-1-git-send-email-castet.matthieu@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Matthieu Castet <matthieu.castet@parrot.com>
---
 drivers/tty/hvc/hvc_dcc.c |   34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/tty/hvc/hvc_dcc.c b/drivers/tty/hvc/hvc_dcc.c
index 44fbeba..489e9e5 100644
--- a/drivers/tty/hvc/hvc_dcc.c
+++ b/drivers/tty/hvc/hvc_dcc.c
@@ -26,6 +26,7 @@
 
 #include "hvc_console.h"
 
+#if defined(CONFIG_CPU_V6) || defined(CONFIG_CPU_V7)
 /* DCC Status Bits */
 #define DCC_STATUS_RX		(1 << 30)
 #define DCC_STATUS_TX		(1 << 29)
@@ -58,6 +59,39 @@ static inline void __dcc_putchar(char c)
 		: "r" (c));
 	isb();
 }
+#else
+/* DCC Status Bits */
+#define DCC_STATUS_RX		(1 << 0)
+#define DCC_STATUS_TX		(1 << 1)
+
+/* primitive JTAG1 protocol utilities */
+static inline u32 __dcc_getstatus(void)
+{
+	u32 ret;
+
+	asm __volatile__ ("mrc p14, 0, %0, c0, c0	@ read comms ctrl reg"
+		: "=r" (ret));
+
+	return ret;
+}
+
+static inline char __dcc_getchar(void)
+{
+	char c;
+
+	asm __volatile__ ("mrc p14, 0, %0, c1, c0	@ read comms data reg"
+		: "=r" (c));
+
+	return c;
+}
+
+static inline void __dcc_putchar(unsigned char c)
+{
+	asm __volatile__ ("mcr p14, 0, %0, c1, c0	@ write a char"
+		: /* no output register */
+		: "r" (c));
+}
+#endif
 
 static int hvc_dcc_put_chars(uint32_t vt, const char *buf, int count)
 {
-- 
1.7.10.4
