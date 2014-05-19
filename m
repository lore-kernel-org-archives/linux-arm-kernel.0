From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 19 May 2014 16:29:13 +0200
Subject: [PATCH] pinctrl: sunxi: Fix recursive dependency
In-Reply-To: <4667053.sVVFqnz4qh@wuerfel>
References: <1400343715-27884-1-git-send-email-maxime.ripard@free-electrons.com>
 <4667053.sVVFqnz4qh@wuerfel>
Message-ID: <20140519142913.GK29466@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Mon, May 19, 2014 at 01:30:54PM +0200, Arnd Bergmann wrote:
> On Saturday 17 May 2014 18:21:55 Maxime Ripard wrote:
> > Fix the following configuration error:
> > drivers/pinctrl/sunxi/Kconfig:3:error: recursive dependency detected!
> > drivers/pinctrl/sunxi/Kconfig:3:        symbol PINCTRL_SUNXI is selected by PINCTRL_SUN4I_A10
> > drivers/pinctrl/sunxi/Kconfig:9:        symbol PINCTRL_SUN4I_A10 default value contains PINCTRL_SUNXI
> > 
> > Drop the select on PINCTRL_SUNXI, and make PINCTRL_SUNXI enabled by default instead.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> I stubled over the same thing already, but came to a different conclusion.
> 
> >  drivers/pinctrl/sunxi/Kconfig | 8 +-------
> >  1 file changed, 1 insertion(+), 7 deletions(-)
> > 
> > diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
> > index 2007327e0c48..8411857d2a45 100644
> > --- a/drivers/pinctrl/sunxi/Kconfig
> > +++ b/drivers/pinctrl/sunxi/Kconfig
> > @@ -1,32 +1,26 @@
> >  if ARCH_SUNXI
> >  
> >  config PINCTRL_SUNXI
> > -       bool
> > +       def_bool ARCH_SUNXI
> >         select PINMUX
> >         select GENERIC_PINCONF
> >  
> >  config PINCTRL_SUN4I_A10
> >         def_bool PINCTRL_SUNXI || MACH_SUN4I
> > -       select PINCTRL_SUNXI
> >  
> 
> This means you won't be able to stop selecting all drivers dropping
> the 'select PINCTRL_SUNXI' later. How about this one?

I'm not sure what you mean here.

We won't have to select PINCTRL_SUNXI anymore with this patch either,
since it's already enabled whenever ARCH_SUNXI is enabled.

And the drivers won't have to be selected either, because they will
either default to PINCTRL_SUNXI, or to the MACH_SUN*I definition.

As I was saying in the commit log, this is just a temporary solution,
and eventually, and the select PINCTRL_SUNXI should be removed
eventually.

> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
> index 2007327..75b71bb 100644
> --- a/drivers/pinctrl/sunxi/Kconfig
> +++ b/drivers/pinctrl/sunxi/Kconfig
> @@ -2,31 +2,34 @@ if ARCH_SUNXI
>  
>  config PINCTRL_SUNXI
>  	bool
> +
> +config PINCTRL_SUNXI_COMMON
> +	bool
>  	select PINMUX
>  	select GENERIC_PINCONF
>  
>  config PINCTRL_SUN4I_A10
>         def_bool PINCTRL_SUNXI || MACH_SUN4I
> -       select PINCTRL_SUNXI
> +       select PINCTRL_SUNXI_COMMON
>  
>  config PINCTRL_SUN5I_A10S
>         def_bool PINCTRL_SUNXI || MACH_SUN5I
> -       select PINCTRL_SUNXI
> +       select PINCTRL_SUNXI_COMMON
>  
>  config PINCTRL_SUN5I_A13
>         def_bool PINCTRL_SUNXI || MACH_SUN5I
> -       select PINCTRL_SUNXI
> +       select PINCTRL_SUNXI_COMMON
>  
>  config PINCTRL_SUN6I_A31
>         def_bool PINCTRL_SUNXI || MACH_SUN6I
> -       select PINCTRL_SUNXI
> +       select PINCTRL_SUNXI_COMMON
>  
>  config PINCTRL_SUN6I_A31_R
>         def_bool PINCTRL_SUNXI || MACH_SUN6I
> -       select PINCTRL_SUNXI
> +       select PINCTRL_SUNXI_COMMON
>  
>  config PINCTRL_SUN7I_A20
>         def_bool PINCTRL_SUNXI || MACH_SUN7I
> -       select PINCTRL_SUNXI
> +       select PINCTRL_SUNXI_COMMON
>  
>  endif
> diff --git a/drivers/pinctrl/sunxi/Makefile b/drivers/pinctrl/sunxi/Makefile
> index 8e23a15..0f4461c 100644
> --- a/drivers/pinctrl/sunxi/Makefile
> +++ b/drivers/pinctrl/sunxi/Makefile
> @@ -1,5 +1,5 @@
>  # Core
> -obj-$(CONFIG_PINCTRL_SUNXI)	+= pinctrl-sunxi.o
> +obj-$(CONFIG_PINCTRL_SUNXI_COMMON)	+= pinctrl-sunxi.o
>  
>  # SoC Drivers
>  obj-$(CONFIG_PINCTRL_SUN4I_A10)		+= pinctrl-sun4i-a10.o
> 

I'm afraid I don't get the difference...

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140519/574ad05c/attachment.sig>
