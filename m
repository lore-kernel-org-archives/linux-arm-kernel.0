From: tony@atomide.com (Tony Lindgren)
Date: Fri, 24 Sep 2010 17:27:15 -0700
Subject: [PATCH 5/7] Adding i2c eeprom driver to read EDID
In-Reply-To: <20100925002608.24551.67183.stgit@baageli.muru.com>
References: <20100925002608.24551.67183.stgit@baageli.muru.com>
Message-ID: <20100925002715.24551.94749.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mathieu J. Poirier <mathieu.poirier@canonical.com>

Adding i2c eeprom driver to access monitor EDID binary information
from user space, something that is required by 'decode-edid' and
'parse-edid'.

BugLink: https://bugs.launchpad.net/bugs/608279

Signed-off-by: Mathieu Poirier <mathieu.poirier@canonical.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 5534841..e27f3bf 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -412,13 +412,19 @@ static struct i2c_board_info __initdata beagle_i2c_boardinfo[] = {
 	},
 };
 
+static struct i2c_board_info __initdata beagle_i2c_eeprom[] = {
+       {
+               I2C_BOARD_INFO("eeprom", 0x50),
+       },
+};
+
 static int __init omap3_beagle_i2c_init(void)
 {
 	omap_register_i2c_bus(1, 2600, beagle_i2c_boardinfo,
 			ARRAY_SIZE(beagle_i2c_boardinfo));
 	/* Bus 3 is attached to the DVI port where devices like the pico DLP
 	 * projector don't work reliably with 400kHz */
-	omap_register_i2c_bus(3, 100, NULL, 0);
+	omap_register_i2c_bus(3, 100, beagle_i2c_eeprom, ARRAY_SIZE(beagle_i2c_eeprom));
 	return 0;
 }
 
