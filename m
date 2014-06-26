From: achandran@mvista.com (Arun Chandran)
Date: Thu, 26 Jun 2014 12:16:44 +0530
Subject: [PATCH] Arm64: Fix build error while switching from LE to BE
Message-ID: <1403765204-17617-1-git-send-email-achandran@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Selecting CPU_BIG_ENDIAN and building the kernel fails just after
building it for little endian. According to Documentation/kbuild/makefiles.txt,
it is a common mistake to forget 'FORCE' while using 'if_changed'

So fix it by 'Forcing' the build of vdso.  Fixes build errors like these:

arch/arm64/kernel/vdso/note.o: compiled for a little endian system and target is big endian
failed to merge target specific data of file arch/arm64/kernel/vdso/note.o

arch/arm64/kernel/vdso/sigreturn.o: compiled for a little endian system and target is big endian
failed to merge target specific data of file arch/arm64/kernel/vdso/sigreturn.o

Signed-off-by: Arun Chandran <achandran@mvista.com>
---
 arch/arm64/kernel/vdso/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
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
