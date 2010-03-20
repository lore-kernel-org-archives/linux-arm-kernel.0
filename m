From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sat, 20 Mar 2010 20:20:07 +0200
Subject: [PATCH 2/4] Locate kernel at 0x30108000 if PM_H1940 is enabled
In-Reply-To: <1269109209-26237-1-git-send-email-anarsoul@gmail.com>
References: <1269109209-26237-1-git-send-email-anarsoul@gmail.com>
Message-ID: <1269109209-26237-3-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If PM_H1940 is enabled, kernel _must_ be located upper then 0x30008000,
because this area (0x30000000-0x30100000) can be used by bootloader. If kernel
is located at 0x30008000, bootloader will corrupt kernel's code during
resume.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/Makefile                   |    2 ++
 arch/arm/mach-s3c2410/Makefile.boot |   10 +++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 2703222..58e4d8e 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -110,6 +110,8 @@ CHECKFLAGS	+= -D__arm__
 head-y		:= arch/arm/kernel/head$(MMUEXT).o arch/arm/kernel/init_task.o
 textofs-y	:= 0x00008000
 textofs-$(CONFIG_ARCH_CLPS711X) := 0x00028000
+# We don't want the htc bootloader to corrupt kernel during resume
+textofs-$(CONFIG_PM_H1940)      := 0x00108000
 # SA1111 DMA bug: we don't want the kernel to live in precious DMA-able memory
 ifeq ($(CONFIG_ARCH_SA1100),y)
 textofs-$(CONFIG_SA1111) := 0x00208000
diff --git a/arch/arm/mach-s3c2410/Makefile.boot b/arch/arm/mach-s3c2410/Makefile.boot
index 7dab2a0..58c1dd7 100644
--- a/arch/arm/mach-s3c2410/Makefile.boot
+++ b/arch/arm/mach-s3c2410/Makefile.boot
@@ -1,3 +1,7 @@
-   zreladdr-y	:= 0x30008000
-params_phys-y	:= 0x30000100
-
+ifeq ($(CONFIG_PM_H1940),y)
+	zreladdr-y		:= 0x30108000
+	params_phys-y	:= 0x30100100
+else
+	zreladdr-y		:= 0x30008000
+	params_phys-y	:= 0x30000100
+endif
-- 
1.7.0.2
