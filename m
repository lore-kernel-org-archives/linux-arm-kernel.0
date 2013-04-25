From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Apr 2013 19:28:55 +0200
Subject: [PATCH 12/21] irqchip: s3c24xx: add missing __init annotations
In-Reply-To: <1366910944-3033663-1-git-send-email-arnd@arndb.de>
References: <1366910944-3033663-1-git-send-email-arnd@arndb.de>
Message-ID: <1366910944-3033663-13-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The s3c24xx_init_intc and s3c2412_init_irq functions are only called
at init time, and they call functions already marked __init, so they
should be marked in the same way. This was reported as

WARNING: vmlinux.o(.text+0x19e0b4): Section mismatch in reference from the function s3c2412_init_irq() to the function .init.text:s3c24xx_init_intc.constprop.8()
The function s3c2412_init_irq() references
the function __init s3c24xx_init_intc.constprop.8().
This is often because s3c2412_init_irq lacks a __init
annotation or the annotation of s3c24xx_init_intc.constprop.8 is wrong.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Kukjin Kim <kgene.kim@samsung.com>
---
 drivers/irqchip/irq-s3c24xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-s3c24xx.c b/drivers/irqchip/irq-s3c24xx.c
index c8afd7b..bbcc944 100644
--- a/drivers/irqchip/irq-s3c24xx.c
+++ b/drivers/irqchip/irq-s3c24xx.c
@@ -535,7 +535,7 @@ static void s3c24xx_clear_intc(struct s3c_irq_intc *intc)
 	}
 }
 
-static struct s3c_irq_intc *s3c24xx_init_intc(struct device_node *np,
+static struct s3c_irq_intc * __init s3c24xx_init_intc(struct device_node *np,
 				       struct s3c_irq_data *irq_data,
 				       struct s3c_irq_intc *parent,
 				       unsigned long address)
@@ -795,7 +795,7 @@ static struct s3c_irq_data init_s3c2412subint[32] = {
 	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 21 }, /* CF */
 };
 
-void s3c2412_init_irq(void)
+void __init s3c2412_init_irq(void)
 {
 	pr_info("S3C2412: IRQ Support\n");
 
-- 
1.8.1.2
