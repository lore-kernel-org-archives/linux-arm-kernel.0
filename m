From: pcc@google.com (Peter Collingbourne)
Date: Tue,  6 Nov 2018 16:39:13 -0800
Subject: [PATCH] arm64: Build vDSO with -ffixed-x18
Message-ID: <20181107003913.19061-1-pcc@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The vDSO needs to be build with x18 reserved in order to accommodate
userspace platform ABIs built on top of Linux that use the register
to carry inter-procedural state, as provided for by the AAPCS.
An example of such a platform ABI is the one that will be used by an
upcoming version of Android.

Although this change is currently a no-op due to the fact that the vDSO
is currently implemented in pure assembly on arm64, it is necessary
in order to prepare for another change [1] that will add C code to
the vDSO.

[1] https://patchwork.kernel.org/patch/10044501/

Signed-off-by: Peter Collingbourne <pcc@google.com>
Cc: Mark Salyzyn <salyzyn@google.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm64/kernel/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index b215c712d897..8cd4707f832a 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -12,7 +12,7 @@ obj-vdso := gettimeofday.o note.o sigreturn.o
 targets := $(obj-vdso) vdso.so vdso.so.dbg
 obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
 
-ccflags-y := -shared -fno-common -fno-builtin
+ccflags-y := -shared -fno-common -fno-builtin -ffixed-x18
 ccflags-y += -nostdlib -Wl,-soname=linux-vdso.so.1 \
 		$(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
 
-- 
2.19.1.930.g4563a0d9d0-goog
