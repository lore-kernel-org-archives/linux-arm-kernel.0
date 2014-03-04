From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 4 Mar 2014 10:28:06 +0000
Subject: [PATCH v2] arm64: topology: Implement basic CPU topology support
In-Reply-To: <20140304101641.GK13126@sirena.org.uk>
References: <1393919477-27814-1-git-send-email-broonie@kernel.org>
 <20140304095534.GE30596@arm.com>
 <20140304101641.GK13126@sirena.org.uk>
Message-ID: <20140304102806.GH30596@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 04, 2014 at 10:16:41AM +0000, Mark Brown wrote:
> On Tue, Mar 04, 2014 at 09:55:36AM +0000, Catalin Marinas wrote:
> > On Tue, Mar 04, 2014 at 07:51:17AM +0000, Mark Brown wrote:
> 
> > > +config CPU_TOPOLOGY
> > > +	bool "Support CPU topology definition"
> 
> > Thanks for the patch. I applied it but not pushed to -next yet. I wonder
> > whether it makes sense to drop the description of the CPU_TOPOLOGY entry
> > here so that it is no longer selectable. It will be enabled by default
> > when SMP (I can do the change myself, no need to repost).
> 
> I'm totally fine with that, I only made it selectable due to the 32 bit
> code doing that - I'm not sure we even need the separate symbol.
> Whatever you prefer.

Like that?


diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 4474e247f94a..140cd1a9dc0c 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -165,17 +165,9 @@ config SMP
 
 	  If you don't know what to do here, say N.
 
-config CPU_TOPOLOGY
-	bool "Support CPU topology definition"
-	depends on SMP
-	default y
-	help
-	  Support CPU topology definition, based on configuration
-	  provided by the firmware.
-
 config SCHED_MC
 	bool "Multi-core scheduler support"
-	depends on CPU_TOPOLOGY
+	depends on SMP
 	help
 	  Multi-core scheduler support improves the CPU scheduler's decision
 	  making when dealing with multi-core CPU chips at a cost of slightly
@@ -183,7 +175,7 @@ config SCHED_MC
 
 config SCHED_SMT
 	bool "SMT scheduler support"
-	depends on CPU_TOPOLOGY
+	depends on SMP
 	help
 	  Improves the CPU scheduler's decision making when dealing with
 	  MultiThreading at a cost of slightly increased overhead in some
diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
index c8a47e8f452b..0172e6d76bf3 100644
--- a/arch/arm64/include/asm/topology.h
+++ b/arch/arm64/include/asm/topology.h
@@ -1,7 +1,7 @@
 #ifndef __ASM_TOPOLOGY_H
 #define __ASM_TOPOLOGY_H
 
-#ifdef CONFIG_CPU_TOPOLOGY
+#ifdef CONFIG_SMP
 
 #include <linux/cpumask.h>
 
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index da1dafb3db87..cfee8273fccb 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -14,14 +14,13 @@ arm64-obj-y		:= cputable.o debug-monitors.o entry.o irq.o fpsimd.o	\
 arm64-obj-$(CONFIG_COMPAT)		+= sys32.o kuser32.o signal32.o 	\
 					   sys_compat.o
 arm64-obj-$(CONFIG_MODULES)		+= arm64ksyms.o module.o
-arm64-obj-$(CONFIG_SMP)			+= smp.o smp_spin_table.o
+arm64-obj-$(CONFIG_SMP)			+= smp.o smp_spin_table.o topology.o
 arm64-obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event.o
 arm64-obj-$(CONFIG_HAVE_HW_BREAKPOINT)+= hw_breakpoint.o
 arm64-obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 arm64-obj-$(CONFIG_ARM64_CPU_SUSPEND)	+= sleep.o suspend.o
 arm64-obj-$(CONFIG_JUMP_LABEL)		+= jump_label.o
 arm64-obj-$(CONFIG_KGDB)		+= kgdb.o
-arm64-obj-$(CONFIG_CPU_TOPOLOGY)	+= topology.o
 
 obj-y					+= $(arm64-obj-y) vdso/
 obj-m					+= $(arm64-obj-m)
