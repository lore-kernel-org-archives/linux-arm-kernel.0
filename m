From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 22 Nov 2013 08:19:22 -0500
Subject: [PATCH V5] kbuild: dtbs_install: new make target
In-Reply-To: <653B066B-5B24-4817-86EF-D4D9F129123D@codeaurora.org>
References: <1384201760-16785-1-git-send-email-jason@lakedaemon.net>
 <1385062552-9882-1-git-send-email-jason@lakedaemon.net>
 <653B066B-5B24-4817-86EF-D4D9F129123D@codeaurora.org>
Message-ID: <20131122131922.GC29241@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 21, 2013 at 05:31:49PM -0600, Kumar Gala wrote:
> On Nov 21, 2013, at 1:35 PM, Jason Cooper <jason@lakedaemon.net> wrote:
> > diff --git a/Makefile b/Makefile
> > index 920ad07180c9..bd28cb211411 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -339,6 +339,7 @@ OBJDUMP		= $(CROSS_COMPILE)objdump
> > AWK		= awk
> > GENKSYMS	= scripts/genksyms/genksyms
> > INSTALLKERNEL  := installkernel
> > +INSTALLDTBS    := installdtbs
> > DEPMOD		= /sbin/depmod
> > PERL		= perl
> > CHECK		= sparse
> > @@ -391,7 +392,7 @@ KERNELVERSION = $(VERSION)$(if $(PATCHLEVEL),.$(PATCHLEVEL)$(if $(SUBLEVEL),.$(S
> > export VERSION PATCHLEVEL SUBLEVEL KERNELRELEASE KERNELVERSION
> > export ARCH SRCARCH CONFIG_SHELL HOSTCC HOSTCFLAGS CROSS_COMPILE AS LD CC
> > export CPP AR NM STRIP OBJCOPY OBJDUMP
> > -export MAKE AWK GENKSYMS INSTALLKERNEL PERL UTS_MACHINE
> > +export MAKE AWK GENKSYMS INSTALLKERNEL INSTALLDTBS PERL UTS_MACHINE
> > export HOSTCXX HOSTCXXFLAGS LDFLAGS_MODULE CHECK CHECKFLAGS
> > 
> > export KBUILD_CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS LDFLAGS
> > @@ -704,6 +705,15 @@ export KBUILD_IMAGE ?= vmlinux
> > export	INSTALL_PATH ?= /boot
> > 
> > #
> > +# INSTALL_DTBS_PATH specifies a prefix for relocations required by build roots.
> > +# Like INSTALL_MOD_PATH, it isn't defined in the Makefile, but can be passed as
> > +# an argument if needed.
> > +#
> 
> Nit, do we want to match INSTALL_MOD_PATH and drop the ?S? for INSTALL_DTB_PATH?

Yeah, I can go either way on this one.  So, sure.

thx,

Jason.

> > +
> > +DTBBOOT = $(INSTALL_DTBS_PATH)/boot/devicetrees/$(KERNELRELEASE)
> > +export DTBBOOT
> > +
> > +#
> > # INSTALL_MOD_PATH specifies a prefix to MODLIB for module directory
> > # relocations required by build roots.  This is not defined in the
> > # makefile but the argument can be passed to make if needed.
> > @@ -914,6 +924,14 @@ firmware_install: FORCE
> > 	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.fwinst obj=firmware __fw_install
> > 
> > # ---------------------------------------------------------------------------
> > +# devicetree install
> > +PHONY += dtbs_install
> > +
> > +dtbs_install:
> > +	$(CONFIG_SHELL) $(srctree)/scripts/installdtbs.sh $(KERNELRELEASE) \
> > +	"$(DTBBOOT)" "$(srctree)"
> > +
> > +# ---------------------------------------------------------------------------
> > # Kernel headers
> > 
> > #Default location for installed headers
