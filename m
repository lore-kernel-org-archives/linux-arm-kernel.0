From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Jan 2015 20:48:13 +0100
Subject: [PATCH 06/15] ARM: disable UACCESS_WITH_MEMCPY and Kprobes for ARMv3
In-Reply-To: <1422474502-3097078-1-git-send-email-arnd@arndb.de>
References: <1422474502-3097078-1-git-send-email-arnd@arndb.de>
Message-ID: <1422474502-3097078-7-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We cannot currently build a kernel with either of these
options when gcc thinks it is building for ARMv3. Just
disabling them helps us build more random configurations.

Note that we don't actually support ARMv3 at all any more,
but when building a kernel for RiscPC with a StrongARM
CPU, we have to pretend to run on ARMv3 anyway.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b03c6d8dd80b..b9b68b467584 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -55,7 +55,7 @@ config ARM
 	select HAVE_KERNEL_LZMA
 	select HAVE_KERNEL_LZO
 	select HAVE_KERNEL_XZ
-	select HAVE_KPROBES if !XIP_KERNEL && !CPU_ENDIAN_BE32
+	select HAVE_KPROBES if !XIP_KERNEL && !CPU_ENDIAN_BE32 && !CPU_32v3
 	select HAVE_KRETPROBES if (HAVE_KPROBES)
 	select HAVE_MEMBLOCK
 	select HAVE_MOD_ARCH_SPECIFIC if ARM_UNWIND
@@ -1726,7 +1726,7 @@ config ALIGNMENT_TRAP
 
 config UACCESS_WITH_MEMCPY
 	bool "Use kernel mem{cpy,set}() for {copy_to,clear}_user()"
-	depends on MMU
+	depends on MMU && !CPU_32v3
 	default y if CPU_FEROCEON
 	help
 	  Implement faster copy_to_user and clear_user methods for CPU
-- 
2.1.0.rc2
