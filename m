From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 19 Aug 2012 14:05:24 +0000
Subject: [PATCH 0/6] Integrator devicetree support
In-Reply-To: <CACRpkdYYgdzAU=nyL7dQbdMLx3z3G+K7ba0uJe1=aX=BLeF_sg@mail.gmail.com>
References: <1345119317-22600-1-git-send-email-linus.walleij@linaro.org>
 <201208161344.55723.arnd@arndb.de>
 <CACRpkdYYgdzAU=nyL7dQbdMLx3z3G+K7ba0uJe1=aX=BLeF_sg@mail.gmail.com>
Message-ID: <201208191405.25048.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 18 August 2012, Linus Walleij wrote:
> Since we already have CONFIG_USE_OF I think
> CONFIG_USE_ATAGS is more apropriate, but I get the
> idea.

There is both CONFIG_USE_OF and CONFIG_OF. The former is what
a platform selects and it turns on a few other options as well,
while the latter is the one that you typically check in #ifdef.

We might need both of them for ATAG as well, but I think if
we have just one, CONFIG_ATAGS or CONFIG_ATAG would be nicer
because it's slightly shorter.

> So it begins like this:
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index e91c7cd..0764ef7 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1907,6 +1907,12 @@ endmenu
> 
>  menu "Boot options"
> 
> +config USE_ATAGS
> +       bool "ATAGS support"
> +       default y
> +       help
> +         Include support for ATAGS-based machine descriptions.
> +
>  config USE_OF
>         bool "Flattened Device Tree support"
>         select OF
> @@ -2110,6 +2116,7 @@ config KEXEC
> 
>  config ATAGS_PROC
>         bool "Export atags in procfs"
> +       depends on USE_ATAGS
>         depends on KEXEC
>         default y
>         help
> 
> But then we hit #ifdeffing and compiling out a lot of dangerous stuff
> in arch/arm/kernel and then I get the creeps. I can try, but I think
> this is typical Nico territory for example...

We don't have to enclose every single usage of ATAGS with this, but
I think it's helpful in platforms that you want to migrate away
from ATAG to DT-only. I think we should also use this method in
mach-ux500, for instance.

Putting MACHINE_START and DT_MACHINE_START inside of CONFIG_ATAG
and CONFIG_OF respectively would help ensure that we don't
accidentally build support for a board that cannot work.

	Arnd
