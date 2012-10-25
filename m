From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 24 Oct 2012 17:44:42 -0700
Subject: [PATCHv3] ARM: Sort exception table at compile time
Message-ID: <1351125882-13046-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the ARM machine identifier to sortextable and select the
config option so that we can sort the exception table at compile
time. sortextable relies on a section named __ex_table existing
in the vmlinux, but ARM's linker script places the exception
table in the data section. Give the exception table its own
section so that sortextable can find it.

This allows us to skip the sorting step during boot.

Cc: David Daney <david.daney@cavium.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

Changes since v2:
 * Refreshed against linux-next

 arch/arm/Kconfig              |  1 +
 arch/arm/kernel/vmlinux.lds.S | 19 +++++++++----------
 scripts/sortextable.c         |  1 +
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 73067ef..208414c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -5,6 +5,7 @@ config ARM
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select ARCH_HAVE_CUSTOM_GPIO_H
 	select ARCH_WANT_IPC_PARSE_VERSION
+	select BUILDTIME_EXTABLE_SORT if MMU
 	select CPU_PM if (SUSPEND || CPU_IDLE)
 	select DCACHE_WORD_ACCESS if (CPU_V6 || CPU_V6K || CPU_V7) && !CPU_BIG_ENDIAN
 	select GENERIC_ATOMIC64 if (CPU_V6 || !CPU_32v6K || !AEABI)
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 36ff15b..b9f38e3 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -114,6 +114,15 @@ SECTIONS
 
 	RO_DATA(PAGE_SIZE)
 
+	. = ALIGN(4);
+	__ex_table : AT(ADDR(__ex_table) - LOAD_OFFSET) {
+		__start___ex_table = .;
+#ifdef CONFIG_MMU
+		*(__ex_table)
+#endif
+		__stop___ex_table = .;
+	}
+
 #ifdef CONFIG_ARM_UNWIND
 	/*
 	 * Stack unwinding tables
@@ -220,16 +229,6 @@ SECTIONS
 		READ_MOSTLY_DATA(L1_CACHE_BYTES)
 
 		/*
-		 * The exception fixup table (might need resorting at runtime)
-		 */
-		. = ALIGN(4);
-		__start___ex_table = .;
-#ifdef CONFIG_MMU
-		*(__ex_table)
-#endif
-		__stop___ex_table = .;
-
-		/*
 		 * and the usual data section
 		 */
 		DATA_DATA
diff --git a/scripts/sortextable.c b/scripts/sortextable.c
index f19ddc4..1f10e89 100644
--- a/scripts/sortextable.c
+++ b/scripts/sortextable.c
@@ -248,6 +248,7 @@ do_file(char const *const fname)
 	case EM_S390:
 		custom_sort = sort_relative_table;
 		break;
+	case EM_ARM:
 	case EM_MIPS:
 		break;
 	}  /* end switch */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
