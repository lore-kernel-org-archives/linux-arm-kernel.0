From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 31 May 2016 15:57:59 +0100
Subject: [PATCH 1/2] arm64: move {PAGE,CONT}_SHIFT into Kconfig
In-Reply-To: <1464706680-15713-1-git-send-email-mark.rutland@arm.com>
References: <1464706680-15713-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1464706680-15713-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In some cases (e.g. the awk for CONFIG_RANDOMIZE_TEXT_OFFSET) we would
like to make use of PAGE_SHIFT outside of code that can include the
usual header files.

Add a new CONFIG_ARM64_PAGE_SHIFT for this, likewise with
ARM64_CONT_SHIFT for consistency.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Kconfig            | 12 ++++++++++++
 arch/arm64/include/asm/page.h | 12 ++----------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 76747d9..5fe3208 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -113,6 +113,18 @@ config ARCH_PHYS_ADDR_T_64BIT
 config MMU
 	def_bool y
 
+config ARM64_PAGE_SHIFT
+	int
+	default 16 if ARM64_64K_PAGES
+	default 14 if ARM64_16K_PAGES
+	default 12
+
+config ARM64_CONT_SHIFT
+	int
+	default 5 if ARM64_64K_PAGES
+	default 7 if ARM64_16K_PAGES
+	default 4
+
 config ARCH_MMAP_RND_BITS_MIN
        default 14 if ARM64_64K_PAGES
        default 16 if ARM64_16K_PAGES
diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
index 17b45f7..8472c6d 100644
--- a/arch/arm64/include/asm/page.h
+++ b/arch/arm64/include/asm/page.h
@@ -23,16 +23,8 @@
 
 /* PAGE_SHIFT determines the page size */
 /* CONT_SHIFT determines the number of pages which can be tracked together  */
-#ifdef CONFIG_ARM64_64K_PAGES
-#define PAGE_SHIFT		16
-#define CONT_SHIFT		5
-#elif defined(CONFIG_ARM64_16K_PAGES)
-#define PAGE_SHIFT		14
-#define CONT_SHIFT		7
-#else
-#define PAGE_SHIFT		12
-#define CONT_SHIFT		4
-#endif
+#define PAGE_SHIFT		CONFIG_ARM64_PAGE_SHIFT
+#define CONT_SHIFT		CONFIG_ARM64_CONT_SHIFT
 #define PAGE_SIZE		(_AC(1, UL) << PAGE_SHIFT)
 #define PAGE_MASK		(~(PAGE_SIZE-1))
 
-- 
1.9.1
