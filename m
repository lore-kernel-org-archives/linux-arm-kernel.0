From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 01 Nov 2011 16:08:28 +0000
Subject: [PATCH 1/5] ARM: restart: remove argument to setup_mm_for_reboot()
In-Reply-To: <20111101160731.GQ19187@n2100.arm.linux.org.uk>
References: <20111101160731.GQ19187@n2100.arm.linux.org.uk>
Message-ID: <E1RLGt2-0005IN-A0@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

setup_mm_for_reboot() doesn't make use of its argument, so remove it.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/machine_kexec.c |    4 ++--
 arch/arm/kernel/process.c       |    4 ++--
 arch/arm/mm/idmap.c             |    2 +-
 arch/arm/mm/nommu.c             |    2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index c1b4463..6fcdfc4 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -16,7 +16,7 @@
 extern const unsigned char relocate_new_kernel[];
 extern const unsigned int relocate_new_kernel_size;
 
-extern void setup_mm_for_reboot(char mode);
+extern void setup_mm_for_reboot(void);
 
 extern unsigned long kexec_start_address;
 extern unsigned long kexec_indirection_page;
@@ -114,7 +114,7 @@ void machine_kexec(struct kimage *image)
 		kexec_reinit();
 	local_irq_disable();
 	local_fiq_disable();
-	setup_mm_for_reboot(0); /* mode is not used, so just pass 0*/
+	setup_mm_for_reboot(); /* mode is not used, so just pass 0*/
 	flush_cache_all();
 	outer_flush_all();
 	outer_disable();
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index fd08140..62946c0 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -57,7 +57,7 @@ static const char *isa_modes[] = {
   "ARM" , "Thumb" , "Jazelle", "ThumbEE"
 };
 
-extern void setup_mm_for_reboot(char mode);
+extern void setup_mm_for_reboot(void);
 
 static volatile int hlt_counter;
 
@@ -103,7 +103,7 @@ void arm_machine_restart(char mode, const char *cmd)
 	 * we may need it to insert some 1:1 mappings so that
 	 * soft boot works.
 	 */
-	setup_mm_for_reboot(mode);
+	setup_mm_for_reboot();
 
 	/* Clean and invalidate caches */
 	flush_cache_all();
diff --git a/arch/arm/mm/idmap.c b/arch/arm/mm/idmap.c
index 2be9139..296ad2e 100644
--- a/arch/arm/mm/idmap.c
+++ b/arch/arm/mm/idmap.c
@@ -78,7 +78,7 @@ void identity_mapping_del(pgd_t *pgd, unsigned long addr, unsigned long end)
  * the user-mode pages.  This will then ensure that we have predictable
  * results when turning the mmu off
  */
-void setup_mm_for_reboot(char mode)
+void setup_mm_for_reboot(void)
 {
 	/*
 	 * We need to access to user-mode page tables here. For kernel threads
diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index 941a98c..8841751 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -43,7 +43,7 @@ void __init paging_init(struct machine_desc *mdesc)
 /*
  * We don't need to do anything here for nommu machines.
  */
-void setup_mm_for_reboot(char mode)
+void setup_mm_for_reboot(void)
 {
 }
 
-- 
1.7.4.4
