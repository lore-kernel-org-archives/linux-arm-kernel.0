From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 26 Apr 2018 13:57:02 +0100
Subject: [PATCH boot-wrapper] Fix out-of-tree build
In-Reply-To: <20180423163206.17071-1-jean-philippe.brucker@arm.com>
References: <20180423163206.17071-1-jean-philippe.brucker@arm.com>
Message-ID: <20180426125701.6h27qvxw2645o7vb@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 23, 2018 at 05:32:06PM +0100, Jean-Philippe Brucker wrote:
> Adding AArch32 support to the boot-wrapper changed the source layout and
> broke out-of-tree build. This patch allows to put all generated files
> into a separate directory again, and build multiple images in parallel:
> 
>     mkdir build/ && cd build/
>     ~/src/boot-wrapper-aarch64/configure ...
>     make
> 
> Make attempts to output object files into build/arch/aarchXX/, but fails
> because that folder doesn't exist in the build directory. Add mkdir as
> prerequisite for any *.o target in the arch folder.
> 
> So that Make doesn't confuse the destination folder with the source,
> override VPATH to only affect .S and .c sources.
> 
> And set $(ARCH_SRC) as order-only-prerequisite (after a '|'). Otherwise
> Make would rebuild all objects whenever the timestamp of $(ARCH_SRC)
> changes, which is every time an object is rebuilt...
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

Applied, thanks!

Mark.

> ---
>  Makefile.am | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile.am b/Makefile.am
> index 49cfa84..d3b5188 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -118,7 +118,7 @@ CHOSEN_NODE	:= chosen {						\
>  		   };
>  
>  CPPFLAGS	+= $(INITRD_FLAGS)
> -CFLAGS		+= -Iinclude/ -I$(ARCH_SRC)/include/
> +CFLAGS		+= -I$(top_srcdir)/include/ -I$(top_srcdir)/$(ARCH_SRC)/include/
>  CFLAGS		+= -Wall -fomit-frame-pointer
>  CFLAGS		+= -ffunction-sections -fdata-sections
>  LDFLAGS		+= --gc-sections
> @@ -126,6 +126,12 @@ LDFLAGS		+= --gc-sections
>  OFILES		+= boot_common.o bakery_lock.o platform.o $(GIC) cache.o lib.o
>  OFILES		+= $(addprefix $(ARCH_SRC),boot.o stack.o $(BOOTMETHOD) utils.o)
>  
> +# Don't lookup all prerequisites in $(top_srcdir), only the source files. When
> +# building outside the source tree $(ARCH_SRC) needs to be created.
> +VPATH		=
> +vpath %.c $(top_srcdir)
> +vpath %.S $(top_srcdir)
> +
>  all: $(IMAGE)
>  
>  CLEANFILES = $(IMAGE) linux-system.axf xen-system.axf $(OFILES) model.lds fdt.dtb
> @@ -133,7 +139,10 @@ CLEANFILES = $(IMAGE) linux-system.axf xen-system.axf $(OFILES) model.lds fdt.dt
>  $(IMAGE): $(OFILES) model.lds fdt.dtb $(KERNEL_IMAGE) $(FILESYSTEM) $(XEN_IMAGE)
>  	$(LD) $(LDFLAGS) $(OFILES) -o $@ --script=model.lds
>  
> -%.o: %.S Makefile
> +$(ARCH_SRC):
> +	$(MKDIR_P) $@
> +
> +%.o: %.S Makefile | $(ARCH_SRC)
>  	$(CC) $(CPPFLAGS) -D__ASSEMBLY__ $(CFLAGS) $(DEFINES) -c -o $@ $<
>  
>  %.o: %.c Makefile
> -- 
> 2.17.0
> 
