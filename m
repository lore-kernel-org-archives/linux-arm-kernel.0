From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sun,  1 Oct 2017 22:06:18 -0400
Subject: [PATCH 3/3] ARM: early_printk: use printascii() rather than printch()
In-Reply-To: <20171002020618.23924-1-nicolas.pitre@linaro.org>
References: <20171002020618.23924-1-nicolas.pitre@linaro.org>
Message-ID: <20171002020618.23924-4-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With printch() the console messages are sent out one character at a time
which is agonizingly slow especially with semihosting as the whole trap
intercept, remote byte access, and system resume danse is performed for
every single character across a relatively slow remote debug connection.
Let's use printascii() to send a whole string at once. This is also going
to be more efficient, albeit to a quite lesser extent, with serial ports
as well.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/kernel/early_printk.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/early_printk.c b/arch/arm/kernel/early_printk.c
index 4307653696..9257736ec9 100644
--- a/arch/arm/kernel/early_printk.c
+++ b/arch/arm/kernel/early_printk.c
@@ -11,16 +11,20 @@
 #include <linux/kernel.h>
 #include <linux/console.h>
 #include <linux/init.h>
+#include <linux/string.h>
 
-extern void printch(int);
+extern void printascii(const char *);
 
 static void early_write(const char *s, unsigned n)
 {
-	while (n-- > 0) {
-		if (*s == '\n')
-			printch('\r');
-		printch(*s);
-		s++;
+	char buf[128];
+	while (n) {
+		unsigned l = min(n, sizeof(buf)-1);
+		memcpy(buf, s, l);
+		buf[l] = 0;
+		s += l;
+		n -= l;
+		printascii(buf);
 	}
 }
 
-- 
2.9.5
