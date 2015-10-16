From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 17 Oct 2015 00:21:07 +0200
Subject: [PATCH] ARM: psci-smp is built only for SMP
Message-ID: <4561751.e2CPD6ukve@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PSCI SMP implementation is built only when both CONFIG_SMP and
CONFIG_ARM_PSCI are set, so a configuration that has the latter
but not the former can get a link error when it tries to call
psci_smp_available().

arch/arm/mach-tegra/built-in.o: In function `tegra114_cpuidle_init':
cpuidle-tegra114.c:(.init.text+0x52a): undefined reference to `psci_smp_available'

This corrects the #ifdef in the psci.h header file to match the
Makefile conditional we have for building that function.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/include/asm/psci.h b/arch/arm/include/asm/psci.h
index 68ee3ce17b82..b4c6d99364f1 100644
--- a/arch/arm/include/asm/psci.h
+++ b/arch/arm/include/asm/psci.h
@@ -16,7 +16,7 @@
 
 extern struct smp_operations psci_smp_ops;
 
-#ifdef CONFIG_ARM_PSCI
+#if defined(CONFIG_SMP) && defined(CONFIG_ARM_PSCI)
 bool psci_smp_available(void);
 #else
 static inline bool psci_smp_available(void) { return false; }
