From: arnd@arndb.de (Arnd Bergmann)
Date: Mon,  1 Feb 2016 21:35:57 +0100
Subject: [PATCH 3/4] ARM: davinci: DA8xx+DMx combined kernels need
 PATCH_PHYS_VIRT
In-Reply-To: <1454358962-640598-1-git-send-email-arnd@arndb.de>
References: <1454358962-640598-1-git-send-email-arnd@arndb.de>
Message-ID: <1454358962-640598-4-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We already forbid that combination when AUTO_ZRELADDR is disabled,
for the same reason that the two have their RAM at different
physical addresses as seen from the CPU.

This does the same change for PATCH_PHYS_VIRT: if you disable
either of the options, Kconfig now enforces that you have to
pick one or the other SoC family.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig              | 1 +
 arch/arm/mach-davinci/Kconfig | 6 ++----
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 21d79b2531cc..8b10ccf4077e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -612,6 +612,7 @@ config ARCH_DAVINCI
 	select ARCH_HAS_HOLES_MEMORYMODEL
 	select ARCH_REQUIRE_GPIOLIB
 	select CLKDEV_LOOKUP
+	select CPU_ARM926T
 	select GENERIC_ALLOCATOR
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_IRQ_CHIP
diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
index 6124c69154c3..8f54be83ec15 100644
--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -9,7 +9,6 @@ config CP_INTC
 
 config ARCH_DAVINCI_DMx
 	bool
-	select CPU_ARM926T
 
 menu "TI DaVinci Implementations"
 
@@ -32,7 +31,7 @@ config ARCH_DAVINCI_DM646x
 
 config ARCH_DAVINCI_DA830
 	bool "DA830/OMAP-L137/AM17x based system"
-	depends on !ARCH_DAVINCI_DMx || AUTO_ZRELADDR
+	depends on !ARCH_DAVINCI_DMx || (AUTO_ZRELADDR && ARM_PATCH_PHYS_VIRT)
 	select ARCH_DAVINCI_DA8XX
 	# needed on silicon revs 1.0, 1.1:
 	select CPU_DCACHE_WRITETHROUGH if !CPU_DCACHE_DISABLE
@@ -40,13 +39,12 @@ config ARCH_DAVINCI_DA830
 
 config ARCH_DAVINCI_DA850
 	bool "DA850/OMAP-L138/AM18x based system"
-	depends on !ARCH_DAVINCI_DMx || AUTO_ZRELADDR
+	depends on !ARCH_DAVINCI_DMx || (AUTO_ZRELADDR && ARM_PATCH_PHYS_VIRT)
 	select ARCH_DAVINCI_DA8XX
 	select CP_INTC
 
 config ARCH_DAVINCI_DA8XX
 	bool
-	select CPU_ARM926T
 
 config ARCH_DAVINCI_DM365
 	bool "DaVinci 365 based system"
-- 
2.7.0
