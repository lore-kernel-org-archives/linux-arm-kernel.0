From: mark.rutland@arm.com (Mark Rutland)
Date: Wed,  9 Dec 2015 12:44:38 +0000
Subject: [RFC PATCH 03/20] arm64: mm: fold alternatives into .init
In-Reply-To: <1449665095-20774-1-git-send-email-mark.rutland@arm.com>
References: <1449665095-20774-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1449665095-20774-4-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we treat the alternatives separately from other data that's
only used during initialisation, using separate .altinstructions and
.altinstr_replacement linker sections. These are freed for general
allocation separately from .init*. This is problematic as:

* We do not remove execute permissions, as we do for .init, leaving the
  memory executable.

* We pad between them, making the kernel Image bianry up to PAGE_SIZE
  bytes larger than necessary.

This patch moves the two sections into the contiguous region used for
.init*. This saves some memory, ensures that we remove execute
permissions, and allows us to remove some code made redundant by this
reorganisation.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jeremy Linton <jeremy.linton@arm.com>
Cc: Laura Abbott <labbott@fedoraproject.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/alternative.h | 1 -
 arch/arm64/kernel/alternative.c      | 6 ------
 arch/arm64/kernel/vmlinux.lds.S      | 5 ++---
 arch/arm64/mm/init.c                 | 1 -
 4 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
index d56ec07..e4962f0 100644
--- a/arch/arm64/include/asm/alternative.h
+++ b/arch/arm64/include/asm/alternative.h
@@ -19,7 +19,6 @@ struct alt_instr {
 
 void __init apply_alternatives_all(void);
 void apply_alternatives(void *start, size_t length);
-void free_alternatives_memory(void);
 
 #define ALTINSTR_ENTRY(feature)						      \
 	" .word 661b - .\n"				/* label           */ \
diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
index ab9db0e..d2ee1b2 100644
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -158,9 +158,3 @@ void apply_alternatives(void *start, size_t length)
 
 	__apply_alternatives(&region);
 }
-
-void free_alternatives_memory(void)
-{
-	free_reserved_area(__alt_instructions, __alt_instructions_end,
-			   0, "alternatives");
-}
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index a64340d..f943a84 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -140,9 +140,6 @@ SECTIONS
 
 	PERCPU_SECTION(64)
 
-	. = ALIGN(PAGE_SIZE);
-	__init_end = .;
-
 	. = ALIGN(4);
 	.altinstructions : {
 		__alt_instructions = .;
@@ -154,6 +151,8 @@ SECTIONS
 	}
 
 	. = ALIGN(PAGE_SIZE);
+	__init_end = .;
+
 	_data = .;
 	_sdata = .;
 	RW_DATA_SECTION(64, PAGE_SIZE, THREAD_SIZE)
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 17bf39a..9b979e0 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -360,7 +360,6 @@ void free_initmem(void)
 {
 	fixup_init();
 	free_initmem_default(0);
-	free_alternatives_memory();
 }
 
 #ifdef CONFIG_BLK_DEV_INITRD
-- 
1.9.1
