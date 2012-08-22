From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 Aug 2012 16:29:38 +0200
Subject: [PATCH 2/4] ARM: allow PID_IN_CONTEXTIDR only for ARMv7
In-Reply-To: <1345645780-2749-1-git-send-email-arnd@arndb.de>
References: <1345645780-2749-1-git-send-email-arnd@arndb.de>
Message-ID: <1345645780-2749-3-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When ARMv6 is enabled, we build the kernel with -march=armv6 or
-march=armv6k, which means the bfi instruction is not available.
Instead, it only works with -march=armv6t2 or -march=armv7-a.

Without this patch, building rand-enIHAOL results in:

/tmp/ccwCsCXC.s: Assembler messages:
/tmp/ccwCsCXC.s:49: Error: selected processor does not support ARM mode `bfi r3,r2,#0,#8'

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig.debug |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index f15f82b..11b9ff4 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -398,6 +398,7 @@ config ARM_KPROBES_TEST
 config PID_IN_CONTEXTIDR
 	bool "Write the current PID to the CONTEXTIDR register"
 	depends on CPU_COPY_V6
+	depends on CPU_V7 && !CPU_V6
 	help
 	  Enabling this option causes the kernel to write the current PID to
 	  the PROCID field of the CONTEXTIDR register, at the expense of some
-- 
1.7.10
