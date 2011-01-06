From: nm@ti.com (Nishanth Menon)
Date: Thu,  6 Jan 2011 13:54:37 -0600
Subject: [PATCH v3 1/3] omap3: beaglexm: fix EHCI power up GPIO dir
In-Reply-To: <1294343679-10605-1-git-send-email-nm@ti.com>
References: <1294343679-10605-1-git-send-email-nm@ti.com>
Message-ID: <1294343679-10605-2-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Koen Kooi <koen@beagleboard.org>

EHCI enable power pin is inverted (active high) in comparison
to vanilla beagle which is active low. Handle this case conditionally.

[nm at ti.com: helped split up]
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Koen Kooi <koen@beagleboard.org>
---
 arch/arm/mach-omap2/board-omap3beagle.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 6c12760..1b5aa7a 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -297,9 +297,16 @@ static int beagle_twl_gpio_setup(struct device *dev,
 	gpio_request(gpio + 1, "EHCI_nOC");
 	gpio_direction_input(gpio + 1);
 
-	/* TWL4030_GPIO_MAX + 0 == ledA, EHCI nEN_USB_PWR (out, active low) */
+	/*
+	 * TWL4030_GPIO_MAX + 0 == ledA, EHCI nEN_USB_PWR (out, XM active
+	 * high / others active low)
+	 */
 	gpio_request(gpio + TWL4030_GPIO_MAX, "nEN_USB_PWR");
 	gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0);
+	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM)
+		gpio_direction_output(gpio + TWL4030_GPIO_MAX, 1);
+	else
+		gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0);
 
 	/* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED) */
 	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
-- 
1.6.3.3
