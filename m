From: tony@atomide.com (Tony Lindgren)
Date: Fri, 14 May 2010 14:27:54 -0700
Subject: [PATCH 03/10] omap: init the gpio pinmux for mmc
In-Reply-To: <20100514212506.25599.98073.stgit@baageli.muru.com>
References: <20100514212506.25599.98073.stgit@baageli.muru.com>
Message-ID: <20100514212754.25599.5024.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: stanley.miao <stanley.miao@windriver.com>

There is two gpio for mmc use, one is for card detecting, another is
used for checking write protect. Intialize its pinmux in case the bootloader
doesn't set it.

Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/devices.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 10f3a3c..3d30f22 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -591,6 +591,15 @@ static inline void omap_hsmmc_reset(void) {}
 static inline void omap2_mmc_mux(struct omap_mmc_platform_data *mmc_controller,
 			int controller_nr)
 {
+	if ((mmc_controller->slots[0].switch_pin > 0) && \
+		(mmc_controller->slots[0].switch_pin < OMAP_MAX_GPIO_LINES))
+		omap_mux_init_gpio(mmc_controller->slots[0].switch_pin,
+					OMAP_PIN_INPUT_PULLUP);
+	if ((mmc_controller->slots[0].gpio_wp > 0) && \
+		(mmc_controller->slots[0].gpio_wp < OMAP_MAX_GPIO_LINES))
+		omap_mux_init_gpio(mmc_controller->slots[0].gpio_wp,
+					OMAP_PIN_INPUT_PULLUP);
+
 	if (cpu_is_omap2420() && controller_nr == 0) {
 		omap_cfg_reg(H18_24XX_MMC_CMD);
 		omap_cfg_reg(H15_24XX_MMC_CLKI);
