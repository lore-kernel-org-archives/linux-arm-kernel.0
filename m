From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 5 Nov 2013 12:52:24 +0100
Subject: [PATCH v5 1/4] ARM: deprecate mach/timex.h for !ARCH_MULTIPLATFORM
In-Reply-To: <201311051234.43321.arnd@arndb.de>
References: <20131105083336.GK14892@pengutronix.de>
 <1383642757-9762-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CACRpkdacQhwccK8nKf7m5aTA9ciHPuWth11v-OVPo0kS9WcUCQ@mail.gmail.com>
 <201311051234.43321.arnd@arndb.de>
Message-ID: <20131105115224.GN14892@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 05, 2013 at 12:34:42PM +0100, Arnd Bergmann wrote:
> On Tuesday 05 November 2013, Linus Walleij wrote:
> > On Tue, Nov 5, 2013 at 10:12 AM, Uwe Kleine-K?nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > 
> > > +config NEED_MACH_TIMEX_H
> > > +       bool
> > > +       help
> > > +         Select this when mach/timex.h is required to provide special
> > > +         definitions for this platform. This should be avoided when possible.
> > 
> > OK this is no blocker, and do proceed with this as the kernel sure
> > looks better after this than before it.
> > 
> > However as the next step I would prefer that we start to get rid of
> > all the NEED_MACH_FOO_H used for just refactoring out headers.
> > 
> > Can we not completely do away with this header next, and provide
> > the services it supplied locally in the mach-foo folder for these machines
> > instead so we do not need to have all these Kconfig things and preserve
> > the <mach/*> namespace for them?
> 
> Maybe we can collapse the CLOCK_TICK_RATE into a single Kconfig symbol
> like
> 
> 
> asm/timex.h:
> 
> #ifdef CONFIG_CLOCK_TICK_RATE
> #define CLOCK_TICK_RATE CONFIG_CLOCK_TICK_RATE
> #endif
> /* EOF */
> 
> Kconfig:
> 
> config CLOCK_TICK_RATE
> 	int
> 	depends on !ARCH_MULTIPLATFORM && ARCH_USES_GETTIMEOFFSET
> 	depends on ARCH_GEMINI || ARCH_SA1100 || ARCH_EBSA110 || ARCH_EP93XX || ARCH_RPC || ARCH_AT91X40
"depends on ARCH_USES_GETTIMEOFFSET" is wrong I think:

	$ make hackkit_defconfig
	....
	$ grep -E '^CONFIG_(ARCH_SA|USES_GET)' .config 
	CONFIG_ARCH_SA1100=y
	$

so ARCH_SA1100 doesn't imply ARCH_USES_GETTIMEOFFSET and so there won't
be a CONFIG_CLOCK_TICK_RATE here.

> 	default 40000000 if ARCH_AT91X40
> 	default 38000000 if ARCH_GEMINI
> 	default 3686400 if ARCH_SA1100
> 	default 47894000 if ARCH_EBSA110
> 	default 983040 if ARCH_EP93xx
> 	default 2000000 if ARCH_RPC
> 	# don't even think about adding more to this list, better get rid of the
> 	# existing ones by converting them to proper clocksources
> 
> > The real trick is to make CLOCK_TICK_RATE and LATCH runtime
> > variables instead of a compile-time variables, right? Can't we do
> > this?
> 
> We've almost killed off CLOCK_TICK_RATE for anything that matters, I'd prefer not
> doing anything to it other than reducing its uses to the places that we know need
> it.
Where is it still needed apart from some platform specific uses? I think
my patch is fine and with the corresponding hardware to test its easy to
fix all users that I am aware of. IMHO a Kconfig symbol is overkill
here. I even volunteer to address the users, just cannot test.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
