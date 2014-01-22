From: jean.pihet@linaro.org (Jean Pihet)
Date: Wed, 22 Jan 2014 15:11:19 +0100
Subject: [PATCH 4/4] ARM64: perf: support dwarf unwinding in compat mode
In-Reply-To: <1390399879-5109-1-git-send-email-jean.pihet@linaro.org>
References: <1390399879-5109-1-git-send-email-jean.pihet@linaro.org>
Message-ID: <1390399879-5109-5-git-send-email-jean.pihet@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for unwinding using the dwarf information in compat
mode. Using the correct user stack pointer allows perf to record
the frames correctly in the native and compat modes.

Note that although the dwarf frame unwinding works ok using
libunwind in native mode (on ARMv7 & ARMv8), some changes are
required to the libunwind code for the compat mode. Those changes
are posted separately on the libunwind mailing list.

Tested on ARMv8 platform with v8 and compat v7 binaries, the latter
are statically built.

Signed-off-by: Jean Pihet <jean.pihet@linaro.org>
---
 arch/arm64/include/asm/compat.h | 2 +-
 arch/arm64/include/asm/ptrace.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
index fda2704..e71f81f 100644
--- a/arch/arm64/include/asm/compat.h
+++ b/arch/arm64/include/asm/compat.h
@@ -228,7 +228,7 @@ static inline compat_uptr_t ptr_to_compat(void __user *uptr)
 	return (u32)(unsigned long)uptr;
 }
 
-#define compat_user_stack_pointer() (current_pt_regs()->compat_sp)
+#define compat_user_stack_pointer() (user_stack_pointer(current_pt_regs()))
 
 static inline void __user *arch_compat_alloc_user_space(long len)
 {
diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index fbb0020..86d5b54 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -133,7 +133,7 @@ struct pt_regs {
 	(!((regs)->pstate & PSR_F_BIT))
 
 #define user_stack_pointer(regs) \
-	((regs)->sp)
+	(!compat_user_mode(regs)) ? ((regs)->sp) : ((regs)->compat_sp)
 
 /*
  * Are the current registers suitable for user mode? (used to maintain
-- 
1.7.11.7
