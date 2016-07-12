From: julien.grall@arm.com (Julien Grall)
Date: Tue, 12 Jul 2016 11:48:33 +0100
Subject: [PATCH 2/4] Xen: Support adding DT nodes
In-Reply-To: <20160620150934.1729-3-andre.przywara@arm.com>
References: <20160620150934.1729-1-andre.przywara@arm.com>
 <20160620150934.1729-3-andre.przywara@arm.com>
Message-ID: <5784CB01.9080600@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andre,

On 20/06/16 16:09, Andre Przywara wrote:
> From: Christoffer Dall <christoffer.dall@linaro.org>
>
> Support adding xen,xen-bootargs node via --with-xen-bootargs to the
> configure script and automatically add the Dom0 node to the DT as well.
>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>   Makefile.am  | 34 +++++++++++++++++++++-------------
>   configure.ac |  9 +++++++++
>   2 files changed, 30 insertions(+), 13 deletions(-)
>
> diff --git a/Makefile.am b/Makefile.am
> index 1a801c0..d83b417 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -93,24 +93,32 @@ FILESYSTEM_END	:= $(shell echo $$(($(FILESYSTEM_START) + $(FILESYSTEM_SIZE))))
>
>   FDT_OFFSET	:= 0x08000000
>
> +if XEN
> +XEN		:= -DXEN=$(XEN_IMAGE)
> +XEN_OFFSET	:= 0x08200000
> +KERNEL_SIZE	:= $(shell stat -Lc %s $(KERNEL_IMAGE) 2>/dev/null || echo 0)
> +DOM0_OFFSET	:= $(shell echo $$(($(PHYS_OFFSET) + $(KERNEL_OFFSET))))
> +XEN_BOOTARGS	:= xen,xen-bootargs = \"$(BOOTARGS)\";			\

I would prefer BOOTARGS with XEN_ to avoid confusion.

> +		   \#address-cells = <2>;				\
> +		   \#size-cells = <2>;					\
> +		   module at 1 {						\
> +			compatible = \"xen,linux-zimage\", \"xen,multiboot-module\"; \
> +			reg = <0x0 $(DOM0_OFFSET) 0x0 $(KERNEL_SIZE)>;	\
> +		   };
> +endif
> +
> +
>   if INITRD
>   INITRD_FLAGS	:= -DUSE_INITRD
> +INITRD_CHOSEN   := linux,initrd-start = <$(FILESYSTEM_START)>;	\
> +		   linux,initrd-end = <$(FILESYSTEM_END)>;
> +endif
> +
>   CHOSEN_NODE	:= chosen {						\
>   			bootargs = \"$(CMDLINE)\";			\
> -			linux,initrd-start = <$(FILESYSTEM_START)>;	\
> -			linux,initrd-end = <$(FILESYSTEM_END)>;		\
> -		   };
> -else
> -INITRD_FLAGS	:=
> -CHOSEN_NODE	:= chosen {						\
> -			bootargs = \"$(CMDLINE)\";			\
> +			$(INITRD_CHOSEN)				\
> +			$(XEN_BOOTARGS)					\
>   		   };
> -endif
> -
> -if XEN
> -XEN		:= -DXEN=$(XEN_IMAGE)
> -XEN_OFFSET	:= 0x08200000
> -endif

This code was added in the previous patch. Can you add the code in the 
correct place directly in patch #1?

>
>   CPPFLAGS	+= $(INITRD_FLAGS)
>   CFLAGS		+= -Iinclude/ -I$(ARCH_SRC)/include/
> diff --git a/configure.ac b/configure.ac
> index 2441f8b..b001939 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -95,6 +95,12 @@ AC_ARG_WITH([cmdline],
>   	[C_CMDLINE=$withval])
>   AC_SUBST([CMDLINE], [$C_CMDLINE])
>
> +X_BOOTARGS="console=dtuart dtuart=serial0 no-bootscrub"
> +AC_ARG_WITH([xen-bootargs],

I would name the option xen-cmdline to stay inline with the kernel one.

> +	AS_HELP_STRING([--with-xen-bootargs], [set Xen bootargs]),
> +	[X_BOOTARGS=$withval])
> +AC_SUBST([BOOTARGS], [$X_BOOTARGS])
> +
>   # Allow a user to pass --enable-gicv3
>   AC_ARG_ENABLE([gicv3],
>   	AS_HELP_STRING([--enable-gicv3], [enable GICv3 instead of GICv2]),
> @@ -133,4 +139,7 @@ echo "  Use GICv3?                         ${USE_GICV3}"
>   echo "  Boot-wrapper execution state:      AArch${BOOTWRAPPER_ES}"
>   echo "  Kernel execution state:            AArch${KERNEL_ES}"
>   echo "  Xen image                          ${X_IMAGE:-NONE}"
> +if test "x${X_IMAGE}" != "x"; then
> +echo "  Xen Bootargs:                      ${X_BOOTARGS}"

Same suggestion here "Xen command line".

> +fi
>   echo ""
>

Regards,

-- 
Julien Grall
