From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun,  3 Apr 2016 23:39:19 +0900
Subject: [RFC PATCH 1/9] ARM: prepare arch/arm/platforms for immigration
In-Reply-To: <1459694367-18635-1-git-send-email-yamada.masahiro@socionext.com>
References: <1459694367-18635-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1459694367-18635-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At the point of v4.6-rc1, we have 71 mach-* directories in arch/arm/
and 42 of them do not have either Makefile.boot or an SoC header
directory (mach-*/include/mach).  In other words, 60 % of mach-*
directories lost reason to sit there.  We expect more SoCs will do
as the progress of Multi-platform conversion.

This commit creates a new home "arch/arm/platforms/" for such SoCs,
where we can use the standard Makefile notation "obj-y" instead of
the ARM special one "machine-y".

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/Kconfig            | 2 ++
 arch/arm/Makefile           | 1 +
 arch/arm/platforms/Kconfig  | 1 +
 arch/arm/platforms/Makefile | 3 +++
 4 files changed, 7 insertions(+)
 create mode 100644 arch/arm/platforms/Kconfig
 create mode 100644 arch/arm/platforms/Makefile

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index cdfa6c2..91e62d4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -716,6 +716,8 @@ config ARCH_VIRT
 	select ARM_PSCI
 	select HAVE_ARM_ARCH_TIMER
 
+source "arch/arm/platforms/Kconfig"
+
 #
 # This is sorted alphabetically by mach-* pathname.  However, plat-*
 # Kconfigs may be included either alphabetically (according to the
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 8c3ce2a..9052487 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -289,6 +289,7 @@ core-y				+= arch/arm/net/
 core-y				+= arch/arm/crypto/
 core-y				+= arch/arm/firmware/
 core-y				+= $(machdirs) $(platdirs)
+core-y				+= arch/arm/platforms/
 
 drivers-$(CONFIG_OPROFILE)      += arch/arm/oprofile/
 
diff --git a/arch/arm/platforms/Kconfig b/arch/arm/platforms/Kconfig
new file mode 100644
index 0000000..db3d104
--- /dev/null
+++ b/arch/arm/platforms/Kconfig
@@ -0,0 +1 @@
+# This is sorted alphabetically by directory pathname.
diff --git a/arch/arm/platforms/Makefile b/arch/arm/platforms/Makefile
new file mode 100644
index 0000000..5b2bd85
--- /dev/null
+++ b/arch/arm/platforms/Makefile
@@ -0,0 +1,3 @@
+# This list sorted alphanumerically by CONFIG_* macro name.
+
+obj- += dummy.o
-- 
1.9.1
