From: ext-mika.1.westerberg@nokia.com (Mika Westerberg)
Date: Mon, 29 Mar 2010 12:26:36 +0300
Subject: [RFC 10/10] arm: kdump: add CONFIG_CRASH_DUMP Kconfig option
In-Reply-To: <9c79bfd3046abe3165a79b6ef10c1938c455fa71.1269854500.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<7b747cd930c20ae4a625c981d88e2773c706fce9.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<e3c9449c42a735f9acee8e50af33762ffcadf7b4.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<0f8c479602b8957c49db7ac56b8f90ac6f4da5dc.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<5d4c557a427346c129c8f6cc43c5819177c05ff5.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<f05417b66eedd3c1fe32b433dcdae71a2a151da5.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<49c5365fe4f794390ca2a4de75365953e211ab3f.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<01f3321661bf5d6fc4ba83a0e9fdaf99a7673abc.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<4973ec4f4071a967bcb4f8d72bbe950204fcc83a.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<9c79bfd3046abe3165a79b6ef10c1938c455fa71.1269854500.git.ext-mika.1.westerberg@nokia.com>
Message-ID: <93374240ce1d6ab986503ca1594237c2995303a8.1269854500.git.ext-mika.1.westerberg@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add CONFIG_CRASH_DUMP configuration option which is used by dump capture
kernels. This option also forces one to link kernel in different address (by
default it is 0x02008000).

Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
---
 arch/arm/Kconfig  |   11 +++++++++++
 arch/arm/Makefile |   10 ++++++++++
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c5408bf..4940cff 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1466,6 +1466,17 @@ config ATAGS_PROC
 	  Should the atags used to boot the kernel be exported in an "atags"
 	  file in procfs. Useful with kexec.
 
+config CRASH_DUMP
+	bool "Build kdump crash kernel (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  Build a kernel suitable for use as kdump capture kernel. This should
+	  be set only on dump capture kernels. Note that dump capture kernel
+	  must be loaded into different address than the primary kernel. See
+	  file arch/arm/Makefile how to change this.
+
+	  For more details see Documentation/kdump/kdump.txt
+
 endmenu
 
 menu "CPU Power Management"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index ed820e7..848dee9 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -109,6 +109,16 @@ CHECKFLAGS	+= -D__arm__
 #Default value
 head-y		:= arch/arm/kernel/head$(MMUEXT).o arch/arm/kernel/init_task.o
 textofs-y	:= 0x00008000
+
+#
+# Dump capture kernels are linked by default to address 0x02008000 to prevent
+# them from stepping over the primary kernel memory. Adjust this if you need to
+# link it into a different address.
+#
+# Remember also check your $(MACHINE)/Makefile.boot to correspond this.
+#
+textofs-$(CONFIG_CRASH_DUMP) := 0x02008000
+
 textofs-$(CONFIG_ARCH_CLPS711X) := 0x00028000
 # SA1111 DMA bug: we don't want the kernel to live in precious DMA-able memory
 ifeq ($(CONFIG_ARCH_SA1100),y)
-- 
1.5.6.5
