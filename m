From: khilman@ti.com (Kevin Hilman)
Date: Wed, 11 Jul 2012 16:18:20 -0700
Subject: [PATCH] ARM: OMAP2+: ads7846 init: fix fault caused by freeing
 pen-down GPIO
Message-ID: <1342048700-15040-1-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 97ee9f01d6 (ARM: OMAP: fix the ads7846 init code) mistakenly
frees the pen-down GPIO even though it will be used by the ads7846
driver.

Freeing a GPIO means that the GPIO bank containing that GPIO can be
runtime suspended if its the last/only GPIO being used in that bank.
If the GPIO bank is runtime suspended, any accesses to that bank will
cause faults.

Because the current code frees the GPIO, the ads7846 driver probe will
fault when it requests its IRQ line.  Because the IRQ is a GPIO line,
the request IRQ will trickle down into the OMAP GPIO layer:
gpio_irq_type() --> _set_gpio_triggering() which can fault if the
bank has been runtime suspended.

This is exctly what happens on Overo platforms (3530 Water, 3730 Overo
FireSTORM) since this is the only GPIO used in the bank.

To fix, don't free the GPIO at all since it is always in use.

Cc: Igor Grinberg <grinberg@compulab.co.il>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
Tony, this applies on top of your current fixes-non-critical branch and
should probably go in to v3.5-rc since the patch which introduced the
problem did as well.

 arch/arm/mach-omap2/common-board-devices.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-omap2/common-board-devices.c b/arch/arm/mach-omap2/common-board-devices.c
index c187586..1ae6fd6 100644
--- a/arch/arm/mach-omap2/common-board-devices.c
+++ b/arch/arm/mach-omap2/common-board-devices.c
@@ -84,9 +84,6 @@ void __init omap_ads7846_init(int bus_num, int gpio_pendown, int gpio_debounce,
 		ads7846_config.gpio_pendown = gpio_pendown;
 	}
 
-	if (!board_pdata || (board_pdata && !board_pdata->get_pendown_state))
-		gpio_free(gpio_pendown);
-
 	spi_register_board_info(&ads7846_spi_board_info, 1);
 }
 #else
-- 
1.7.9.2
