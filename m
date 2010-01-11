From: dwalker@codeaurora.org (Daniel Walker)
Date: Mon, 11 Jan 2010 14:47:36 -0800
Subject: [RFC 17/18] arm: mm: Add SW emulation for ARM domain manager feature
In-Reply-To: <1263250057-26692-1-git-send-email-dwalker@codeaurora.org>
References: <1263250057-26692-1-git-send-email-dwalker@codeaurora.org>
Message-ID: <1263250057-26692-18-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dave Estes <cestes@quicinc.com>

Do not set domain manager bits in cp15 dacr.  Emulate using SW.  Add
kernel hooks to handle domain changes, permission faults, and context
switches.

This feature is required by ARCH_QSD8x50 to fix a problem with page
crossing memory accesses.  Set ARCH_QSD8X50 to select emulator.

Signed-off-by: Dave Estes <cestes@quicinc.com>
Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
---
 Documentation/arm/msm/emulate_domain_manager.txt |  282 ++++++++++++++++
 arch/arm/include/asm/domain.h                    |   13 +
 arch/arm/kernel/entry-armv.S                     |    8 +
 arch/arm/kernel/head.S                           |    8 +
 arch/arm/mm/Kconfig                              |    2 +
 arch/arm/mm/Makefile                             |    1 +
 arch/arm/mm/emulate_domain_manager-v7.c          |  386 ++++++++++++++++++++++
 arch/arm/mm/fault.c                              |   14 +
 arch/arm/mm/proc-v7.S                            |    8 +
 9 files changed, 722 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/arm/msm/emulate_domain_manager.txt
 create mode 100644 arch/arm/mm/emulate_domain_manager-v7.c

diff --git a/Documentation/arm/msm/emulate_domain_manager.txt b/Documentation/arm/msm/emulate_domain_manager.txt
new file mode 100644
index 0000000..97a2566
--- /dev/null
+++ b/Documentation/arm/msm/emulate_domain_manager.txt
@@ -0,0 +1,282 @@
+Copyright (c) 2009, Code Aurora Forum. All rights reserved.
+
+Redistribution and use in source form and compiled forms (SGML, HTML, PDF,
+PostScript, RTF and so forth) with or without modification, are permitted
+provided that the following conditions are met:
+
+Redistributions in source form must retain the above copyright notice, this
+list of conditions and the following disclaimer as the first lines of this
+file unmodified.
+
+Redistributions in compiled form (transformed to other DTDs, converted to
+PDF, PostScript, RTF and other formats) must reproduce the above copyright
+notice, this list of conditions and the following disclaimer in the
+documentation and/or other materials provided with the distribution.
+
+THIS DOCUMENTATION IS PROVIDED BY THE CODE AURORA FORUM "AS IS"
+AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+AND NON-INFRINGEMENT ARE DISCLAIMED. IN NO EVENT SHALL THE FREEBSD
+DOCUMENTATION PROJECT BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
+PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
+OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
+WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
+OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS DOCUMENTATION, EVEN IF
+ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+
+
+Introduction
+============
+
+8x50 chipset requires the ability to disable HW domain manager function.
+
+The ARM MMU architecture has a feature known as domain manager mode.
+Briefly each page table, section, or supersection is assigned a domain.
+Each domain can be globally configured to NoAccess, Client, or Manager
+mode.  These global configurations allow the access permissions of the
+entire domain to be changed simultaneously.
+
+The domain manger emulation is required to fix a HW problem on the 8x50
+chipset.  The problem is simple to repair except when domain manager mode
+is enabled.  The emulation allows the problem to be completely resolved.
+
+
+Hardware description
+====================
+
+When domain manager mode is enabled on a specific domain, the MMU
+hardware ignores the access permission bits and the execute never bit.  All
+accesses, to memory in the domain, are granted full read, write,
+execute permissions.
+
+The mode of each domain is controlled by a field in the cp15 dacr register.
+Each domain can be globally configured to NoAccess, Client, or Manager mode.
+
+See: ARMv7 Architecture Reference Manual
+
+
+Software description
+====================
+
+In order to disable domain manager mode the equivalent HW functionality must
+be emulated in SW.  Any attempts to enable domain manager mode, must be
+intercepted.
+
+Because domain manager mode is not enabled, permissions for the
+associated domain will remain restricted.  Permission faults will be generated.
+The permission faults will be intercepted.  The faulted pages/sections will
+be modified to grant full access and execute permissions.
+
+The modified page tables must be restored when exiting domain manager mode.
+
+
+Design
+======
+
+Design Goals:
+
+Disable Domain Manager Mode
+Exact SW emulation of Domain Manager Mode
+Minimal Kernel changes
+Minimal Security Risk
+
+Design Decisions:
+
+Detect kernel page table modifications on restore
+Direct ARMv7 HW MMU table manipulation
+Restore emulation modified MMU entries on context switch
+No need to restore MMU entries for MMU entry copy operations
+Invalidate TLB entries on modification
+Store Domain Manager bits in memory
+8 entry MMU entry cache
+Use spin_lock_irqsave to protect domain manipulation
+Assume no split MMU table
+
+Design Discussion:
+
+Detect kernel page table modifications on restore -
+When restoring original page/section permission faults, the submitted design
+verifies the MMU entry has not been modified.  The kernel modifies MMU
+entries for the following purposes : create a memory mapping, release a
+memory mapping, add permissions during a permission fault, and map a page
+during a translation fault.  The submitted design works with the listed
+scenarios.  The translation fault and permission faults simply do not happen on
+relevant entries (valid entries with full access permissions).  The alternative
+would be to hook every MMU table modification.  The alternative greatly
+increases complexity and code maintenance issues.
+
+Direct ARMv7 HW MMU table manipulation -
+The natural choice would be to use the kernel provided mechanism to manipulate
+MMU page table entries.  The ARM MMU interface is described in pgtable.h.
+This interface is complicated by the Linux implementation.  The level 1 pgd
+entries are treated and manipulated as entry pairs.  The level 2 entries are
+shadowed and cloned.  The compromise was chosen to actually use the ARMv7 HW
+registers to walk and modify the MMU table entries.  The choice limits the
+usage of this implementation to ARMv7 and similar ARM MMU architectures.  Since
+this implementation is targeted at fixing an issue in 8x50 ARMv7, the choice is
+logical.  The HW manipulation is in distinct low level functions.  These could
+easily be replaced or generalized to support other architectures as necessary.
+
+Restore emulation modified MMU entries on context switch -
+This additional hook was added to minimize performance impact.  By guaranteeing
+the ASID will not change during the emulation, the emulation may invalidate each
+entry by MVA & ASID.  Only the affected page table entries will be removed from
+the TLB cache.  The performance cost of the invalidate on context switch is near
+zero.  Typically on context switch the domain mode would also change, forcing a
+complete restore of all modified MMU entries.  The alternative would be to
+invalidate the entire TLB every time a table entry is restored.
+
+No need to restore MMU entries for copy operations -
+Operations which copy MMU entries are relatively rare in the kernel.  Because
+we modify the level 2 pte entries directly in hardware, the Linux shadow copies
+are left untouched.  The kernel treats the shadow copies as the primary pte
+entry.  Any pte copy operations would be unaffected by the HW modification.
+On translation section fault, pgd entries are copied from the kernel master
+page table to the current thread page table.  Since we restore MMU entries on
+context switch, we guarantee the master table will not contain modifications,
+while faulting on a process local entry.  Other read, modify write operations
+occur during permission fault handling.  Since we open permission on modified
+entries, these do not need to be restored, because we guarantee these
+permission fault operations will not happen.
+
+Invalidate TLB entries on modification -
+No real choice here.  This is more of a design requirement.  On permission
+fault, the MMU entry with restricted permissions will be in the TLB.  To open
+access permissions, the TLB entry must be invalidated.  Otherwise the access
+will permission fault again.  Upon restoring original MMU entries, the TLB
+must be invalidated to restrict memory access.
+
+Store Domain Manager bits in memory -
+There was only one alternative here.  2.6.29 kernel only uses 3 of 16
+possible domains.  Additional bits in dacr could be used to store the
+manager bits.  This would allow faster access to the manager bits.
+Overall this would reduce any performance impact.  The performance
+needs did not seem to justify the added weirdness.
+
+8 entry MMU entry cache-
+The size of the modified MMU entry cache is somewhat arbitrary.  The thought
+process is that typically, a thread is using two pointers to perform a copy
+operation.  In this case only 2 entries would be required.  One could imagine
+a more complicated operation, a masked copy for instance, which would require
+more pointers.  8 pointer seemed to be large enough to minimize risk of
+permission fault thrashing.  The disadvantage of a larger cache would simply
+be a longer list of entries to restore.
+
+Use spin_lock_irqsave to protect domain manipulation -
+The obvious choice.
+
+Assume no split MMU table -
+This same assumption is documented in cpu_v7_switch_mm.
+
+
+Power Management
+================
+
+Not affected.
+
+
+SMP/multi-core
+==============
+
+SMP/multicore not supported.  This is intended as a 8x50 workaround.
+
+
+Security
+========
+
+MMU page/section permissions must be manipulated correctly to emulate domain
+manager mode.  If page permission are left in full access mode, any process
+can read associated memory.
+
+
+Performance
+===========
+
+Performance should be impacted only minimally.  When emulating domain manager
+mode, there is overhead added to MMU table/context switches, set_domain()
+calls, data aborts, and prefetch aborts.
+
+Normally the kernel operates with domain != DOMAIN_MANAGER.  In this case the
+overhead is minimal.  An additional check is required to see if domain manager
+mode is on.  This minimal code is added to each of emulation entry points :
+set, data abort, prefetch abort, and MMU table/context switch.
+
+Initial accesses to a MMU protected page/section will generate a permission
+fault. The page will be manipulated to grant full access permissions and
+the access will be retried.  This will typically require 2-3 page table
+walks.
+
+On a context switch, all modified MMU entries will be restored.  On thread
+resume, additional accesses will be treated as initial accesses.
+
+
+Interface
+=========
+
+The emulation does not have clients.  It is hooked to the kernel through a
+small list of functions.
+
+void emulate_domain_manager_set(u32 domain);
+int emulate_domain_manager_data_abort(u32 dfsr, u32 dfar);
+int emulate_domain_manager_prefetch_abort(u32 ifsr, u32 ifar);
+void emulate_domain_manager_switch_mm(
+	unsigned long pgd_phys,
+	struct mm_struct *mm,
+	void (*switch_mm)(unsigned long pgd_phys, struct mm_struct *));
+
+emulate_domain_manager_set() is the set_domain handler.  This replaces the
+direct manipulation of CP15 dacr with a function call.  This allows emulation
+to prevent setting dacr manager bits.  It also allows emulation to restore
+page/section permissions when domain manger is disabled.
+
+emulate_domain_manager_data_abort() handles data aborts caused by domain
+not being set in HW, and handles section/page manipulation.
+
+emulate_domain_manager_prefetch_abort() is the similar prefetch abort handler.
+
+emulate_domain_manager_switch_mm() handles MMU table and context switches.
+This notifies the emulation that the MMU context is changing.  Allowing the
+emulation to restore page table entry permission before switching contexts.
+
+
+Config options
+==============
+
+This option is enable/disable by the EMULATE_DOMAIN_MANAGER_V7 option.
+
+
+Dependencies
+============
+
+Implementation is for ARMv7, MMU, and !SMP.  Targets solving issue for 8x50
+chipset.
+
+
+User space utilities
+====================
+
+None
+
+
+Other
+=====
+
+Code is implemented in kernel/arch/arm/mm.
+
+
+arch/arm/mm/emulate_domain_manager.c contains comments.  No additional public
+documentation available or planned.
+
+
+Known issues
+============
+
+No intent to support SMP or non ARMv7 architectures
+
+
+To do
+=====
+
+None
+
diff --git a/arch/arm/include/asm/domain.h b/arch/arm/include/asm/domain.h
index cc7ef40..2f1d9e4 100644
--- a/arch/arm/include/asm/domain.h
+++ b/arch/arm/include/asm/domain.h
@@ -2,6 +2,7 @@
  *  arch/arm/include/asm/domain.h
  *
  *  Copyright (C) 1999 Russell King.
+ *  Copyright (c) 2009, Code Aurora Forum. All rights reserved.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -52,6 +53,17 @@
 #ifndef __ASSEMBLY__
 
 #ifdef CONFIG_MMU
+#ifdef CONFIG_EMULATE_DOMAIN_MANAGER_V7
+void emulate_domain_manager_set(u32 domain);
+int emulate_domain_manager_data_abort(u32 dfsr, u32 dfar);
+int emulate_domain_manager_prefetch_abort(u32 ifsr, u32 ifar);
+void emulate_domain_manager_switch_mm(
+	unsigned long pgd_phys,
+	struct mm_struct *mm,
+	void (*switch_mm)(unsigned long pgd_phys, struct mm_struct *));
+
+#define set_domain(x) emulate_domain_manager_set(x)
+#else
 #define set_domain(x)					\
 	do {						\
 	__asm__ __volatile__(				\
@@ -59,6 +71,7 @@
 	  : : "r" (x));					\
 	isb();						\
 	} while (0)
+#endif
 
 #define modify_domain(dom,type)					\
 	do {							\
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index d2903e3..d6aaf63 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -4,6 +4,7 @@
  *  Copyright (C) 1996,1997,1998 Russell King.
  *  ARM700 fix by Matthew Godbolt (linux-user at willothewisp.demon.co.uk)
  *  nommu support by Hyok S. Choi (hyok.choi at samsung.com)
+ *  Copyright (c) 2009, Code Aurora Forum. All rights reserved.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -746,8 +747,15 @@ ENTRY(__switch_to)
 	str	r3, [r4, #-15]			@ TLS val at 0xffff0ff0
 #endif
 #ifdef CONFIG_MMU
+#ifdef CONFIG_EMULATE_DOMAIN_MANAGER_V7
+	stmdb	r13!, {r0-r3, lr}
+	mov	r0, r6
+	bl	emulate_domain_manager_set
+	ldmia	r13!, {r0-r3, lr}
+#else
 	mcr	p15, 0, r6, c3, c0, 0		@ Set domain register
 #endif
+#endif
 	mov	r5, r0
 	add	r4, r2, #TI_CPU_SAVE
 	ldr	r0, =thread_notify_head
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index eb62bf9..70be2c7 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -4,6 +4,7 @@
  *  Copyright (C) 1994-2002 Russell King
  *  Copyright (c) 2003 ARM Limited
  *  All Rights Reserved
+ *  Copyright (c) 2009, Code Aurora Forum. All rights reserved.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -172,10 +173,17 @@ __enable_mmu:
 #ifdef CONFIG_CPU_ICACHE_DISABLE
 	bic	r0, r0, #CR_I
 #endif
+#ifdef CONFIG_EMULATE_DOMAIN_MANAGER_V7
+	mov	r5, #(domain_val(DOMAIN_USER, DOMAIN_CLIENT) | \
+		      domain_val(DOMAIN_KERNEL, DOMAIN_CLIENT) | \
+		      domain_val(DOMAIN_TABLE, DOMAIN_CLIENT) | \
+		      domain_val(DOMAIN_IO, DOMAIN_CLIENT))
+#else
 	mov	r5, #(domain_val(DOMAIN_USER, DOMAIN_MANAGER) | \
 		      domain_val(DOMAIN_KERNEL, DOMAIN_MANAGER) | \
 		      domain_val(DOMAIN_TABLE, DOMAIN_MANAGER) | \
 		      domain_val(DOMAIN_IO, DOMAIN_CLIENT))
+#endif
 	mcr	p15, 0, r5, c3, c0, 0		@ load domain access register
 	mcr	p15, 0, r4, c2, c0, 0		@ load page table pointer
 	b	__turn_mmu_on
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index c721880..9c745ca 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -573,6 +573,8 @@ config CPU_TLB_V6
 config CPU_TLB_V7
 	bool
 
+config EMULATE_DOMAIN_MANAGER_V7
+	bool
 endif
 
 config CPU_HAS_ASID
diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
index 827e238..3fe7a01 100644
--- a/arch/arm/mm/Makefile
+++ b/arch/arm/mm/Makefile
@@ -83,6 +83,7 @@ obj-$(CONFIG_CPU_MOHAWK)	+= proc-mohawk.o
 obj-$(CONFIG_CPU_FEROCEON)	+= proc-feroceon.o
 obj-$(CONFIG_CPU_V6)		+= proc-v6.o
 obj-$(CONFIG_CPU_V7)		+= proc-v7.o
+obj-$(CONFIG_EMULATE_DOMAIN_MANAGER_V7) += emulate_domain_manager-v7.o
 
 obj-$(CONFIG_CACHE_FEROCEON_L2)	+= cache-feroceon-l2.o
 obj-$(CONFIG_CACHE_L2X0)	+= cache-l2x0.o
diff --git a/arch/arm/mm/emulate_domain_manager-v7.c b/arch/arm/mm/emulate_domain_manager-v7.c
new file mode 100644
index 0000000..a55d2b2
--- /dev/null
+++ b/arch/arm/mm/emulate_domain_manager-v7.c
@@ -0,0 +1,386 @@
+/*
+ * Basic implementation of a SW emulation of the domain manager feature in
+ * ARM architecture.  Assumes single processor ARMv7 chipset.
+ *
+ * Requires hooks to be alerted to any runtime changes of dacr or MMU context.
+ *
+ * Copyright (c) 2009, Code Aurora Forum. All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Code Aurora Forum nor
+ *       the names of its contributors may be used to endorse or promote
+ *       products derived from this software without specific prior written
+ *       permission.
+ *
+ * Alternatively, provided that this notice is retained in full, this software
+ * may be relicensed by the recipient under the terms of the GNU General Public
+ * License version 2 ("GPL") and only version 2, in which case the provisions of
+ * the GPL apply INSTEAD OF those given above.  If the recipient relicenses the
+ * software under the GPL, then the identification text in the MODULE_LICENSE
+ * macro must be changed to reflect "GPLv2" instead of "Dual BSD/GPL".  Once a
+ * recipient changes the license terms to the GPL, subsequent recipients shall
+ * not relicense under alternate licensing terms, including the BSD or dual
+ * BSD/GPL terms.  In addition, the following license statement immediately
+ * below and between the words START and END shall also then apply when this
+ * software is relicensed under the GPL:
+ *
+ * START
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 and only version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
+ * FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
+ *
+ * END
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+ * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
+ * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGE.
+ *
+ */
+
+#include <linux/sched.h>
+#include <asm/domain.h>
+#include <asm/pgtable.h>
+#include <asm/tlbflush.h>
+
+#define DOMAIN_MANAGER_BITS (0xAAAAAAAA)
+
+#define DFSR_DOMAIN(dfsr) ((dfsr >> 4) & (16-1))
+
+#define FSR_PERMISSION_FAULT(fsr) ((fsr & 0x40D) == 0x00D)
+#define FSR_PERMISSION_SECT(fsr) ((fsr & 0x40F) == 0x00D)
+
+/* ARMv7 MMU HW Macros.  Not conveniently defined elsewhere */
+#define MMU_TTB_ADDRESS(x)   ((u32 *)(((u32)(x)) & ~((1 << 14) - 1)))
+#define MMU_PMD_INDEX(addr) (((u32)addr) >> SECTION_SHIFT)
+#define MMU_TABLE_ADDRESS(x) ((u32 *)((x) & ~((1 << 10) - 1)))
+#define MMU_TABLE_INDEX(x) ((((u32)x) >> 12) & (256 - 1))
+
+/* Convenience Macros */
+#define PMD_IS_VALID(x) (PMD_IS_TABLE(x) || PMD_IS_SECTION(x))
+#define PMD_IS_TABLE(x) ((x & PMD_TYPE_MASK) == PMD_TYPE_TABLE)
+#define PMD_IS_SECTION(x) ((x & PMD_TYPE_MASK) == PMD_TYPE_SECT)
+#define PMD_IS_SUPERSECTION(x) \
+	(PMD_IS_SECTION(x) && ((x & PMD_SECT_SUPER) == PMD_SECT_SUPER))
+
+#define PMD_GET_DOMAIN(x)					\
+	(PMD_IS_TABLE(x) ||					\
+	(PMD_IS_SECTION(x) && !PMD_IS_SUPERSECTION(x)) ?	\
+		 0 : (x >> 5) & (16-1))
+
+#define PTE_IS_LARGE(x) ((x & PTE_TYPE_MASK) == PTE_TYPE_LARGE)
+
+
+/* Only DOMAIN_MMU_ENTRIES will be granted access simultaneously */
+#define DOMAIN_MMU_ENTRIES (8)
+
+#define LRU_INC(lru) ((lru + 1) >= DOMAIN_MMU_ENTRIES ? 0 : lru + 1)
+
+
+static DEFINE_SPINLOCK(edm_lock);
+
+static u32 edm_manager_bits;
+
+struct domain_entry_save {
+	u32 *mmu_entry;
+	u32 *addr;
+	u32 value;
+	u16 sect;
+	u16 size;
+};
+
+static struct domain_entry_save edm_save[DOMAIN_MMU_ENTRIES];
+
+static u32 edm_lru;
+
+
+/*
+ *  Return virtual address of pmd (level 1) entry for addr
+ *
+ *  This routine walks the ARMv7 page tables in HW.
+ */
+static inline u32 *__get_pmd_v7(u32 *addr)
+{
+	u32 *ttb;
+
+	__asm__ __volatile__(
+		"mrc	p15, 0, %0, c2, c0, 0	@ ttbr0\n\t"
+		: "=r" (ttb)
+		:
+	);
+
+	return __va(MMU_TTB_ADDRESS(ttb) + MMU_PMD_INDEX(addr));
+}
+
+/*
+ *  Return virtual address of pte (level 2) entry for addr
+ *
+ *  This routine walks the ARMv7 page tables in HW.
+ */
+static inline u32 *__get_pte_v7(u32 *addr)
+{
+	u32 *pmd = __get_pmd_v7(addr);
+	u32 *table_pa = pmd && PMD_IS_TABLE(*pmd) ?
+		MMU_TABLE_ADDRESS(*pmd) : 0;
+	u32 *entry = table_pa ? __va(table_pa[MMU_TABLE_INDEX(addr)]) : 0;
+
+	return entry;
+}
+
+/*
+ *  Invalidate the TLB for a given address for the current context
+ *
+ *  After manipulating access permissions, TLB invalidation changes are
+ *  observed
+ */
+static inline void __tlb_invalidate(u32 *addr)
+{
+	__asm__ __volatile__(
+		"mrc	p15, 0, %%r2, c13, c0, 1	@ contextidr\n\t"
+		"and %%r2, %%r2, #0xff			@ asid\n\t"
+		"mov %%r3, %0, lsr #12			@ mva[31:12]\n\t"
+		"orr %%r2, %%r2, %%r3, lsl #12		@ tlb mva and asid\n\t"
+		"mcr	p15, 0, %%r2, c8, c7, 1		@ utlbimva\n\t"
+		"isb"
+		:
+		: "r" (addr)
+		: "r2", "r3"
+	);
+}
+
+/*
+ *  Set HW MMU entry and do required synchronization operations.
+ */
+static inline void __set_entry(u32 *entry, u32 *addr, u32 value, int size)
+{
+	int i;
+
+	if (!entry)
+		return;
+
+	entry = (u32 *)((u32) entry & ~(size * sizeof(u32) - 1));
+
+	for (i = 0; i < size; i++)
+		entry[i] = value;
+
+	__asm__ __volatile__(
+		"mcr	p15, 0, %0, c7, c10, 1		@ flush entry\n\t"
+		"dsb\n\t"
+		"isb\n\t"
+		:
+		: "r" (entry)
+	);
+	__tlb_invalidate(addr);
+}
+
+/*
+ *  Return the number of duplicate entries associated with entry value.
+ *  Supersections and Large page table entries are replicated 16x.
+ */
+static inline int __entry_size(int sect, int value)
+{
+	u32 size;
+
+	if (sect)
+		size = PMD_IS_SUPERSECTION(value) ? 16 : 1;
+	else
+		size = PTE_IS_LARGE(value) ? 16 : 1;
+
+	return size;
+}
+
+/*
+ *  Change entry permissions to emulate domain manager access
+ */
+static inline int __manager_perm(int sect, int value)
+{
+	u32 edm_value;
+
+	if (sect) {
+		edm_value = (value & ~(PMD_SECT_APX | PMD_SECT_XN)) |
+		(PMD_SECT_AP_READ | PMD_SECT_AP_WRITE);
+	} else {
+		edm_value = (value & ~(PTE_EXT_APX | PTE_EXT_XN)) |
+			(PTE_EXT_AP1 | PTE_EXT_AP0);
+	}
+	return edm_value;
+}
+
+/*
+ *  Restore original HW MMU entry.  Cancels domain manager access
+ */
+static inline void __restore_entry(int index)
+{
+	struct domain_entry_save *entry = &edm_save[index];
+	u32 edm_value;
+
+	if (!entry->mmu_entry)
+		return;
+
+	edm_value = __manager_perm(entry->sect, entry->value);
+
+	if (*entry->mmu_entry == edm_value)
+		__set_entry(entry->mmu_entry, entry->addr,
+			entry->value, entry->size);
+
+	entry->mmu_entry = 0;
+}
+
+/*
+ *  Modify HW MMU entry to grant domain manager access for a given MMU entry.
+ *  This adds full read, write, and exec access permissions.
+ */
+static inline void __set_manager(int sect, u32 *addr)
+{
+	u32 *entry = sect ? __get_pmd_v7(addr) : __get_pte_v7(addr);
+	u32 value;
+	u32 edm_value;
+	u16 size;
+
+	if (!entry)
+		return;
+
+	value = *entry;
+
+	size = __entry_size(sect, value);
+	edm_value = __manager_perm(sect, value);
+
+	__set_entry(entry, addr, edm_value, size);
+
+	__restore_entry(edm_lru);
+
+	edm_save[edm_lru].mmu_entry = entry;
+	edm_save[edm_lru].addr = addr;
+	edm_save[edm_lru].value = value;
+	edm_save[edm_lru].sect = sect;
+	edm_save[edm_lru].size = size;
+
+	edm_lru = LRU_INC(edm_lru);
+}
+
+/*
+ *  Restore original HW MMU entries.
+ *
+ *  entry - MVA for HW MMU entry
+ */
+static inline void __restore(void)
+{
+	if (unlikely(edm_manager_bits)) {
+		u32 i;
+
+		for (i = 0; i < DOMAIN_MMU_ENTRIES; i++)
+			__restore_entry(i);
+	}
+}
+
+/*
+ * Common abort handler code
+ *
+ * If domain manager was actually set, permission fault would not happen.
+ * Open access permissions to emulate.  Save original settings to restore
+ * later. Return 1 to pretend fault did not happen.
+ */
+static int __emulate_domain_manager_abort(u32 fsr, u32 far, int dabort)
+{
+	if (unlikely(FSR_PERMISSION_FAULT(fsr) && edm_manager_bits)) {
+		int domain = dabort ? DFSR_DOMAIN(fsr) : PMD_GET_DOMAIN(far);
+		if (edm_manager_bits & domain_val(domain, DOMAIN_MANAGER)) {
+			unsigned long flags;
+
+			spin_lock_irqsave(&edm_lock, flags);
+
+			__set_manager(FSR_PERMISSION_SECT(fsr), (u32 *) far);
+
+			spin_unlock_irqrestore(&edm_lock, flags);
+			return 1;
+		}
+	}
+	return 0;
+}
+
+/*
+ * Change domain setting.
+ *
+ * Lock and restore original contents.  Extract and save manager bits.  Set
+ * DACR, excluding manager bits.
+ */
+void emulate_domain_manager_set(u32 domain)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&edm_lock, flags);
+
+	if (edm_manager_bits != (domain & DOMAIN_MANAGER_BITS)) {
+		__restore();
+		edm_manager_bits = domain & DOMAIN_MANAGER_BITS;
+	}
+
+	__asm__ __volatile__(
+		"mcr	p15, 0, %0, c3, c0, 0	@ set domain\n\t"
+		"isb"
+		:
+		: "r" (domain & ~DOMAIN_MANAGER_BITS)
+	);
+
+	spin_unlock_irqrestore(&edm_lock, flags);
+}
+
+/*
+ * Switch thread context.  Restore original contents.
+ */
+void emulate_domain_manager_switch_mm(unsigned long pgd_phys,
+	struct mm_struct *mm,
+	void (*switch_mm)(unsigned long pgd_phys, struct mm_struct *))
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&edm_lock, flags);
+
+	__restore();
+
+	/* Call underlying kernel handler */
+	switch_mm(pgd_phys, mm);
+
+	spin_unlock_irqrestore(&edm_lock, flags);
+}
+
+/*
+ * Kernel data_abort hook
+ */
+int emulate_domain_manager_data_abort(u32 dfsr, u32 dfar)
+{
+	return __emulate_domain_manager_abort(dfsr, dfar, 1);
+}
+
+/*
+ * Kernel prefetch_abort hook
+ */
+int emulate_domain_manager_prefetch_abort(u32 ifsr, u32 ifar)
+{
+	return __emulate_domain_manager_abort(ifsr, ifar, 0);
+}
+
+
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index bea3e75..3446863 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -24,6 +24,10 @@
 #include <asm/pgtable.h>
 #include <asm/tlbflush.h>
 
+#ifdef CONFIG_EMULATE_DOMAIN_MANAGER_V7
+#include <asm/domain.h>
+#endif /* CONFIG_EMULATE_DOMAIN_MANAGER_V7 */
+
 #include "fault.h"
 
 /*
@@ -545,6 +549,11 @@ do_DataAbort(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	const struct fsr_info *inf = fsr_info + fsr_fs(fsr);
 	struct siginfo info;
 
+#ifdef CONFIG_EMULATE_DOMAIN_MANAGER_V7
+	if (emulate_domain_manager_data_abort(fsr, addr))
+		return;
+#endif
+
 	if (!inf->fn(addr, fsr & ~FSR_LNX_PF, regs))
 		return;
 
@@ -600,6 +609,11 @@ do_PrefetchAbort(unsigned long addr, unsigned int ifsr, struct pt_regs *regs)
 	const struct fsr_info *inf = ifsr_info + fsr_fs(ifsr);
 	struct siginfo info;
 
+#ifdef CONFIG_EMULATE_DOMAIN_MANAGER_V7
+	if (emulate_domain_manager_prefetch_abort(ifsr, addr))
+		return;
+#endif
+
 	if (!inf->fn(addr, ifsr | FSR_LNX_PF, regs))
 		return;
 
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 88da392..ec6388e 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/domain.h>
 #include <asm/asm-offsets.h>
 #include <asm/hwcap.h>
 #include <asm/pgtable-hwdef.h>
@@ -102,6 +103,11 @@ ENDPROC(cpu_v7_dcache_clean_area)
  */
 ENTRY(cpu_v7_switch_mm)
 #ifdef CONFIG_MMU
+#ifdef CONFIG_EMULATE_DOMAIN_MANAGER_V7
+	ldr	r2, =cpu_v7_switch_mm_private
+	b	emulate_domain_manager_switch_mm
+cpu_v7_switch_mm_private:
+#endif
 	mov	r2, #0
 	ldr	r1, [r1, #MM_CONTEXT_ID]	@ get mm->context.id
 	orr	r0, r0, #TTB_FLAGS
@@ -236,8 +242,10 @@ __v7_setup:
 	mcr	p15, 0, r10, c2, c0, 2		@ TTB control register
 	orr	r4, r4, #TTB_FLAGS
 	mcr	p15, 0, r4, c2, c0, 1		@ load TTB1
+#ifndef CONFIG_EMULATE_DOMAIN_MANAGER_V7
 	mov	r10, #0x1f			@ domains 0, 1 = manager
 	mcr	p15, 0, r10, c3, c0, 0		@ load domain access register
+#endif
 #ifdef CONFIG_ARCH_MSM_SCORPION
 	mov     r0, #0x77
 	mcr     p15, 3, r0, c15, c0, 3          @ set L2CR1
-- 
1.6.3.3
