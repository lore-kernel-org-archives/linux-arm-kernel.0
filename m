From: sebastian@breakpoint.cc (Sebastian Andrzej Siewior)
Date: Fri,  2 Oct 2015 23:13:24 +0200
Subject: [PATCH] arm: make psci_smp_available() depend on SMP + PSCI as the
 makefile does
Message-ID: <1443820404-16431-1-git-send-email-sebastian@breakpoint.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

with CONFIG_ARM_PSCI=y, CONFIG_SMP=n and CONFIG_ARCH_TEGRA_124_SOC=y I
end up with:

|arch/arm/mach-tegra/built-in.o: In function `tegra114_cpuidle_init':
|arch/arm/mach-tegra/cpuidle-tegra114.c:93: undefined reference to `psci_smp_available'
|Makefile:927: recipe for target 'vmlinux' failed

during build testing.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/include/asm/psci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/psci.h b/arch/arm/include/asm/psci.h
index 68ee3ce17b82..ff956f4d4307 100644
--- a/arch/arm/include/asm/psci.h
+++ b/arch/arm/include/asm/psci.h
@@ -16,7 +16,7 @@
 
 extern struct smp_operations psci_smp_ops;
 
-#ifdef CONFIG_ARM_PSCI
+#if defined(CONFIG_ARM_PSCI) && defined(CONFIG_SMP)
 bool psci_smp_available(void);
 #else
 static inline bool psci_smp_available(void) { return false; }
-- 
2.6.0
