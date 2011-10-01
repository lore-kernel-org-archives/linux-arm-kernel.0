From: arnd@arndb.de (Arnd Bergmann)
Date: Sat,  1 Oct 2011 22:03:49 +0200
Subject: [PATCH 17/26] ARM: pxa: pxa95x is incompatible with earlier pxa
In-Reply-To: <1317499438-14058-1-git-send-email-arnd@arndb.de>
References: <1317499438-14058-1-git-send-email-arnd@arndb.de>
Message-ID: <1317499438-14058-18-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We cannot support ARMv5 and ARMv7 based boards in a single kernel,
so introduce a new option in mach-pxa to select between the two.

The PJ4 (ARMv7) based boards are now only visible when
CONFIG_ARCH_PXA_V7 is set, the other boards are only visible
when it's not set.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/Kconfig |   31 ++++++++++++++++++++++---------
 1 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index cd19309..bb310d0 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -2,6 +2,27 @@ if ARCH_PXA
 
 menu "Intel PXA2xx/PXA3xx Implementations"
 
+config ARCH_PXA_V7
+	bool "ARMv7 (PXA95x) based systems"
+
+if ARCH_PXA_V7
+comment "Marvell Dev Platforms (sorted by hardware release time)"
+config MACH_TAVOREVB3
+	bool "PXA95x Development Platform (aka TavorEVB III)"
+	select CPU_PXA955
+
+config MACH_SAARB
+	bool "PXA955 Handheld Platform (aka SAARB)"
+	select CPU_PXA955
+endif
+
+config PXA_V7_MACH_AUTO
+	def_bool y
+	depends on ARCH_PXA_V7
+	depends on !MACH_SAARB
+	select MACH_TAVOREVB3
+
+if !ARCH_PXA_V7
 comment "Intel/Marvell Dev Platforms (sorted by hardware release time)"
 
 config ARCH_LUBBOCK
@@ -41,19 +62,11 @@ config MACH_TAVOREVB
 	select PXA3xx
 	select CPU_PXA930
 
-config MACH_TAVOREVB3
-	bool "PXA95x Development Platform (aka TavorEVB III)"
-	select CPU_PXA950
-
 config MACH_SAAR
 	bool "PXA930 Handheld Platform (aka SAAR)"
 	select PXA3xx
 	select CPU_PXA930
 
-config MACH_SAARB
-	bool "PXA955 Handheld Platform (aka SAARB)"
-	select CPU_PXA955
-
 comment "Third Party Dev Platforms (sorted by vendor name)"
 
 config ARCH_PXA_IDP
@@ -598,7 +611,7 @@ config MACH_ZIPIT2
 	bool "Zipit Z2 Handheld"
 	select PXA27x
 	select HAVE_PWM
-
+endif
 endmenu
 
 config PXA25x
-- 
1.7.5.4
