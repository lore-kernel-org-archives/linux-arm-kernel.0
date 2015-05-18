From: nathan_lynch@mentor.com (Nathan Lynch)
Date: Mon, 18 May 2015 12:43:45 -0500
Subject: [PATCH 1/2] ARM: VDSO: group link options
In-Reply-To: <1431971026-18317-1-git-send-email-nathan_lynch@mentor.com>
References: <1431971026-18317-1-git-send-email-nathan_lynch@mentor.com>
Message-ID: <1431971026-18317-2-git-send-email-nathan_lynch@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the VDSO's link options are kind of a mess spread between
ccflags-y and cmd_vdsold.  Collect linker directives into one
variable, VDSO_LDFLAGS, and use that in cmd_vdsold.

Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
---
 arch/arm/vdso/Makefile | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
index 8aa791051029..89182ad44ee8 100644
--- a/arch/arm/vdso/Makefile
+++ b/arch/arm/vdso/Makefile
@@ -6,9 +6,14 @@ obj-vdso := vgettimeofday.o datapage.o
 targets := $(obj-vdso) vdso.so vdso.so.dbg vdso.so.raw vdso.lds
 obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
 
-ccflags-y := -shared -fPIC -fno-common -fno-builtin -fno-stack-protector
-ccflags-y += -nostdlib -Wl,-soname=linux-vdso.so.1 -DDISABLE_BRANCH_PROFILING
-ccflags-y += -Wl,--no-undefined $(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
+ccflags-y := -fPIC -fno-common -fno-builtin -fno-stack-protector
+ccflags-y += -DDISABLE_BRANCH_PROFILING
+
+VDSO_LDFLAGS := -Wl,-Bsymbolic -Wl,--no-undefined -Wl,-soname=linux-vdso.so.1
+VDSO_LDFLAGS += -Wl,-z,max-page-size=4096 -Wl,-z,common-page-size=4096
+VDSO_LDFLAGS += -nostdlib -shared
+VDSO_LDFLAGS += $(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
+VDSO_LDFLAGS += $(call cc-ldoption, -Wl$(comma)--build-id)
 
 obj-$(CONFIG_VDSO) += vdso.o
 extra-$(CONFIG_VDSO) += vdso.lds
@@ -40,10 +45,8 @@ $(obj)/%.so: $(obj)/%.so.dbg FORCE
 
 # Actual build commands
 quiet_cmd_vdsold = VDSO    $@
-      cmd_vdsold = $(CC) $(c_flags) -Wl,-T $(filter %.lds,$^) $(filter %.o,$^) \
-                   $(call cc-ldoption, -Wl$(comma)--build-id) \
-                   -Wl,-Bsymbolic -Wl,-z,max-page-size=4096 \
-                   -Wl,-z,common-page-size=4096 -o $@
+      cmd_vdsold = $(CC) $(c_flags) $(VDSO_LDFLAGS) \
+                   -Wl,-T $(filter %.lds,$^) $(filter %.o,$^) -o $@
 
 quiet_cmd_vdsomunge = MUNGE   $@
       cmd_vdsomunge = $(objtree)/$(obj)/vdsomunge $< $@
-- 
2.1.0
