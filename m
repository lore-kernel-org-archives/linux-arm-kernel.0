From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Sep 2012 23:36:15 +0200
Subject: [PATCH 10/12] gpio: pcf857x: select IRQ_DOMAIN
In-Reply-To: <1348868177-21205-1-git-send-email-arnd@arndb.de>
References: <1348868177-21205-1-git-send-email-arnd@arndb.de>
Message-ID: <1348868177-21205-11-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch 6e20a0a4 "gpio: pcf857x: enable gpio_to_irq() support"
added IRQ domain support to the pcf857x driver, but some configurations
(e.g. davinci_all_defconfig) don't already enable CONFIG_IRQ_DOMAIN.

Always selecting it from the Kconfig in this case is what other
such drivers do as well, and avoids these build errors:

Without this patch, building davinci_all_defconfig results in:

drivers/gpio/gpio-pcf857x.c: In function 'pcf857x_to_irq':
drivers/gpio/gpio-pcf857x.c:167:2: error: implicit declaration of function 'irq_create_mapping'
drivers/gpio/gpio-pcf857x.c: In function 'pcf857x_irq_demux_work':
drivers/gpio/gpio-pcf857x.c:183:3: error: implicit declaration of function 'irq_find_mapping'
drivers/gpio/gpio-pcf857x.c: In function 'pcf857x_irq_domain_cleanup':
drivers/gpio/gpio-pcf857x.c:218:3: error: implicit declaration of function 'irq_domain_remove'
drivers/gpio/gpio-pcf857x.c: In function 'pcf857x_irq_domain_init':
drivers/gpio/gpio-pcf857x.c:230:2: error: implicit declaration of function 'irq_domain_add_linear'

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 0c05532..d055cee 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -336,6 +336,7 @@ config GPIO_PCA953X_IRQ
 config GPIO_PCF857X
 	tristate "PCF857x, PCA{85,96}7x, and MAX732[89] I2C GPIO expanders"
 	depends on I2C
+	select IRQ_DOMAIN
 	help
 	  Say yes here to provide access to most "quasi-bidirectional" I2C
 	  GPIO expanders used for additional digital outputs or inputs.
-- 
1.7.10
