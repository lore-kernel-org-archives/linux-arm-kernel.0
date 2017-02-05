From: w@1wt.eu (Willy Tarreau)
Date: Sun,  5 Feb 2017 20:20:46 +0100
Subject: [PATCH 3.10 059/319] arm64: Define AT_VECTOR_SIZE_ARCH for ARCH_DLINFO
In-Reply-To: <1486322486-8024-1-git-send-email-w@1wt.eu>
References: <1486322486-8024-1-git-send-email-w@1wt.eu>
Message-ID: <1486322486-8024-30-git-send-email-w@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: James Hogan <james.hogan@imgtec.com>

commit 3146bc64d12377a74dbda12b96ea32da3774ae07 upstream.

AT_VECTOR_SIZE_ARCH should be defined with the maximum number of
NEW_AUX_ENT entries that ARCH_DLINFO can contain, but it wasn't defined
for arm64 at all even though ARCH_DLINFO will contain one NEW_AUX_ENT
for the VDSO address.

This shouldn't be a problem as AT_VECTOR_SIZE_BASE includes space for
AT_BASE_PLATFORM which arm64 doesn't use, but lets define it now and add
the comment above ARCH_DLINFO as found in several other architectures to
remind future modifiers of ARCH_DLINFO to keep AT_VECTOR_SIZE_ARCH up to
date.

Fixes: f668cd1673aa ("arm64: ELF definitions")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 arch/arm64/include/asm/elf.h         | 1 +
 arch/arm64/include/uapi/asm/auxvec.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index fe32c0e..e647e6d 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -126,6 +126,7 @@ extern unsigned long randomize_et_dyn(unsigned long base);
 
 #define SET_PERSONALITY(ex)		clear_thread_flag(TIF_32BIT);
 
+/* update AT_VECTOR_SIZE_ARCH if the number of NEW_AUX_ENT entries changes */
 #define ARCH_DLINFO							\
 do {									\
 	NEW_AUX_ENT(AT_SYSINFO_EHDR,					\
diff --git a/arch/arm64/include/uapi/asm/auxvec.h b/arch/arm64/include/uapi/asm/auxvec.h
index 22d6d88..4cf0c17 100644
--- a/arch/arm64/include/uapi/asm/auxvec.h
+++ b/arch/arm64/include/uapi/asm/auxvec.h
@@ -19,4 +19,6 @@
 /* vDSO location */
 #define AT_SYSINFO_EHDR	33
 
+#define AT_VECTOR_SIZE_ARCH 1 /* entries in ARCH_DLINFO */
+
 #endif
-- 
2.8.0.rc2.1.gbe9624a
