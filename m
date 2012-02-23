From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 23 Feb 2012 17:48:34 +0000
Subject: [PATCH-WIP 13/13] xen/arm: compile grant-table features events and
 xenbus, do not compile pci
In-Reply-To: <alpine.DEB.2.00.1202231714590.23091@kaball-desktop>
References: <alpine.DEB.2.00.1202231714590.23091@kaball-desktop>
Message-ID: <1330019314-20865-13-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Also select XEN_DOM0 by default.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 arch/arm/Kconfig     |    4 ++++
 drivers/xen/Makefile |    7 ++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 57b294c..1a95b35 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2201,9 +2201,13 @@ config NEON
 	  Say Y to include support code for NEON, the ARMv7 Advanced SIMD
 	  Extension.
 
+config XEN_DOM0
+	def_bool y
+
 config XEN
 	bool "Xen guest support on ARM"
 	depends on ARM
+	select XEN_DOM0
 	help
 	  Say Y if you want to run Linux in a Virtual Machine on Xen on ARM.
 
diff --git a/drivers/xen/Makefile b/drivers/xen/Makefile
index dab8305..e3542e1 100644
--- a/drivers/xen/Makefile
+++ b/drivers/xen/Makefile
@@ -1,7 +1,9 @@
 ifeq (CONFIG_X86,y)
-obj-y	+= grant-table.o features.o events.o manage.o balloon.o
-obj-y	+= xenbus/
+obj-y	+= manage.o balloon.o
+obj-$(CONFIG_XEN_DOM0)			+= pci.o
 endif
+obj-y	+= grant-table.o features.o events.o
+obj-y	+= xenbus/
 
 nostackp := $(call cc-option, -fno-stack-protector)
 CFLAGS_features.o			:= $(nostackp)
@@ -21,7 +23,6 @@ obj-$(CONFIG_XEN_SYS_HYPERVISOR)	+= sys-hypervisor.o
 obj-$(CONFIG_XEN_PVHVM)			+= platform-pci.o
 obj-$(CONFIG_XEN_TMEM)			+= tmem.o
 obj-$(CONFIG_SWIOTLB_XEN)		+= swiotlb-xen.o
-obj-$(CONFIG_XEN_DOM0)			+= pci.o
 obj-$(CONFIG_XEN_PCIDEV_BACKEND)	+= xen-pciback/
 
 xen-evtchn-y				:= evtchn.o
-- 
1.7.2.5
