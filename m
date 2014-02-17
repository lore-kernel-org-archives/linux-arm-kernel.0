From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 17 Feb 2014 10:18:40 +0100
Subject: [PATCH] arm: imx: remove MACH_MXLADS
In-Reply-To: <1392627768.10966.23.camel@x220>
References: <1392573811.28866.22.camel@x220>
 <1392578464.996901773@f49.i.mail.ru>
 <1392582900.28866.85.camel@x220>
 <1392612187.657010375@f87.i.mail.ru>
 <1392627768.10966.23.camel@x220>
Message-ID: <20140217091840.GO17250@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 17, 2014 at 10:02:48AM +0100, Paul Bolle wrote:
> On Mon, 2014-02-17 at 08:43 +0400, Alexander Shiyan wrote:
> > It seems that even in the current state, Kconfig for i.MX contains an error.
> > As a start, we should rename ARCH_MX1ADS to MACH_MX1ADS first.

No. Have a look at arch/arm/tools/mach-types:

mxlads                  MACH_MXLADS             MXLADS	1851
mx1ads                  ARCH_MX1ADS             MX1ADS  160

And what gen-mach-types makes from it:

#ifdef CONFIG_MACH_MXLADS
# ifdef machine_arch_type
#  undef machine_arch_type
#  define machine_arch_type     __machine_arch_type
# else
#  define machine_arch_type     MACH_TYPE_MXLADS
# endif
# define machine_is_mxlads()    (machine_arch_type == MACH_TYPE_MXLADS)
#else
# define machine_is_mxlads()    (0)
#endif

#ifdef CONFIG_ARCH_MX1ADS
# ifdef machine_arch_type
#  undef machine_arch_type
#  define machine_arch_type     __machine_arch_type
# else
#  define machine_arch_type     MACH_TYPE_MX1ADS
# endif
# define machine_is_mx1ads()    (machine_arch_type == MACH_TYPE_MX1ADS)
#else
# define machine_is_mx1ads()    (0)
#endif

So machine_is_mx1ads() can only ever evaluate to true when
CONFIG_ARCH_MX1ADS is set and machine_is_mxlads() can only evaluate to true
when CONFIG_MACH_MXLADS is set.

Whether to use ARCH or MACH simply depends on what Russell has in the
machine registry database for a given board.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
