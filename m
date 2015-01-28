From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Jan 2015 20:48:09 +0100
Subject: [PATCH 02/15] ARM: KGDB does not build on BE32
In-Reply-To: <1422474502-3097078-1-git-send-email-arnd@arndb.de>
References: <1422474502-3097078-1-git-send-email-arnd@arndb.de>
Message-ID: <1422474502-3097078-3-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

KGDB requires code patching, which only works on little-endian
or newer big-endian (BE8) machines but not on the older big-endian
ones (BE32) where it results in this build error:

arch/arm/kernel/patch.c: In function '__patch_text_real':
arch/arm/kernel/patch.c:93:4: error: implicit declaration of function '__opcode_to_mem_thumb32' [-Werror=implicit-function-declaration]
    insn = __opcode_to_mem_thumb32(insn);

This adds a Kconfig dependency to avoid the broken case and
for all other symbols that require code patching.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 23a4e4050ba9 ("arm: kgdb: Handle read-only text / modules")
---
 arch/arm/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c0ad9e62192b..b03c6d8dd80b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -29,8 +29,8 @@ config ARM
 	select HARDIRQS_SW_RESEND
 	select HAVE_ARCH_AUDITSYSCALL if (AEABI && !OABI_COMPAT)
 	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
-	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL
-	select HAVE_ARCH_KGDB
+	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32
+	select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32
 	select HAVE_ARCH_SECCOMP_FILTER if (AEABI && !OABI_COMPAT)
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_BPF_JIT
@@ -41,7 +41,7 @@ config ARM
 	select HAVE_DMA_API_DEBUG
 	select HAVE_DMA_ATTRS
 	select HAVE_DMA_CONTIGUOUS if MMU
-	select HAVE_DYNAMIC_FTRACE if (!XIP_KERNEL)
+	select HAVE_DYNAMIC_FTRACE if (!XIP_KERNEL) && !CPU_ENDIAN_BE32
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS if (CPU_V6 || CPU_V6K || CPU_V7) && MMU
 	select HAVE_FTRACE_MCOUNT_RECORD if (!XIP_KERNEL)
 	select HAVE_FUNCTION_GRAPH_TRACER if (!THUMB2_KERNEL)
@@ -55,7 +55,7 @@ config ARM
 	select HAVE_KERNEL_LZMA
 	select HAVE_KERNEL_LZO
 	select HAVE_KERNEL_XZ
-	select HAVE_KPROBES if !XIP_KERNEL
+	select HAVE_KPROBES if !XIP_KERNEL && !CPU_ENDIAN_BE32
 	select HAVE_KRETPROBES if (HAVE_KPROBES)
 	select HAVE_MEMBLOCK
 	select HAVE_MOD_ARCH_SPECIFIC if ARM_UNWIND
-- 
2.1.0.rc2
