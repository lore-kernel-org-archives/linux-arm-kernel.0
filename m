From: jslaby@suse.cz (Jiri Slaby)
Date: Thu, 29 Sep 2016 12:23:59 +0200
Subject: [PATCH 3.12 003/119] arm64: Define AT_VECTOR_SIZE_ARCH for ARCH_DLINFO
In-Reply-To: <a528a0fa6d67ebe60bfc762c72b316d28ed21dea.1475144721.git.jslaby@suse.cz>
References: <a528a0fa6d67ebe60bfc762c72b316d28ed21dea.1475144721.git.jslaby@suse.cz>
Message-ID: <29fe597d4b04182ebcf448b0b90cde7ff8f9d2f5.1475144721.git.jslaby@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: James Hogan <james.hogan@imgtec.com>

3.12-stable review patch.  If anyone has any objections, please let me know.

===============

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
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/arm64/include/asm/elf.h         | 1 +
 arch/arm64/include/uapi/asm/auxvec.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index e7fa87f9201b..a4e1758c44dc 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -124,6 +124,7 @@ extern unsigned long randomize_et_dyn(unsigned long base);
 
 #define SET_PERSONALITY(ex)		clear_thread_flag(TIF_32BIT);
 
+/* update AT_VECTOR_SIZE_ARCH if the number of NEW_AUX_ENT entries changes */
 #define ARCH_DLINFO							\
 do {									\
 	NEW_AUX_ENT(AT_SYSINFO_EHDR,					\
diff --git a/arch/arm64/include/uapi/asm/auxvec.h b/arch/arm64/include/uapi/asm/auxvec.h
index 22d6d8885854..4cf0c17787a8 100644
--- a/arch/arm64/include/uapi/asm/auxvec.h
+++ b/arch/arm64/include/uapi/asm/auxvec.h
@@ -19,4 +19,6 @@
 /* vDSO location */
 #define AT_SYSINFO_EHDR	33
 
+#define AT_VECTOR_SIZE_ARCH 1 /* entries in ARCH_DLINFO */
+
 #endif
-- 
2.10.0
