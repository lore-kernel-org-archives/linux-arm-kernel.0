From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 24 Dec 2013 15:14:26 +0100
Subject: [PATCH RFC 03/11] ARM: SAMSUNG: pm: Use debug_ll_addr() to get UART
 base address
In-Reply-To: <1387894474-14428-1-git-send-email-t.figa@samsung.com>
References: <1387894474-14428-1-git-send-email-t.figa@samsung.com>
Message-ID: <1387894474-14428-3-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch modifies Samsung PM debug helpers to use a multiplatform
friendly way of getting base address of debug UART port, so instead
of using a per-mach static macro, a generic debug_ll_addr() helper
is used.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/plat-samsung/pm.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-samsung/pm.c b/arch/arm/plat-samsung/pm.c
index e017b7b..bafd4f1 100644
--- a/arch/arm/plat-samsung/pm.c
+++ b/arch/arm/plat-samsung/pm.c
@@ -21,6 +21,7 @@
 #include <linux/io.h>
 
 #include <asm/cacheflush.h>
+#include <asm/mach/map.h>
 #include <asm/suspend.h>
 
 #include <plat/cpu.h>
@@ -72,9 +73,19 @@ static inline void s3c_pm_debug_init(void)
 
 static struct pm_uart_save uart_save;
 
+static inline void __iomem *s3c_pm_uart_base(void)
+{
+	unsigned long paddr;
+	unsigned long vaddr;
+
+	debug_ll_addr(&paddr, &vaddr);
+
+	return (void __iomem *)vaddr;
+}
+
 static void s3c_pm_save_uart(unsigned int uart, struct pm_uart_save *save)
 {
-	void __iomem *regs = S3C_VA_UARTx(uart);
+	void __iomem *regs = s3c_pm_uart_base();
 
 	save->ulcon = __raw_readl(regs + S3C2410_ULCON);
 	save->ucon = __raw_readl(regs + S3C2410_UCON);
@@ -96,7 +107,7 @@ static void s3c_pm_save_uarts(void)
 
 static void s3c_pm_restore_uart(unsigned int uart, struct pm_uart_save *save)
 {
-	void __iomem *regs = S3C_VA_UARTx(uart);
+	void __iomem *regs = s3c_pm_uart_base();
 
 	s3c_pm_arch_update_uart(regs, save);
 
-- 
1.8.4.3
