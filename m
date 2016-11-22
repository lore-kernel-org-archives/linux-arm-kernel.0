From: andre.przywara@arm.com (Andre Przywara)
Date: Tue, 22 Nov 2016 15:09:14 +0000
Subject: [PATCH v2 1/4] Support for building in a Xen binary
In-Reply-To: <20161122150917.16524-1-andre.przywara@arm.com>
References: <20161122150917.16524-1-andre.przywara@arm.com>
Message-ID: <20161122150917.16524-2-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoffer Dall <christoffer.dall@linaro.org>

Add support for building a Xen binary which includes a Dom0 image and
the Dom0 command-line.

If the user specifies --with-xen=<Xen>, where Xen is an appropriate
AArch64 Xen binary, the build system will generate a xen-system.axf
instead of a linux-system.axf.

Original patch from Ian Campbell, but I modified most of it so all bugs
are probably mine.
[Andre: adapt to newest boot-wrapper branch, increase load address,
	fixup Xen image file test]

Cc: Ian Campbell <ijc@hellion.org.uk>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .gitignore    |  1 +
 Makefile.am   | 10 +++++++---
 boot_common.c |  4 ++--
 configure.ac  | 17 +++++++++++++++++
 model.lds.S   | 14 ++++++++++++++
 5 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/.gitignore b/.gitignore
index 8653852..80770c0 100644
--- a/.gitignore
+++ b/.gitignore
@@ -14,6 +14,7 @@ configure
 dtc
 fdt.dtb
 Image
+Xen
 install-sh
 Makefile
 Makefile.in
diff --git a/Makefile.am b/Makefile.am
index 692d2cc..f8b9ec9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -85,7 +85,6 @@ TEXT_LIMIT	:= 0x80080000
 endif
 
 LD_SCRIPT	:= model.lds.S
-IMAGE		:= linux-system.axf
 
 FS_OFFSET	:= 0x10000000
 FILESYSTEM_START:= $(shell echo $$(($(PHYS_OFFSET) + $(FS_OFFSET))))
@@ -94,6 +93,11 @@ FILESYSTEM_END	:= $(shell echo $$(($(FILESYSTEM_START) + $(FILESYSTEM_SIZE))))
 
 FDT_OFFSET	:= 0x08000000
 
+if XEN
+XEN		:= -DXEN=$(XEN_IMAGE)
+XEN_OFFSET	:= 0x08200000
+endif
+
 if INITRD
 INITRD_FLAGS	:= -DUSE_INITRD
 CHOSEN_NODE	:= chosen {						\
@@ -121,7 +125,7 @@ all: $(IMAGE)
 
 CLEANFILES = $(IMAGE) $(OFILES) model.lds fdt.dtb
 
-$(IMAGE): $(OFILES) model.lds fdt.dtb $(KERNEL_IMAGE) $(FILESYSTEM)
+$(IMAGE): $(OFILES) model.lds fdt.dtb $(KERNEL_IMAGE) $(FILESYSTEM) $(XEN_IMAGE)
 	$(LD) $(LDFLAGS) $(OFILES) -o $@ --script=model.lds
 
 %.o: %.S Makefile
@@ -131,7 +135,7 @@ $(IMAGE): $(OFILES) model.lds fdt.dtb $(KERNEL_IMAGE) $(FILESYSTEM)
 	$(CC) $(CPPFLAGS) $(CFLAGS) $(DEFINES) -c -o $@ $<
 
 model.lds: $(LD_SCRIPT) Makefile
-	$(CPP) $(CPPFLAGS) -ansi -DPHYS_OFFSET=$(PHYS_OFFSET) -DMBOX_OFFSET=$(MBOX_OFFSET) -DKERNEL_OFFSET=$(KERNEL_OFFSET) -DFDT_OFFSET=$(FDT_OFFSET) -DFS_OFFSET=$(FS_OFFSET) -DKERNEL=$(KERNEL_IMAGE) -DFILESYSTEM=$(FILESYSTEM) -DTEXT_LIMIT=$(TEXT_LIMIT) -P -C -o $@ $<
+	$(CPP) $(CPPFLAGS) -ansi -DPHYS_OFFSET=$(PHYS_OFFSET) -DMBOX_OFFSET=$(MBOX_OFFSET) -DKERNEL_OFFSET=$(KERNEL_OFFSET) -DFDT_OFFSET=$(FDT_OFFSET) -DFS_OFFSET=$(FS_OFFSET) $(XEN) -DXEN_OFFSET=$(XEN_OFFSET) -DKERNEL=$(KERNEL_IMAGE) -DFILESYSTEM=$(FILESYSTEM) -DTEXT_LIMIT=$(TEXT_LIMIT) -P -C -o $@ $<
 
 fdt.dtb: $(KERNEL_DTB) Makefile gen-cpu-nodes.sh
 	( $(DTC) -O dts -I dtb $(KERNEL_DTB) ; echo "/ { $(CHOSEN_NODE) $(PSCI_NODE) $(CPUS_NODE) };" ) | $(DTC) -O dtb -o $@ -
diff --git a/boot_common.c b/boot_common.c
index 4947fe3..e7b8e1d 100644
--- a/boot_common.c
+++ b/boot_common.c
@@ -9,7 +9,7 @@
 #include <cpu.h>
 #include <spin.h>
 
-extern unsigned long kernel;
+extern unsigned long entrypoint;
 extern unsigned long dtb;
 
 void init_platform(void);
@@ -67,7 +67,7 @@ void __noreturn first_spin(unsigned int cpu, unsigned long *mbox,
 	if (cpu == 0) {
 		init_platform();
 
-		*mbox = (unsigned long)&kernel;
+		*mbox = (unsigned long)&entrypoint;
 		sevl();
 		spin(mbox, invalid, 1);
 	} else {
diff --git a/configure.ac b/configure.ac
index ab8f5b3..f7e24c7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -40,6 +40,18 @@ AC_ARG_WITH([dtb],
 	AS_HELP_STRING([--with-dtb], [Specify a particular DTB to use]),
 	[KERN_DTB="$withval"])
 
+AC_ARG_WITH([xen],
+	AS_HELP_STRING([--with-xen], [Compile for Xen, and Specify a particular Xen to use]),
+	X_IMAGE=$withval)
+
+AS_IF([test "x$X_IMAGE" == "x"], [],
+      [AS_IF([test ! -f "$X_IMAGE"],
+	     [AC_MSG_ERROR([Could not find Xen hypervisor binary: $X_IMAGE])]
+      )]
+)
+AC_SUBST([XEN_IMAGE], [$X_IMAGE])
+AM_CONDITIONAL([XEN], [test "x$X_IMAGE" != "x"])
+
 # Ensure that the user has provided us with a sane kernel dir.
 m4_define([CHECKFILES], [KERN_DIR,
 	KERN_DTB,
@@ -50,6 +62,10 @@ m4_foreach([checkfile], [CHECKFILES],
 
 AC_SUBST([KERNEL_IMAGE], [$KERN_IMAGE])
 AC_SUBST([KERNEL_DTB], [$KERN_DTB])
+AS_IF([test "x$X_IMAGE" != "x"],
+      [AC_SUBST([IMAGE], ["xen-system.axf"])],
+      [AC_SUBST([IMAGE], ["linux-system.axf"])]
+)
 
 # Allow a user to pass --enable-psci
 AC_ARG_ENABLE([psci],
@@ -119,4 +135,5 @@ echo "  CPU IDs:                           ${CPU_IDS}"
 echo "  Use GICv3?                         ${USE_GICV3}"
 echo "  Boot-wrapper execution state:      AArch${BOOTWRAPPER_ES}"
 echo "  Kernel execution state:            AArch${KERNEL_ES}"
+echo "  Xen image                          ${XEN_IMAGE:-NONE}"
 echo ""
diff --git a/model.lds.S b/model.lds.S
index 51c5684..511f552 100644
--- a/model.lds.S
+++ b/model.lds.S
@@ -16,6 +16,9 @@ OUTPUT_ARCH(aarch64)
 #endif
 TARGET(binary)
 
+#ifdef XEN
+INPUT(XEN)
+#endif
 INPUT(KERNEL)
 INPUT(./fdt.dtb)
 
@@ -36,6 +39,17 @@ SECTIONS
 		KERNEL
 	}
 
+#ifdef XEN
+	.xen (PHYS_OFFSET + XEN_OFFSET): {
+		xen = .;
+		XEN
+	}
+
+	entrypoint = xen;
+#else
+	entrypoint = kernel;
+#endif
+
 	.dtb (PHYS_OFFSET + FDT_OFFSET): {
 		dtb = .;
 		./fdt.dtb
-- 
2.9.0
