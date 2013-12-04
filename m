From: olof@lixom.net (Olof Johansson)
Date: Wed,  4 Dec 2013 15:30:26 -0800
Subject: [PATCH] ARM: Clean up setup printks a bit
Message-ID: <1386199826-8183-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clean up the setup ARM printks a bit. Add printk level to a few
that were missing (CPU: <...> ones, in particular), and switch from
printk(KERN_* ..) to pr_*().

Finally, un-wrap some long lines since it makes it harder to grep the
sources from where an error came from and tweak some cases of indentation.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/kernel/setup.c |   39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 6a1b8a8..7c472f4 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -334,7 +334,7 @@ static void __init cacheid_init(void)
 		cacheid = CACHEID_VIVT;
 	}
 
-	printk("CPU: %s data cache, %s instruction cache\n",
+	pr_info("CPU: %s data cache, %s instruction cache\n",
 		cache_is_vivt() ? "VIVT" :
 		cache_is_vipt_aliasing() ? "VIPT aliasing" :
 		cache_is_vipt_nonaliasing() ? "PIPT / VIPT nonaliasing" : "unknown",
@@ -416,7 +416,7 @@ void notrace cpu_init(void)
 	struct stack *stk = &stacks[cpu];
 
 	if (cpu >= NR_CPUS) {
-		printk(KERN_CRIT "CPU%u: bad primary CPU number\n", cpu);
+		pr_crit("CPU%u: bad primary CPU number\n", cpu);
 		BUG();
 	}
 
@@ -484,7 +484,7 @@ void __init smp_setup_processor_id(void)
 	 */
 	set_my_cpu_offset(0);
 
-	printk(KERN_INFO "Booting Linux on physical CPU 0x%x\n", mpidr);
+	pr_info("Booting Linux on physical CPU 0x%x\n", mpidr);
 }
 
 struct mpidr_hash mpidr_hash;
@@ -564,7 +564,7 @@ static void __init setup_processor(void)
 	 */
 	list = lookup_processor_type(read_cpuid_id());
 	if (!list) {
-		printk("CPU configuration botched (ID %08x), unable "
+		pr_err("CPU configuration botched (ID %08x), unable "
 		       "to continue.\n", read_cpuid_id());
 		while (1);
 	}
@@ -585,9 +585,9 @@ static void __init setup_processor(void)
 	cpu_cache = *list->cache;
 #endif
 
-	printk("CPU: %s [%08x] revision %d (ARMv%s), cr=%08lx\n",
-	       cpu_name, read_cpuid_id(), read_cpuid_id() & 15,
-	       proc_arch[cpu_architecture()], cr_alignment);
+	pr_info("CPU: %s [%08x] revision %d (ARMv%s), cr=%08lx\n",
+		cpu_name, read_cpuid_id(), read_cpuid_id() & 15,
+		proc_arch[cpu_architecture()], cr_alignment);
 
 	snprintf(init_utsname()->machine, __NEW_UTS_LEN + 1, "%s%c",
 		 list->arch_name, ENDIANNESS);
@@ -629,8 +629,8 @@ int __init arm_add_memory(u64 start, u64 size)
 	u64 aligned_start;
 
 	if (meminfo.nr_banks >= NR_BANKS) {
-		printk(KERN_CRIT "NR_BANKS too low, "
-			"ignoring memory at 0x%08llx\n", (long long)start);
+		pr_crit("NR_BANKS too low, "ignoring memory at 0x%08llx\n",
+			(long long)start);
 		return -EINVAL;
 	}
 
@@ -643,14 +643,14 @@ int __init arm_add_memory(u64 start, u64 size)
 
 #ifndef CONFIG_ARCH_PHYS_ADDR_T_64BIT
 	if (aligned_start > ULONG_MAX) {
-		printk(KERN_CRIT "Ignoring memory at 0x%08llx outside "
-		       "32-bit physical address space\n", (long long)start);
+		pr_crit("Ignoring memory at 0x%08llx outside 32-bit physical address space\n",
+			(long long)start);
 		return -EINVAL;
 	}
 
 	if (aligned_start + size > ULONG_MAX) {
-		printk(KERN_CRIT "Truncating memory at 0x%08llx to fit in "
-			"32-bit physical address space\n", (long long)start);
+		pr_crit("Truncating memory at 0x%08llx to fit in 32-bit physical address space\n",
+			(long long)start);
 		/*
 		 * To ensure bank->start + bank->size is representable in
 		 * 32 bits, we use ULONG_MAX as the upper limit rather than 4GB.
@@ -819,16 +819,15 @@ static void __init reserve_crashkernel(void)
 
 	ret = reserve_bootmem(crash_base, crash_size, BOOTMEM_EXCLUSIVE);
 	if (ret < 0) {
-		printk(KERN_WARNING "crashkernel reservation failed - "
-		       "memory is in use (0x%lx)\n", (unsigned long)crash_base);
+		pr_warn("crashkernel reservation failed - memory is in use (0x%lx)\n",
+			(unsigned long)crash_base);
 		return;
 	}
 
-	printk(KERN_INFO "Reserving %ldMB of memory@%ldMB "
-	       "for crashkernel (System RAM: %ldMB)\n",
-	       (unsigned long)(crash_size >> 20),
-	       (unsigned long)(crash_base >> 20),
-	       (unsigned long)(total_mem >> 20));
+	pr_info("Reserving %ldMB of memory at %ldMB for crashkernel (System RAM: %ldMB)\n",
+		(unsigned long)(crash_size >> 20),
+		(unsigned long)(crash_base >> 20),
+		(unsigned long)(total_mem >> 20));
 
 	crashk_res.start = crash_base;
 	crashk_res.end = crash_base + crash_size - 1;
-- 
1.7.10.4
