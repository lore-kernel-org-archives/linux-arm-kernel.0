From: achandran@mvista.com (arun chandran)
Date: Wed, 25 Jun 2014 20:39:38 +0530
Subject: [PATCH] Arm64: Fix build error while switching from LE to BE
Message-ID: <53AAE632.3020806@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Selecting CPU_BIG_ENDIAN and building the kernel fails just after
building it for little endian with the message

   VDSOA arch/arm64/kernel/vdso/gettimeofday.o
   VDSOL arch/arm64/kernel/vdso/vdso.so.dbg
/gcc-linaro-aarch64_be-linux-gnu-4.9-2014.05_linux/bin/../lib/gcc/aarch64_be-linux-gnu/4.9.1/../../../../aarch64_be-linux-gnu/bin/ld:
arch/arm64/kernel/vdso/note.o: compiled for a little endian system and
target is big endian
/gcc-linaro-aarch64_be-linux-gnu-4.9-2014.05_linux/bin/../lib/gcc/aarch64_be-linux-gnu/4.9.1/../../../../aarch64_be-linux-gnu/bin/ld:
failed to merge target specific data of file
arch/arm64/kernel/vdso/note.o
/gcc-linaro-aarch64_be-linux-gnu-4.9-2014.05_linux/bin/../lib/gcc/aarch64_be-linux-gnu/4.9.1/../../../../aarch64_be-linux-gnu/bin/ld:
arch/arm64/kernel/vdso/sigreturn.o: compiled for a little endian system
and target is big endian
/gcc-linaro-aarch64_be-linux-gnu-4.9-2014.05_linux/bin/../lib/gcc/aarch64_be-linux-gnu/4.9.1/../../../../aarch64_be-linux-gnu/bin/ld:
failed to merge target specific data of file
arch/arm64/kernel/vdso/sigreturn.o
collect2: error: ld returned 1 exit status
make[2]: *** [arch/arm64/kernel/vdso/vdso.so.dbg] Error 1
make[1]: *** [arch/arm64/kernel/vdso] Error 2
make: *** [arch/arm64/kernel] Error 2
make: *** Waiting for unfinished jobs....

Fix it by 'Forcing' the build in arch/arm64/kernel/vdso/Makefile

Signed-off-by: Arun Chandran <achandran@mvista.com>
---
  arch/arm64/kernel/vdso/Makefile |    2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso/Makefile 
b/arch/arm64/kernel/vdso/Makefile
index 6d20b7d..a268a9a 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -43,7 +43,7 @@ $(obj)/vdso-offsets.h: $(obj)/vdso.so.dbg FORCE
      $(call if_changed,vdsosym)

  # Assembly rules for the .S files
-$(obj-vdso): %.o: %.S
+$(obj-vdso): %.o: %.S FORCE
      $(call if_changed_dep,vdsoas)

  # Actual build commands
-- 
1.7.9.5

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-Arm64-Fix-build-error-while-switching-from-LE-to-BE.patch
Type: text/x-patch
Size: 2189 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140625/dff48525/attachment.bin>
