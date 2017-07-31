From: ynorov@caviumnetworks.com (Yury Norov)
Date: Mon, 31 Jul 2017 17:48:25 +0300
Subject: [PATCH RFC] arm64: introduce mm_context_t flags
Message-ID: <20170731144825.31322-1-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pratyush, Catalin

In patch 06beb72fbe23e ("arm64: introduce mm context flag to keep 32 bit task
information") you introduce the field flags but use it only for a single flag -
TIF_32BIT. It looks hacky to me for three reasons:
 - The flag is introduced for the case where it's impossible to get the thread
   info structure for the thread associated with mm. So thread_info flags (TIF)
   may also be unavailable at place. This is not the case for the only existing
   user of if - uprobes, but in general this approach requires to include thread
   headers in mm code, which may become unwanted dependency.
 - New flag, if it uses TIF bits, for consistency should for example set/clear
   TIF_32BIT_AARCH64 for ILP32 tasks. And to be completely consistent, with
   current approach we'd mirror thread_info flags to mm_context flags. And keep
   it syncronized.
 - If we start using TIF flags here, we cannot easily add new mm_context
   specific bits because they may mess with TIF ones.

I think that this is not what was intended when you added new field in
mm_context_t.

In this patch the MMCF_AARCH32 flag is introduced, where MMCF prefix stands for
mm_context_t flags. And the new flag is used for uprobes code instead of TIF_32BIT.

Yury

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/include/asm/elf.h       | 4 ++--
 arch/arm64/include/asm/mmu.h       | 2 ++
 arch/arm64/kernel/probes/uprobes.c | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index acae781f7359..de11ed1484e3 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -139,7 +139,7 @@ typedef struct user_fpsimd_state elf_fpregset_t;
 
 #define SET_PERSONALITY(ex)						\
 ({									\
-	clear_bit(TIF_32BIT, &current->mm->context.flags);		\
+	clear_bit(MMCF_AARCH32, &current->mm->context.flags);		\
 	clear_thread_flag(TIF_32BIT);					\
 	current->personality &= ~READ_IMPLIES_EXEC;			\
 })
@@ -195,7 +195,7 @@ typedef compat_elf_greg_t		compat_elf_gregset_t[COMPAT_ELF_NGREG];
  */
 #define COMPAT_SET_PERSONALITY(ex)					\
 ({									\
-	set_bit(TIF_32BIT, &current->mm->context.flags);		\
+	set_bit(MMCF_AARCH32, &current->mm->context.flags);		\
 	set_thread_flag(TIF_32BIT);					\
  })
 #define COMPAT_ARCH_DLINFO
diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 5468c834b072..3ae24ed11ae3 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -16,6 +16,8 @@
 #ifndef __ASM_MMU_H
 #define __ASM_MMU_H
 
+#define MMCF_AARCH32	0x1
+
 typedef struct {
 	atomic64_t	id;
 	void		*vdso;
diff --git a/arch/arm64/kernel/probes/uprobes.c b/arch/arm64/kernel/probes/uprobes.c
index 26c998534dca..f29ef6b297e4 100644
--- a/arch/arm64/kernel/probes/uprobes.c
+++ b/arch/arm64/kernel/probes/uprobes.c
@@ -40,7 +40,7 @@ int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	probe_opcode_t insn;
 
 	/* TODO: Currently we do not support AARCH32 instruction probing */
-	if (test_bit(TIF_32BIT, &mm->context.flags))
+	if (test_bit(MMCF_AARCH32, &mm->context.flags))
 		return -ENOTSUPP;
 	else if (!IS_ALIGNED(addr, AARCH64_INSN_SIZE))
 		return -EINVAL;
-- 
2.11.0
