From: stefan@agner.ch (Stefan Agner)
Date: Mon,  1 Oct 2018 00:22:30 +0200
Subject: [PATCH] ARM: disable ARMv6 for Clang older than 8.0
Message-ID: <20180930222230.24167-1-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kernel passes the ArmV6K architecture to the compiler when
using the multi platform selection and enabling ARMv6. Clang
older than version 8.0 emit assembly with an non-existing CPU,
which then makes the assembler fail. Prevent the user from
selecting ARMv6 when using Clang before 8.0.

Signed-off-by: Stefan Agner <stefan@agner.ch>
Link: https://github.com/ClangBuiltLinux/linux/issues/55
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e8cd55a5b04c..8da160757381 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -671,6 +671,7 @@ config ARCH_MULTI_V4_V5
 
 config ARCH_MULTI_V6
 	bool "ARMv6 based platforms (ARM11)"
+	depends on !CC_IS_CLANG || CLANG_VERSION>=80000
 	select ARCH_MULTI_V6_V7
 	select CPU_V6K
 
-- 
2.19.0
