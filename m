From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 10 Jan 2014 13:29:23 -0500
Subject: [PATCH V6] kbuild: dtbs_install: new make target
In-Reply-To: <1385942188-21831-1-git-send-email-jason@lakedaemon.net>
References: <1384201760-16785-1-git-send-email-jason@lakedaemon.net>
 <1385942188-21831-1-git-send-email-jason@lakedaemon.net>
Message-ID: <20140110182923.GM19878@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grant,

On Sun, Dec 01, 2013 at 11:56:28PM +0000, Jason Cooper wrote:
> Unlike other build products in the Linux kernel, there is no 'make
> *install' mechanism to put devicetree blobs in a standard place.
> 
> This patch is an attempt to fix this problem.  Akin to 'make install',
> this creates a new make target, dtbs_install.  The script that gets
> called defers to a distribution or user supplied installdtbs binary,
> if found in the system.  Otherwise, the default action is to install the
> built dtbs into
> 
>   /lib/devicetrees/${kernel_version}/${dts_filename}.dtb
> 
> This is done to keep dtbs from different kernel versions separate until
> things have settled down.  Once the dtbs are stable, and not so strongly
> linked to the kernel version, the devicetree files will most likely move
> to their own repo.  Users will need to upgrade install scripts at that
> time.
> 
> /lib has been selected over /boot since /boot is often a FAT filesystem
> and a majority of the dts filenames are longer than 8+3.
> 
> Signed-off-by: Jason Cooper <jason@lakedaemon.net>
> ---

Is this good to go?

thx,

Jason.

> Note: Stephen, I haven't added your Ack because I wanted to make sure you were
> Ok with the change to /lib in light of /boot partitions formatted to FAT
> 
> changes since v5:
>  - move make target back to arch/arm/Makefile (gcl)
>  - change default install location to /lib from /boot (FAT) (ojn,jac)
> 
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
>  Makefile               | 12 +++++++++++-
>  arch/arm/Makefile      | 10 ++++++++++
>  scripts/installdtbs.sh | 33 +++++++++++++++++++++++++++++++++
>  3 files changed, 54 insertions(+), 1 deletion(-)
>  create mode 100644 scripts/installdtbs.sh
> 
> diff --git a/Makefile b/Makefile
> index c0c2d58e3998..240e0d52b126 100644
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
> +DTBBOOT = $(INSTALL_DTBS_PATH)/lib/devicetrees/$(KERNELRELEASE)
> +export DTBBOOT
> +
> +#
>  # INSTALL_MOD_PATH specifies a prefix to MODLIB for module directory
>  # relocations required by build roots.  This is not defined in the
>  # makefile but the argument can be passed to make if needed.
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index c99b1086d83d..400a3a7ee899 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -314,6 +314,12 @@ PHONY += dtbs
>  dtbs: scripts
>  	$(Q)$(MAKE) $(build)=$(boot)/dts MACHINE=$(MACHINE) dtbs
>  
> +PHONY += dtbs_install
> +
> +dtbs_install: dtbs
> +	$(CONFIG_SHELL) $(srctree)/scripts/installdtbs.sh $(KERNELRELEASE) \
> +	"$(DTBBOOT)" "$(srctree)"
> +
>  # We use MRPROPER_FILES and CLEAN_FILES now
>  archclean:
>  	$(Q)$(MAKE) $(clean)=$(boot)
> @@ -331,6 +337,10 @@ define archhelp
>    echo  '  bootpImage    - Combined zImage and initial RAM disk'
>    echo  '                  (supply initrd image via make variable INITRD=<path>)'
>    echo  '* dtbs          - Build device tree blobs for enabled boards'
> +  echo  '  dtbs_install  - Install dtbs'
> +  echo  '                  Install using (your) ~/bin/$(INSTALLDTBS) or'
> +  echo  '                  (distribution) /sbin/$(INSTALLDTBS) or'
> +  echo  '                  install to $(DTBBOOT)'
>    echo  '  install       - Install uncompressed kernel'
>    echo  '  zinstall      - Install compressed kernel'
>    echo  '  uinstall      - Install U-Boot wrapped compressed kernel'
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
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
