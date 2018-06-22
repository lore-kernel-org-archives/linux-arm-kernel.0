From: will.deacon@arm.com (Will Deacon)
Date: Fri, 22 Jun 2018 09:31:17 +0100
Subject: [PATCH v2 3/4] arm64: IPI each CPU after invalidating the I-cache for
 kernel mappings
In-Reply-To: <1529656278-878-1-git-send-email-will.deacon@arm.com>
References: <1529656278-878-1-git-send-email-will.deacon@arm.com>
Message-ID: <1529656278-878-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When invalidating the instruction cache for a kernel mapping via
flush_icache_range(), it is also necessary to flush the pipeline for
other CPUs so that instructions fetched into the pipeline before the
I-cache invalidation are discarded. For example, if module 'foo' is
unloaded and then module 'bar' is loaded into the same area of memory,
a CPU could end up executing instructions from 'foo' when branching into
'bar' if these instructions were fetched into the pipeline before 'foo'
was unloaded.

Whilst this is highly unlikely to occur in practice, particularly as
any exception acts as a context-synchronizing operation, following the
letter of the architecture requires us to execute an ISB on each CPU
in order for the new instruction stream to be visible.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/cacheflush.h | 13 ++++++++++++-
 arch/arm64/kernel/cpu_errata.c      |  2 +-
 arch/arm64/kernel/insn.c            | 18 ++++--------------
 arch/arm64/mm/cache.S               |  4 ++--
 4 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
index d264a7274811..a0ec27066e6f 100644
--- a/arch/arm64/include/asm/cacheflush.h
+++ b/arch/arm64/include/asm/cacheflush.h
@@ -71,7 +71,7 @@
  *		- kaddr  - page address
  *		- size   - region size
  */
-extern void flush_icache_range(unsigned long start, unsigned long end);
+extern void __flush_icache_range(unsigned long start, unsigned long end);
 extern int  invalidate_icache_range(unsigned long start, unsigned long end);
 extern void __flush_dcache_area(void *addr, size_t len);
 extern void __inval_dcache_area(void *addr, size_t len);
@@ -81,6 +81,17 @@ extern void __clean_dcache_area_pou(void *addr, size_t len);
 extern long __flush_cache_user_range(unsigned long start, unsigned long end);
 extern void sync_icache_aliases(void *kaddr, unsigned long len);
 
+static inline void flush_icache_range(unsigned long start, unsigned long end)
+{
+	__flush_icache_range(start, end);
+
+	/*
+	 * IPI all online CPUs so that they undergo a context synchronization
+	 * event and are forced to refetch the new instructions.
+	 */
+	kick_all_cpus_sync();
+}
+
 static inline void flush_cache_mm(struct mm_struct *mm)
 {
 }
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 1d2b6d768efe..0a338a1cd2d7 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -101,7 +101,7 @@ static void __copy_hyp_vect_bpi(int slot, const char *hyp_vecs_start,
 	for (i = 0; i < SZ_2K; i += 0x80)
 		memcpy(dst + i, hyp_vecs_start, hyp_vecs_end - hyp_vecs_start);
 
-	flush_icache_range((uintptr_t)dst, (uintptr_t)dst + SZ_2K);
+	__flush_icache_range((uintptr_t)dst, (uintptr_t)dst + SZ_2K);
 }
 
 static void __install_bp_hardening_cb(bp_hardening_cb_t fn,
diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
index 816d03c4c913..0f6a2e0cfde0 100644
--- a/arch/arm64/kernel/insn.c
+++ b/arch/arm64/kernel/insn.c
@@ -216,8 +216,8 @@ int __kprobes aarch64_insn_patch_text_nosync(void *addr, u32 insn)
 
 	ret = aarch64_insn_write(tp, insn);
 	if (ret == 0)
-		flush_icache_range((uintptr_t)tp,
-				   (uintptr_t)tp + AARCH64_INSN_SIZE);
+		__flush_icache_range((uintptr_t)tp,
+				     (uintptr_t)tp + AARCH64_INSN_SIZE);
 
 	return ret;
 }
@@ -283,18 +283,8 @@ int __kprobes aarch64_insn_patch_text(void *addrs[], u32 insns[], int cnt)
 		if (ret)
 			return ret;
 
-		if (aarch64_insn_hotpatch_safe(insn, insns[0])) {
-			/*
-			 * ARMv8 architecture doesn't guarantee all CPUs see
-			 * the new instruction after returning from function
-			 * aarch64_insn_patch_text_nosync(). So send IPIs to
-			 * all other CPUs to achieve instruction
-			 * synchronization.
-			 */
-			ret = aarch64_insn_patch_text_nosync(addrs[0], insns[0]);
-			kick_all_cpus_sync();
-			return ret;
-		}
+		if (aarch64_insn_hotpatch_safe(insn, insns[0]))
+			return aarch64_insn_patch_text_nosync(addrs[0], insns[0]);
 	}
 
 	return aarch64_insn_patch_text_sync(addrs, insns, cnt);
diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
index 30334d81b021..0c22ede52f90 100644
--- a/arch/arm64/mm/cache.S
+++ b/arch/arm64/mm/cache.S
@@ -35,7 +35,7 @@
  *	- start   - virtual start address of region
  *	- end     - virtual end address of region
  */
-ENTRY(flush_icache_range)
+ENTRY(__flush_icache_range)
 	/* FALLTHROUGH */
 
 /*
@@ -77,7 +77,7 @@ alternative_else_nop_endif
 9:
 	mov	x0, #-EFAULT
 	b	1b
-ENDPROC(flush_icache_range)
+ENDPROC(__flush_icache_range)
 ENDPROC(__flush_cache_user_range)
 
 /*
-- 
2.1.4
