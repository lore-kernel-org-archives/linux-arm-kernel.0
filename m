From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 22 Nov 2013 07:44:11 +0000
Subject: [PATCH V5] kbuild: dtbs_install: new make target
In-Reply-To: <1385062552-9882-1-git-send-email-jason@lakedaemon.net>
References: <1384201760-16785-1-git-send-email-jason@lakedaemon.net> <
 1385062552-9882-1-git-send-email-jason@lakedaemon.net>
Message-ID: <20131122074411.47DE5C40753@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 21 Nov 2013 19:35:52 +0000, Jason Cooper <jason@lakedaemon.net> wrote:
> Unlike other build products in the Linux kernel, there is no 'make
> *install' mechanism to put devicetree blobs in a standard place.
> 
> This patch is an attempt to fix this problem.  Akin to 'make install',
> this creates a new make target, dtbs_install.  The script that gets
> called defers to a distribution or user supplied installdtbs binary,
> if found in the system.  Otherwise, the default action is to install a
> given dtb into
> 
>   /boot/devicetrees/${kernel_version}/${dts_filename}.dtb
> 
> This is done to keep dtbs from different kernel versions separate until
> things have settled down.  Once the dtbs are stable, and not so strongly
> linked to the kernel version, the devicetree files will most likely move
> to their own repo.  Users will need to upgrade install scripts at that
> time.
> 
> Signed-off-by: Jason Cooper <jason@lakedaemon.net>
> ---
> changes since v4:
>  - move make target from arch/arm/Makefile to Makefile (swarren)
>  - change default install location to /boot/devicetrees/$KERNVER (swarren/gcl)
>  - add INSTALL_DTBS_PATH for changing build root (jac)
> 
> changes since v3:
>  - drop renaming files to ${compat}.dtb (rmk/swarren)
>  - move installdtbs.sh to ./scripts/ (gcl)
> 
> changes since v2:
>  - use fdtget instead of a modified dtc to get the board compat string
> 
> changes since v1:
>  - added this patch
> 
>  Makefile               | 20 +++++++++++++++++++-

Adding it to Makefile enables it unconditionally for all architectures,
even the ones with no DT support. I suspect (but have no evidence for)
that this will be considered bad form. I have no problem with each
architecture adding the build rule explicitly. The script is in a common
place and that is the important bit.

g.

>  scripts/installdtbs.sh | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 52 insertions(+), 1 deletion(-)
>  create mode 100644 scripts/installdtbs.sh
> 
> diff --git a/Makefile b/Makefile
> index 920ad07180c9..bd28cb211411 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -339,6 +339,7 @@ OBJDUMP		= $(CROSS_COMPILE)objdump
>  AWK		= awk
>  GENKSYMS	= scripts/genksyms/genksyms
>  INSTALLKERNEL  := installkernel
> +INSTALLDTBS    := installdtbs
>  DEPMOD		= /sbin/depmod
>  PERL		= perl
>  CHECK		= sparse
> @@ -391,7 +392,7 @@ KERNELVERSION = $(VERSION)$(if $(PATCHLEVEL),.$(PATCHLEVEL)$(if $(SUBLEVEL),.$(S
>  export VERSION PATCHLEVEL SUBLEVEL KERNELRELEASE KERNELVERSION
>  export ARCH SRCARCH CONFIG_SHELL HOSTCC HOSTCFLAGS CROSS_COMPILE AS LD CC
>  export CPP AR NM STRIP OBJCOPY OBJDUMP
> -export MAKE AWK GENKSYMS INSTALLKERNEL PERL UTS_MACHINE
> +export MAKE AWK GENKSYMS INSTALLKERNEL INSTALLDTBS PERL UTS_MACHINE
>  export HOSTCXX HOSTCXXFLAGS LDFLAGS_MODULE CHECK CHECKFLAGS
>  
>  export KBUILD_CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS LDFLAGS
> @@ -704,6 +705,15 @@ export KBUILD_IMAGE ?= vmlinux
>  export	INSTALL_PATH ?= /boot
>  
>  #
> +# INSTALL_DTBS_PATH specifies a prefix for relocations required by build roots.
> +# Like INSTALL_MOD_PATH, it isn't defined in the Makefile, but can be passed as
> +# an argument if needed.
> +#
> +
> +DTBBOOT = $(INSTALL_DTBS_PATH)/boot/devicetrees/$(KERNELRELEASE)
> +export DTBBOOT
> +
> +#
>  # INSTALL_MOD_PATH specifies a prefix to MODLIB for module directory
>  # relocations required by build roots.  This is not defined in the
>  # makefile but the argument can be passed to make if needed.
> @@ -914,6 +924,14 @@ firmware_install: FORCE
>  	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.fwinst obj=firmware __fw_install
>  
>  # ---------------------------------------------------------------------------
> +# devicetree install
> +PHONY += dtbs_install
> +
> +dtbs_install:
> +	$(CONFIG_SHELL) $(srctree)/scripts/installdtbs.sh $(KERNELRELEASE) \
> +	"$(DTBBOOT)" "$(srctree)"
> +
> +# ---------------------------------------------------------------------------
>  # Kernel headers
>  
>  #Default location for installed headers
> diff --git a/scripts/installdtbs.sh b/scripts/installdtbs.sh
> new file mode 100644
> index 000000000000..11027f00c3a4
> --- /dev/null
> +++ b/scripts/installdtbs.sh
> @@ -0,0 +1,33 @@
> +#!/bin/sh
> +#
> +# This file is subject to the terms and conditions of the GNU General Public
> +# License.  See the file "COPYING" in the main directory of this archive
> +# for more details.
> +#
> +# Copyright (C) 1995 by Linus Torvalds
> +#
> +# Adapted from code in arch/i386/boot/Makefile by H. Peter Anvin
> +#
> +# Further adapted from arch/x86/boot/install.sh by Jason Cooper
> +#
> +# "make dtbs_install" script
> +#
> +# Arguments:
> +#   $1 - kernel version
> +#   $2 - default install path (blank if root directory)
> +#   $3 - directory containing dtbs
> +#
> +
> +# User may have a custom install script
> +
> +if [ -x ~/bin/${INSTALLDTBS} ]; then exec ~/bin/${INSTALLDTBS} "$@"; fi
> +if [ -x /sbin/${INSTALLDTBS} ]; then exec /sbin/${INSTALLDTBS} "$@"; fi
> +
> +# Default install
> +[ -d "$2" ] && rm -rf "$2"
> +
> +mkdir -p "$2"
> +
> +for dtb in `find "$3" -name "*.dtb"`; do
> +	cp "$dtb" "$2/${dtb##*/}"
> +done
> -- 
> 1.8.4.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
