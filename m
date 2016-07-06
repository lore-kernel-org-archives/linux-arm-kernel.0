From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 6 Jul 2016 18:57:39 +0100
Subject: [PATCH RESEND] arm64: fix vdso-offsets.h dependency
In-Reply-To: <1463071155-7435-1-git-send-email-kevin.brodsky@arm.com>
References: <1463071155-7435-1-git-send-email-kevin.brodsky@arm.com>
Message-ID: <20160706175739.GB22615@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 12, 2016 at 05:39:15PM +0100, Kevin Brodsky wrote:
> +# We need to generate vdso-offsets.h before compiling certain files in kernel/.
> +# In order to do that, we should use the archprepare target, but we can't since
> +# asm-offsets.h is included in some files used to generate vdso-offsets.h, and
> +# asm-offsets.h is built in prepare0, for which archprepare is a dependency.
> +# Therefore we need to generate the header after prepare0 has been made, hence
> +# this hack.
> +prepare: vdso_prepare
> +vdso_prepare: prepare0
> +	$(Q)$(MAKE) $(build)=arch/arm64/kernel/vdso include/generated/vdso-offsets.h

This indeed looks dodgy. I'm not sure about the makefile rules but would
the above override the "prepare" target in the top Makefile?

I think a dependency problem we have is that arch/arm64/kernel/signal.o
depends on include/generated/vdso-offsets.h. However, we don't have any
target for the latter, only for
$(objtree)arch/arm64/kernel/vdso/vdso-offsets.h which no-one is
including. Because of this, we have a fake dependency in
arch/arm64/kernel/Makefile.

It's been a long time since I wrote makefiles but I think a simpler
approach may be to just get the include/generated/vdso-offsets.h target
and remove the arch/arm64/kernel/vdso/vdso-offsets.h one entirely like
below. Otherwise, we give up on storing the generated file in
include/generated/ and move arch/arm64/include/asm/vdso.h to
arch/arm64/kernel/vdso/.

-----------8<-------------------------
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 7700c0c23962..9bdacbf59091 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -55,5 +55,4 @@ head-y					:= head.o
 extra-y					+= $(head-y) vmlinux.lds
 
 # vDSO - this must be built first to generate the symbol offsets
-$(call objectify,$(arm64-obj-y)): $(obj)/vdso/vdso-offsets.h
-$(obj)/vdso/vdso-offsets.h: $(obj)/vdso
+$(objtree)/include/generated/vdso-offsets.h: $(obj)/vdso
diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index b467fd0a384b..44c20e3c9f43 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -23,7 +23,7 @@ GCOV_PROFILE := n
 ccflags-y += -Wl,-shared
 
 obj-y += vdso.o
-extra-y += vdso.lds vdso-offsets.h
+extra-y += vdso.lds ../../../../include/generated/vdso-offsets.h
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
+$(obj)/../../../../include/generated/vdso-offsets.h: $(obj)/vdso.so.dbg FORCE
 	$(call if_changed,vdsosym)
 
 # Assembly rules for the .S files
