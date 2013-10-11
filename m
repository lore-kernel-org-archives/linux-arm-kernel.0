From: matthew.leach@arm.com (Matthew Leach)
Date: Fri, 11 Oct 2013 14:52:10 +0100
Subject: [PATCH 04/14] arm64: ELF: add support for big-endian executables
In-Reply-To: <1381499540-28794-1-git-send-email-matthew.leach@arm.com>
References: <1381499540-28794-1-git-send-email-matthew.leach@arm.com>
Message-ID: <1381499540-28794-5-git-send-email-matthew.leach@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon <will.deacon@arm.com>

This patch adds support for the aarch64_be ELF format to the AArch64 ELF
loader.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/elf.h |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index e7fa87f..a3e4a55 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -90,11 +90,24 @@ typedef struct user_fpsimd_state elf_fpregset_t;
  * These are used to set parameters in the core dumps.
  */
 #define ELF_CLASS	ELFCLASS64
+#ifdef __AARCH64EB__
+#define ELF_DATA	ELFDATA2MSB
+#else
 #define ELF_DATA	ELFDATA2LSB
+#endif
 #define ELF_ARCH	EM_AARCH64
 
+/*
+ * This yields a string that ld.so will use to load implementation
+ * specific libraries for optimization.  This is more specific in
+ * intent than poking at uname or /proc/cpuinfo.
+ */
 #define ELF_PLATFORM_SIZE	16
+#ifdef __AARCH64EB__
+#define ELF_PLATFORM		("aarch64_be")
+#else
 #define ELF_PLATFORM		("aarch64")
+#endif
 
 /*
  * This is used to ensure we don't load something for the wrong architecture.
-- 
1.7.9.5
