From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 30 Jul 2012 14:30:03 -0700
Subject: [PATCH] ARM: Sort exception table at compile time
Message-ID: <1343683803-15507-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the ARM machine identifier to sortextable and select the
config option so that we can sort the exception table at compile
time. sortextable relies on a section named __ex_table existing
in the vmlinux, but ARM's linker script places the exception
table in the data section. Give the exception table its own
section so that sortextable can find it.

This allows us to skip the runtime sorting step during boot.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Cc: David Daney <david.daney@cavium.com>
---

I can't find any information on why the exception table lives in the data
section. If there's a good reason for that, I'll look into changing
sortextable to look for the __start___ex_table symbol.

 arch/arm/Kconfig              |  1 +
 arch/arm/kernel/vmlinux.lds.S | 19 +++++++++----------
 scripts/sortextable.c         |  1 +
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b25c9d3..2af95e6 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1,6 +1,7 @@
 config ARM
 	bool
 	default y
+	select BUILDTIME_EXTABLE_SORT if MMU
 	select ARCH_HAVE_CUSTOM_GPIO_H
 	select HAVE_AOUT
 	select HAVE_DMA_API_DEBUG
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 36ff15b..0e3e8b4 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -220,16 +220,6 @@ SECTIONS
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
@@ -239,6 +229,15 @@ SECTIONS
 	}
 	_edata_loc = __data_loc + SIZEOF(.data);
 
+	. = ALIGN(4);
+	__ex_table : AT(ADDR(__ex_table) - LOAD_OFFSET) {
+		__start___ex_table = .;
+#ifdef CONFIG_MMU
+		*(__ex_table)
+#endif
+		__stop___ex_table = .;
+	}
+
 #ifdef CONFIG_HAVE_TCM
         /*
 	 * We align everything to a page boundary so we can
diff --git a/scripts/sortextable.c b/scripts/sortextable.c
index 1ca9ceb..591acb3 100644
--- a/scripts/sortextable.c
+++ b/scripts/sortextable.c
@@ -248,6 +248,7 @@ do_file(char const *const fname)
 		custom_sort = sort_x86_table;
 		break;
 	case EM_MIPS:
+	case EM_ARM:
 		break;
 	}  /* end switch */
 
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
