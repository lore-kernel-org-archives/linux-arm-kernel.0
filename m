From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue, 04 Oct 2011 12:58:32 +0530
Subject: [PATCH 0/3] mmc: sdhci-s3c: Remove 'clk_type' member from platform
	data
Message-ID: <1317713315-5830-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset removes all uses of 'clk_type' member from the platform data
of sdhci-s3c driver. The clk_type is a SoC specific information and not a board/
machine specific information. Hence, this information can be more aptly
represented using SoC specific driver data in the sdhci-s3c driver.

Hence all uses of 'clk_type' member in sdhci-s3c driver's platform data is
removed. In place of that, the sdhci host qurik 'SDHCI_QUIRK_NONSTANDARD_CLOCK'
is used to handle controllers that do not have a standard sdclk division
(like those in the exynos4 SoC's).

This is a pre-requisite patchset for adding device tree support for sdhci-s3c
driver. While migrating towards device tree support, retreving 'clk_type'
information does not seem correct and hence it has been added as SoC specific
driver data.

This patchset is based on the following tree
https://github.com/kgene/linux-samsung.git  branch: for-next

and tested on smdkv310, smdkv210 and smdk2416.

Thomas Abraham (3):
  mmc: sdhci-s3c: Remove usage of clk_type member in platform data
  arm: exynos4: use 'exynos4-sdhci' as device name for sdhci controllers
  arm: samsung: remove all uses of clk_type member in sdhci platform data

 arch/arm/mach-exynos4/clock.c               |   16 +++---
 arch/arm/mach-exynos4/cpu.c                 |    5 ++
 arch/arm/mach-exynos4/mach-armlex4210.c     |    3 -
 arch/arm/mach-exynos4/mach-nuri.c           |    3 -
 arch/arm/mach-exynos4/mach-origen.c         |    2 -
 arch/arm/mach-exynos4/mach-smdk4212.c       |    2 -
 arch/arm/mach-exynos4/mach-smdkv310.c       |    4 --
 arch/arm/mach-exynos4/mach-universal_c210.c |    2 -
 arch/arm/plat-samsung/dev-hsmmc.c           |    1 -
 arch/arm/plat-samsung/dev-hsmmc1.c          |    1 -
 arch/arm/plat-samsung/dev-hsmmc2.c          |    1 -
 arch/arm/plat-samsung/dev-hsmmc3.c          |    1 -
 arch/arm/plat-samsung/include/plat/sdhci.h  |   34 ++++++++++---
 arch/arm/plat-samsung/platformdata.c        |    2 -
 drivers/mmc/host/sdhci-s3c.c                |   74 +++++++++++++++++++++++++--
 15 files changed, 110 insertions(+), 41 deletions(-)
