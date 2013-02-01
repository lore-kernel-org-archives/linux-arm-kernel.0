From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 1 Feb 2013 18:18:54 +0000
Subject: [RFC PATCH] arm: decompressor: initialize PIC offset base
 register for uClinux tools
In-Reply-To: <510BF0B3.3030608@arm.com>
References: <1359480546-7033-1-git-send-email-jonathan.austin@arm.com>
 <alpine.LFD.2.02.1301291453530.6300@xanadu.home> <510BF0B3.3030608@arm.com>
Message-ID: <20130201181854.GU23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 01, 2013 at 04:43:31PM +0000, Jonathan Austin wrote:
> Code that needs to access anything global will need to derive the location
> of the GOT for itself, but there's a possible upside there that there's an
> extra free register (r9 can be used as a general purpose register...)
> 
> The patch would look like:
> -----8<-------
> diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
> index 5cad8a6..afed28e 100644
> --- a/arch/arm/boot/compressed/Makefile
> +++ b/arch/arm/boot/compressed/Makefile
> @@ -120,7 +120,7 @@ ORIG_CFLAGS := $(KBUILD_CFLAGS)
>  KBUILD_CFLAGS = $(subst -pg, , $(ORIG_CFLAGS))
>  endif
>  -ccflags-y := -fpic -fno-builtin -I$(obj)
> +ccflags-y := -fpic -mno-single-pic-base -fno-builtin -I$(obj)
>  asflags-y := -Wa,-march=all -DZIMAGE
>   # Supply kernel BSS size to the decompressor via a linker symbol.
> ------>8---------
> 
> 
> I did a fairly crude benchmark - count how many instructions we need in
> order to finish decompressing the kernel...
> 
> Setup r9 correctly:       129,976,282
> Use -mno-single-pic-base: 124,826,778
> 
> (this was done using an R-class model and a magic semi-hosting call to pause
> the model at the end of the decompress_kernel function)
> 
> So, it seems like the extra register means there's actually a 4% *win* 
> in instruction terms from using -mno-single-pic-base

Hmm.  This is the opposite of what I'd expect.  -msingle-pic-base says:

     Treat the register used for PIC addressing as read-only, rather
     than loading it in the prologue for each function.  The run-time
     system is responsible for initializing this register with an
     appropriate value before execution begins.

which implies that we should be able to load it before calling the C
code (as you're doing) and then the compiler won't issue instructions
to reload that register.

Giving -mno-single-pic-base suggests that it would turn _off_ this
behaviour (which afaik - sensibly - is not by default enabled.)

So, I'm not sure I fully understand what's going on here.
