From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 05 Aug 2010 16:25:56 +0900
Subject: [PATCH 5/5] ARM: S5PC110: Assign the group number for GPIOs
Message-ID: <20100805072556.GA22281@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

With this, it can calculate the proper GPIOs offset when support the GPIO interrupt.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/gpiolib.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-s5pv210/gpiolib.c b/arch/arm/mach-s5pv210/gpiolib.c
index 94d4fe2..ffb0d0d 100644
--- a/arch/arm/mach-s5pv210/gpiolib.c
+++ b/arch/arm/mach-s5pv210/gpiolib.c
@@ -260,11 +260,14 @@ static __init int s5pv210_gpiolib_init(void)
 {
 	struct s3c_gpio_chip *chip = s5pv210_gpio_4bit;
 	int nr_chips = ARRAY_SIZE(s5pv210_gpio_4bit);
-	int i, extint = 0;
+	int i, extint = 0, group = 0;
 
 	for (i = 0; i < nr_chips; i++, chip++) {
-		if (chip->config == NULL)
+		if (chip->config == NULL) {
 			chip->config = &gpio_cfg;
+			/* Assign the GPIO interrupt group number */
+			chip->group = group++;
+		}
 		if (chip->config == &gpio_cfg_extint) {
 			chip->base = S5PV210_BANK_BASE(extint) + EXTINT_OFFSET;
 			/* Assign the external GPIO interrupt group number */
-- 
1.5.3.3
