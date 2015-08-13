From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Thu, 13 Aug 2015 12:34:04 +0100
Subject: [PATCH 14/14] arm64: 36 bit VA
In-Reply-To: <1439465645-22584-1-git-send-email-suzuki.poulose@arm.com>
References: <1439465645-22584-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1439465645-22584-15-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>

36bit VA lets us use 2 level page tables while limiting the
available address space to 64GB.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/Kconfig |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 8327edf..0407fd3 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -164,6 +164,7 @@ config FIX_EARLYCON_MEM
 
 config PGTABLE_LEVELS
 	int
+	default 2 if ARM64_16K_PAGES && ARM64_VA_BITS_36
 	default 2 if ARM64_64K_PAGES && ARM64_VA_BITS_42
 	default 3 if ARM64_64K_PAGES && ARM64_VA_BITS_48
 	default 3 if ARM64_4K_PAGES && ARM64_VA_BITS_39
@@ -472,6 +473,10 @@ choice
 	  space sizes. The level of translation table is determined by
 	  a combination of page size and virtual address space size.
 
+config ARM64_VA_BITS_36
+	bool "36-bit"
+	depends on ARM64_16K_PAGES
+
 config ARM64_VA_BITS_39
 	bool "39-bit"
 	depends on ARM64_4K_PAGES
@@ -491,6 +496,7 @@ endchoice
 
 config ARM64_VA_BITS
 	int
+	default 36 if ARM64_VA_BITS_36
 	default 39 if ARM64_VA_BITS_39
 	default 42 if ARM64_VA_BITS_42
 	default 47 if ARM64_VA_BITS_47
@@ -564,7 +570,7 @@ config ARCH_WANT_GENERAL_HUGETLB
 	def_bool y
 
 config ARCH_WANT_HUGE_PMD_SHARE
-	def_bool y if ARM64_4K_PAGES || ARM64_16K_PAGES
+	def_bool y if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)
 
 config HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	def_bool y
-- 
1.7.9.5
