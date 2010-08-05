From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 05 Aug 2010 16:25:32 +0900
Subject: [PATCH 1/5] ARM: S5PC110: Use the correct external GPIO config
Message-ID: <20100805072532.GA22262@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Actually external GPIOs have interrupt.
and It's handled from differnt place, irq-eint.c

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/gpiolib.c |   27 ++++++++++++++++++---------
 1 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-s5pv210/gpiolib.c b/arch/arm/mach-s5pv210/gpiolib.c
index 9ea8972..f6a32c4 100644
--- a/arch/arm/mach-s5pv210/gpiolib.c
+++ b/arch/arm/mach-s5pv210/gpiolib.c
@@ -31,11 +31,20 @@ static struct s3c_gpio_cfg gpio_cfg_noint = {
 	.get_pull	= s3c_gpio_getpull_updown,
 };
 
+static struct s3c_gpio_cfg gpio_cfg_extint = {
+	.set_config	= s3c_gpio_setcfg_s3c64xx_4bit,
+	.set_pull	= s3c_gpio_setpull_updown,
+	.get_pull	= s3c_gpio_getpull_updown,
+};
+
+
 /* GPIO bank's base address given the index of the bank in the
  * list of all gpio banks.
  */
 #define S5PV210_BANK_BASE(bank_nr)	(S5P_VA_GPIO + ((bank_nr) * 0x20))
 
+#define EXTINT_OFFSET			(0xC00)
+
 /*
  * Following are the gpio banks in v210.
  *
@@ -207,32 +216,28 @@ static struct s3c_gpio_chip s5pv210_gpio_4bit[] = {
 			.label	= "MP03",
 		},
 	}, {
-		.base	= (S5P_VA_GPIO + 0xC00),
-		.config	= &gpio_cfg_noint,
+		.config	= &gpio_cfg_extint,
 		.chip	= {
 			.base	= S5PV210_GPH0(0),
 			.ngpio	= S5PV210_GPIO_H0_NR,
 			.label	= "GPH0",
 		},
 	}, {
-		.base	= (S5P_VA_GPIO + 0xC20),
-		.config	= &gpio_cfg_noint,
+		.config	= &gpio_cfg_extint,
 		.chip	= {
 			.base	= S5PV210_GPH1(0),
 			.ngpio	= S5PV210_GPIO_H1_NR,
 			.label	= "GPH1",
 		},
 	}, {
-		.base	= (S5P_VA_GPIO + 0xC40),
-		.config	= &gpio_cfg_noint,
+		.config	= &gpio_cfg_extint,
 		.chip	= {
 			.base	= S5PV210_GPH2(0),
 			.ngpio	= S5PV210_GPIO_H2_NR,
 			.label	= "GPH2",
 		},
 	}, {
-		.base	= (S5P_VA_GPIO + 0xC60),
-		.config	= &gpio_cfg_noint,
+		.config	= &gpio_cfg_extint,
 		.chip	= {
 			.base	= S5PV210_GPH3(0),
 			.ngpio	= S5PV210_GPIO_H3_NR,
@@ -245,11 +250,15 @@ static __init int s5pv210_gpiolib_init(void)
 {
 	struct s3c_gpio_chip *chip = s5pv210_gpio_4bit;
 	int nr_chips = ARRAY_SIZE(s5pv210_gpio_4bit);
-	int i = 0;
+	int i, extint = 0;
 
 	for (i = 0; i < nr_chips; i++, chip++) {
 		if (chip->config == NULL)
 			chip->config = &gpio_cfg;
+		if (chip->config == &gpio_cfg_extint) {
+			chip->base = S5PV210_BANK_BASE(extint) + EXTINT_OFFSET;
+			extint++;
+		}
 		if (chip->base == NULL)
 			chip->base = S5PV210_BANK_BASE(i);
 	}
-- 
1.5.3.3
