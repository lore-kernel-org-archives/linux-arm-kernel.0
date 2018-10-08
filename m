From: arnd@arndb.de (Arnd Bergmann)
Date: Mon,  8 Oct 2018 17:57:43 +0200
Subject: [PATCH] pinctrl: mediatek: select GPIOLIB
Message-ID: <20181008155803.3322412-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Removing the linux/gpio.h include means we no longer have a declaration
of gpiochip_lock_as_irq() when CONFIG_GPIOLIB is disabled:

drivers/pinctrl/mediatek/mtk-eint.c: In function 'mtk_eint_irq_request_resources':
drivers/pinctrl/mediatek/mtk-eint.c:247:8: error: implicit declaration of function 'gpiochip_lock_as_irq'; did you mean 'spin_lock_irq'? [-Werror=implicit-function-declaration]
drivers/pinctrl/mediatek/mtk-eint.c: In function 'mtk_eint_irq_release_resources':
drivers/pinctrl/mediatek/mtk-eint.c:272:2: error: implicit declaration of function 'gpiochip_unlock_as_irq'; did you mean 'spin_unlock_irq'? [-Werror=implicit-function-declaration]

Select it explictly instead.

Fixes: 1c5fb66afa2a ("pinctrl: Include <linux/gpio/driver.h> nothing else")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pinctrl/mediatek/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
index 05be5ddafec4..9d142e1da567 100644
--- a/drivers/pinctrl/mediatek/Kconfig
+++ b/drivers/pinctrl/mediatek/Kconfig
@@ -4,6 +4,7 @@ menu "MediaTek pinctrl drivers"
 config EINT_MTK
 	bool "MediaTek External Interrupt Support"
 	depends on PINCTRL_MTK || PINCTRL_MTK_MOORE || COMPILE_TEST
+	select GPIOLIB
 	select IRQ_DOMAIN
 
 config PINCTRL_MTK
-- 
2.18.0
