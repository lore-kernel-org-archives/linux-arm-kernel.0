From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 1 Oct 2018 17:53:42 +0100
Subject: [PATCH] ARM: disable ARMv6 for Clang older than 8.0
In-Reply-To: <aa1fbf64fc1190674abb9ecae3ffe1a39e1e60c0.camel@perches.com>
References: <20180930222230.24167-1-stefan@agner.ch>
 <aa1fbf64fc1190674abb9ecae3ffe1a39e1e60c0.camel@perches.com>
Message-ID: <20181001165342.GR30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 30, 2018 at 04:48:20PM -0700, Joe Perches wrote:
> On Mon, 2018-10-01 at 00:22 +0200, Stefan Agner wrote:
> > The kernel passes the ArmV6K architecture to the compiler when
> > using the multi platform selection and enabling ARMv6. Clang
> > older than version 8.0 emit assembly with an non-existing CPU,
> > which then makes the assembler fail. Prevent the user from
> > selecting ARMv6 when using Clang before 8.0.
> > 
> > Signed-off-by: Stefan Agner <stefan@agner.ch>
> > Link: https://github.com/ClangBuiltLinux/linux/issues/55
> > ---
> >  arch/arm/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index e8cd55a5b04c..8da160757381 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -671,6 +671,7 @@ config ARCH_MULTI_V4_V5
> >  
> >  config ARCH_MULTI_V6
> >  	bool "ARMv6 based platforms (ARM11)"
> > +	depends on !CC_IS_CLANG || CLANG_VERSION>=80000
> >  	select ARCH_MULTI_V6_V7
> >  	select CPU_V6K
> >  
> 
> Perhaps it'd be better to avoid this in selection
> criteria in Kconfig and instead add this to
> include/linux/compiler_clang.h
> ---
>  include/linux/compiler-clang.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> index b1ce500fe8b3..90fd16c85359 100644
> --- a/include/linux/compiler-clang.h
> +++ b/include/linux/compiler-clang.h
> @@ -3,6 +3,10 @@
>  #error "Please don't include <linux/compiler-clang.h> directly, include <linux/compiler.h> instead."
>  #endif
>  
> +#if defined(CONFIG_ARCH_MULTI_V6) && CLANG_VERSION < 80000
> +# error Sorry, your compiler is too old - please upgrade it.
> +#endif

(a) does it makes sense to have arch CONFIG_* in linux/*.h?  It could
    instead go in arch/arm/kernel/asm-offsets.c, where we have the other
    tests similar to this for GCC.

(b) do we get far enough that the #error will be generated before the
    reported assembler error happens?  IOW, would the assembler error
    mask this #error?

I think it needs confirmation that a #error for this problem results
in the desired behaviour.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 14.8Mbps down 650kbps up
According to speedtest.net: 13Mbps down 490kbps up
