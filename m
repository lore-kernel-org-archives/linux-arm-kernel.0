From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 10 Jun 2010 11:43:10 +0200
Subject: [PATCH 4/5] [ARM] Auto calculate ZRELADDR and provide option
	for exceptions
In-Reply-To: <AANLkTilOaHD12oxQZNaWJzKw1gcoT-1LTzpEtULUSLU4@mail.gmail.com>
References: <1275550613-9553-1-git-send-email-eric.miao@canonical.com>
	<1275550613-9553-5-git-send-email-eric.miao@canonical.com>
	<20100610090015.GD3422@pengutronix.de>
	<20100610091608.GA28305@n2100.arm.linux.org.uk>
	<AANLkTilOaHD12oxQZNaWJzKw1gcoT-1LTzpEtULUSLU4@mail.gmail.com>
Message-ID: <20100610094310.GG3422@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 10, 2010 at 05:38:27PM +0800, Eric Miao wrote:
> 2010/6/10 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> > On Thu, Jun 10, 2010 at 11:00:15AM +0200, Uwe Kleine-K?nig wrote:
> >> What do you think about requiring r4 to be set to physoffset as I did in
> >> my series? ?This way zImage would already know PHYSOFFSET and so didn't
> >> need to guess ZRELADDR. ?OK, until most bootloaders are fixed we need
> >> to guess, too. ?But at least this would provide a way to stop guessing
> >> wrong for the affected platforms.
> >
> > That means it won't get implemented. ?Look at the facts. ?It's taken
> > _years_ (5+ years) for boot loaders to start passing a value in r1.
> > We then switched to the ATAG stuff, and it's again taking years for
> > boot loaders to start passing right ATAG stuff - and most of them don't
> > get it right. ?Eg, lots of uboot are happy to print out the memory
> > information on the terminal as they start up, but don't pass memory
> > information to the kernel.
> >
> > So if we want phys offset in r4, we better realise that it'll take
> > something like five years of nagging to get it in place, and even then
> > people will continue to use boot loaders which don't have support.
> > And if it's only necessary for a handful of platforms, I doubt anyone's
> > really going to bother - or even validate that r4 is correct.
> >
> > You have a whole set of other problems - how do you cope with existing
> > boot loaders which happen to call the kernel with a value in r4 which
> > _could_ potentially be valid, but should not be used? ?At the moment,
> > r4 could contain _any_ value what so ever.
> >
> > Let's face it - advertising that "the kernel will eventually start using
> > r4" doesn't solve the problem either - we did that with the ATAG list
> > and we know the results from that.
> >
> > Maybe the right experiment to try this time - if we want r4 to contain
> > a value - is to say that kernel 2.6.37 will require a value in r4, and
> > won't boot without it, and will therefore be incompatible with old
> > boot loaders.
> >
> 
> It might be difficult to guess if it's a correct value in r4 and we might
> not need it. We know which boards can be compiled together and
> the phys_offset can be guessed and we make a single kernel for them,
> otherwise we end up building a specific kernel. Although my observation
> is that most platforms can guess phys_offset automatically, but due to
> the fact there are so many ARM variants out there, and each is doing
> things differently, what we can do now is to provide both choices.
> 
> And you reminded me that it might be better if we can make RUNTIME_PHYS_OFFSET
> depends on the architecture this is test-proofed, so when the day that
> 
> RUNTIME_PHYS_OFFSET
>         depends on {ALL_ARCH}
I would prefer

	config HAVE_RUNTIME_PHYS_OFFSET
		bool

	config RUNTIME_PHYS_OFFSET
		depens on HAVE_RUNTIME_PHYS_OFFSET

	config ARCH_FOO
		select HAVE_RUNTIME_PHYS_OFFSET

for the usual reasons.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
