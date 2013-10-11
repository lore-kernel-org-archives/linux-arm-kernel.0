From: ankit.jindal@linaro.org (Ankit Jindal)
Date: Fri, 11 Oct 2013 17:52:12 +0530
Subject: [RFC PATCH 1/4] ARM64: Add Kconfig option to enable Big Endian kernel
In-Reply-To: <1381494135-15085-1-git-send-email-ankit.jindal@linaro.org>
References: <1381494135-15085-1-git-send-email-ankit.jindal@linaro.org>
Message-ID: <1381494135-15085-2-git-send-email-ankit.jindal@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds Kconfig options and relevant Big Endian compiler flags.

Signed-off-by: Ankit Jindal <ankit.jindal@linaro.org>
Signed-off-by: Tushar Jagad <tushar.jagad@linaro.org>
---
 arch/arm64/Kconfig    |    2 ++
 arch/arm64/Makefile   |    7 +++++++
 arch/arm64/mm/Kconfig |    7 +++++++
 3 files changed, 16 insertions(+)
 create mode 100644 arch/arm64/mm/Kconfig

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index f558058..2214ab9 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -285,6 +285,8 @@ config SYSVIPC_COMPAT
 
 endmenu
 
+source "arch/arm64/mm/Kconfig"
+
 source "net/Kconfig"
 
 source "drivers/Kconfig"
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index d90cf79..c92b0f9 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -20,9 +20,16 @@ LIBGCC 		:= $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
 KBUILD_DEFCONFIG := defconfig
 
 KBUILD_CFLAGS	+= -mgeneral-regs-only
+
+ifeq ($(CONFIG_CPU_BIG_ENDIAN),y)
+KBUILD_CPPFLAGS += -mbig-endian
+AS              += -EB
+LD              += -EB
+else
 KBUILD_CPPFLAGS	+= -mlittle-endian
 AS		+= -EL
 LD		+= -EL
+endif
 
 comma = ,
 
diff --git a/arch/arm64/mm/Kconfig b/arch/arm64/mm/Kconfig
new file mode 100644
index 0000000..e4122ac
--- /dev/null
+++ b/arch/arm64/mm/Kconfig
@@ -0,0 +1,7 @@
+config CPU_BIG_ENDIAN
+        bool "Build big-endian kernel"
+        help
+          Say Y if you plan on running a kernel in big-endian mode.
+          Note that your board must be properly built and your board
+          port must properly enable any big-endian related features
+          of your chipset/board/processor.
-- 
1.7.9.5
