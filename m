From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Wed, 19 Jul 2017 14:42:32 +0300
Subject: [PATCH v3 8/8] staging: fsl-mc: allow the driver compile multi-arch
In-Reply-To: <20170719114232.8347-1-laurentiu.tudor@nxp.com>
References: <20170719114232.8347-1-laurentiu.tudor@nxp.com>
Message-ID: <20170719114232.8347-9-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Add an alternate dependency on COMPILE_TEST, thus leaving
this driver compile on other architectures.
Also, other drivers depending on the bus are updated to depend
on ARCH_LAYERSCAPE until they'll also be made multi-arch.
This was compiled tested on:
 - booke powerpc (corenet{32,64}_smp_defconfig)
 - x86 (i386_defconfig, x86_64_defconfig, needs CONFIG_OF)
 - arm64 (defconfig)

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
Notes:
    -v3
      -add COMPILE_TEST instead of dropping ARCH_LAYERSCAPE
    -v2
      -no changes

 drivers/staging/fsl-dpaa2/Kconfig  | 2 +-
 drivers/staging/fsl-mc/bus/Kconfig | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/Kconfig b/drivers/staging/fsl-dpaa2/Kconfig
index 730fd6d..dfff675 100644
--- a/drivers/staging/fsl-dpaa2/Kconfig
+++ b/drivers/staging/fsl-dpaa2/Kconfig
@@ -4,7 +4,7 @@
 
 config FSL_DPAA2
 	bool "Freescale DPAA2 devices"
-	depends on FSL_MC_BUS
+	depends on FSL_MC_BUS && ARCH_LAYERSCAPE
 	---help---
 	  Build drivers for Freescale DataPath Acceleration
 	  Architecture (DPAA2) family of SoCs.
diff --git a/drivers/staging/fsl-mc/bus/Kconfig b/drivers/staging/fsl-mc/bus/Kconfig
index a10aaf0..1af8d1d 100644
--- a/drivers/staging/fsl-mc/bus/Kconfig
+++ b/drivers/staging/fsl-mc/bus/Kconfig
@@ -8,7 +8,7 @@
 
 config FSL_MC_BUS
 	bool "QorIQ DPAA2 fsl-mc bus driver"
-	depends on OF && ARCH_LAYERSCAPE
+	depends on OF && (ARCH_LAYERSCAPE || COMPILE_TEST)
 	select GENERIC_MSI_IRQ_DOMAIN
 	help
 	  Driver to enable the bus infrastructure for the QorIQ DPAA2
@@ -18,7 +18,7 @@ config FSL_MC_BUS
 
 config FSL_MC_DPIO
         tristate "QorIQ DPAA2 DPIO driver"
-        depends on FSL_MC_BUS
+        depends on FSL_MC_BUS && ARCH_LAYERSCAPE
         help
 	  Driver for the DPAA2 DPIO object.  A DPIO provides queue and
 	  buffer management facilities for software to interact with
-- 
2.9.4
