From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 31 May 2011 15:14:08 -0600
Subject: [PATCH 2/2] ARM: Tegra: Seaboard: Re-order sdhci device registration
In-Reply-To: <1306876448-28147-1-git-send-email-swarren@nvidia.com>
References: <1306876448-28147-1-git-send-email-swarren@nvidia.com>
Message-ID: <1306876448-28147-3-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ensure the built-in eMMC is always named mmcblk0.

This is important because:

* U-Boot statically assigns MMC device IDs based on controller ID.
* U-Boot assumes that kernel MMC device ID numbering matches U-Boot numbering.
* U-Boot provides a kernel cmdline option e.g. root=/dev/mmcblk0p3 based on
  that numbering.
* The kernel dynamically assigns MMC device IDs based on enumeration order of
  the memory behind the host controller, rather than statically based on host
  controller ID like U-Boot.
* By registering the SDHCI controller for the built-in eMMC first, the
  enumeration of the built-in eMMC is performed first, and hence eMMC gets
  assigned ID 0 just like U-Boot. If the SD slot is filled, it then gets
  assigned ID 1 just like U-Boot.
* If the MMC IDs mismatch, and the system boots from SD card not eMMC, the
  kernel will access the eMMC instead of SD card when attempting to mount
  /dev/mmcblk1p3 as the root fs. If eMMC is not partitioned/formatted, the
  kernel will panic since the root fs can't be mounted. If eMMC is partitioned
  and formatted, the kernel will mount an unexpected filesystem as the root fs.

This change relies on the SDHCI driver performing initial card detection
synchronously during device registration. This is currently the case.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/board-seaboard.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/board-seaboard.c b/arch/arm/mach-tegra/board-seaboard.c
index a8d7ace..783de17 100644
--- a/arch/arm/mach-tegra/board-seaboard.c
+++ b/arch/arm/mach-tegra/board-seaboard.c
@@ -137,9 +137,9 @@ static struct tegra_sdhci_platform_data sdhci_pdata4 = {
 static struct platform_device *seaboard_devices[] __initdata = {
 	&debug_uart,
 	&tegra_pmu_device,
-	&tegra_sdhci_device1,
-	&tegra_sdhci_device3,
 	&tegra_sdhci_device4,
+	&tegra_sdhci_device3,
+	&tegra_sdhci_device1,
 	&seaboard_gpio_keys_device,
 };
 
-- 
1.7.0.4
