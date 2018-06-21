From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 21 Jun 2018 17:59:06 +0200
Subject: [PATCH] [RFC] arm: Replace "multiple platforms" by "common platform"
Message-ID: <20180621155906.12821-1-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"ARM multiplatform" has actually two meanings:
? 1. It groups platforms that follow the "ARM multiplatform" software
     framework,
? 2. It allows to build a single kernel that can be booted on multiple
? ? ?platforms.

Currently support for XIP and/or NOMMU cannot be enabled on platforms
that follow the "ARM multiplatform" framework, without duplicating their
machine selection logic under a new Kconfig symbol.  As (in theory) all
platforms can be used with XIP and/or NOMMU, this is not sustainable.

Hence clarify the meaning of ARCH_MULTIPLATFORM:
  1. Replace "multiple platforms" by "common platform", as it allows to
     select one or more platforms adhering to the common framework,
  2. Note that a single kernel may not boot on all platforms if XIP or
     NOMMU is enabled.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
References:
  - "[PATCHv4 0/4] arm/versatile: no-MMU support"
    (http://lists.infradead.org/pipermail/linux-arm-kernel/2018-June/584555.html)

  - "[PATCH 0/2] ARM: ARMv7 (with MMU) XIP without ARCH_MULTIPLATFORM"
    (http://lists.infradead.org/pipermail/linux-arm-kernel/2017-February/486835.html)

 arch/arm/Kconfig | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 54eeb8d00bc62a9f..6b286c018cf748c7 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -329,7 +329,7 @@ choice
 	default ARCH_MULTIPLATFORM if MMU
 
 config ARCH_MULTIPLATFORM
-	bool "Allow multiple platforms to be selected"
+	bool "Common platforms (\"multiplatform\")"
 	depends on MMU
 	select ARM_HAS_SG_CHAIN
 	select ARM_PATCH_PHYS_VIRT
@@ -342,6 +342,13 @@ config ARCH_MULTIPLATFORM
 	select PCI_DOMAINS if PCI
 	select SPARSE_IRQ
 	select USE_OF
+	help
+	  Support for systems implemented using the common "multiplatform"
+	  framework.
+
+	  Unless specialized options depending on intimate platform
+	  details, like XIP or NOMMU, are enabled, this allows to build a
+	  single kernel that boots on multiple platforms.
 
 config ARM_SINGLE_ARMV7M
 	bool "ARMv7-M based platforms (Cortex-M0/M3/M4)"
-- 
2.17.1
