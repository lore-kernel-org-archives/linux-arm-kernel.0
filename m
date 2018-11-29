From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 29 Nov 2018 12:09:31 +0100
Subject: [PATCH 2/2] ARM: shmobile: R-Mobile: Move pm-rmobile to
 drivers/soc/renesas/
In-Reply-To: <20181129110931.11783-1-geert+renesas@glider.be>
References: <20181129110931.11783-1-geert+renesas@glider.be>
Message-ID: <20181129110931.11783-3-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pm-rmobile driver is really a driver for the System Controller
(SYSC) found in R-Mobile SoCs.  An equivalent driver for R-Car SoCs is
already located under drivers/soc/renesas/.

Hence move the pm-rmobile driver from arch/arm/mach-shmobile/ to
drivers/soc/renesas/, and rename it to rmobile-sysc.

Enable compile-testing on non-ARM and non-R-Mobile SoCs.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/Kconfig                             | 5 -----
 arch/arm/mach-shmobile/Makefile                            | 1 -
 drivers/soc/renesas/Kconfig                                | 7 ++++++-
 drivers/soc/renesas/Makefile                               | 1 +
 .../pm-rmobile.c => drivers/soc/renesas/rmobile-sysc.c     | 0
 5 files changed, 7 insertions(+), 7 deletions(-)
 rename arch/arm/mach-shmobile/pm-rmobile.c => drivers/soc/renesas/rmobile-sysc.c (100%)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 9b798c9dffe4e94a..3683d6f109730ee7 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -1,9 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-config PM_RMOBILE
-	bool
-	select PM
-	select PM_GENERIC_DOMAINS
-
 menuconfig ARCH_RENESAS
 	bool "Renesas ARM SoCs"
 	depends on ARCH_MULTI_V7 && MMU
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 5591646cb9bbfd33..f7bf17b7abaef7a9 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -35,7 +35,6 @@ smp-$(CONFIG_ARCH_EMEV2)	+= smp-emev2.o headsmp-scu.o platsmp-scu.o
 
 # PM objects
 obj-$(CONFIG_SUSPEND)		+= suspend.o
-obj-$(CONFIG_PM_RMOBILE)	+= pm-rmobile.o
 obj-$(CONFIG_ARCH_RCAR_GEN2)	+= pm-rcar-gen2.o
 
 # Framework support
diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index fe7f58616cdd6cf7..4d8012e1205c5a7f 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -34,9 +34,11 @@ config ARCH_RCAR_GEN3
 
 config ARCH_RMOBILE
 	bool
-	select PM_RMOBILE
+	select PM
+	select PM_GENERIC_DOMAINS
 	select SYS_SUPPORTS_SH_CMT
 	select SYS_SUPPORTS_SH_TMU
+	select SYSC_RMOBILE
 
 config ARCH_RZN1
 	bool
@@ -297,4 +299,7 @@ config RST_RCAR
 config SYSC_RCAR
 	bool "R-Car System Controller support" if COMPILE_TEST
 
+config SYSC_RMOBILE
+	bool "R-Mobile System Controller support" if COMPILE_TEST
+
 endif # SOC_RENESAS
diff --git a/drivers/soc/renesas/Makefile b/drivers/soc/renesas/Makefile
index 3bdd7dbc38a9c7a3..00764d5a60b33dfe 100644
--- a/drivers/soc/renesas/Makefile
+++ b/drivers/soc/renesas/Makefile
@@ -27,3 +27,4 @@ endif
 # Family
 obj-$(CONFIG_RST_RCAR)		+= rcar-rst.o
 obj-$(CONFIG_SYSC_RCAR)		+= rcar-sysc.o
+obj-$(CONFIG_SYSC_RMOBILE)	+= rmobile-sysc.o
diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/drivers/soc/renesas/rmobile-sysc.c
similarity index 100%
rename from arch/arm/mach-shmobile/pm-rmobile.c
rename to drivers/soc/renesas/rmobile-sysc.c
-- 
2.17.1
