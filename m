From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Oct 2015 15:46:08 +0200
Subject: [PATCH] pxa: remove incorrect __init annotation on pxa27x_set_pwrmode
In-Reply-To: <5287252.pkh9x0t1Y6@wuerfel>
References: <5287252.pkh9x0t1Y6@wuerfel>
Message-ID: <11408970.yetkS1BjHr@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The z2 machine calls pxa27x_set_pwrmode() in order to power off
the machine, but this function gets discarded early at boot because
it is marked __init, as pointed out by kbuild:

WARNING: vmlinux.o(.text+0x145c4): Section mismatch in reference from the function z2_power_off() to the function .init.text:pxa27x_set_pwrmode()
The function z2_power_off() references
the function __init pxa27x_set_pwrmode().
This is often because z2_power_off lacks a __init
annotation or the annotation of pxa27x_set_pwrmode is wrong.

This removes the __init section modifier to fix rebooting and the
build error.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: ba4a90a6d86a ("ARM: pxa/z2: fix building error of pxa27x_cpu_suspend() no longer available")
---
This is a fix for an old bug, I'd just put it into 4.4

It showed up now because section mismatches now produce errors instead
of warnings.

diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index 885d83cfa522..3d5335f2bbe0 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -84,7 +84,7 @@ EXPORT_SYMBOL_GPL(pxa27x_configure_ac97reset);
  */
 static unsigned int pwrmode = PWRMODE_SLEEP;
 
-int __init pxa27x_set_pwrmode(unsigned int mode)
+int pxa27x_set_pwrmode(unsigned int mode)
 {
 	switch (mode) {
 	case PWRMODE_SLEEP:
diff --git a/arch/arm/mach-pxa/pxa27x.h b/arch/arm/mach-pxa/pxa27x.h
index d064e0a9f2ce..075131d83eab 100644
--- a/arch/arm/mach-pxa/pxa27x.h
+++ b/arch/arm/mach-pxa/pxa27x.h
@@ -19,7 +19,7 @@
 #define ARB_CORE_PARK		(1<<24)	   /* Be parked with core when idle */
 #define ARB_LOCK_FLAG		(1<<23)	   /* Only Locking masters gain access to the bus */
 
-extern int __init pxa27x_set_pwrmode(unsigned int mode);
+extern int pxa27x_set_pwrmode(unsigned int mode);
 extern void pxa27x_cpu_pm_enter(suspend_state_t state);
 
 #endif /* __MACH_PXA27x_H */
