From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 25 Apr 2016 17:55:08 +0200
Subject: [PATCH] kbuild: fix call to adjust_autoksyms.sh when output directory
 specified
Message-ID: <1461599708-1397-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a different output directory is specified during the build process (with
O= or KBUILD_OUTPUT), the call to adjust_autoksyms.sh script fails with the
following error:
/bin/sh scripts/adjust_autoksyms.sh \
	  "make KBUILD_MODULES=1 -f ../Makefile autoksyms_recursive"
	  /bin/sh: scripts/adjust_autoksyms.sh: No such file or directory
	  make[2]: *** [vmlinux] Error 127
	  make[1]: *** [sub-make] Error 2
	  make: *** [__sub-make] Error 2

Using the absolute path with $(srctree) variable solves the problem.

This is in case the CONFIG_TRIM_UNUSED_KSYMS option is specified.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Fixes: 23121ca2b56b ("kbuild: create/adjust generated/autoksyms.h")
Cc: Nicolas Pitre <nico@linaro.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>
---
Hi Nicolas,

I found this issue while running on today's Linux-next with my ARM
cross-compiler.
I suspect it's the proper way to fix the issue but I may miss some of the
details of the top kernel Makefile.
It does work for my separated output directory setup and I verified it still
compiles an in-sources setup as well (even if it's obvious...).

Bye,


 Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index c3937c5ae3b8..1c26b410ba7b 100644
--- a/Makefile
+++ b/Makefile
@@ -934,7 +934,7 @@ quiet_cmd_link-vmlinux = LINK    $@
 # execute if the rest of the kernel build went well.
 vmlinux: scripts/link-vmlinux.sh $(vmlinux-deps) FORCE
 ifdef CONFIG_TRIM_UNUSED_KSYMS
-	$(Q)$(CONFIG_SHELL) scripts/adjust_autoksyms.sh \
+	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/adjust_autoksyms.sh \
 	  "$(MAKE) KBUILD_MODULES=1 -f $(srctree)/Makefile autoksyms_recursive"
 endif
 ifdef CONFIG_HEADERS_CHECK
@@ -949,13 +949,13 @@ endif
 	+$(call if_changed,link-vmlinux)
 
 autoksyms_recursive: $(vmlinux-deps)
-	$(Q)$(CONFIG_SHELL) scripts/adjust_autoksyms.sh \
+	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/adjust_autoksyms.sh \
 	  "$(MAKE) KBUILD_MODULES=1 -f $(srctree)/Makefile autoksyms_recursive"
 PHONY += autoksyms_recursive
 
 # standalone target for easier testing
 include/generated/autoksyms.h: FORCE
-	$(Q)$(CONFIG_SHELL) scripts/adjust_autoksyms.sh true
+	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/adjust_autoksyms.sh true
 
 # Build samples along the rest of the kernel
 ifdef CONFIG_SAMPLES
-- 
2.1.3
