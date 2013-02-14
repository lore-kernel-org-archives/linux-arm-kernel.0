From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Feb 2013 14:49:24 +0100
Subject: [PATCH 08/11] ARM: pick Versatile by default for !MMU
In-Reply-To: <1360849767-1463135-1-git-send-email-arnd@arndb.de>
References: <1360849767-1463135-1-git-send-email-arnd@arndb.de>
Message-ID: <1360849767-1463135-9-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The introduction of ARCH_MULTIPLATFORM changed
the default for nommu kernels from Versatile to
Integrator, which is less common, and does not
currently build for allnoconfig because that does
not select any of the CPUs.

This also ensures that at least one of the three
board files in versatile are enabled, which lets
us successfully build an allnoconfig kernel.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/Kconfig                | 3 ++-
 arch/arm/mach-versatile/Kconfig | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 91d4aea..b934d90 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -261,7 +261,8 @@ config MMU
 #
 choice
 	prompt "ARM system type"
-	default ARCH_MULTIPLATFORM
+	default ARCH_VERSATILE if !MMU
+	default ARCH_MULTIPLATFORM if MMU
 
 config ARCH_MULTIPLATFORM
 	bool "Allow multiple platforms to be selected"
diff --git a/arch/arm/mach-versatile/Kconfig b/arch/arm/mach-versatile/Kconfig
index 63d8e9f..1dba368 100644
--- a/arch/arm/mach-versatile/Kconfig
+++ b/arch/arm/mach-versatile/Kconfig
@@ -25,4 +25,9 @@ config MACH_VERSATILE_DT
 	  Include support for the ARM(R) Versatile/PB platform,
 	  using the device tree for discovery
 
+config MACH_VERSATILE_AUTO
+	def_bool y
+	depends on !ARCH_VERSATILE_PB && !MACH_VERSATILE_AB
+	select MACH_VERSATILE_DT
+
 endmenu
-- 
1.8.1.2
