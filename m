From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 14 Jun 2011 19:25:00 +0800
Subject: [PATCH 0/3] patches to allow DTB to be appended to the ARM zImage
In-Reply-To: <alpine.LFD.2.00.1106140300500.2142@xanadu.home>
References: <1307858800-16712-1-git-send-email-nicolas.pitre@linaro.org>
	<20110612081541.GA10283@n2100.arm.linux.org.uk>
	<20110612083414.GA29516@S2100-06.ap.freescale.net>
	<20110612092131.GC10283@n2100.arm.linux.org.uk>
	<20110612095217.GD10283@n2100.arm.linux.org.uk>
	<20110612104215.GC29516@S2100-06.ap.freescale.net>
	<20110612104048.GE10283@n2100.arm.linux.org.uk>
	<8yaaadlfi3q.fsf@huya.qualcomm.com>
	<alpine.LFD.2.00.1106131910570.2142@xanadu.home>
	<alpine.LFD.2.00.1106140300500.2142@xanadu.home>
Message-ID: <20110614112459.GC30295@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 14, 2011 at 03:09:02AM -0400, Nicolas Pitre wrote:
> On Mon, 13 Jun 2011, Nicolas Pitre wrote:
> 
> > > Unless I'm missing something, I don't see a clean way of supporting this
> > > that doesn't involve the kernel being able to parse the ATAGS as well.
> > 
> > FYI: I've dug up the patch from John Bonesio doing just that.  While the 
> > patch doesn't apply anymore, it looks trivial enough.  I should have it 
> > working by tomorrow.
> 
> Well, here it is.  It compiles, but otherwise completely untested.
> 
Just tested the patch on mx51 babbage, and it's working.  Great work!
I have one comment below though.

> This applies on top of the 3 other patches I posted when this thread was 
> started.
> 
> While this could be cleaned up further, the functionality should all be 
> there and usable.
> 
> From: Nicolas Pitre <nicolas.pitre@linaro.org>
> Date: Tue, 14 Jun 2011 02:40:33 -0400
> Subject: [PATCH] ARM: zImage: allow supplementing appended DTB with traditional ATAG data
> 
> This is based on an older patch from John Bonesio <bones@secretlab.ca>.
> 
> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 66b7d1e..166bd2a 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1735,6 +1735,17 @@ config ARM_APPENDED_DTB
>  	  (dtb) appended to zImage
>  	  (e.g. cat zImage <filename>.dtb > zImage_w_dtb).
>  
> +config ARM_ATAG_DTB_COMPAT
> +	bool "Supplement the appended DTB with traditional ATAG information"
> +	depends on ARM_APPENDED_DTB
> +	help
> +	  Some old bootloaders can't be updated to a DTB capable one, yet
> +	  they provide ATAGs with memory configuration, the ramdisk address,
> +	  the kernel cmdline string, etc.  To allow a device tree enabled
> +	  kernel to be used with such bootloaders, this option allows
> +	  zImage to extract the information from the ATAG list and store it
> +	  at run time into the appended DTB.
> +
>  config CMDLINE
>  	string "Default kernel command string"
>  	default ""
> diff --git a/arch/arm/boot/compressed/.gitignore b/arch/arm/boot/compressed/.gitignore
> index c602896..e0936a1 100644
> --- a/arch/arm/boot/compressed/.gitignore
> +++ b/arch/arm/boot/compressed/.gitignore
> @@ -5,3 +5,12 @@ piggy.lzo
>  piggy.lzma
>  vmlinux
>  vmlinux.lds
> +
> +# borrowed libfdt files
> +fdt.c
> +fdt.h
> +fdt_ro.c
> +fdt_rw.c
> +fdt_wip.c
> +libfdt.h
> +libfdt_internal.h

[Note: I copied these files from scripts/dtc/libfdt]

> diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
> index 48bead9..4b94995 100644
> --- a/arch/arm/boot/compressed/Makefile
> +++ b/arch/arm/boot/compressed/Makefile
> @@ -83,19 +83,36 @@ suffix_$(CONFIG_KERNEL_GZIP) = gzip
>  suffix_$(CONFIG_KERNEL_LZO)  = lzo
>  suffix_$(CONFIG_KERNEL_LZMA) = lzma
>  
> +# libfdt files for the ATAG compatibility mode
> +
> +libfdt		:= fdt_rw.c fdt_ro.c fdt_wip.c fdt.c
> +libfdt_hdrs	:= fdt.h libfdt.h libfdt_internal.h
> +
> +libfdt_objs	:= $(addsuffix .o, $(basename $(libfdt)))
> +
> +$(addprefix $(obj)/,$(libfdt) $(libfdt_hdrs)): $(obj)/%: $(srctree)/scripts/dtc/libfdt/%
> +	$(call if_changed,shipped)
> +
> +$(addprefix $(obj)/,$(libfdt_objs) atags_to_fdt.o): \
> +	$(addprefix $(obj)/,$(libfdt_hdrs))
> +
> +ifeq ($(CONFIG_ARM_ATAG_DTB_COMPAT),y)
> +OBJS	+= $(libfdt_objs) atags_to_fdt.o 
> +endif
> +
>  targets       := vmlinux vmlinux.lds \
>  		 piggy.$(suffix_y) piggy.$(suffix_y).o \
>  		 font.o font.c head.o misc.o $(OBJS)
>  
>  # Make sure files are removed during clean
> -extra-y       += piggy.gzip piggy.lzo piggy.lzma lib1funcs.S
> +extra-y       += piggy.gzip piggy.lzo piggy.lzma lib1funcs.S $(libfdt) $(libfdt_hdrs)
>  
>  ifeq ($(CONFIG_FUNCTION_TRACER),y)
>  ORIG_CFLAGS := $(KBUILD_CFLAGS)
>  KBUILD_CFLAGS = $(subst -pg, , $(ORIG_CFLAGS))
>  endif
>  
> -ccflags-y := -fpic -fno-builtin
> +ccflags-y := -fpic -fno-builtin -I$(src)
>  asflags-y := -Wa,-march=all
>  
>  # Supply kernel BSS size to the decompressor via a linker symbol.
> @@ -118,7 +135,7 @@ LDFLAGS_vmlinux += -X
>  LDFLAGS_vmlinux += -T
>  
>  # For __aeabi_uidivmod
> -lib1funcs = $(obj)/lib1funcs.o
> +lib1funcs = $(obj)/lib1funcs.o $(obj)/../../lib/lib.a
>  
>  $(obj)/lib1funcs.S: $(srctree)/arch/$(SRCARCH)/lib/lib1funcs.S FORCE
>  	$(call cmd,shipped)
> diff --git a/arch/arm/boot/compressed/atags_to_fdt.c b/arch/arm/boot/compressed/atags_to_fdt.c
> new file mode 100644
> index 0000000..11c1a88
> --- /dev/null
> +++ b/arch/arm/boot/compressed/atags_to_fdt.c
> @@ -0,0 +1,71 @@
> +#include <asm/setup.h>
> +#include <libfdt.h>
> +
> +static int setprop(void *fdt, const char *node_path, const char *property,
> +		   uint32_t *val_array, int size)
> +{
> +	int offset = fdt_path_offset(fdt, node_path);
> +	if (offset < 0)
> +		return offset;
> +	return fdt_setprop(fdt, offset, property, val_array, size);
> +}
> +
> +static int setprop_string(void *fdt, const char *node_path,
> +			  const char *property, const char *string)
> +{
> +	int offset = fdt_path_offset(fdt, node_path);
> +	if (offset < 0)
> +		return offset;
> +	return fdt_setprop_string(fdt, offset, property, string);
> +}
> +
> +static int setprop_cell(void *fdt, const char *node_path,
> +			const char *property, uint32_t val)
> +{
> +	int offset = fdt_path_offset(fdt, node_path);
> +	if (offset < 0)
> +		return offset;
> +	return fdt_setprop_cell(fdt, offset, property, val);
> +}
> +
> +int atags_to_fdt(void *dt,  void *atag_list)
> +{
> +	struct tag *atag = atag_list;
> +
> +	/* make sure we've got an aligned pointer */
> +	if ((u32)atag_list & 0x3)
> +		return -1;
> +
> +	/* if we get a DTB here we're done already */
> +	if (*(u32 *)atag_list == fdt32_to_cpu(FDT_MAGIC))
> +	       return 0;	
> +
> +	/* validate the ATAG */
> +	if (atag->hdr.tag != ATAG_CORE ||
> +	    (atag->hdr.size != tag_size(tag_core) &&
> +	     atag->hdr.size != 2))
> +		return -1;
> +
> +	for_each_tag(atag, atag_list) {
> +		if (atag->hdr.tag == ATAG_CMDLINE) {
> +			setprop_string(dt, "/chosen", "bootargs",
> +			                  atag->u.cmdline.cmdline);
> +		} else if (atag->hdr.tag == ATAG_MEM) {
> +			uint32_t mem_reg_property[2];
> +			mem_reg_property[0] = cpu_to_fdt32(atag->u.mem.start);
> +			mem_reg_property[1] = cpu_to_fdt32(atag->u.mem.size);
> +			setprop(dt, "/memory", "reg", mem_reg_property,
> +			           sizeof(mem_reg_property));
> +		} else if (atag->hdr.tag == ATAG_INITRD2) {
> +			uint32_t initrd_start, initrd_size;
> +			initrd_start = atag->u.initrd.start;
> +			initrd_size = atag->u.initrd.size;
> +			setprop_cell(dt, "/chosen", "linux,initrd-start",
> +			                initrd_start);
> +			setprop_cell(dt, "/chosen", "linux,initrd-end",
> +			                initrd_start + initrd_size);
> +		}
> +	}
> +
> +	return 0;
> +}

This works only when there are corresponding nodes already in dtb.
Otherwise, the atag arguments are not going to be updated into dtb.
I suppose these nodes should be created to accommodate the arguments
from atags if the appended dtb does not have them, no?

-- 
Regards,
Shawn
