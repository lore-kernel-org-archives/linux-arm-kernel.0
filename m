From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 10 Dec 2015 14:19:20 +0100
Subject: [PATCH] ARM: davinci: only select WT cache if cache is enabled
Message-ID: <2043568.VG8xo4jr1Z@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DA830 chip only works if the dcache is in writethrough mode,
but that produces a harmless Kconfig warning if the cache happens
to be disabled:

warning: (ARCH_DAVINCI_DA830) selects CPU_DCACHE_WRITETHROUGH which has unmet direct dependencies ((CPU_ARM740T || CPU_ARM920T || CPU_ARM922T || CPU_ARM925T || CPU_ARM926T || CPU_ARM940T || CPU_ARM946E || CPU_ARM1020 || CPU_FA526) && !CPU_DCACHE_DISABLE)

This makes the select conditional so we don't have to worry
about the warning in randconfig builds any more.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---

diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
index 88233824d1fe..83e0f40f9ff1 100644
--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -34,7 +34,8 @@ config ARCH_DAVINCI_DA830
 	bool "DA830/OMAP-L137/AM17x based system"
 	depends on !ARCH_DAVINCI_DMx || AUTO_ZRELADDR
 	select ARCH_DAVINCI_DA8XX
-	select CPU_DCACHE_WRITETHROUGH # needed on silicon revs 1.0, 1.1
+	# needed on silicon revs 1.0, 1.1:
+	select CPU_DCACHE_WRITETHROUGH if !CPU_DCACHE_DISABLE
 	select CP_INTC
 
 config ARCH_DAVINCI_DA850
