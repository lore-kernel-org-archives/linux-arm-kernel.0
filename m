From: tony@atomide.com (Tony Lindgren)
Date: Fri, 24 Sep 2010 17:27:10 -0700
Subject: [PATCH 3/7] omap: Beagle: only Cx boards use pin 23 for write protect
In-Reply-To: <20100925002608.24551.67183.stgit@baageli.muru.com>
References: <20100925002608.24551.67183.stgit@baageli.muru.com>
Message-ID: <20100925002710.24551.64851.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robert Nelson <robertcnelson@gmail.com>

system_rev comes from u-boot and is a constant 0x20, so
Bx boards also fall in this 'if' and will get setup with the
wrong gpio_wp pin. Switch to using the Beagle revision routine
to correcly set pin 23 only for C1/2/3 and C4 Boards. Bx boards
will then use the correct default pin setting.

Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
Acked-by: Jarkko Nikula <jhnikula@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 1aebb3f..1908b33 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -272,7 +272,8 @@ static struct gpio_led gpio_leds[];
 static int beagle_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
-	if (system_rev >= 0x20 && system_rev <= 0x34301000) {
+	if ((omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_C1_3) ||
+		(omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_C4)) {
 		omap_mux_init_gpio(23, OMAP_PIN_INPUT);
 		mmc[0].gpio_wp = 23;
 	} else {
