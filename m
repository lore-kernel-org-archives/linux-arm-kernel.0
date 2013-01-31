From: bp@alien8.de (Borislav Petkov)
Date: Thu, 31 Jan 2013 22:33:27 +0100
Subject: [RFC] arm: use built-in byte swap function
In-Reply-To: <20130131145947.f62474a0600848df86548b96@freescale.com>
References: <20130128193033.8a0b0a871150c99247f05a95@freescale.com>
 <20130129083522.GA14302@pd.tnic>
 <1359478014.3529.157.camel@shinybook.infradead.org>
 <20130129174249.GB25415@pd.tnic>
 <1359482147.3529.161.camel@shinybook.infradead.org>
 <20130129181046.GC25415@pd.tnic>
 <1359541333.3529.186.camel@shinybook.infradead.org>
 <20130130200900.9d7cf7908caeaef4ecee1d61@freescale.com>
 <20130131092801.GV23505@n2100.arm.linux.org.uk>
 <20130131145947.f62474a0600848df86548b96@freescale.com>
Message-ID: <20130131213327.GB5050@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 31, 2013 at 02:59:47PM -0600, Kim Phillips wrote:
> - add new ARCH_DEFINES_BUILTIN_BSWAP (see Kconfig help).
>   - if set, generic compiler header does not set HAVE_BUILTIN_BSWAPxx
>   - not too sure about this having to be a new CONFIG_, but it's hard
>     to find a place for it given linux/compiler.h doesn't include any
>     arch-specific files.

Yeah, me neither. It seems to me the whole deal can be simplified even
further without introducing CONFIG_ARCH_DEFINES_BUILTIN_BSWAP.

And, we don't even want to use CONFIG_ARCH_USE_BUILTIN_BSWAP on arm due
to different compiler versions supporting it (correct me if I'm wrong
here) vs the generic thing in include/linux/compiler-gcc4.h which we
want off.

If so, you'd need to simply put the following from below in
arch/arm/include/asm/swab.h

#if GCC_VERSION >= 40600
#define __HAVE_BUILTIN_BSWAP32__
#define __HAVE_BUILTIN_BSWAP64__
#if GCC_VERSION >= 40800
#define __HAVE_BUILTIN_BSWAP16__
#endif /* GCC_VERSION >= 40800 */
#endif /* GCC_VERSION >= 40600 */

and that's it.

Makes sense or am I over-simplifying this?

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
