From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 24 Dec 2013 15:14:27 +0100
Subject: [PATCH RFC 04/11] ARM: SAMSUNG: pm: Consolidate PM debug functions
In-Reply-To: <1387894474-14428-1-git-send-email-t.figa@samsung.com>
References: <1387894474-14428-1-git-send-email-t.figa@samsung.com>
Message-ID: <1387894474-14428-4-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes one-line functions that was used just to pass
constant arguments to lower level functions. After previous patches the
need for those constants has been eliminated, so the main functions can
be called directly.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/plat-samsung/pm.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/arch/arm/plat-samsung/pm.c b/arch/arm/plat-samsung/pm.c
index bafd4f1..6f19a8e 100644
--- a/arch/arm/plat-samsung/pm.c
+++ b/arch/arm/plat-samsung/pm.c
@@ -83,9 +83,10 @@ static inline void __iomem *s3c_pm_uart_base(void)
 	return (void __iomem *)vaddr;
 }
 
-static void s3c_pm_save_uart(unsigned int uart, struct pm_uart_save *save)
+static void s3c_pm_save_uarts(void)
 {
 	void __iomem *regs = s3c_pm_uart_base();
+	struct pm_uart_save *save = &uart_save;
 
 	save->ulcon = __raw_readl(regs + S3C2410_ULCON);
 	save->ucon = __raw_readl(regs + S3C2410_UCON);
@@ -96,18 +97,14 @@ static void s3c_pm_save_uart(unsigned int uart, struct pm_uart_save *save)
 	if (!soc_is_s3c2410())
 		save->udivslot = __raw_readl(regs + S3C2443_DIVSLOT);
 
-	S3C_PMDBG("UART[%d]: ULCON=%04x, UCON=%04x, UFCON=%04x, UBRDIV=%04x\n",
-		  uart, save->ulcon, save->ucon, save->ufcon, save->ubrdiv);
-}
-
-static void s3c_pm_save_uarts(void)
-{
-	s3c_pm_save_uart(CONFIG_DEBUG_S3C_UART, &uart_save);
+	S3C_PMDBG("UART[%p]: ULCON=%04x, UCON=%04x, UFCON=%04x, UBRDIV=%04x\n",
+		  regs, save->ulcon, save->ucon, save->ufcon, save->ubrdiv);
 }
 
-static void s3c_pm_restore_uart(unsigned int uart, struct pm_uart_save *save)
+static void s3c_pm_restore_uarts(void)
 {
 	void __iomem *regs = s3c_pm_uart_base();
+	struct pm_uart_save *save = &uart_save;
 
 	s3c_pm_arch_update_uart(regs, save);
 
@@ -120,11 +117,6 @@ static void s3c_pm_restore_uart(unsigned int uart, struct pm_uart_save *save)
 	if (!soc_is_s3c2410())
 		__raw_writel(save->udivslot, regs + S3C2443_DIVSLOT);
 }
-
-static void s3c_pm_restore_uarts(void)
-{
-	s3c_pm_restore_uart(CONFIG_DEBUG_S3C_UART, &uart_save);
-}
 #else
 #define s3c_pm_debug_init() do { } while(0)
 
-- 
1.8.4.3
