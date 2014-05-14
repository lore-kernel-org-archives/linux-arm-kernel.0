From: kyle@redhat.com (Kyle McMartin)
Date: Wed, 14 May 2014 14:57:21 -0400
Subject: [PATCH] arm64: don't set READ_IMPLIES_EXEC for EM_AARCH64
Message-ID: <20140514185720.GI26038@redacted.bos.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

current->personality & READ_IMPLIES_EXEC is currently being set for
AArch64 binaries, resulting in an executable stack, when no explicit
PT_GNU_STACK header is present.

[kmcmarti at sedition ~]$ uname -p
aarch64
[kmcmarti at sedition ~]$ cat /proc/$$/personality 
00400000

The reason for this is, without an explicit PT_GNU_STACK entry in the
binary, stk is still set to EXSTACK_DEFAULT (which should be
non-executable on AArch64.) As a result, elf_read_implies_exec is true,
and we set READ_IMPLIES_EXEC in binfmt_elf.c:load_elf_binary.

Fix this to return 0 in the native case, and parrot the logic from
arch/arm/kernel/elf.c otherwise. With this patch, binaries correctly
don't have READ_IMPLIES_EXEC set, and we can let PT_GNU_STACK change
things if it's explicitly requested.

Signed-off-by: Kyle McMartin <kyle@redhat.com>

--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -114,7 +114,8 @@ typedef struct user_fpsimd_state elf_fpregset_t;
  */
 #define elf_check_arch(x)		((x)->e_machine == EM_AARCH64)
 
-#define elf_read_implies_exec(ex,stk)	(stk != EXSTACK_DISABLE_X)
+#define elf_read_implies_exec(ex,stk)	(test_thread_flag(TIF_32BIT) \
+					 ? (stk == EXSTACK_ENABLE_X) : 0)
 
 #define CORE_DUMP_USE_REGSET
 #define ELF_EXEC_PAGESIZE	PAGE_SIZE
