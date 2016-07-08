From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 8 Jul 2016 12:27:59 +0100
Subject: [PATCH RESEND] arm64: fix vdso-offsets.h dependency
In-Reply-To: <1463071155-7435-1-git-send-email-kevin.brodsky@arm.com>
References: <1463071155-7435-1-git-send-email-kevin.brodsky@arm.com>
Message-ID: <20160708112759.GA22099@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 12, 2016 at 05:39:15PM +0100, Kevin Brodsky wrote:
> I am not completely satisfied with the fix, since it uses a hack with
> the prepare and prepare0 rules that should not be used in arch
> Makefiles. However, all of my other attempts (including explicit
> dependencies on gettimeofday.S, etc. in arm64/kernel/Makefile) failed
> in some way. Hopefully, a Makefile wizard will come up with a better
> solution.

This is the patch I'm going to push to arm64 for-next/core. Thanks for
the report and attempt at fixing it, it saved me from trying to
understand what was going on:

-------------8<------------------------------------
>From 19a5ab422b6ca3b3c8f656ca6d697dbfb577d360 Mon Sep 17 00:00:00 2001
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Fri, 8 Jul 2016 12:13:20 +0100
Subject: [PATCH] arm64: Fix vdso-offsets.h dependency

arch/arm64/kernel/{vdso,signal}.c include generated/vdso-offsets.h, and
therefore the symbol offsets must be generated before these files are
compiled.

The current rules in arm64/kernel/Makefile do not actually enforce
this, because even though $(obj)/vdso is listed as a prerequisite for
vdso-offsets.h, this does not result in the intended effect of
building the vdso subdirectory (before all the other objects). As a
consequence, depending on the order in which the rules are followed,
vdso-offsets.h is updated or not before arm64/kernel/{vdso,signal}.o
are built. The current rules also impose an unnecessary dependency on
vdso-offsets.h for all arm64/kernel/*.o, resulting in unnecessary
rebuilds.

This patch removes the arch/arm64/kernel/vdso/vdso-offsets.h file
generation, leaving only the include/generated/vdso-offsets.h one. It
adds a forced dependency check of the vdso-offsets.h file in
arch/arm64/kernel/Makefile which, if not up to date according to the
arch/arm64/kernel/vdso/Makefile rules (depending on vdso.so.dbg), will
trigger the vdso/ subdirectory build and vdso-offsets.h re-generation.
Automatic kbuild dependency rules between kernel/{vdso,signal}.c rules
and vdso-offsets.h will guarantee that the vDSO object is built first,
followed by the generated symbol offsets header file.

Reported-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/kernel/Makefile      | 7 ++++---
 arch/arm64/kernel/vdso/Makefile | 7 +++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 7700c0c23962..b4f0a03dc830 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -54,6 +54,7 @@ obj-m					+= $(arm64-obj-m)
 head-y					:= head.o
 extra-y					+= $(head-y) vmlinux.lds
 
-# vDSO - this must be built first to generate the symbol offsets
-$(call objectify,$(arm64-obj-y)): $(obj)/vdso/vdso-offsets.h
-$(obj)/vdso/vdso-offsets.h: $(obj)/vdso
+# Check that the vDSO symbol offsets header file is up to date and re-generate
+# it if necessary.
+$(objtree)/include/generated/vdso-offsets.h: FORCE
+	$(Q)$(MAKE) $(build)=$(obj)/vdso $@
diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index b467fd0a384b..70fb663ddf7b 100644
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
+$(objtree)/include/generated/vdso-offsets.h: $(obj)/vdso.so.dbg
 	$(call if_changed,vdsosym)
 
 # Assembly rules for the .S files
