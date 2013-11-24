From: acourbot@nvidia.com (Alexandre Courbot)
Date: Sun, 24 Nov 2013 15:30:49 +0900
Subject: [PATCH v11 4/7] ARM: tegra: add support for Trusted Foundations
In-Reply-To: <1385274652-16415-1-git-send-email-acourbot@nvidia.com>
References: <1385274652-16415-1-git-send-email-acourbot@nvidia.com>
Message-ID: <1385274652-16415-5-git-send-email-acourbot@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register the firmware operations for Trusted Foundations if the device
tree indicates it is active on the device.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
Reviewed-by: Stephen Warren <swarren@nvidia.com>
---
 Documentation/devicetree/bindings/arm/tegra.txt | 5 +++++
 arch/arm/mach-tegra/Kconfig                     | 1 +
 arch/arm/mach-tegra/tegra.c                     | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/tegra.txt b/Documentation/devicetree/bindings/arm/tegra.txt
index ed9c853..558ed4b 100644
--- a/Documentation/devicetree/bindings/arm/tegra.txt
+++ b/Documentation/devicetree/bindings/arm/tegra.txt
@@ -32,3 +32,8 @@ board-specific compatible values:
   nvidia,whistler
   toradex,colibri_t20-512
   toradex,iris
+
+Trusted Foundations
+-------------------------------------------
+Tegra supports the Trusted Foundation secure monitor. See the
+"tlm,trusted-foundations" binding's documentation for more details.
diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 09e740f..00b85fd 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -2,6 +2,7 @@ config ARCH_TEGRA
 	bool "NVIDIA Tegra" if ARCH_MULTI_V7
 	select ARCH_HAS_CPUFREQ
 	select ARCH_REQUIRE_GPIOLIB
+	select ARCH_SUPPORTS_TRUSTED_FOUNDATIONS
 	select ARM_GIC
 	select CLKSRC_MMIO
 	select CLKSRC_OF
diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index 7336817..09a1f8d 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -40,6 +40,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <asm/setup.h>
+#include <asm/trusted_foundations.h>
 
 #include "apbio.h"
 #include "board.h"
@@ -90,6 +91,7 @@ static void __init tegra_init_cache(void)
 
 static void __init tegra_init_early(void)
 {
+	of_register_trusted_foundations();
 	tegra_apb_io_init();
 	tegra_init_fuse();
 	tegra_cpu_reset_handler_init();
-- 
1.8.4.2
