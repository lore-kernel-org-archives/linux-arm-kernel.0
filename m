From: ynorov@caviumnetworks.com (Yury Norov)
Date: Sat,  5 Aug 2017 17:40:21 +0300
Subject: [PATCH 1/2] arm64: introduce separated bits for mm_context_t flags
In-Reply-To: <20170805144022.17260-1-ynorov@caviumnetworks.com>
References: <20170805144022.17260-1-ynorov@caviumnetworks.com>
Message-ID: <20170805144022.17260-2-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently mm->context.flags field uses thread_info flags which is not the best
idea for many reasons. For example, mm_context_t doesn't need most of thread_info
flags. And it would be difficult to add new mm-related flag if needed because it
may easily interfere with TIF ones.

To deal with it, the new MMCF_AARCH32 flag is introduced for mm_context_t flags,
where MMCF prefix stands for mm_context_t flags.

RFC: https://lkml.org/lkml/2017/7/31/454
v1:
 - changed the MMCF_AARCH32 bit number from 0x1 to 0x0 and added comment.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
CC: Pratyush Anand <panand@redhat.com>
CC: Catalin Marinas <catalin.marinas@arm.com>
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
index 5468c834b072..2c57b06b2883 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -16,6 +16,8 @@
 #ifndef __ASM_MMU_H
 #define __ASM_MMU_H
 
+#define MMCF_AARCH32	0x0	/* MM hosts AArch32 executables */
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
