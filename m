From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 06 Apr 2012 09:43:23 +0200
Subject: [PATCH 1/4] ARM: Exynos4: fix SDHCI support on NURI & UniversalC210
 boards
In-Reply-To: <1333698206-12348-1-git-send-email-m.szyprowski@samsung.com>
References: <1333698206-12348-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1333698206-12348-2-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some patches for s3c-sdhci driver which changed support for Exynos4 SoC
have not been merged to v3.4-rc1, while some of their followups have been
applied to mach-universal.c and mach-nuri.c. This patch reverts that
changes and add missing MMC_CAP2_BROKEN_VOLTAGE capability which got lost
together with s3c-sdhci changes.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/mach-nuri.c           |    5 +++--
 arch/arm/mach-exynos/mach-universal_c210.c |    3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-exynos/mach-nuri.c b/arch/arm/mach-exynos/mach-nuri.c
index b3982c8..b3966f0 100644
--- a/arch/arm/mach-exynos/mach-nuri.c
+++ b/arch/arm/mach-exynos/mach-nuri.c
@@ -112,12 +112,13 @@ static struct s3c_sdhci_platdata nuri_hsmmc0_data __initdata = {
 	.host_caps		= (MMC_CAP_8_BIT_DATA | MMC_CAP_4_BIT_DATA |
 				MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
 				MMC_CAP_ERASE),
+	.host_caps2		= MMC_CAP2_BROKEN_VOLTAGE,
 	.cd_type		= S3C_SDHCI_CD_PERMANENT,
 	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 };
 
 static struct regulator_consumer_supply emmc_supplies[] = {
-	REGULATOR_SUPPLY("vmmc", "exynos4-sdhci.0"),
+	REGULATOR_SUPPLY("vmmc", "s3c-sdhci.0"),
 	REGULATOR_SUPPLY("vmmc", "dw_mmc"),
 };
 
@@ -417,7 +418,7 @@ static struct regulator_consumer_supply __initdata max8997_ldo12_[] = {
 	REGULATOR_SUPPLY("vddio", "6-003c"), /* HDC802 */
 };
 static struct regulator_consumer_supply __initdata max8997_ldo13_[] = {
-	REGULATOR_SUPPLY("vmmc", "exynos4-sdhci.2"), /* TFLASH */
+	REGULATOR_SUPPLY("vmmc", "s3c-sdhci.2"), /* TFLASH */
 };
 static struct regulator_consumer_supply __initdata max8997_ldo14_[] = {
 	REGULATOR_SUPPLY("inmotor", "max8997-haptic"),
diff --git a/arch/arm/mach-exynos/mach-universal_c210.c b/arch/arm/mach-exynos/mach-universal_c210.c
index 6bb9dbd..e10c87f 100644
--- a/arch/arm/mach-exynos/mach-universal_c210.c
+++ b/arch/arm/mach-exynos/mach-universal_c210.c
@@ -746,12 +746,13 @@ static struct s3c_sdhci_platdata universal_hsmmc0_data __initdata = {
 	.max_width		= 8,
 	.host_caps		= (MMC_CAP_8_BIT_DATA | MMC_CAP_4_BIT_DATA |
 				MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED),
+	.host_caps2		= MMC_CAP2_BROKEN_VOLTAGE,
 	.cd_type		= S3C_SDHCI_CD_PERMANENT,
 	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 };
 
 static struct regulator_consumer_supply mmc0_supplies[] = {
-	REGULATOR_SUPPLY("vmmc", "exynos4-sdhci.0"),
+	REGULATOR_SUPPLY("vmmc", "s3c-sdhci.0"),
 };
 
 static struct regulator_init_data mmc0_fixed_voltage_init_data = {
-- 
1.7.1.569.g6f426
