From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 7 Jul 2011 22:48:33 +0200
Subject: reply: [PATCH v5 1/3] ARM: mxs: add GPMI-NFC support
	for?imx23/imx28
In-Reply-To: <201107071757.23405.arnd@arndb.de>
References: <14C4E31473AF7E4B98176CB73615181C19FBD3@039-SN1MPN1-006.039d.mgd.msft.net>
	<201107011109.27206.arnd@arndb.de> <4E1574A1.4050502@freescale.com>
	<201107071757.23405.arnd@arndb.de>
Message-ID: <20110707204833.GL29624@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2011 at 05:57:23PM +0200, Arnd Bergmann wrote:
> On Thursday 07 July 2011, Huang Shijie wrote:
> > > On Friday 01 July 2011 10:57:40 Huang Shijie wrote:
> > >>>> It's annoying, but it really saves some lines.
> > >>> It would save more lines if you introduce the macros globally and
> > >>> convert all existing resource definitions ;-)
> > >> The origin code did not use any macros.
> > >> Some one suggested me to use macros.
> > >> So i used the macros.
> > >>
> > >> Do i have to drop the macros?
> > > Can you find out who made the suggestion? Let's first reach consensus
> > > about how we want to do these things in the future.
> > http://www.spinics.net/lists/arm-kernel/msg121384.html
> > 
> 
> Ok, so Uwe made a rather generic comment that he'd prefer you to use
> macros for that part. I think your original code actually looks cleaner
> in this case, mostly because it doesn't obfuscate the identifiers
> and because the macro is specific to this file.
> 
> Uwe, do you think it's worthwhile introducing a global macro for
> everyone to use for defining resources? Clearly this is not an
> mxs specific problem, and I'd much rather have the same solution
> everywhere.
The thing I didn't like in the original code is that there are two
nearly identical data definitions. With the macros introduced here
(one example to ease the discussion:

	#define RES_MEM(soc, _id, _s, _n)				\
		{							\
			.start = soc ##_## _id ## _BASE_ADDR,		\
			.end   = soc ##_## _id ## _BASE_ADDR + (_s) - 1,\
			.name  = (_n),					\
			.flags = IORESOURCE_MEM,			\
		}

)

My thoughts on this is that it should better go to where struct resource
is defined (<linux/ioports.h>, as Arndt suggested) but then probably a
bit more generic as:

	#define RES_MEM_NAMED(_start, _end, _name)			\
		{							\
			.start = _start,				\
			.end = _end,					\
			.name = _name,					\
			.flags = IORESOURCE_MEM,			\
		}
	#define RES_MEM(_start, _end)					\
		RES_MEM_NAMED(_start, _end, NULL)

(Maybe alternatively take a _size parameter instead of _end?)
While this makes the repetition shorter, it's still there.

I thought this could be shrinked down to

	const struct resource res_imx23[] __initconst = something_magic(MX23);
	const struct resource res_imx28[] __initconst = something_magic(MX28);

While this part looks nice, I agree that it's not as easy to understand
(for a human) as the expanded version. Knowing not everybody agrees with
me, I still prefer the shrinked representation.
But as I'm not willing to argue about that: Please use the expanded version
if you prefer it.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
