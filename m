From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 12 Feb 2016 17:06:18 +0100
Subject: [PATCH 1/5] Kbuild: change CC_OPTIMIZE_FOR_SIZE definition
In-Reply-To: <1455293187-179811-1-git-send-email-arnd@arndb.de>
References: <1455293187-179811-1-git-send-email-arnd@arndb.de>
Message-ID: <1455293187-179811-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CC_OPTIMIZE_FOR_SIZE disables the often useful -Wmaybe-unused warning,
because that causes a ridiculous amount of false positives when combined
with -Os.

This means a lot of warnings don't show up in testing by the developers
that should see them with an 'allmodconfig' kernel that has
CC_OPTIMIZE_FOR_SIZE enabled, but only later in randconfig builds
that don't.

This changes the Kconfig logic around CC_OPTIMIZE_FOR_SIZE to make
it a 'choice' statement defaulting to CC_OPTIMIZE_FOR_PERFORMANCE
that gets added for this purpose. The allmodconfig and allyesconfig
kernels now default to -O2 with the maybe-unused warning enabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 init/Kconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index 651ec15ecddb..159a542ef3fc 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1305,6 +1305,17 @@ source "usr/Kconfig"
 
 endif
 
+choice
+	prompt "Compiler optimization level"
+	default CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE
+
+config CC_OPTIMIZE_FOR_PERFORMANCE
+	bool "Optimize for performance"
+	help
+	  This is the default optimization level for the kernel, building
+	  with the "-O2" compiler flag for best performance and most
+	  helpful compile-time warnings.
+
 config CC_OPTIMIZE_FOR_SIZE
 	bool "Optimize for size"
 	help
@@ -1313,6 +1324,8 @@ config CC_OPTIMIZE_FOR_SIZE
 
 	  If unsure, say N.
 
+endchoice
+
 config SYSCTL
 	bool
 
-- 
2.7.0
