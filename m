From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Thu, 13 Aug 2015 12:33:56 +0100
Subject: [PATCH 06/14] arm64: Clean config usages for page size
In-Reply-To: <1439465645-22584-1-git-send-email-suzuki.poulose@arm.com>
References: <1439465645-22584-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1439465645-22584-7-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>

We use !CONFIG_ARM64_64K_PAGES for CONFIG_ARM64_4K_PAGES
(and vice versa) in code. It all worked well, so far since
we only had two options. Now, with the introduction of 16K,
these cases will break. This patch cleans up the code to
use the required CONFIG symbol expression without the assumption
that !64K => 4K (and vice versa)

Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Steve Capper <steve.capper@linaro.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/Kconfig                   |    4 ++--
 arch/arm64/Kconfig.debug             |    2 +-
 arch/arm64/include/asm/thread_info.h |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 78b89fa..d1fb2a3 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -550,7 +550,7 @@ config ARCH_WANT_GENERAL_HUGETLB
 	def_bool y
 
 config ARCH_WANT_HUGE_PMD_SHARE
-	def_bool y if !ARM64_64K_PAGES
+	def_bool y if ARM64_4K_PAGES
 
 config HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	def_bool y
@@ -762,7 +762,7 @@ source "fs/Kconfig.binfmt"
 
 config COMPAT
 	bool "Kernel support for 32-bit EL0"
-	depends on !ARM64_64K_PAGES || EXPERT
+	depends on ARM64_4K_PAGES || EXPERT
 	select COMPAT_BINFMT_ELF
 	select HAVE_UID16
 	select OLD_SIGSUSPEND3
diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
index d6285ef..c24d6ad 100644
--- a/arch/arm64/Kconfig.debug
+++ b/arch/arm64/Kconfig.debug
@@ -77,7 +77,7 @@ config DEBUG_RODATA
           If in doubt, say Y
 
 config DEBUG_ALIGN_RODATA
-	depends on DEBUG_RODATA && !ARM64_64K_PAGES
+	depends on DEBUG_RODATA && ARM64_4K_PAGES
 	bool "Align linker sections up to SECTION_SIZE"
 	help
 	  If this option is enabled, sections that may potentially be marked as
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index dcd06d1..d9c8c9f 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -23,7 +23,7 @@
 
 #include <linux/compiler.h>
 
-#ifndef CONFIG_ARM64_64K_PAGES
+#ifdef CONFIG_ARM64_4K_PAGES
 #define THREAD_SIZE_ORDER	2
 #endif
 
-- 
1.7.9.5
