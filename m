From: tony@atomide.com (Tony Lindgren)
Date: Wed, 14 Dec 2011 13:58:15 -0800
Subject: [PATCH] ARM: fix $(CROSS_COMPILE) prefix missing from size
 invocation
In-Reply-To: <201112140021.42598.jkrzyszt@tis.icnet.pl>
References: <1322186338-6020-1-git-send-email-jkrzyszt@tis.icnet.pl>
 <201112140021.42598.jkrzyszt@tis.icnet.pl>
Message-ID: <20111214215815.GP32251@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [111213 14:55]:
> On Friday 25 of November 2011 at 02:58:58, Janusz Krzysztofik wrote:
> > Otherwise, cross compilation may fail with error messages like:
> > 
> > ...
> > size: arch/arm/boot/compressed/../../../../vmlinux: File format is ambiguous
> > size: Matching formats: elf32-littlearm elf32-littlearm-symbian elf32-littlearm-vxworks
> >   LD      arch/arm/boot/compressed/vmlinux
> >   arm-angstrom-linux-uclibcgnueabi-ld:--defsym _kernel_bss_size=: syntax error
> > 
> > Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> 
> Trying to guess why this patch is still sitting in the Incoming queue in 
> the Russell's patch system (7184/1) while others have found their way to 
> the Applied queue meanwhile, I wonder if this is because I didn't 
> mention explicitly that it is a fix to a regression introduced into 
> 3.2-rc with the following commit:

It's because not all cross compiler in use have $(CROSS_COMPILE)size
available, so it would have to be symlinked to host size to keep things
compiling. So it's probably best to rather take the warning and keep
things compiling rather than fix the warning and break compile for
many people.

Regards,

Tony
 
> $ git log v3.1..v3.2-rc1 -Ssize -p arch/arm/boot/compressed/Makefile
> commit 5ffb04f6690d71fab241b3562ebf52b893ac4ff1
> Author: Nicolas Pitre <nicolas.pitre@linaro.org>
> Date:   Sun Jun 12 01:07:33 2011 -0400
> 
>     ARM: zImage: make sure appended DTB doesn't get overwritten by kernel .bss
>     
>     The appended DTB gets relocated with the decompressor code to get out
>     of the way of the decompressed kernel.  However the kernel's .bss section
>     may be larger than the relocated code and data, and then the DTB gets
>     overwritten.  Let's make sure the relocation takes care of moving zImage
>     far enough so no such conflict with .bss occurs.
>     
>     Thanks to Tony Lindgren <tony@atomide.com> for figuring out this issue.
>     
>     While at it, let's clean up the code a bit so that the wont_overwrite
>     symbol is used while determining if a conflict exists, making the above
>     change more precise as well as eliminating some ARM/THUMB alternates.
>     
>     Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
>     Acked-by: Tony Lindgren <tony@atomide.com>
>     Tested-by: Shawn Guo <shawn.guo@linaro.org>
>     Tested-by: Dave Martin <dave.martin@linaro.org>
>     Tested-by: Thomas Abraham <thomas.abraham@linaro.org>
> 
> diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
> index 0c74a6f..4867647 100644
> --- a/arch/arm/boot/compressed/Makefile
> +++ b/arch/arm/boot/compressed/Makefile
> @@ -104,6 +104,9 @@ endif
>  ccflags-y := -fpic -fno-builtin
>  asflags-y := -Wa,-march=all
>  
> +# Supply kernel BSS size to the decompressor via a linker symbol.
> +KBSS_SZ = $(shell size $(obj)/../../../../vmlinux | awk 'END{print $$3}')
> +LDFLAGS_vmlinux = --defsym _kernel_bss_size=$(KBSS_SZ)
>  # Supply ZRELADDR to the decompressor via a linker symbol.
>  ifneq ($(CONFIG_AUTO_ZRELADDR),y)
>  LDFLAGS_vmlinux += --defsym zreladdr=$(ZRELADDR)
> 
> Thanks,
> Janusz
> 
> > ---
> >  arch/arm/boot/compressed/Makefile |    3 ++-
> >  1 files changed, 2 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
> > index 21f56ff..cf0a64c 100644
> > --- a/arch/arm/boot/compressed/Makefile
> > +++ b/arch/arm/boot/compressed/Makefile
> > @@ -126,7 +126,8 @@ ccflags-y := -fpic -fno-builtin -I$(obj)
> >  asflags-y := -Wa,-march=all
> >  
> >  # Supply kernel BSS size to the decompressor via a linker symbol.
> > -KBSS_SZ = $(shell size $(obj)/../../../../vmlinux | awk 'END{print $$3}')
> > +KBSS_SZ = $(shell $(CROSS_COMPILE)size $(obj)/../../../../vmlinux | \
> > +		awk 'END{print $$3}')
> >  LDFLAGS_vmlinux = --defsym _kernel_bss_size=$(KBSS_SZ)
> >  # Supply ZRELADDR to the decompressor via a linker symbol.
> >  ifneq ($(CONFIG_AUTO_ZRELADDR),y)
> > 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
