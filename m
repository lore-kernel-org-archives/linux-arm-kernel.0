From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Thu, 8 Sep 2016 04:48:15 +0300
Subject: [PATCH v2 2/3] gpio: mxc: shift gpio_mxc_init() to subsys_initcall
 level
In-Reply-To: <1473299296-22458-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1473299296-22458-1-git-send-email-vladimir_zapolskiy@mentor.com>
Message-ID: <1473299296-22458-3-git-send-email-vladimir_zapolskiy@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In general situation on-SoC GPIO controller drivers should be probed
after pinctrl/pinmux controller driver, because on-SoC GPIOs utilize a
pin/pad as a resource provided and controlled by pinctrl subsystem.

This is stated in multiple places, e.g. from drivers/Makefile:

  GPIO must come after pinctrl as gpios may need to mux pins etc

Looking at Freescale iMX SoC series specifics, imx*_pinctrl_init()
functions are called at arch_initcall and postcore_initcall init
levels, so the change of initcall level for gpio-mxc driver from
postcore_initcall to subsys_initcall level is sufficient. Also note
that the most of GPIO controller drivers settled at subsys_initcall
level.

If pinctrl subsystem manages pads with GPIO functions, the change is
needed to avoid unwanted driver probe deferrals during kernel boot.

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
---
Changes from v1 to v2:
* replaced by a change with better commit description and which
  moves gpio_mxc_init() call to subsys_initcall() instead of
  apparently too late device_initcall(), this mitigates Shawn's
  expressed concern about the change.

 drivers/gpio/gpio-mxc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
index 1b342a3842c8..1fdd5d804b5b 100644
--- a/drivers/gpio/gpio-mxc.c
+++ b/drivers/gpio/gpio-mxc.c
@@ -510,7 +510,7 @@ static int __init gpio_mxc_init(void)
 {
 	return platform_driver_register(&mxc_gpio_driver);
 }
-postcore_initcall(gpio_mxc_init);
+subsys_initcall(gpio_mxc_init);
 
 MODULE_AUTHOR("Freescale Semiconductor, "
 	      "Daniel Mack <danielncaiaq.de>, "
-- 
2.8.1
