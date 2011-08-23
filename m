From: will.deacon@arm.com (Will Deacon)
Date: Tue, 23 Aug 2011 22:46:52 +0100
Subject: [PATCH v4 8/8] ARM: stop: execute platform callback from cpu_stop code
In-Reply-To: <1314136012-20533-1-git-send-email-will.deacon@arm.com>
References: <1314136012-20533-1-git-send-email-will.deacon@arm.com>
Message-ID: <1314136012-20533-9-git-send-email-will.deacon@arm.com>
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
index 5ebc5d9..d2e9d42 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1849,7 +1849,7 @@ config XIP_PHYS_ADDR
 
 config KEXEC
 	bool "Kexec system call (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
+	depends on EXPERIMENTAL && (!SMP || HOTPLUG_CPU)
 	help
 	  kexec is a system call that implements the ability to shutdown your
 	  current kernel, and to start another kernel.  It is like a reboot
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 96a7956..3f6e8d1 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -559,6 +559,10 @@ static void ipi_cpu_stop(unsigned int cpu)
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
1.7.0.4
