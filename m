From: joel.schopp@amd.com (Joel Schopp)
Date: Tue, 22 Jul 2014 12:28:09 -0500
Subject: [PATCH] kvmtool: arm64: fix compilation error
Message-ID: <20140722172809.4939.92258.stgit@joelaarch64.amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently tools/kvm doesn't build on arm64 when gtk3 is present.  The error looks like this:

  LINK     lkvm
ui/gtk3.o: In function `kvm_gtk_key_press':
/extra/sb/linux-kvm/tools/kvm/ui/gtk3.c:201: undefined reference to `kbd_queue'
/extra/sb/linux-kvm/tools/kvm/ui/gtk3.c:204: undefined reference to `kbd_queue'
/extra/sb/linux-kvm/tools/kvm/ui/gtk3.c:216: undefined reference to `kbd_queue'
/extra/sb/linux-kvm/tools/kvm/ui/gtk3.c:217: undefined reference to `kbd_queue'
/extra/sb/linux-kvm/tools/kvm/ui/gtk3.c:218: undefined reference to `kbd_queue'
ui/gtk3.o:/extra/sb/linux-kvm/tools/kvm/ui/gtk3.c:219: more undefined references to `kbd_queue' follow
collect2: error: ld returned 1 exit status
make: *** [lkvm] Error 1

The patch below makes the error go away and the resulting lkvm runs on arm64.

Cc: Pekka Enberg <penberg@kernel.org>
Signed-off-by: Joel Schopp <joel.schopp@amd.com>
---
 tools/kvm/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/kvm/Makefile b/tools/kvm/Makefile
index 880d580..fba60f1 100644
--- a/tools/kvm/Makefile
+++ b/tools/kvm/Makefile
@@ -102,6 +102,7 @@ OBJS	+= hw/pci-shmem.o
 OBJS	+= kvm-ipc.o
 OBJS	+= builtin-sandbox.o
 OBJS	+= virtio/mmio.o
+OBJS	+= hw/i8042.o
 
 # Translate uname -m into ARCH string
 ARCH ?= $(shell uname -m | sed -e s/i.86/i386/ -e s/ppc.*/powerpc/ \
@@ -129,7 +130,6 @@ ifeq ($(ARCH),x86)
 	OBJS	+= x86/kvm.o
 	OBJS	+= x86/kvm-cpu.o
 	OBJS	+= x86/mptable.o
-	OBJS	+= hw/i8042.o
 # Exclude BIOS object files from header dependencies.
 	OTHEROBJS	+= x86/bios.o
 	OTHEROBJS	+= x86/bios/bios-rom.o
