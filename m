From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 05 Jun 2013 19:44:46 +0900
Subject: [PATCH 02/03] ARM: Handle 64-bit memory in case of 32-bit phys_addr_t
In-Reply-To: <20130605104427.1720.68752.sendpatchset@w520>
References: <20130605104427.1720.68752.sendpatchset@w520>
Message-ID: <20130605104446.1720.12461.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Use CONFIG_ARCH_PHYS_ADDR_T_64BIT to determine
if ignoring or truncating of memory banks is
neccessary. This may be needed in the case of
64-bit memory bank addresses but when phys_addr_t
is kept 32-bit.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Ignoring case tested on APE6EVM in cases when
 HIGHMEM=y/n and LPAE=y/n. Truncating not tested.

 arch/arm/kernel/setup.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

--- 0003/arch/arm/kernel/setup.c
+++ work/arch/arm/kernel/setup.c	2013-06-05 19:08:17.000000000 +0900
@@ -530,6 +530,7 @@ void __init dump_machine_table(void)
 int __init arm_add_memory(u64 start, u64 size)
 {
 	struct membank *bank = &meminfo.bank[meminfo.nr_banks];
+	u64 aligned_start;
 
 	if (meminfo.nr_banks >= NR_BANKS) {
 		printk(KERN_CRIT "NR_BANKS too low, "
@@ -542,10 +543,16 @@ int __init arm_add_memory(u64 start, u64
 	 * Size is appropriately rounded down, start is rounded up.
 	 */
 	size -= start & ~PAGE_MASK;
-	bank->start = PAGE_ALIGN(start);
+	aligned_start = PAGE_ALIGN(start);
 
-#ifndef CONFIG_ARM_LPAE
-	if (bank->start + size < bank->start) {
+#ifndef CONFIG_ARCH_PHYS_ADDR_T_64BIT
+	if (aligned_start > ULONG_MAX) {
+		printk(KERN_CRIT "Ignoring memory at 0x%08llx outside "
+		       "32-bit physical address space\n", (long long)start);
+		return -EINVAL;
+	}
+
+	if (aligned_start + size > ULONG_MAX) {
 		printk(KERN_CRIT "Truncating memory at 0x%08llx to fit in "
 			"32-bit physical address space\n", (long long)start);
 		/*
@@ -553,10 +560,11 @@ int __init arm_add_memory(u64 start, u64
 		 * 32 bits, we use ULONG_MAX as the upper limit rather than 4GB.
 		 * This means we lose a page after masking.
 		 */
-		size = ULONG_MAX - bank->start;
+		size = ULONG_MAX - aligned_start;
 	}
 #endif
 
+	bank->start = aligned_start;
 	bank->size = size & ~(phys_addr_t)(PAGE_SIZE - 1);
 
 	/*
