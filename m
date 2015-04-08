From: nathan_lynch@mentor.com (Nathan Lynch)
Date: Wed, 8 Apr 2015 16:41:05 -0500
Subject: [PATCH] ARM: VDSO: depend on CPU_V7
Message-ID: <1428529265-26772-1-git-send-email-nathan_lynch@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(Arnd reported a build break with the VDSO code when targeting v4 (but
not v4t).  I haven't been able to recreate it locally because all the
toolchains I have at hand convert 'bx lr' to 'mov pc,lr' when
targeting v4.)

The __get_datapage routine in the VDSO uses 'bx lr' to return to the
caller.  This is inappropriate when targeting v4 CPUs, and the VDSO is
unlikely to be useful for pre-v7 CPUs anyway due to its reliance on
the generic timers extension, so the easy thing to do here is just
make CONFIG_VDSO depend on CONFIG_CPU_V7.

An alternative considered was to use 'ldr pc,lr' when armv4 (or lower)
is enabled, but Arnd pointed out that this would be broken when
running with a kernel that supports both v4 arnd v4t, and you have a
thumb user space.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
---
 arch/arm/mm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index b7644310236b..b4f92b9a13ac 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -827,7 +827,7 @@ config KUSER_HELPERS
 
 config VDSO
 	bool "Enable VDSO for acceleration of some system calls"
-	depends on AEABI && MMU
+	depends on AEABI && MMU && CPU_V7
 	default y if ARM_ARCH_TIMER
 	select GENERIC_TIME_VSYSCALL
 	help
-- 
1.9.3
