From: yang.shi@linaro.org (Yang Shi)
Date: Mon,  9 Nov 2015 10:09:55 -0800
Subject: [V3 PATCH] arm64: remove redundant FRAME_POINTER kconfig option and
 force to select it
Message-ID: <1447092595-12644-1-git-send-email-yang.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

FRAME_POINTER is defined in lib/Kconfig.debug, it is unnecessary to redefine
it in arch/arm64/Kconfig.debug. Actually, the one defined in arm64 directory
is never used.
This adds a dependency on DEBUG_KERNEL for building with frame pointers.

ARM64 depends on frame pointer to get correct stack backtrace and need
FRAME_POINTER kconfig option enabled all the time.
However, currect implementation makes it could be disabled, so force it
to be selected by ARM64.

Signed-off-by: Yang Shi <yang.shi@linaro.org>
---
change v3 --> v2:
squash two patches into one.

 arch/arm64/Kconfig       | 1 +
 arch/arm64/Kconfig.debug | 4 ----
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 440d906..b554da2 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -27,6 +27,7 @@ config ARM64
 	select CPU_PM if (SUSPEND || CPU_IDLE)
 	select DCACHE_WORD_ACCESS
 	select EDAC_SUPPORT
+	select FRAME_POINTER
 	select GENERIC_ALLOCATOR
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CLOCKEVENTS_BROADCAST
diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
index d6285ef..915dea7 100644
--- a/arch/arm64/Kconfig.debug
+++ b/arch/arm64/Kconfig.debug
@@ -2,10 +2,6 @@ menu "Kernel hacking"
 
 source "lib/Kconfig.debug"
 
-config FRAME_POINTER
-	bool
-	default y
-
 config ARM64_PTDUMP
 	bool "Export kernel pagetable layout to userspace via debugfs"
 	depends on DEBUG_KERNEL
-- 
2.0.2
