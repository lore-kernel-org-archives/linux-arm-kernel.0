From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 7 Jul 2016 12:23:25 +0100
Subject: [PATCH RESEND] arm64: fix vdso-offsets.h dependency
In-Reply-To: <20160707102601.GA27180@e104818-lin.cambridge.arm.com>
References: <1463071155-7435-1-git-send-email-kevin.brodsky@arm.com>
 <20160706175739.GB22615@e104818-lin.cambridge.arm.com>
 <20160707102601.GA27180@e104818-lin.cambridge.arm.com>
Message-ID: <20160707112325.GB27180@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2016 at 11:26:01AM +0100, Catalin Marinas wrote:
> On Wed, Jul 06, 2016 at 06:57:39PM +0100, Catalin Marinas wrote:
> > On Thu, May 12, 2016 at 05:39:15PM +0100, Kevin Brodsky wrote:
> > > +# We need to generate vdso-offsets.h before compiling certain files in kernel/.
> > > +# In order to do that, we should use the archprepare target, but we can't since
> > > +# asm-offsets.h is included in some files used to generate vdso-offsets.h, and
> > > +# asm-offsets.h is built in prepare0, for which archprepare is a dependency.
> > > +# Therefore we need to generate the header after prepare0 has been made, hence
> > > +# this hack.
> > > +prepare: vdso_prepare
> > > +vdso_prepare: prepare0
> > > +	$(Q)$(MAKE) $(build)=arch/arm64/kernel/vdso include/generated/vdso-offsets.h
> > 
> > This indeed looks dodgy. I'm not sure about the makefile rules but would
> > the above override the "prepare" target in the top Makefile?
> > 
> > I think a dependency problem we have is that arch/arm64/kernel/signal.o
> > depends on include/generated/vdso-offsets.h. However, we don't have any
> > target for the latter, only for
> > $(objtree)arch/arm64/kernel/vdso/vdso-offsets.h which no-one is
> > including. Because of this, we have a fake dependency in
> > arch/arm64/kernel/Makefile.
> > 
> > -----------8<-------------------------
> > diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> > index 7700c0c23962..9bdacbf59091 100644
> > --- a/arch/arm64/kernel/Makefile
> > +++ b/arch/arm64/kernel/Makefile
> > @@ -55,5 +55,4 @@ head-y					:= head.o
> >  extra-y					+= $(head-y) vmlinux.lds
> >  
> >  # vDSO - this must be built first to generate the symbol offsets
> > -$(call objectify,$(arm64-obj-y)): $(obj)/vdso/vdso-offsets.h
> > -$(obj)/vdso/vdso-offsets.h: $(obj)/vdso
> > +$(objtree)/include/generated/vdso-offsets.h: $(obj)/vdso
> 
> This didn't work either. Basically, when building
> arch/arm64/kernel/signal.o for example, it doesn't figure out that
> vdso-offsets.h has additional dependencies like the vdso.so.dbg so that
> it builds the vdso object first. I'll look for a little longer, maybe I
> find a better workaround.

If I also add the patch below, it works fine but I'm not sure we can
guarantee that kbuild first dives into subdirectories with a parallel
build:

--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -49,11 +49,7 @@ arm64-obj-$(CONFIG_HIBERNATION)		+= hibernate.o hibernate-asm.o
 arm64-obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o	\
 					   cpu-reset.o
 
-obj-y					+= $(arm64-obj-y) vdso/
+obj-y					+= vdso/ $(arm64-obj-y)
 obj-m					+= $(arm64-obj-m)
 head-y					:= head.o
 extra-y					+= $(head-y) vmlinux.lds

-- 
Catalin
