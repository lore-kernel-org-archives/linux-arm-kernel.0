From: marek.behun@nic.cz (=?UTF-8?q?Marek=20Beh=C3=BAn?=)
Date: Wed,  8 Aug 2018 17:27:00 +0200
Subject: [PATCH v1 1/7] From: Ken Ma <make@marvell.com>
In-Reply-To: <20180808152706.21727-1-marek.behun@nic.cz>
References: <20180808152706.21727-1-marek.behun@nic.cz>
Message-ID: <20180808152706.21727-2-marek.behun@nic.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pinctrl: armada-37xx: Correct mpp definitions

This patch corrects below mpp definitions:
 - The sdio_sb group is composed of 6 pins and not 5;
 - The rgmii group contains pins mpp2[17:6] and not mpp2[19:6];
 - Pin of group "pmic0" is mpp1[6] but not mpp1[16];
 - Pin of group "pmic1" is mpp1[7] but not mpp1[17];
 - A new group "smi" is added in A0 with 2 pins - mpp2[19:18], its
   bitmask is bit4;
 - Group "pcie1" has 3 pins in A0 - mpp2[5:3], its bit mask is
   bit5 | bit9 | bit10 but not bit4;
 - Group "ptp" has 3 pins in A0 as Z1, but its bitmask is changed to
   bit11 | bit12 | bit13.

Signed-off-by: Marek Behun <marek.behun@nic.cz>

diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
index 53cf800688e9..95abadee8542 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
@@ -157,8 +157,8 @@ static struct armada_37xx_pin_group armada_37xx_nb_groups[] = {
 	PIN_GRP_GPIO("pwm1", 12, 1, BIT(4), "pwm"),
 	PIN_GRP_GPIO("pwm2", 13, 1, BIT(5), "pwm"),
 	PIN_GRP_GPIO("pwm3", 14, 1, BIT(6), "pwm"),
-	PIN_GRP_GPIO("pmic1", 17, 1, BIT(7), "pmic"),
-	PIN_GRP_GPIO("pmic0", 16, 1, BIT(8), "pmic"),
+	PIN_GRP_GPIO("pmic1", 7, 1, BIT(7), "pmic"),
+	PIN_GRP_GPIO("pmic0", 6, 1, BIT(8), "pmic"),
 	PIN_GRP_GPIO("i2c2", 2, 2, BIT(9), "i2c"),
 	PIN_GRP_GPIO("i2c1", 0, 2, BIT(10), "i2c"),
 	PIN_GRP_GPIO("spi_cs1", 17, 1, BIT(12), "spi"),
@@ -182,8 +182,9 @@ static struct armada_37xx_pin_group armada_37xx_sb_groups[] = {
 	PIN_GRP_GPIO("usb2_drvvbus1", 1, 1, BIT(1), "drvbus"),
 	PIN_GRP_GPIO("sdio_sb", 24, 6, BIT(2), "sdio"),
 	PIN_GRP_GPIO("rgmii", 6, 12, BIT(3), "mii"),
-	PIN_GRP_GPIO("pcie1", 3, 2, BIT(4), "pcie"),
-	PIN_GRP_GPIO("ptp", 20, 3, BIT(5), "ptp"),
+	PIN_GRP_GPIO("smi", 18, 2, BIT(4), "smi"),
+	PIN_GRP_GPIO("pcie1", 3, 3, BIT(5) | BIT(9) | BIT(10), "pcie"),
+	PIN_GRP_GPIO("ptp", 20, 3, BIT(11) | BIT(12) | BIT(13), "ptp"),
 	PIN_GRP("ptp_clk", 21, 1, BIT(6), "ptp", "mii"),
 	PIN_GRP("ptp_trig", 22, 1, BIT(7), "ptp", "mii"),
 	PIN_GRP_GPIO_3("mii_col", 23, 1, BIT(8) | BIT(14), 0, BIT(8), BIT(14),
-- 
2.16.4
