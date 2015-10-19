From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Mon, 19 Oct 2015 14:19:37 +0100
Subject: [PATCHv4 11/12] arm64: Add 16K page size support
In-Reply-To: <1445260779-22242-1-git-send-email-suzuki.poulose@arm.com>
References: <1445260779-22242-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1445260779-22242-12-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch turns on the 16K page support in the kernel. We
support 48bit VA (4 level page tables) and 47bit VA (3 level
page tables).

With 16K we can map 128 entries using contiguous bit hint
at level 3 to map 2M using single TLB entry.

TODO: 16K supports 32 contiguous entries at level 2 to get us
1G(which is not yet supported by the infrastructure). That should
be a separate patch altogether.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Jeremy Linton <jeremy.linton@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Steve Capper <steve.capper@linaro.org>
Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

---
Changes since V3:
  - Fix CONT_SHIFT - Spotted by: Jeremey Linton
  - Add comments around FORCE_MAX_ZONEORDER
  - Fix the nits pointed out by Markt show

Changes since V2:
  - Add CONT_SHIFT definitions for 16K
  - Disable KVM for now - Recommended by Marc & Christoffer
---
 arch/arm64/Kconfig                   |   42 ++++++++++++++++++++++++++++++----
 arch/arm64/include/asm/page.h        |    3 +++
 arch/arm64/include/asm/sysreg.h      |    3 +++
 arch/arm64/include/asm/thread_info.h |    2 ++
 arch/arm64/kvm/Kconfig               |    3 +++
 arch/arm64/mm/proc.S                 |    4 +++-
 6 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 13b51a0..8541664 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -173,7 +173,8 @@ config PGTABLE_LEVELS
 	default 2 if ARM64_64K_PAGES && ARM64_VA_BITS_42
 	default 3 if ARM64_64K_PAGES && ARM64_VA_BITS_48
 	default 3 if ARM64_4K_PAGES && ARM64_VA_BITS_39
-	default 4 if ARM64_4K_PAGES && ARM64_VA_BITS_48
+	default 3 if ARM64_16K_PAGES && ARM64_VA_BITS_47
+	default 4 if !ARM64_64K_PAGES && ARM64_VA_BITS_48
 
 source "init/Kconfig"
 
@@ -363,6 +364,13 @@ config ARM64_4K_PAGES
 	help
 	  This feature enables 4KB pages support.
 
+config ARM64_16K_PAGES
+	bool "16KB"
+	help
+	  The system will use 16KB pages support. AArch32 emulation
+	  requires applications compiled with 16K (or a multiple of 16K)
+	  aligned segments.
+
 config ARM64_64K_PAGES
 	bool "64KB"
 	help
@@ -376,6 +384,7 @@ endchoice
 choice
 	prompt "Virtual address space size"
 	default ARM64_VA_BITS_39 if ARM64_4K_PAGES
+	default ARM64_VA_BITS_47 if ARM64_16K_PAGES
 	default ARM64_VA_BITS_42 if ARM64_64K_PAGES
 	help
 	  Allows choosing one of multiple possible virtual address
@@ -390,6 +399,10 @@ config ARM64_VA_BITS_42
 	bool "42-bit"
 	depends on ARM64_64K_PAGES
 
+config ARM64_VA_BITS_47
+	bool "47-bit"
+	depends on ARM64_16K_PAGES
+
 config ARM64_VA_BITS_48
 	bool "48-bit"
 
@@ -399,6 +412,7 @@ config ARM64_VA_BITS
 	int
 	default 39 if ARM64_VA_BITS_39
 	default 42 if ARM64_VA_BITS_42
+	default 47 if ARM64_VA_BITS_47
 	default 48 if ARM64_VA_BITS_48
 
 config CPU_BIG_ENDIAN
@@ -466,7 +480,7 @@ config ARCH_WANT_GENERAL_HUGETLB
 	def_bool y
 
 config ARCH_WANT_HUGE_PMD_SHARE
-	def_bool y if ARM64_4K_PAGES
+	def_bool y if ARM64_4K_PAGES || ARM64_16K_PAGES
 
 config HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	def_bool y
@@ -503,7 +517,25 @@ config XEN
 config FORCE_MAX_ZONEORDER
 	int
 	default "14" if (ARM64_64K_PAGES && TRANSPARENT_HUGEPAGE)
+	default "12" if (ARM64_16K_PAGES && TRANSPARENT_HUGEPAGE)
 	default "11"
+	help
+	  The kernel memory allocator divides physically contiguous memory
+	  blocks into "zones", where each zone is a power of two number of
+	  pages.  This option selects the largest power of two that the kernel
+	  keeps in the memory allocator.  If you need to allocate very large
+	  blocks of physically contiguous memory, then you may need to
+	  increase this value.
+
+	  This config option is actually maximum order plus one. For example,
+	  a value of 11 means that the largest free memory block is 2^10 pages.
+
+	  We make sure that we can allocate upto a HugePage size for each configuration.
+	  Hence we have :
+		MAX_ORDER = (PMD_SHIFT - PAGE_SHIFT) + 1 => PAGE_SHIFT - 2
+
+	  However for 4K, we choose a higher default value, 11 as opposed to 10, giving us
+	  4M allocations matching the default size used by generic code.
 
 menuconfig ARMV8_DEPRECATED
 	bool "Emulate deprecated/obsolete ARMv8 instructions"
@@ -689,9 +721,9 @@ config COMPAT
 	  the user helper functions, VFP support and the ptrace interface are
 	  handled appropriately by the kernel.
 
-	  If you also enabled CONFIG_ARM64_64K_PAGES, please be aware that you
-	  will only be able to execute AArch32 binaries that were compiled with
-	  64k aligned segments.
+	  If you use a page size other than 4KB (i.e, 16KB or 64KB), please be aware
+	  that you will only be able to execute AArch32 binaries that were compiled
+	  with page size aligned segments.
 
 	  If you want to execute 32-bit userspace applications, say Y.
 
diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
index da32354..9b2f5a9 100644
--- a/arch/arm64/include/asm/page.h
+++ b/arch/arm64/include/asm/page.h
@@ -24,6 +24,9 @@
 #ifdef CONFIG_ARM64_64K_PAGES
 #define PAGE_SHIFT		16
 #define CONT_SHIFT		5
+#elif defined(CONFIG_ARM64_16K_PAGES)
+#define PAGE_SHIFT		14
+#define CONT_SHIFT		7
 #else
 #define PAGE_SHIFT		12
 #define CONT_SHIFT		4
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index d59cb23..4b57e10 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -59,6 +59,9 @@
 #if defined(CONFIG_ARM64_4K_PAGES)
 #define ID_AA64MMFR0_TGRAN_SHIFT	ID_AA64MMFR0_TGRAN4_SHIFT
 #define ID_AA64MMFR0_TGRAN_SUPPORTED	ID_AA64MMFR0_TGRAN4_SUPPORTED
+#elif defined(CONFIG_ARM64_16K_PAGES)
+#define ID_AA64MMFR0_TGRAN_SHIFT	ID_AA64MMFR0_TGRAN16_SHIFT
+#define ID_AA64MMFR0_TGRAN_SUPPORTED	ID_AA64MMFR0_TGRAN16_SUPPORTED
 #elif defined(CONFIG_ARM64_64K_PAGES)
 #define ID_AA64MMFR0_TGRAN_SHIFT	ID_AA64MMFR0_TGRAN64_SHIFT
 #define ID_AA64MMFR0_TGRAN_SUPPORTED	ID_AA64MMFR0_TGRAN64_SUPPORTED
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 5eac6a2..90c7ff2 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -25,6 +25,8 @@
 
 #ifdef CONFIG_ARM64_4K_PAGES
 #define THREAD_SIZE_ORDER	2
+#elif defined(CONFIG_ARM64_16K_PAGES)
+#define THREAD_SIZE_ORDER	0
 #endif
 
 #define THREAD_SIZE		16384
diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 5c7e920..6a7d5cd 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -19,6 +19,7 @@ if VIRTUALIZATION
 config KVM
 	bool "Kernel-based Virtual Machine (KVM) support"
 	depends on OF
+	depends on !ARM64_16K_PAGES
 	select MMU_NOTIFIER
 	select PREEMPT_NOTIFIERS
 	select ANON_INODES
@@ -33,6 +34,8 @@ config KVM
 	select HAVE_KVM_IRQFD
 	---help---
 	  Support hosting virtualized guest machines.
+	  We don't support KVM with 16K page tables yet, due to the multiple
+	  levels of fake page tables.
 
 	  If unsure, say N.
 
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 91cb2ea..3a4b8b1 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -30,7 +30,9 @@
 
 #ifdef CONFIG_ARM64_64K_PAGES
 #define TCR_TG_FLAGS	TCR_TG0_64K | TCR_TG1_64K
-#else
+#elif defined(CONFIG_ARM64_16K_PAGES)
+#define TCR_TG_FLAGS	TCR_TG0_16K | TCR_TG1_16K
+#else /* CONFIG_ARM64_4K_PAGES */
 #define TCR_TG_FLAGS	TCR_TG0_4K | TCR_TG1_4K
 #endif
 
-- 
1.7.9.5
