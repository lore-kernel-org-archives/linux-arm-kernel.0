From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  8 Aug 2012 16:47:23 +0200
Subject: [PATCH 06/11] gpio: em: do not discard em_gio_irq_domain_cleanup
In-Reply-To: <1344437248-20560-1-git-send-email-arnd@arndb.de>
References: <1344437248-20560-1-git-send-email-arnd@arndb.de>
Message-ID: <1344437248-20560-7-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The newly added gpio-em driver marks its em_gio_irq_domain_cleanup
function as __devexit, which would lead to that function being
discarded in case CONFIG_HOTPLUG is disabled. However, the function
is also called by the error handling logic em_gio_probe, which
would cause a jump into a NULL pointer if it was removed from the
kernel or module.

Without this patch, building kzm9d_defconfig results in:

WARNING: drivers/gpio/built-in.o(.devinit.text+0x330): Section mismatch in reference from the function em_gio_probe() to the function .devexit.text:em_gio_irq_domain_cleanup()
The function __devinit em_gio_probe() references
a function __devexit em_gio_irq_domain_cleanup().
This is often seen when error handling in the init function
uses functionality in the exit path.
The fix is often to remove the __devexit annotation of
em_gio_irq_domain_cleanup() so it may be used outside an exit section.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Magnus Damm <damm@opensource.se>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/gpio/gpio-em.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-em.c b/drivers/gpio/gpio-em.c
index 150d976..ae37181 100644
--- a/drivers/gpio/gpio-em.c
+++ b/drivers/gpio/gpio-em.c
@@ -266,7 +266,7 @@ static int __devinit em_gio_irq_domain_init(struct em_gio_priv *p)
 	return 0;
 }
 
-static void __devexit em_gio_irq_domain_cleanup(struct em_gio_priv *p)
+static void em_gio_irq_domain_cleanup(struct em_gio_priv *p)
 {
 	struct gpio_em_config *pdata = p->pdev->dev.platform_data;
 
-- 
1.7.10
