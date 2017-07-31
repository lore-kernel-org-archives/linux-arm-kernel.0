From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Mon, 31 Jul 2017 16:42:35 +0300
Subject: [PATCH] staging: fsl-mc: add explicit dependencies for compile-tested
 arches
Message-ID: <20170731134235.6529-1-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

The driver makes use of GENERIC_MSI_IRQ_DOMAIN which requires arch
support so, on architectures that don't have it, the kernel will fail
to build. Add explicit dependency on architectures that were
compile-tested, thus fixing compilation for the ones that don't
implement GENERIC_MSI_IRQ_DOMAIN.

Fixes: 03274850279c ("staging: fsl-mc: allow the driver compile multi-arch")

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 - This should take care of the compilation issue that Stephen Rothwell
   reported here: https://lkml.org/lkml/2017/7/31/200
 - Note that ppc will compile after merge with the powerpc tree because
   this patch is required: https://patchwork.ozlabs.org/patch/789474/

 drivers/staging/fsl-mc/bus/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fsl-mc/bus/Kconfig b/drivers/staging/fsl-mc/bus/Kconfig
index 1af8d1d..504c987 100644
--- a/drivers/staging/fsl-mc/bus/Kconfig
+++ b/drivers/staging/fsl-mc/bus/Kconfig
@@ -8,7 +8,7 @@
 
 config FSL_MC_BUS
 	bool "QorIQ DPAA2 fsl-mc bus driver"
-	depends on OF && (ARCH_LAYERSCAPE || COMPILE_TEST)
+	depends on OF && (ARCH_LAYERSCAPE || (COMPILE_TEST && (ARM || ARM64 || X86 || PPC)))
 	select GENERIC_MSI_IRQ_DOMAIN
 	help
 	  Driver to enable the bus infrastructure for the QorIQ DPAA2
-- 
2.9.4
