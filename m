From: colin.tuckley@arm.com (Colin Tuckley)
Date: Tue, 16 Feb 2010 15:31:18 +0000
Subject: [PATCH] ARM: RealView SD/MMC Card detection and write-protect using
	GPIOLIB
Message-ID: <20100216153118.23344.90703.stgit@ARM03585.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The switch to using GPIOLIB broke the sd/mmc card detection on the
RealView development boards if GPIO_PL061 was not selected.
This patch selects GPIO_PL061 if GPIOLIB is selected.
The sense of the return value from mmc_status has also changed
and is corrected.

Signed-off-by: Colin Tuckley <colin.tuckley@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/Kconfig              |    1 +
 arch/arm/mach-realview/core.c |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4c33ca8..a3c0baa 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -235,6 +235,7 @@ config ARCH_REALVIEW
 	select GENERIC_TIME
 	select GENERIC_CLOCKEVENTS
 	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select GPIO_PL061 if GPIOLIB
 	help
 	  This enables support for ARM Ltd RealView boards.
 
diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index 27e2338..06bb649 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -253,7 +253,7 @@ static unsigned int realview_mmc_status(struct device *dev)
 	else
 		mask = 2;
 
-	return readl(REALVIEW_SYSMCI) & mask;
+	return !(readl(REALVIEW_SYSMCI) & mask);
 }
 
 struct mmci_platform_data realview_mmc0_plat_data = {
