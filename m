From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 18 Feb 2016 12:14:06 -0500 (EST)
Subject: [PATCH v2] ARM: atags_to_fdt: don't warn about stack size
In-Reply-To: <7301172.5fH67MHlU9@wuerfel>
References: <1455804123-2526139-1-git-send-email-arnd@arndb.de>
 <1455804123-2526139-6-git-send-email-arnd@arndb.de>
 <alpine.LFD.2.20.1602181112310.13632@knanqh.ubzr>
 <7301172.5fH67MHlU9@wuerfel>
Message-ID: <alpine.LFD.2.20.1602181213260.13632@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 18 Feb 2016, Arnd Bergmann wrote:

> The merge_fdt_bootargs() function by definition consumes more than 1024
> bytes of stack because it has a 1024 byte command line on the stack,
> meaning that we always get a warning when building this file:
> 
> arch/arm/boot/compressed/atags_to_fdt.c: In function 'merge_fdt_bootargs':
> arch/arm/boot/compressed/atags_to_fdt.c:98:1: warning: the frame size of 1032 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> 
> However, as this is the decompressor and we know that it has a very shallow
> call chain, and we do not actually risk overflowing the kernel stack
> at runtime here.
> 
> This just shuts up the warning by slightly increasing the limit for this
> file.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Nicolas Pitre <nico@linaro.org>


> ---
> On Thursday 18 February 2016 11:13:52 Nicolas Pitre wrote:
> > What about setting the warning to 2048 instead?
> 
> Sure, actually 1280 is more than enough I think.
> 
> diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
> index 7a6a58ef8aaf..2cc63038d6c8 100644
> --- a/arch/arm/boot/compressed/Makefile
> +++ b/arch/arm/boot/compressed/Makefile
> @@ -85,6 +85,8 @@ $(addprefix $(obj)/,$(libfdt) $(libfdt_hdrs)): $(obj)/%: $(srctree)/scripts/dtc/
>  $(addprefix $(obj)/,$(libfdt_objs) atags_to_fdt.o): \
>  	$(addprefix $(obj)/,$(libfdt_hdrs))
>  
> +CFLAGS_atags_to_fdt.o += -Wframe-larger-than=1280
> +
>  ifeq ($(CONFIG_ARM_ATAG_DTB_COMPAT),y)
>  OBJS	+= $(libfdt_objs) atags_to_fdt.o
>  endif
> 
> 
