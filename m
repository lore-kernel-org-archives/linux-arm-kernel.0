From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Jun 2016 17:45:46 +0200
Subject: [PATCH v2 04/11] Kbuild: arch: look for generated headers in obtree
In-Reply-To: <20160615154553.3177021-1-arnd@arndb.de>
References: <20160615154553.3177021-1-arnd@arndb.de>
Message-ID: <20160615154553.3177021-5-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are very few files that need add an -I$(obj) gcc for the preprocessor
or the assembler. For C files, we add always these for both the objtree and
srctree, but for the other ones we require the Makefile to add them, and
Kbuild then adds it for both trees.

As a preparation for changing the meaning of the -I$(obj) directive to
only refer to the srctree, this changes the two instances in arch/x86 to use
an explictit $(objtree) prefix where needed, otherwise we won't find the
headers any more, as reported by the kbuild 0day builder.

arch/x86/realmode/rm/realmode.lds.S:75:20: fatal error: pasyms.h: No such file or directory

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/boot/Makefile           | 2 +-
 arch/powerpc/boot/Makefile         | 2 +-
 arch/powerpc/kvm/Makefile          | 2 +-
 arch/s390/boot/compressed/Makefile | 4 ++--
 arch/um/Makefile                   | 4 ++--
 arch/x86/boot/Makefile             | 2 +-
 arch/x86/realmode/rm/Makefile      | 2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/alpha/boot/Makefile b/arch/alpha/boot/Makefile
index 8399bd0e68e8..0cbe4c59d3ce 100644
--- a/arch/alpha/boot/Makefile
+++ b/arch/alpha/boot/Makefile
@@ -15,7 +15,7 @@ targets		:= vmlinux.gz vmlinux \
 OBJSTRIP	:= $(obj)/tools/objstrip
 
 HOSTCFLAGS	:= -Wall -I$(objtree)/usr/include
-BOOTCFLAGS	+= -I$(obj) -I$(srctree)/$(obj)
+BOOTCFLAGS	+= -I$(objtree)/$(obj) -I$(srctree)/$(obj)
 
 # SRM bootable image.  Copy to offset 512 of a partition.
 $(obj)/bootimage: $(addprefix $(obj)/tools/,mkbb lxboot bootlx) $(obj)/vmlinux.nh
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 8fe78a3efc92..ad3782610cf1 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -43,7 +43,7 @@ ifeq ($(call cc-option-yn, -fstack-protector),y)
 BOOTCFLAGS	+= -fno-stack-protector
 endif
 
-BOOTCFLAGS	+= -I$(obj) -I$(srctree)/$(obj)
+BOOTCFLAGS	+= -I$(objtree)/$(obj) -I$(srctree)/$(obj)
 
 DTC_FLAGS	?= -p 1024
 
diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Makefile
index eba0bea6e032..1f9e5529e692 100644
--- a/arch/powerpc/kvm/Makefile
+++ b/arch/powerpc/kvm/Makefile
@@ -20,7 +20,7 @@ common-objs-y += powerpc.o emulate.o emulate_loadstore.o
 obj-$(CONFIG_KVM_EXIT_TIMING) += timing.o
 obj-$(CONFIG_KVM_BOOK3S_HANDLER) += book3s_exports.o
 
-AFLAGS_booke_interrupts.o := -I$(obj)
+AFLAGS_booke_interrupts.o := -I$(objtree)/$(obj)
 
 kvm-e500-objs := \
 	$(common-objs-y) \
diff --git a/arch/s390/boot/compressed/Makefile b/arch/s390/boot/compressed/Makefile
index 1dd210347e12..2657a29a2026 100644
--- a/arch/s390/boot/compressed/Makefile
+++ b/arch/s390/boot/compressed/Makefile
@@ -31,10 +31,10 @@ quiet_cmd_sizes = GEN $@
 $(obj)/sizes.h: vmlinux
 	$(call if_changed,sizes)
 
-AFLAGS_head.o += -I$(obj)
+AFLAGS_head.o += -I$(objtree)/$(obj)
 $(obj)/head.o: $(obj)/sizes.h
 
-CFLAGS_misc.o += -I$(obj)
+CFLAGS_misc.o += -I$(objtree)/$(obj)
 $(obj)/misc.o: $(obj)/sizes.h
 
 OBJCOPYFLAGS_vmlinux.bin :=  -R .comment -S
diff --git a/arch/um/Makefile b/arch/um/Makefile
index e3abe6f3156d..0ca46ededfc7 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -78,8 +78,8 @@ include $(ARCH_DIR)/Makefile-os-$(OS)
 
 KBUILD_CPPFLAGS += -I$(srctree)/$(HOST_DIR)/include \
 		   -I$(srctree)/$(HOST_DIR)/include/uapi \
-		   -I$(HOST_DIR)/include/generated \
-		   -I$(HOST_DIR)/include/generated/uapi
+		   -I$(objtree)/$(HOST_DIR)/include/generated \
+		   -I$(objtree)/$(HOST_DIR)/include/generated/uapi
 
 # -Derrno=kernel_errno - This turns all kernel references to errno into
 # kernel_errno to separate them from the libc errno.  This allows -fno-common
diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index be8e688fa0d4..12ea8f8384f4 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -96,7 +96,7 @@ $(obj)/zoffset.h: $(obj)/compressed/vmlinux FORCE
 	$(call if_changed,zoffset)
 
 
-AFLAGS_header.o += -I$(obj)
+AFLAGS_header.o += -I$(objtree)/$(obj)
 $(obj)/header.o: $(obj)/zoffset.h
 
 LDFLAGS_setup.elf	:= -T
diff --git a/arch/x86/realmode/rm/Makefile b/arch/x86/realmode/rm/Makefile
index c556c5ae8de5..25012abc3409 100644
--- a/arch/x86/realmode/rm/Makefile
+++ b/arch/x86/realmode/rm/Makefile
@@ -48,7 +48,7 @@ targets += realmode.lds
 $(obj)/realmode.lds: $(obj)/pasyms.h
 
 LDFLAGS_realmode.elf := --emit-relocs -T
-CPPFLAGS_realmode.lds += -P -C -I$(obj)
+CPPFLAGS_realmode.lds += -P -C -I$(objtree)/$(obj)
 
 targets += realmode.elf
 $(obj)/realmode.elf: $(obj)/realmode.lds $(REALMODE_OBJS) FORCE
-- 
2.9.0
