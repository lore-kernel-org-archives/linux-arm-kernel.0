From: will.deacon@arm.com (Will Deacon)
Date: Fri, 19 Jun 2015 13:56:33 +0100
Subject: [PATCH] arm64: vdso: work-around broken ELF toolchains in Makefile
Message-ID: <1434718593-3648-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When building the kernel with a bare-metal (ELF) toolchain, the -shared
option may not be passed down to collect2, resulting in silent corruption
of the vDSO image (in particular, the DYNAMIC section is omitted).

The effect of this corruption is that the dynamic linker fails to find
the vDSO symbols and libc is instead used for the syscalls that we
intended to optimise (e.g. gettimeofday). Functionally, there is no
issue as the sigreturn trampoline is still intact and located by the
kernel.

This patch fixes the problem by explicitly passing -shared to the linker
when building the vDSO.

Cc: <stable@vger.kernel.org>
Reported-by: Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Reported-by: James Greenlaigh <james.greenhalgh@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/vdso/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index ff3bddea482d..f6fe17d88da5 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -15,6 +15,10 @@ ccflags-y := -shared -fno-common -fno-builtin
 ccflags-y += -nostdlib -Wl,-soname=linux-vdso.so.1 \
 		$(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
 
+# Workaround for bare-metal (ELF) toolchains that neglect to pass -shared
+# down to collect2, resulting in silent corruption of the vDSO image.
+ccflags-y += -Wl,-shared
+
 obj-y += vdso.o
 extra-y += vdso.lds vdso-offsets.h
 CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
-- 
2.1.4
