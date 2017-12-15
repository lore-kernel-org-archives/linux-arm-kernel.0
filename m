From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 15 Dec 2017 21:16:39 +0100
Subject: [PATCH] fix perl locale warnings in arch/arm/boot/
In-Reply-To: <20171127094620.GA18072@amd>
References: <20171119222703.GA12824@amd>
 <CAK7LNARWMpxxC9hT8f7rGj5McjdNU1GXfjML9NbWFTCGyQ++dg@mail.gmail.com>
 <20171127094620.GA18072@amd>
Message-ID: <20171215201639.GA32042@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2017-11-27 10:46:20, Pavel Machek wrote:
> 
> Commit 429f7a062e3b5cf6fcf01eb00600cee5fe4d751f introduced perl into
> arch/arm/boot/compressed/Makefile, which unfortunately leads to locale
> warnings.
> 
> Fix it by setting default locale.
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

RMK apparently can't be bothered to fix the stuff he broke. Can
someone take the patch? Arm-soc? Linus? Andrew? 

Thanks,
								Pavel

> diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
> index 45a6b9b..4656e98 100644
> --- a/arch/arm/boot/compressed/Makefile
> +++ b/arch/arm/boot/compressed/Makefile
> @@ -118,7 +118,7 @@ asflags-y := -DZIMAGE
>  
>  # Supply kernel BSS size to the decompressor via a linker symbol.
>  KBSS_SZ = $(shell $(CROSS_COMPILE)nm $(obj)/../../../../vmlinux | \
> -		perl -e 'while (<>) { \
> +		LC_ALL=C perl -e 'while (<>) { \
>  			$$bss_start=hex($$1) if /^([[:xdigit:]]+) B __bss_start$$/; \
>  			$$bss_end=hex($$1) if /^([[:xdigit:]]+) B __bss_stop$$/; \
>  		}; printf "%d\n", $$bss_end - $$bss_start;')
> 
> 



-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171215/6fe8baf2/attachment.sig>
