From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed,  2 Jun 2010 23:29:50 +0200
Subject: [PATCH] mioa701: fix camera regression
Message-ID: <1275514190-32006-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit a48c24a696f0d93c49f913b7818e9819612b1f4e, the
camera is not working anymore.

After the v4l2 migration, the mt9m111 camera board
information was not passed to the i2c layer anymore, but
stored for future use of v4l2 (through soc_camera).

Because mioa701_i2c_devices[] was tagged as "__initdata",
and because after the v4l2 migration, the new structure
"iclink" references it, the mt9m111 driver is not probed
anymore, as part of "iclink" is not valid (discarded after
kernel init).

Although there is not compilation error, nor runtime oops,
this patch restores a working camera on the mioa701 board.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>

--
Eric, could you schedule that into your fix branch please ?
---
 arch/arm/mach-pxa/mioa701.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
index 7a50ed8..9836921 100644
--- a/arch/arm/mach-pxa/mioa701.c
+++ b/arch/arm/mach-pxa/mioa701.c
@@ -696,7 +696,7 @@ static struct i2c_board_info __initdata mioa701_pi2c_devices[] = {
 };
 
 /* Board I2C devices. */
-static struct i2c_board_info __initdata mioa701_i2c_devices[] = {
+static struct i2c_board_info mioa701_i2c_devices[] = {
 	{
 		I2C_BOARD_INFO("mt9m111", 0x5d),
 	},
-- 
1.7.0.4
