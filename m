From: stefan@agner.ch (Stefan Agner)
Date: Sat, 11 Aug 2018 11:52:35 +0200
Subject: [PATCH] ARM: require GCC for FRAME_POINTER
Message-ID: <20180811095235.1938-1-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To produce a meaningful backtrace with FRAME_POINTER enabled the
kernel needs a specific function prologue:
    mov    ip, sp
    stmfd    sp!, {fp, ip, lr, pc}
    sub    fp, ip, #4

To get to the required prologue gcc uses apcs and no-sched-prolog.
This compiler options are not available on clang, and clang is not
able to generate the required prologue. Make the FRAME_POINTER
config symbol dependent on GCC.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 693f84392f1b..cb65cf67dfa2 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -54,7 +54,7 @@ config DEBUG_WX
 # n, but then RMK will have to kill you ;).
 config FRAME_POINTER
 	bool
-	depends on !THUMB2_KERNEL
+	depends on !THUMB2_KERNEL && CC_IS_GCC
 	default y if !ARM_UNWIND || FUNCTION_GRAPH_TRACER
 	help
 	  If you say N here, the resulting kernel will be slightly smaller and
-- 
2.18.0
