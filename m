From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu,  6 May 2010 16:23:54 -0700
Subject: [PATCH 03/34] davinci: da830/omap-l137 evm: add support for GPIO
	based MMC/SD card detection
In-Reply-To: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
References: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1273188265-12782-4-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vipin Bhandari <vipin.bhandari@ti.com>

The DA830/OMAP-L137 EVM has GPIO based card detection logic, but the current
code does not use it.

Add support for GPIO based card detection to avoid reading the card to see
if a card is present or not.

Signed-off-by: Vipin Bhandari <vipin.bhandari@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/board-da830-evm.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index dc19870..8e67037 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -229,14 +229,21 @@ static const short da830_evm_mmc_sd_pins[] = {
 };
 
 #define DA830_MMCSD_WP_PIN		GPIO_TO_PIN(2, 1)
+#define DA830_MMCSD_CD_PIN		GPIO_TO_PIN(2, 2)
 
 static int da830_evm_mmc_get_ro(int index)
 {
 	return gpio_get_value(DA830_MMCSD_WP_PIN);
 }
 
+static int da830_evm_mmc_get_cd(int index)
+{
+	return !gpio_get_value(DA830_MMCSD_CD_PIN);
+}
+
 static struct davinci_mmc_config da830_evm_mmc_config = {
 	.get_ro			= da830_evm_mmc_get_ro,
+	.get_cd			= da830_evm_mmc_get_cd,
 	.wires			= 4,
 	.max_freq		= 50000000,
 	.caps			= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED,
@@ -262,6 +269,14 @@ static inline void da830_evm_init_mmc(void)
 	}
 	gpio_direction_input(DA830_MMCSD_WP_PIN);
 
+	ret = gpio_request(DA830_MMCSD_CD_PIN, "MMC CD\n");
+	if (ret) {
+		pr_warning("da830_evm_init: can not open GPIO %d\n",
+			   DA830_MMCSD_CD_PIN);
+		return;
+	}
+	gpio_direction_input(DA830_MMCSD_CD_PIN);
+
 	ret = da8xx_register_mmcsd0(&da830_evm_mmc_config);
 	if (ret) {
 		pr_warning("da830_evm_init: mmc/sd registration failed: %d\n",
-- 
1.7.0.2
