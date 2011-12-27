From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue, 27 Dec 2011 11:42:23 +0530
Subject: [PATCH] ARM: Exynos: Remove duplicated SROMC static memory mapping
Message-ID: <1324966343-7560-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SROMC static memory mapping is included in the common s5p initialization
code. Hence, remove the duplicated SROMC static memory mapping for Exynos.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
This was identified while testing Nicolas Pitre's vmalloc.h removal
patch series for Exynos. The duplicated static memory mapping caused
the detection of overlapped memory region (in vm_area_add_early) which
resulted in boot failure.	

 arch/arm/mach-exynos/cpu.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-exynos/cpu.c b/arch/arm/mach-exynos/cpu.c
index 1213027..574f4b9 100644
--- a/arch/arm/mach-exynos/cpu.c
+++ b/arch/arm/mach-exynos/cpu.c
@@ -118,11 +118,6 @@ static struct map_desc exynos4_iodesc[] __initdata = {
 		.length		= SZ_64K,
 		.type		= MT_DEVICE,
 	}, {
-		.virtual	= (unsigned long)S5P_VA_SROMC,
-		.pfn		= __phys_to_pfn(EXYNOS4_PA_SROMC),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	}, {
 		.virtual	= (unsigned long)S3C_VA_USB_HSPHY,
 		.pfn		= __phys_to_pfn(EXYNOS4_PA_HSPHY),
 		.length		= SZ_4K,
-- 
1.6.6.rc2
