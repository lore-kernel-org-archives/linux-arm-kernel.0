From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Tue, 15 Sep 2015 16:41:24 +0100
Subject: [PATCH 15/15] arm64: 36 bit VA
In-Reply-To: <1442331684-28818-1-git-send-email-suzuki.poulose@arm.com>
References: <1442331684-28818-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1442331684-28818-16-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>

36bit VA lets us use 2 level page tables while limiting the
available address space to 64GB.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/Kconfig |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 2253819..3560241 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -168,6 +168,7 @@ config FIX_EARLYCON_MEM
 
 config PGTABLE_LEVELS
 	int
+	default 2 if ARM64_16K_PAGES && ARM64_VA_BITS_36
 	default 2 if ARM64_64K_PAGES && ARM64_VA_BITS_42
 	default 3 if ARM64_64K_PAGES && ARM64_VA_BITS_48
 	default 3 if ARM64_4K_PAGES && ARM64_VA_BITS_39
@@ -373,6 +374,10 @@ choice
 	  space sizes. The level of translation table is determined by
 	  a combination of page size and virtual address space size.
 
+config ARM64_VA_BITS_36
+	bool "36-bit"
+	depends on ARM64_16K_PAGES
+
 config ARM64_VA_BITS_39
 	bool "39-bit"
 	depends on ARM64_4K_PAGES
@@ -392,6 +397,7 @@ endchoice
 
 config ARM64_VA_BITS
 	int
+	default 36 if ARM64_VA_BITS_36
 	default 39 if ARM64_VA_BITS_39
 	default 42 if ARM64_VA_BITS_42
 	default 47 if ARM64_VA_BITS_47
@@ -465,7 +471,7 @@ config ARCH_WANT_GENERAL_HUGETLB
 	def_bool y
 
 config ARCH_WANT_HUGE_PMD_SHARE
-	def_bool y if ARM64_4K_PAGES || ARM64_16K_PAGES
+	def_bool y if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)
 
 config HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	def_bool y
-- 
1.7.9.5
