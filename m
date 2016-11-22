From: andre.przywara@arm.com (Andre Przywara)
Date: Tue, 22 Nov 2016 15:09:15 +0000
Subject: [PATCH v2 2/4] Xen: Support adding DT nodes
In-Reply-To: <20161122150917.16524-1-andre.przywara@arm.com>
References: <20161122150917.16524-1-andre.przywara@arm.com>
Message-ID: <20161122150917.16524-3-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoffer Dall <christoffer.dall@linaro.org>

Support adding xen,xen-bootargs node via --with-xen-bootargs to the
configure script and automatically add the Dom0 node to the DT as well.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 Makefile.am  | 23 +++++++++++++++--------
 configure.ac |  9 +++++++++
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index f8b9ec9..db97f9c 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -96,21 +96,28 @@ FDT_OFFSET	:= 0x08000000
 if XEN
 XEN		:= -DXEN=$(XEN_IMAGE)
 XEN_OFFSET	:= 0x08200000
+KERNEL_SIZE	:= $(shell stat -Lc %s $(KERNEL_IMAGE) 2>/dev/null || echo 0)
+DOM0_OFFSET	:= $(shell echo $$(($(PHYS_OFFSET) + $(KERNEL_OFFSET))))
+XEN_BOOTARGS	:= xen,xen-bootargs = \"$(XEN_CMDLINE)\";		\
+		   \#address-cells = <2>;				\
+		   \#size-cells = <2>;					\
+		   module at 1 {						\
+			compatible = \"xen,linux-zimage\", \"xen,multiboot-module\"; \
+			reg = <0x0 $(DOM0_OFFSET) 0x0 $(KERNEL_SIZE)>;	\
+		   };
 endif
 
 if INITRD
 INITRD_FLAGS	:= -DUSE_INITRD
+INITRD_CHOSEN   := linux,initrd-start = <$(FILESYSTEM_START)>;	\
+		   linux,initrd-end = <$(FILESYSTEM_END)>;
+endif
+
 CHOSEN_NODE	:= chosen {						\
 			bootargs = \"$(CMDLINE)\";			\
-			linux,initrd-start = <$(FILESYSTEM_START)>;	\
-			linux,initrd-end = <$(FILESYSTEM_END)>;		\
-		   };
-else
-INITRD_FLAGS	:=
-CHOSEN_NODE	:= chosen {						\
-			bootargs = \"$(CMDLINE)\";			\
+			$(INITRD_CHOSEN)				\
+			$(XEN_BOOTARGS)					\
 		   };
-endif
 
 CPPFLAGS	+= $(INITRD_FLAGS)
 CFLAGS		+= -Iinclude/ -I$(ARCH_SRC)/include/
diff --git a/configure.ac b/configure.ac
index f7e24c7..aff4aad 100644
--- a/configure.ac
+++ b/configure.ac
@@ -98,6 +98,12 @@ AC_ARG_WITH([cmdline],
 	[C_CMDLINE=$withval])
 AC_SUBST([CMDLINE], [$C_CMDLINE])
 
+X_CMDLINE="console=dtuart dtuart=serial0 no-bootscrub"
+AC_ARG_WITH([xen-cmdline],
+	AS_HELP_STRING([--with-xen-cmdline], [set Xen command line]),
+	[X_CMDLINE=$withval])
+AC_SUBST([XEN_CMDLINE], [$X_CMDLINE])
+
 # Allow a user to pass --enable-gicv3
 AC_ARG_ENABLE([gicv3],
 	AS_HELP_STRING([--enable-gicv3], [enable GICv3 instead of GICv2]),
@@ -136,4 +142,7 @@ echo "  Use GICv3?                         ${USE_GICV3}"
 echo "  Boot-wrapper execution state:      AArch${BOOTWRAPPER_ES}"
 echo "  Kernel execution state:            AArch${KERNEL_ES}"
 echo "  Xen image                          ${XEN_IMAGE:-NONE}"
+if test "x${XEN_IMAGE}" != "x"; then
+echo "  Xen command line:                  ${XEN_CMDLINE}"
+fi
 echo ""
-- 
2.9.0
