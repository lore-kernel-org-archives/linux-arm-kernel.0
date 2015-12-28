From: bamvor.zhangjian@linaro.org (Bamvor Jian Zhang)
Date: Mon, 28 Dec 2015 16:43:06 +0800
Subject: > diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
In-Reply-To: <1450215766-14765-5-git-send-email-ynorov@caviumnetworks.com>
References: <1450215766-14765-5-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <1451292190-15024-1-git-send-email-bamvor.zhangjian@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I feel we need something like this to avoid the failure of compiling
when build with ARM64_ILP32(which will select COMPAT) and
ARMV8_DEPRECATED (which depends on the opcodes.o).

>From f8b8ffdb449491ecf8ba465238bbdb4625a74ac0 Mon Sep 17 00:00:00 2001
From: Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>
Date: Mon, 28 Dec 2015 12:57:46 +0800
Subject: [PATCH] arm64: compat: fix wrong dependency of ARMV8_DEPRECATED

When compile with ARM64_ILP32, ARMV8_DEPRECATED will be selected due
to the dependency of COMPAT. It leads to the following error:
    LD      init/built-in.o
    arch/arm64/kernel/built-in.o: In function `cp15barrier_handler':
    /home/bamvor/works/source/kernel/linux_ilp32/arch/arm64/kernel/armv8_deprecated.c:467: undefined reference to `arm_check_condition'
    /home/bamvor/works/source/kernel/linux_ilp32/arch/arm64/kernel/armv8_deprecated.c:467: undefined reference to `arm_check_condition'
    arch/arm64/kernel/built-in.o: In function `swp_handler':
    /home/bamvor/works/source/kernel/linux_ilp32/arch/arm64/kernel/armv8_deprecated.c:386: undefined reference to `arm_check_condition'
    /home/bamvor/works/source/kernel/linux_ilp32/arch/arm64/kernel/armv8_deprecated.c:386: undefined reference to `arm_check_condition'
    Makefile:927: recipe for target 'vmlinux' failed
    make: *** [vmlinux] Error 1

This patch fix this by updating the dependency from COMPAT to
AARCH32_EL0.

Signed-off-by: Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>
---
 arch/arm64/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index deec37a..e52fd03 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -509,7 +509,7 @@ config FORCE_MAX_ZONEORDER
 
 menuconfig ARMV8_DEPRECATED
 	bool "Emulate deprecated/obsolete ARMv8 instructions"
-	depends on COMPAT
+	depends on AARCH32_EL0
 	help
 	  Legacy software support may require certain instructions
 	  that have been deprecated or obsoleted in the architecture.
-- 
2.1.4
