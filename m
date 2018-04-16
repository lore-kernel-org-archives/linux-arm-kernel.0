From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 Apr 2018 13:09:30 +0100
Subject: [PATCH] Replace unnecessary perl with sed, printf, and the shell
 $(( )) operator.
In-Reply-To: <9c72100c-b3e4-07ca-1784-fda2ac9d708c@landley.net>
References: <9c72100c-b3e4-07ca-1784-fda2ac9d708c@landley.net>
Message-ID: <20180416120930.GS16141@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2018 at 08:38:37PM -0500, Rob Landley wrote:
> You can build a kernel in a cross compiling environment that doesn't have perl
> in the $PATH. Commit 429f7a062e3b broke that for 32 bit arm. Fix it.
> 
> Signed-off-by: Rob Landley <rob@landley.net>
> ---
> 
>  arch/arm/boot/compressed/Makefile |    9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
> index 45a6b9b..33ebeb2 100644
> --- a/arch/arm/boot/compressed/Makefile
> +++ b/arch/arm/boot/compressed/Makefile
> @@ -117,11 +117,10 @@ ccflags-y := -fpic -mno-single-pic-base -fno-builtin -I$(obj)
>  asflags-y := -DZIMAGE
>  
>  # Supply kernel BSS size to the decompressor via a linker symbol.
> -KBSS_SZ = $(shell $(CROSS_COMPILE)nm $(obj)/../../../../vmlinux | \
> -		perl -e 'while (<>) { \
> -			$$bss_start=hex($$1) if /^([[:xdigit:]]+) B __bss_start$$/; \
> -			$$bss_end=hex($$1) if /^([[:xdigit:]]+) B __bss_stop$$/; \
> -		}; printf "%d\n", $$bss_end - $$bss_start;')
> +KBSS_SZ := $(shell echo $$(($$(printf '%d+%d' $$( \
> +		$(CROSS_COMPILE)nm $(obj)/../../../../vmlinux | \
> +		sed -n -e 's/^\([^ ]*\) B __bss_start$$/-0x\1/p' \
> +		       -e 's/^\([^ ]*\) B __bss_stop$$/0x\1/p') ) )) )

This looks more complicated than necessary, and therefore less readable.
What's wrong with:

KBSS_SZ := $(shell echo $$(($$($(CROSS_COMPILE)nm $(obj)/../../../../vmlinux | \
		sed -n -e 's/^\([^ ]*\) B __bss_start$$/-0x\1/p' \
		       -e 's/^\([^ ]*\) B __bss_stop$$/+0x\1/p') ))

The sed command produces output such as:

-0xc0955e58
+0xc10b0f9c

which the shell is then able to evaluate and produce a decimal number.
This seems to work fine with both bash and dash.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
