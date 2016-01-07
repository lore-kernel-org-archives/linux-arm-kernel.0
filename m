From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 7 Jan 2016 11:30:29 +0000
Subject: [PATCH v3] ARM: fix atags_to_fdt with stack-protector-strong
In-Reply-To: <20160106233656.GA9316@www.outflux.net>
References: <20160106233656.GA9316@www.outflux.net>
Message-ID: <20160107113029.GE19062@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 06, 2016 at 03:36:56PM -0800, Kees Cook wrote:
> diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
> index 3f9a9ebc77c3..d7d2c2981f65 100644
> --- a/arch/arm/boot/compressed/Makefile
> +++ b/arch/arm/boot/compressed/Makefile
> @@ -106,6 +106,14 @@ ORIG_CFLAGS := $(KBUILD_CFLAGS)
>  KBUILD_CFLAGS = $(subst -pg, , $(ORIG_CFLAGS))
>  endif
>  
> +# -fstack-protector-strong triggers protection checks in this code,
> +# but it is being used too early to link to meaningful stack_chk logic.
> +CFLAGS_atags_to_fdt.o := $(call cc-option, -fno-stack-protector)
> +CFLAGS_fdt.o := $(call cc-option, -fno-stack-protector)
> +CFLAGS_fdt_ro.o := $(call cc-option, -fno-stack-protector)
> +CFLAGS_fdt_rw.o := $(call cc-option, -fno-stack-protector)
> +CFLAGS_fdt_wip.o := $(call cc-option, -fno-stack-protector)

This will result in "$(call cc-option, -fno-stack-protector)" being
called five times when this Makefile is parsed, which seems very
wasteful.  I'm sure there's better solutions to that - maybe caching
the value in a variable in a higher level makefile (eg,
arch/arm/Makefile) ?

Also, I suspect that all of the decompressor should be built with
-fno-stack-protector as we don't have sufficient environment here.
Maybe it should be placed in the global CFLAGS for the decompressor?

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
