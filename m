From: petr.cvek@tul.cz (Petr Cvek)
Date: Mon, 28 Sep 2015 23:32:25 +0200
Subject: [PATCH v4 11/26] ARM: pxa: magician: Optimize EGPIO initial values
In-Reply-To: <cover.1443472089.git.petr.cvek@tul.cz>
References: <cover.1443472089.git.petr.cvek@tul.cz>
Message-ID: <5609B1E9.4020508@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch optimizes initial values of the EGPIO chip driver.

GSM and sound should be powered off during boot. A weak accumulator and
a powered GSM sometimes cause a system reboot. A charging current should be
as high as possible during boot.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 arch/arm/mach-pxa/magician.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 2c487ae..bf0760e 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -263,9 +263,12 @@ static struct htc_egpio_chip egpio_chips[] = {
 		.num_gpios	= 24,
 		.direction	= HTC_EGPIO_OUTPUT,
 		/*
-		 * Depends on modules configuration
+		 * NOTICE LCD valid power on sequence
+		 * Disable GSM and sound
+		 * Low accu can cause reboot, set 500mA charging
+		 * OR 0x8000 for LCD backlight (debug printks)
 		 */
-		.initial_values	= 0x40,
+		.initial_values	= 0x2020c0,
 	},
 	[1] = {
 		.reg_start	= 4,
-- 
1.7.12.1
