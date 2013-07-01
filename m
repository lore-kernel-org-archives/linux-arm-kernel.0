From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Mon,  1 Jul 2013 12:03:59 +0100
Subject: [PATCH 01/10] ARM: fix ARCH_IXP4xx usage of ARCH_SUPPORTS_BIG_ENDIAN
In-Reply-To: <1372676648-9254-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1372676648-9254-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1372676648-9254-2-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Kconfig for arch/arm/mach-ixp4xx has a local definition
of ARCH_SUPPORTS_BIG_ENDIAN which could be used elsewhere.
This means that if IXP4xx is selected and this symbol is
selected eleswhere then an warning is produced.

Clean the following error up by making the symbol be
selected by the main ARCH_IXP4XX definition and have a
common definition in arch/arm/mm/Kconfig

warning: (ARCH_xxx) selects ARCH_SUPPORTS_BIG_ENDIAN which has unmet direct dependencies (ARCH_IXP4XX)
warning: (ARCH_xxx) selects ARCH_SUPPORTS_BIG_ENDIAN which has unmet direct dependencies (ARCH_IXP4XX)

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/Kconfig             |    1 +
 arch/arm/mach-ixp4xx/Kconfig |    4 ----
 arch/arm/mm/Kconfig          |    6 ++++++
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 136f263..0e60b0e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -474,6 +474,7 @@ config ARCH_IXP4XX
 	bool "IXP4xx-based"
 	depends on MMU
 	select ARCH_HAS_DMA_SET_COHERENT_MASK
+	select ARCH_SUPPORTS_BIG_ENDIAN
 	select ARCH_REQUIRE_GPIOLIB
 	select CLKSRC_MMIO
 	select CPU_XSCALE
diff --git a/arch/arm/mach-ixp4xx/Kconfig b/arch/arm/mach-ixp4xx/Kconfig
index 73a2d90..72de05f 100644
--- a/arch/arm/mach-ixp4xx/Kconfig
+++ b/arch/arm/mach-ixp4xx/Kconfig
@@ -1,9 +1,5 @@
 if ARCH_IXP4XX
 
-config ARCH_SUPPORTS_BIG_ENDIAN
-	bool
-	default y
-
 menu "Intel IXP4xx Implementation Options"
 
 comment "IXP4xx Platforms"
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 35955b5..b83782e 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -895,3 +895,9 @@ config ARCH_HAS_BARRIERS
 	help
 	  This option allows the use of custom mandatory barriers
 	  included via the mach/barriers.h file.
+
+config ARCH_SUPPORTS_BIG_ENDIAN
+	bool
+	help
+	  This option specifies the architecture can support big endian
+	  operation.
-- 
1.7.10.4
