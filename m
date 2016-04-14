From: kevin.brodsky@arm.com (Kevin Brodsky)
Date: Thu, 14 Apr 2016 17:31:28 +0100
Subject: [PATCH] arm64: fix vdso-offsets.h dependency
Message-ID: <1460651488-11069-1-git-send-email-kevin.brodsky@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm64/kernel/{vdso,signal}.c include vdso-offsets.h, as well as any
file that includes asm/vdso.h. Therefore, vdso-offsets.h must be
generated before these files are compiled.

The current rules in arm64/kernel/Makefile do not actually enforce
this, because even though $(obj)/vdso is listed as a prerequisite for
vdso-offsets.h, this does not result in the intended effect of
building the vdso subdirectory (before all the other objects). As a
consequence, depending on the order in which the rules are followed,
vdso-offsets.h is updated or not before arm64/kernel/{vdso,signal}.o
are built. The current rules also impose an unnecessary dependency on
vdso-offsets.h for all arm64/kernel/*.o, resulting in unnecessary
rebuilds. This is made obvious when using make -j:

  touch arch/arm64/kernel/vdso/gettimeofday.S && make -j$NCPUS arch/arm64/kernel

will sometimes result in none of arm64/kernel/*.o being
rebuilt, sometimes all of them, or even just some of them.

It is quite difficult to ensure that a header is generated before it
is used with recursive Makefiles by using normal rules.  Instead,
arch-specific generated headers are normally built in the archprepare
recipe in the arch Makefile (see for instance arch/ia64/Makefile).
Unfortunately, asm-offsets.h is included in gettimeofday.S, and must
therefore be generated before vdso-offsets.h, which is not the case if
archprepare is used. For this reason, a rule run after archprepare has
to be used.

This commit adds rules in arm64/Makefile to build vdso-offsets.h
during the prepare step, ensuring that vdso-offsets.h is generated
before building anything. It also removes the now-unnecessary
dependencies on vdso-offsets.h in arm64/kernel/Makefile. Finally, it
removes the duplication of asm-offsets.h between arm64/kernel/vdso/
and include/generated/ and makes include/generated/vdso-offsets.h a
target in arm64/kernel/vdso/Makefile.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---

I am not completely satisfied with the fix, since it uses a hack with
the prepare and prepare0 rules that should not be used in arch
Makefiles. However, all of my other attempts (including explicit
dependencies on gettimeofday.S, etc. in arm64/kernel/Makefile) failed
in some way. Hopefully, a Makefile wizard will come up with a better
solution.

 arch/arm64/Makefile             | 10 ++++++++++
 arch/arm64/kernel/Makefile      |  4 ----
 arch/arm64/kernel/vdso/Makefile |  7 +++----
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 354d75402ace..7bb702a0f1e2 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -119,6 +119,16 @@ archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
 	$(Q)$(MAKE) $(clean)=$(boot)/dts
 
+# We need to generate vdso-offsets.h before compiling certain files in kernel/.
+# In order to do that, we should use the archprepare target, but we can't since
+# asm-offsets.h is included in some files used to generate vdso-offsets.h, and
+# asm-offsets.h is built in prepare0, for which archprepare is a dependency.
+# Therefore we need to generate the header after prepare0 has been made, hence
+# this hack.
+prepare: vdso_prepare
+vdso_prepare: prepare0
+	$(Q)$(MAKE) $(build)=arch/arm64/kernel/vdso include/generated/vdso-offsets.h
+
 define archhelp
   echo  '* Image.gz      - Compressed kernel image (arch/$(ARCH)/boot/Image.gz)'
   echo  '  Image         - Uncompressed kernel image (arch/$(ARCH)/boot/Image)'
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 3793003e16a2..bab85990691d 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -50,7 +50,3 @@ obj-y					+= $(arm64-obj-y) vdso/
 obj-m					+= $(arm64-obj-m)
 head-y					:= head.o
 extra-y					+= $(head-y) vmlinux.lds
-
-# vDSO - this must be built first to generate the symbol offsets
-$(call objectify,$(arm64-obj-y)): $(obj)/vdso/vdso-offsets.h
-$(obj)/vdso/vdso-offsets.h: $(obj)/vdso
diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index b467fd0a384b..62c84f7cb01b 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -23,7 +23,7 @@ GCOV_PROFILE := n
 ccflags-y += -Wl,-shared
 
 obj-y += vdso.o
-extra-y += vdso.lds vdso-offsets.h
+extra-y += vdso.lds
 CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
 
 # Force dependency (incbin is bad)
@@ -42,11 +42,10 @@ $(obj)/%.so: $(obj)/%.so.dbg FORCE
 gen-vdsosym := $(srctree)/$(src)/gen_vdso_offsets.sh
 quiet_cmd_vdsosym = VDSOSYM $@
 define cmd_vdsosym
-	$(NM) $< | $(gen-vdsosym) | LC_ALL=C sort > $@ && \
-	cp $@ include/generated/
+	$(NM) $< | $(gen-vdsosym) | LC_ALL=C sort > $@
 endef
 
-$(obj)/vdso-offsets.h: $(obj)/vdso.so.dbg FORCE
+include/generated/vdso-offsets.h: $(obj)/vdso.so.dbg FORCE
 	$(call if_changed,vdsosym)
 
 # Assembly rules for the .S files
-- 
2.8.0
