From: haokexin@gmail.com (Kevin Hao)
Date: Thu, 15 Jan 2015 20:07:33 +0800
Subject: [PATCH v2] arm64: kill off the libgcc dependency
Message-ID: <1421323653-27214-1-git-send-email-haokexin@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arm64 kernel builds fine without the libgcc. Actually it should not
be used at all in the kernel. The following are the reasons indicated
by Russell King:
  Although libgcc is part of the compiler, libgcc is built with the
  expectation that it will be running in userland - it expects to link
  to a libc.  That's why you can't build libgcc without having the glibc
  headers around.

  For example, on ARM, libgcc.a may contain calls to __div0, and it may
  provide its own __div0 implementation, which invokes various Linux
  system calls.

  Various functions reference _GLOBAL_OFFSET_TABLE_ which we don't want
  to have in the kernel.

  Depending on how the compiler was built, libgcc.a may be built for
  ARMv4, ARMv5, ARMv6 or ARMv7, and may not be appropriate for linking
  with the kernel.  (Eg, you wouldn't want to try to link an ARMv7
  libgcc.a in an ARMv5 kernel - and we /really/ don't want the mess
  of having different toolchains for different ARM arch versions.)

  It may also drag in the userspace exception unwind support.

  Meanwhile, having the kernel build the compiler support functions that
  it needs ensures that (a) we know what compiler support functions are
  being used, (b) we know the implementation of those support functions
  are sane for use in the kernel, (c) we can build them with appropriate
  compiler flags for best performance, and (d) we remove an unnecessary
  dependency on the build toolchain.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
Acked-by: Will Deacon <will.deacon@arm.com>
---
v2:
  - Update the commit log.
  - Add ack from Will.

 arch/arm64/Makefile | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 1c43cec971b5..a20c28348be4 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -15,8 +15,6 @@ CPPFLAGS_vmlinux.lds = -DTEXT_OFFSET=$(TEXT_OFFSET)
 OBJCOPYFLAGS	:=-O binary -R .note -R .note.gnu.build-id -R .comment -S
 GZFLAGS		:=-9
 
-LIBGCC 		:= $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
-
 KBUILD_DEFCONFIG := defconfig
 
 KBUILD_CFLAGS	+= -mgeneral-regs-only
@@ -50,7 +48,6 @@ core-$(CONFIG_KVM) += arch/arm64/kvm/
 core-$(CONFIG_XEN) += arch/arm64/xen/
 core-$(CONFIG_CRYPTO) += arch/arm64/crypto/
 libs-y		:= arch/arm64/lib/ $(libs-y)
-libs-y		+= $(LIBGCC)
 libs-$(CONFIG_EFI_STUB) += drivers/firmware/efi/libstub/
 
 # Default target when executing plain make
-- 
1.9.3
