From: j-keerthy@ti.com (Keerthy)
Date: Fri, 27 Jul 2018 11:12:35 +0530
Subject: ARM: Build failures with CONFIG_HAVE_RCU_TABLE_FREE=y on linux-next
Message-ID: <8a8db414-4723-14f2-ef9d-c10aecc80278@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

commit 2ff6ddf19c0ec40633bd14d8fe28a289816bd98d
Author: Rik van Riel <riel@surriel.com>
Date:   Mon Jul 16 15:03:32 2018 -0400

x86/mm/tlb: Leave lazy TLB mode at page table free time

On linux-next introduces tlb_flush_remove_tables_local and
tlb_flush_remove_tables functions that are more or less for x86 only.

I see build failures for standalone dra7 K2 defconfigs and NOT in case
of omap2plus_defconfig, reason being CONFIG_HAVE_RCU_TABLE_FREE is
defined for the failing defconfigs.

I looked at arch/arm/Kconfig which has:

select HAVE_RCU_TABLE_FREE if (SMP && ARM_LPAE)

So in case of K2G/Keystone/dra7 both SMP and LPAE are defined and hence
CONFIG_HAVE_RCU_TABLE_FREE is defined which gives me the following build
errors:

ti_sdk_dra7x_release_defconfig
+ make -j16 ARCH=arm
O=/home/lcpdbld/jenkins_ws/workspace/linux_next_compile/build_out/kernel/ti_s
dk_dra7x_release_defconfig
<stdin>:1332:2: warning: #warning syscall io_pgetevents not implemented
[-Wcpp]
<stdin>:1338:2: warning: #warning syscall open_tree not implemented [-Wcpp]
<stdin>:1341:2: warning: #warning syscall move_mount not implemented [-Wcpp]
<stdin>:1344:2: warning: #warning syscall fsopen not implemented [-Wcpp]
<stdin>:1347:2: warning: #warning syscall fsmount not implemented [-Wcpp]
<stdin>:1350:2: warning: #warning syscall fspick not implemented [-Wcpp]
<stdin>:1353:2: warning: #warning syscall fsinfo not implemented [-Wcpp]
/scratch/lcpdbld/jenkins_ws/workspace/linux_next_compile/linux-
kernel/mm/memory.c: In function ?tlb_remove_table_smp_sync?:
/scratch/lcpdbld/jenkins_ws/workspace/linux_next_compile/linux-
kernel/mm/memory.c:339:2: error: implicit declaration of function
?tlb_flush_remove_tables_local?; did you mean ?tlb_remove_table?? [-
Werror=implicit-function-declaration]
  tlb_flush_remove_tables_local(mm);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  tlb_remove_table
/scratch/lcpdbld/jenkins_ws/workspace/linux_next_compile/linux-
kernel/mm/memory.c: In function ?tlb_table_flush?:
/scratch/lcpdbld/jenkins_ws/workspace/linux_next_compile/linux-
kernel/mm/memory.c:372:2: error: implicit declaration of function
?tlb_flush_remove_tables?; did you mean ?tlb_remove_table??
[-Werror=implicit-
function-declaration]
  tlb_flush_remove_tables(tlb->mm);
  ^~~~~~~~~~~~~~~~~~~~~~~
  tlb_remove_table
cc1: some warnings being treated as errors
make[2]: *** [mm/memory.o] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [mm] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [sub-make] Error 2

I could fix the above errors with the hunk below:

diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
index d5562f9..638f2c4 100644
--- a/arch/arm/include/asm/tlb.h
+++ b/arch/arm/include/asm/tlb.h
@@ -35,6 +35,15 @@

 #define MMU_GATHER_BUNDLE      8

+/*
+ * Used to flush the TLB when page tables are removed, when lazy
+ * TLB mode may cause a CPU to retain intermediate translations
+ * pointing to about-to-be-freed page table memory.
+ */
+#ifndef HAVE_TLB_FLUSH_REMOVE_TABLES
+#define tlb_flush_remove_tables(mm) do {} while (0)
+#define tlb_flush_remove_tables_local(mm) do {} while (0)
+#endif

I am sure there is a better way to fix this. Let me know if this can be
fixed in a better way.

Regards,
Keerthy
