From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 10 Sep 2017 23:44:23 +0200
Subject: [PATCH 4/5] i2c: gpio: Augment all boardfiles to use open drain
In-Reply-To: <20170910214424.14945-1-linus.walleij@linaro.org>
References: <20170910214424.14945-1-linus.walleij@linaro.org>
Message-ID: <20170910214424.14945-5-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We now handle the open drain mode internally in the I2C GPIO
driver, but we will get warnings from the gpiolib that we
override the default mode of the line so it becomes open
drain.

We can fix all in-kernel users by simply passing the right
flag along in the descriptor table, and we already touched
all of these files in the series so let's just tidy it up.

Cc: arm at kernel.org
Cc: Steven Miao <realmz6@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC folks: requesting ACK for Wolfram to take this patch.
Steven (Blackfin): requesting ACK for Wolfram to take this patch.
Ralf (MIPS): requesting ACK for Wolfram to take this patch.
Lee: requesting ACK for Wolfram to take this patch.
---
 arch/arm/mach-ep93xx/core.c                  | 6 ++++--
 arch/arm/mach-ixp4xx/avila-setup.c           | 4 ++--
 arch/arm/mach-ixp4xx/dsmg600-setup.c         | 4 ++--
 arch/arm/mach-ixp4xx/fsg-setup.c             | 4 ++--
 arch/arm/mach-ixp4xx/ixdp425-setup.c         | 4 ++--
 arch/arm/mach-ixp4xx/nas100d-setup.c         | 4 ++--
 arch/arm/mach-ixp4xx/nslu2-setup.c           | 4 ++--
 arch/arm/mach-ks8695/board-acs5k.c           | 6 ++++--
 arch/arm/mach-pxa/palmz72.c                  | 6 ++++--
 arch/arm/mach-pxa/viper.c                    | 8 ++++----
 arch/arm/mach-sa1100/simpad.c                | 6 ++++--
 arch/blackfin/mach-bf533/boards/blackstamp.c | 4 ++--
 arch/blackfin/mach-bf533/boards/ezkit.c      | 4 ++--
 arch/blackfin/mach-bf533/boards/stamp.c      | 4 ++--
 arch/blackfin/mach-bf561/boards/ezkit.c      | 4 ++--
 arch/mips/alchemy/board-gpr.c                | 4 ++++
 arch/mips/ath79/mach-pb44.c                  | 4 ++--
 drivers/mfd/sm501.c                          | 4 ++--
 18 files changed, 48 insertions(+), 36 deletions(-)

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 6b4754ecaffc..efddea867cbe 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -326,8 +326,10 @@ static struct gpiod_lookup_table ep93xx_i2c_gpiod_table = {
 	.dev_id		= "i2c-gpio",
 	.table		= {
 		/* Use local offsets on gpiochip/port "G" */
-		GPIO_LOOKUP_IDX("G", 1, NULL, 0, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("G", 0, NULL, 1, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("G", 1, NULL, 0,
+				GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
+		GPIO_LOOKUP_IDX("G", 0, NULL, 1,
+				GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
 	},
 };
 
diff --git a/arch/arm/mach-ixp4xx/avila-setup.c b/arch/arm/mach-ixp4xx/avila-setup.c
index 72122b5e7f28..bb6fbfc9b11a 100644
--- a/arch/arm/mach-ixp4xx/avila-setup.c
+++ b/arch/arm/mach-ixp4xx/avila-setup.c
@@ -53,9 +53,9 @@ static struct gpiod_lookup_table avila_i2c_gpiod_table = {
 	.dev_id		= "i2c-gpio",
 	.table		= {
 		GPIO_LOOKUP_IDX("IXP4XX_GPIO_CHIP", AVILA_SDA_PIN,
-				NULL, 0, GPIO_ACTIVE_HIGH),
+				NULL, 0, GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
 		GPIO_LOOKUP_IDX("IXP4XX_GPIO_CHIP", AVILA_SCL_PIN,
-				NULL, 1, GPIO_ACTIVE_HIGH),
+				NULL, 1, GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
 	},
 };
 
diff --git a/arch/arm/mach-ixp4xx/dsmg600-setup.c b/arch/arm/mach-ixp4xx/dsmg600-setup.c
index 68ccd669051b..af543dd3da5d 100644
--- a/arch/arm/mach-ixp4xx/dsmg600-setup.c
+++ b/arch/arm/mach-ixp4xx/dsmg600-setup.c
@@ -72,9 +72,9 @@ static struct gpiod_lookup_table dsmg600_i2c_gpiod_table = {
 	.dev_id		= "i2c-gpio",
 	.table		= {
 		GPIO_LOOKUP_IDX("IXP4XX_GPIO_CHIP", DSMG600_SDA_PIN,
-				NULL, 0, GPIO_ACTIVE_HIGH),
+				NULL, 0, GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
 		GPIO_LOOKUP_IDX("IXP4XX_GPIO_CHIP", DSMG600_SCL_PIN,
-				NULL, 1, GPIO_ACTIVE_HIGH),
+				NULL, 1, GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
 	},
 };
 
diff --git a/arch/arm/mach-ixp4xx/fsg-setup.c b/arch/arm/mach-ixp4xx/fsg-setup.c
index a0350ad15175..8afb3f4db376 100644
--- a/arch/arm/mach-ixp4xx/fsg-setup.c
+++ b/arch/arm/mach-ixp4xx/fsg-setup.c
@@ -58,9 +58,9 @@ static struct gpiod_lookup_table fsg_i2c_gpiod_table = {
 	.dev_id		= "i2c-gpio",
 	.table		= {
 		GPIO_LOOKUP_IDX("IXP4XX_GPIO_CHIP", FSG_SDA_PIN,
-				NULL, 0, GPIO_ACTIVE_HIGH),
+				NULL, 0, GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
 		GPIO_LOOKUP_IDX("IXP4XX_GPIO_CHIP", FSG_SCL_PIN,
-				NULL, 1, GPIO_ACTIVE_HIGH),
+				NULL, 1, GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
 	},
 };
 
diff --git a/arch/arm/mach-ixp4xx/ixdp425-setup.c b/arch/arm/mach-ixp4xx/ixdp425-setup.c
index fd32ccde20c5..483d48bf252e 100644
--- a/arch/arm/mach-ixp4xx/ixdp425-setup.c
+++ b/arch/arm/mach-ixp4xx/ixdp425-setup.c
@@ -126,9 +126,9 @@ static struct gpiod_lookup_table ixdp425_i2c_gpiod_table = {
 	.dev_id		= "i2c-gpio",
 	.table		= {
 		GPIO_LOOKUP_IDX("IXP4XX_GPIO_CHIP", IXDP425_SDA_PIN,
-				NULL, 0, GPIO_ACTIVE_HIGH),
+				NULL, 0, GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
 		GPIO_LOOKUP_IDX("IXP4XX_GPIO_CHIP", IXDP425_SCL_PIN,
-				NULL, 1, GPIO_ACTIVE_HIGH),
+				NULL, 1, GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
 	},
 };
 
diff --git a/arch/arm/mach-ixp4xx/nas100d-setup.c b/arch/arm/mach-ixp4xx/nas100d-setup.c
index 612ec8c63456..7e59c59c96a3 100644
--- a/arch/arm/mach-ixp4xx/nas100d-setup.c
+++ b/arch/arm/mach-ixp4xx/nas100d-setup.c
@@ -104,9 +104,9 @@ static struct gpiod_lookup_table nas100d_i2c_gpiod_table = {
 	.dev_id		= "i2c-gpio",
 	.table		= {
 		GPIO_LOOKUP_IDX("IXP4XX_GPIO_CHIP", NAS100D_SDA_PIN,
-				NULL, 0, GPIO_ACTIVE_HIGH),
+				NULL, 0, GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
 		GPIO_LOOKUP_IDX("IXP4XX_GPIO_CHIP", NAS100D_SCL_PIN,
-				NULL, 1, GPIO_ACTIVE_HIGH),
+				NULL, 1, GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
 	},
 };
 
diff --git a/arch/arm/mach-ixp4xx/nslu2-setup.c b/arch/arm/mach-ixp4xx/nslu2-setup.c
index 13afb03b50fa..224717eb8ac2 100644
--- a/arch/arm/mach-ixp4xx/nslu2-setup.c
+++ b/arch/arm/mach-ixp4xx/nslu2-setup.c
@@ -72,9 +72,9 @@ static struct gpiod_lookup_table nslu2_i2c_gpiod_table = {
 	.dev_id		= "i2c-gpio",
 	.table		= {
 		GPIO_LOOKUP_IDX("IXP4XX_GPIO_CHIP", NSLU2_SDA_PIN,
-				NULL, 0, GPIO_ACTIVE_HIGH),
+				NULL, 0, GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
 		GPIO_LOOKUP_IDX("IXP4XX_GPIO_CHIP", NSLU2_SCL_PIN,
-				NULL, 1, GPIO_ACTIVE_HIGH),
+				NULL, 1, GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
 	},
 };
 
diff --git a/arch/arm/mach-ks8695/board-acs5k.c b/arch/arm/mach-ks8695/board-acs5k.c
index f034724e01e1..937eb1d47e7b 100644
--- a/arch/arm/mach-ks8695/board-acs5k.c
+++ b/arch/arm/mach-ks8695/board-acs5k.c
@@ -41,8 +41,10 @@
 static struct gpiod_lookup_table acs5k_i2c_gpiod_table = {
 	.dev_id		= "i2c-gpio",
 	.table		= {
-		GPIO_LOOKUP_IDX("KS8695", 4, NULL, 0, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("KS8695", 5, NULL, 1, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("KS8695", 4, NULL, 0,
+				GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
+		GPIO_LOOKUP_IDX("KS8695", 5, NULL, 1,
+				GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
 	},
 };
 
diff --git a/arch/arm/mach-pxa/palmz72.c b/arch/arm/mach-pxa/palmz72.c
index 94f75632c007..5877e547cecd 100644
--- a/arch/arm/mach-pxa/palmz72.c
+++ b/arch/arm/mach-pxa/palmz72.c
@@ -324,8 +324,10 @@ static struct soc_camera_link palmz72_iclink = {
 static struct gpiod_lookup_table palmz72_i2c_gpiod_table = {
 	.dev_id		= "i2c-gpio",
 	.table		= {
-		GPIO_LOOKUP_IDX("gpio-pxa", 118, NULL, 0, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("gpio-pxa", 117, NULL, 1, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("gpio-pxa", 118, NULL, 0,
+				GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
+		GPIO_LOOKUP_IDX("gpio-pxa", 117, NULL, 1,
+				GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
 	},
 };
 
diff --git a/arch/arm/mach-pxa/viper.c b/arch/arm/mach-pxa/viper.c
index a680742bee2b..4185e7ff073f 100644
--- a/arch/arm/mach-pxa/viper.c
+++ b/arch/arm/mach-pxa/viper.c
@@ -463,9 +463,9 @@ static struct gpiod_lookup_table viper_i2c_gpiod_table = {
 	.dev_id		= "i2c-gpio",
 	.table		= {
 		GPIO_LOOKUP_IDX("gpio-pxa", VIPER_RTC_I2C_SDA_GPIO,
-				NULL, 0, GPIO_ACTIVE_HIGH),
+				NULL, 0, GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
 		GPIO_LOOKUP_IDX("gpio-pxa", VIPER_RTC_I2C_SCL_GPIO,
-				NULL, 1, GPIO_ACTIVE_HIGH),
+				NULL, 1, GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
 	},
 };
 
@@ -792,9 +792,9 @@ struct gpiod_lookup_table viper_tpm_i2c_gpiod_table = {
 	.dev_id = "i2c-gpio",
 	.table = {
 		GPIO_LOOKUP_IDX("gpio-pxa", VIPER_TPM_I2C_SDA_GPIO,
-				NULL, 0, GPIO_ACTIVE_HIGH),
+				NULL, 0, GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
 		GPIO_LOOKUP_IDX("gpio-pxa", VIPER_TPM_I2C_SCL_GPIO,
-				NULL, 1, GPIO_ACTIVE_HIGH),
+				NULL, 1, GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
 	},
 };
 
diff --git a/arch/arm/mach-sa1100/simpad.c b/arch/arm/mach-sa1100/simpad.c
index c6e7e6d8733a..91526024964b 100644
--- a/arch/arm/mach-sa1100/simpad.c
+++ b/arch/arm/mach-sa1100/simpad.c
@@ -327,8 +327,10 @@ static struct platform_device simpad_gpio_leds = {
 static struct gpiod_lookup_table simpad_i2c_gpiod_table = {
 	.dev_id = "i2c-gpio",
 	.table = {
-		GPIO_LOOKUP_IDX("gpio", GPIO_GPIO21, NULL, 0, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("gpio", GPIO_GPIO25, NULL, 1, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("gpio", GPIO_GPIO21, NULL, 0,
+				GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
+		GPIO_LOOKUP_IDX("gpio", GPIO_GPIO25, NULL, 1,
+				GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
 	},
 };
 
diff --git a/arch/blackfin/mach-bf533/boards/blackstamp.c b/arch/blackfin/mach-bf533/boards/blackstamp.c
index d801ca5ca6c4..fab69c736515 100644
--- a/arch/blackfin/mach-bf533/boards/blackstamp.c
+++ b/arch/blackfin/mach-bf533/boards/blackstamp.c
@@ -367,9 +367,9 @@ static struct gpiod_lookup_table bfin_i2c_gpiod_table = {
 	.dev_id = "i2c-gpio",
 	.table = {
 		GPIO_LOOKUP_IDX("BFIN-GPIO", GPIO_PF8, NULL, 0,
-				GPIO_ACTIVE_HIGH),
+				GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
 		GPIO_LOOKUP_IDX("BFIN-GPIO", GPIO_PF9, NULL, 1,
-				GPIO_ACTIVE_HIGH),
+				GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
 	},
 };
 
diff --git a/arch/blackfin/mach-bf533/boards/ezkit.c b/arch/blackfin/mach-bf533/boards/ezkit.c
index 463a72358b0e..d64d270e9e62 100644
--- a/arch/blackfin/mach-bf533/boards/ezkit.c
+++ b/arch/blackfin/mach-bf533/boards/ezkit.c
@@ -395,9 +395,9 @@ static struct gpiod_lookup_table bfin_i2c_gpiod_table = {
 	.dev_id = "i2c-gpio",
 	.table = {
 		GPIO_LOOKUP_IDX("BFIN-GPIO", GPIO_PF1, NULL, 0,
-				GPIO_ACTIVE_HIGH),
+				GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
 		GPIO_LOOKUP_IDX("BFIN-GPIO", GPIO_PF0, NULL, 1,
-				GPIO_ACTIVE_HIGH),
+				GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
 	},
 };
 
diff --git a/arch/blackfin/mach-bf533/boards/stamp.c b/arch/blackfin/mach-bf533/boards/stamp.c
index d2479359adb7..27cbf2fa2c62 100644
--- a/arch/blackfin/mach-bf533/boards/stamp.c
+++ b/arch/blackfin/mach-bf533/boards/stamp.c
@@ -517,9 +517,9 @@ static struct gpiod_lookup_table bfin_i2c_gpiod_table = {
 	.dev_id = "i2c-gpio",
 	.table = {
 		GPIO_LOOKUP_IDX("BFIN-GPIO", GPIO_PF2, NULL, 0,
-				GPIO_ACTIVE_HIGH),
+				GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
 		GPIO_LOOKUP_IDX("BFIN-GPIO", GPIO_PF3, NULL, 1,
-				GPIO_ACTIVE_HIGH),
+				GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
 	},
 };
 
diff --git a/arch/blackfin/mach-bf561/boards/ezkit.c b/arch/blackfin/mach-bf561/boards/ezkit.c
index 72f757ebaa84..acc5363f60c6 100644
--- a/arch/blackfin/mach-bf561/boards/ezkit.c
+++ b/arch/blackfin/mach-bf561/boards/ezkit.c
@@ -384,9 +384,9 @@ static struct gpiod_lookup_table bfin_i2c_gpiod_table = {
 	.dev_id = "i2c-gpio",
 	.table = {
 		GPIO_LOOKUP_IDX("BFIN-GPIO", GPIO_PF1, NULL, 0,
-				GPIO_ACTIVE_HIGH),
+				GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
 		GPIO_LOOKUP_IDX("BFIN-GPIO", GPIO_PF0, NULL, 1,
-				GPIO_ACTIVE_HIGH),
+				GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
 	},
 };
 
diff --git a/arch/mips/alchemy/board-gpr.c b/arch/mips/alchemy/board-gpr.c
index daebc36e5ecb..328d697e72b4 100644
--- a/arch/mips/alchemy/board-gpr.c
+++ b/arch/mips/alchemy/board-gpr.c
@@ -235,6 +235,10 @@ static struct gpiod_lookup_table gpr_i2c_gpiod_table = {
 };
 
 static struct i2c_gpio_platform_data gpr_i2c_data = {
+	/*
+	 * The open drain mode is hardwired somewhere or an electrical
+	 * property of the alchemy GPIO controller.
+	 */
 	.sda_is_open_drain	= 1,
 	.scl_is_open_drain	= 1,
 	.udelay			= 2,		/* ~100 kHz */
diff --git a/arch/mips/ath79/mach-pb44.c b/arch/mips/ath79/mach-pb44.c
index a95409063847..6b2c6f3baefa 100644
--- a/arch/mips/ath79/mach-pb44.c
+++ b/arch/mips/ath79/mach-pb44.c
@@ -37,9 +37,9 @@ static struct gpiod_lookup_table pb44_i2c_gpiod_table = {
 	.dev_id = "i2c-gpio",
 	.table = {
 		GPIO_LOOKUP_IDX("ath79-gpio", PB44_GPIO_I2C_SDA,
-				NULL, 0, GPIO_ACTIVE_HIGH),
+				NULL, 0, GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
 		GPIO_LOOKUP_IDX("ath79-gpio", PB44_GPIO_I2C_SCL,
-				NULL, 1, GPIO_ACTIVE_HIGH),
+				NULL, 1, GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
 	},
 };
 
diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
index 4d40d013a412..ad774161a22d 100644
--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -1152,7 +1152,7 @@ static int sm501_register_gpio_i2c_instance(struct sm501_devdata *sm,
 	lookup->table[0].chip_hwnum = iic->pin_sda % 32;
 	lookup->table[0].con_id = NULL;
 	lookup->table[0].idx = 0;
-	lookup->table[0].flags = GPIO_ACTIVE_HIGH;
+	lookup->table[0].flags = GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN;
 	if (iic->pin_scl < 32)
 		lookup->table[1].chip_label = "SM501-LOW";
 	else
@@ -1160,7 +1160,7 @@ static int sm501_register_gpio_i2c_instance(struct sm501_devdata *sm,
 	lookup->table[1].chip_hwnum = iic->pin_scl % 32;
 	lookup->table[1].con_id = NULL;
 	lookup->table[1].idx = 1;
-	lookup->table[1].flags = GPIO_ACTIVE_HIGH;
+	lookup->table[1].flags = GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN;
 	gpiod_add_lookup_table(lookup);
 
 	icd = dev_get_platdata(&pdev->dev);
-- 
2.13.5
