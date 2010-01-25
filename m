From: colin.tuckley@arm.com (Colin Tuckley)
Date: Mon, 25 Jan 2010 12:58:20 +0000
Subject: [PATCH] ARM: RealView SD/MMC Card detection and write-protect using
	GPIOLIB
Message-ID: <20100125125820.5028.29129.stgit@ARM03585.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The switch to using GPIOLIB broke the sd/mmc card detection on the
RealView development boards because ARCH_REQUIRE_GPIOLIB
and GPIO_PL061 were not always selected. Forcing the use of gpiolib also
means that the write-protect detection works.

Signed-off-by: Colin Tuckley <colin.tuckley@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/Kconfig              |    3 ++-
 arch/arm/mach-realview/core.c |   20 --------------------
 2 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 233a222..7303f62 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -232,7 +232,8 @@ config ARCH_REALVIEW
 	select ICST307
 	select GENERIC_TIME
 	select GENERIC_CLOCKEVENTS
-	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select ARCH_REQUIRE_GPIOLIB
+	select GPIO_PL061
 	help
 	  This enables support for ARM Ltd RealView boards.
 
diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index 27e2338..81cf0aa 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -238,34 +238,14 @@ static int __init realview_i2c_init(void)
 }
 arch_initcall(realview_i2c_init);
 
-#define REALVIEW_SYSMCI	(__io_address(REALVIEW_SYS_BASE) + REALVIEW_SYS_MCI_OFFSET)
-
-/*
- * This is only used if GPIOLIB support is disabled
- */
-static unsigned int realview_mmc_status(struct device *dev)
-{
-	struct amba_device *adev = container_of(dev, struct amba_device, dev);
-	u32 mask;
-
-	if (adev->res.start == REALVIEW_MMCI0_BASE)
-		mask = 1;
-	else
-		mask = 2;
-
-	return readl(REALVIEW_SYSMCI) & mask;
-}
-
 struct mmci_platform_data realview_mmc0_plat_data = {
 	.ocr_mask	= MMC_VDD_32_33|MMC_VDD_33_34,
-	.status		= realview_mmc_status,
 	.gpio_wp	= 17,
 	.gpio_cd	= 16,
 };
 
 struct mmci_platform_data realview_mmc1_plat_data = {
 	.ocr_mask	= MMC_VDD_32_33|MMC_VDD_33_34,
-	.status		= realview_mmc_status,
 	.gpio_wp	= 19,
 	.gpio_cd	= 18,
 };
