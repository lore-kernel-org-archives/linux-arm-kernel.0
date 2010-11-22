From: rabin@rab.in (Rabin Vincent)
Date: Mon, 22 Nov 2010 23:43:06 +0530
Subject: [PATCH] ftrace/ARM: add ARM support for C version of recordmcount
Message-ID: <1290449586-1512-1-git-send-email-rabin@rab.in>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Depending on the compiler version, ARM GCC calls the mcount function
either __gnu_mcount_nc or mcount.

Also, arch/arm/kernel/ftrace.c references mcount like
kernel/tracing/ftrace.c, so change the exclusion filter to match any
ftrace.c

Signed-off-by: Rabin Vincent <rabin@rab.in>
---
 arch/arm/Kconfig       |    1 +
 scripts/recordmcount.c |    7 +++++--
 scripts/recordmcount.h |    5 +++--
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 81c71da..5fdddda 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -23,6 +23,7 @@ config ARM
 	select PERF_USE_VMALLOC
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_HW_BREAKPOINT if (PERF_EVENTS && (CPU_V6 || CPU_V7))
+	select HAVE_C_RECORDMCOUNT
 	help
 	  The ARM series is a line of low-power-consumption RISC chip designs
 	  licensed by ARM Ltd and targeted at embedded applications and
diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
index f2f32ee..038b3d1 100644
--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -38,6 +38,7 @@ static void *ehdr_curr; /* current ElfXX_Ehdr *  for resource cleanup */
 static char gpfx;	/* prefix for global symbol name (sometimes '_') */
 static struct stat sb;	/* Remember .st_size, etc. */
 static jmp_buf jmpenv;	/* setjmp/longjmp per-file error escape */
+static const char *altmcount;	/* alternate mcount symbol name */
 
 /* setjmp() return values */
 enum {
@@ -299,7 +300,9 @@ do_file(char const *const fname)
 		fail_file();
 	} break;
 	case EM_386:	 reltype = R_386_32;                   break;
-	case EM_ARM:	 reltype = R_ARM_ABS32;                break;
+	case EM_ARM:	 reltype = R_ARM_ABS32;
+			 altmcount = "__gnu_mcount_nc";
+			 break;
 	case EM_IA_64:	 reltype = R_IA64_IMM64;   gpfx = '_'; break;
 	case EM_MIPS:	 /* reltype: e_class    */ gpfx = '_'; break;
 	case EM_PPC:	 reltype = R_PPC_ADDR32;   gpfx = '_'; break;
@@ -357,7 +360,7 @@ do_file(char const *const fname)
 int
 main(int argc, char const *argv[])
 {
-	const char ftrace[] = "kernel/trace/ftrace.o";
+	const char ftrace[] = "/ftrace.o";
 	int ftrace_size = sizeof(ftrace) - 1;
 	int n_error = 0;  /* gcc-4.3.0 false positive complaint */
 
diff --git a/scripts/recordmcount.h b/scripts/recordmcount.h
index 58e933a..8087bc8 100644
--- a/scripts/recordmcount.h
+++ b/scripts/recordmcount.h
@@ -275,11 +275,12 @@ static uint_t *sift_rel_mcount(uint_t *mlocp,
 			Elf_Sym const *const symp =
 				&sym0[Elf_r_sym(relp)];
 			char const *symname = &str0[w(symp->st_name)];
+			char const *mcount = '_' == gpfx ? "_mcount" : "mcount";
 
 			if ('.' == symname[0])
 				++symname;  /* ppc64 hack */
-			if (0 == strcmp((('_' == gpfx) ? "_mcount" : "mcount"),
-					symname))
+			if (0 == strcmp(mcount, symname) ||
+			    (altmcount && 0 == strcmp(altmcount, symname)))
 				mcountsym = Elf_r_sym(relp);
 		}
 
-- 
1.7.2.3
