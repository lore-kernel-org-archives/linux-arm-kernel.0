From: will.deacon@arm.com (Will Deacon)
Date: Thu,  8 Dec 2011 19:03:20 +0000
Subject: [PATCH v8 3/4] ARM: stop: execute platform callback from cpu_stop code
In-Reply-To: <1323371001-4036-1-git-send-email-will.deacon@arm.com>
References: <1323371001-4036-1-git-send-email-will.deacon@arm.com>
Message-ID: <1323371001-4036-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sending IPI_CPU_STOP to a CPU causes it to execute a busy cpu_relax
loop forever. This makes it impossible to kexec successfully on an SMP
system since the secondary CPUs do not reset.

This patch adds a callback to platform_cpu_kill, defined when
CONFIG_HOTPLUG_CPU=y, from the ipi_cpu_stop handling code. This function
currently just returns 1 on all platforms that define it but allows them
to do something more sophisticated in the future.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/Kconfig      |    2 +-
 arch/arm/kernel/smp.c |    4 ++++
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4b01d71..abba5b8 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2001,7 +2001,7 @@ config XIP_PHYS_ADDR
 
 config KEXEC
 	bool "Kexec system call (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
+	depends on EXPERIMENTAL && (!SMP || HOTPLUG_CPU)
 	help
 	  kexec is a system call that implements the ability to shutdown your
 	  current kernel, and to start another kernel.  It is like a reboot
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 76ff28d..57db122 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -522,6 +522,10 @@ static void ipi_cpu_stop(unsigned int cpu)
 	local_fiq_disable();
 	local_irq_disable();
 
+#ifdef CONFIG_HOTPLUG_CPU
+	platform_cpu_kill(cpu);
+#endif
+
 	while (1)
 		cpu_relax();
 }
-- 
1.7.4.1
