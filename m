From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 26 Jun 2017 09:53:11 +0100
Subject: [PATCH] arm: pass endianness info to sparse
In-Reply-To: <20170624153842.61064-1-luc.vanoostenryck@gmail.com>
References: <20170624153842.61064-1-luc.vanoostenryck@gmail.com>
Message-ID: <20170626085311.GC4902@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 24, 2017 at 05:38:42PM +0200, Luc Van Oostenryck wrote:
> ARM depends on the macros '__ARMEL__' & '__ARMEB__' being defined
> or not to correctly select or define endian-specific macros,
> structures or pieces of code.
> 
> These macros are predefined by the compiler but sparse knows
> nothing about them and thus may pre-process files differently
> from what gcc would.
> 
> Fix this by passing '-D__ARMEL__' or '-D__ARMEB__' to sparse,
> depending of the endianness of the kernel, like defined by GCC.
> 
> Note: In most case it won't change anything since most ARMs use
>       little-endian (but an allyesconfig would use big-endian!).

I wonder if that's a good thing - as this changes the endian conversion
macros and ifdefs around bitfield declarations, it means that we're not
testing the "popular" paths with an allyesconfig sparse - but then again,
I think allyesconfig with sparse is a very bad idea, it needs to be
targetted to the area being worked in.

> CC: Russell King <linux@armlinux.org.uk>
> CC: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  arch/arm/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 65f4e2a4e..0fca46d7f 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -44,10 +44,12 @@ endif
>  
>  ifeq ($(CONFIG_CPU_BIG_ENDIAN),y)
>  KBUILD_CPPFLAGS	+= -mbig-endian
> +CHECKFLAGS	+= -D__ARMEB__
>  AS		+= -EB
>  LD		+= -EB
>  else
>  KBUILD_CPPFLAGS	+= -mlittle-endian
> +CHECKFLAGS	+= -D__ARMEL__
>  AS		+= -EL
>  LD		+= -EL
>  endif
> -- 
> 2.13.0
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
