From: sebastian@breakpoint.cc (Sebastian Andrzej Siewior)
Date: Thu, 12 Nov 2015 11:06:18 +0100
Subject: [PATCH v2 repost] ARM: Availability of psci_smp_available depends on
 CONFIG_SMP
Message-ID: <1447322778-5237-1-git-send-email-sebastian@breakpoint.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Ensure that we can use psci_smp_available without checking for
CONFIG_SMP first (CONFIG_ARM_PSCI=y, CONFIG_SMP=n and
CONFIG_ARCH_TEGRA_124_SOC=y):

|arch/arm/mach-tegra/built-in.o: In function `tegra114_cpuidle_init':
|arch/arm/mach-tegra/cpuidle-tegra114.c:93: undefined reference to `psci_smp_available'
|Makefile:927: recipe for target 'vmlinux' failed

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

Will Deacon said:
"I just stopped moaning about not understanding it :)"

 arch/arm/include/asm/psci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/include/asm/psci.h
+++ b/arch/arm/include/asm/psci.h
@@ -16,7 +16,7 @@
 
 extern struct smp_operations psci_smp_ops;
 
-#ifdef CONFIG_ARM_PSCI
+#if defined(CONFIG_ARM_PSCI) && defined(CONFIG_SMP)
 bool psci_smp_available(void);
 #else
 static inline bool psci_smp_available(void) { return false; }
