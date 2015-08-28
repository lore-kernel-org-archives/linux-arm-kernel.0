From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 28 Aug 2015 10:44:13 +0100
Subject: [PATCH 1/3] ARM: uniphier: add outer cache support
In-Reply-To: <4027826.UsiXogeDbt@wuerfel>
References: <1440382692-3855-1-git-send-email-yamada.masahiro@socionext.com>
 <2021253.vgeYqalDfp@wuerfel>
 <CAK7LNAQ_oymnQNEcP+FDqyxNKtMyiCwgxSRMmg5HAKQW9C6eRg@mail.gmail.com>
 <4027826.UsiXogeDbt@wuerfel>
Message-ID: <20150828094412.GH21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 26, 2015 at 02:52:45PM +0200, Arnd Bergmann wrote:
> On Wednesday 26 August 2015 10:38:59 Masahiro Yamada wrote:
> > Moreover, outer-cache init seems to be unrelated to
> > IRQ init.
> 
> Agreed, this is also just a historic artifact, as we don't really
> have a place to put cache controller initialization, and the

Arnd, I'm afraid you're completely wrong there.  It's not a historic
artifact by any of the kind.

I explicitly placed the L2 cache initialisation there based upon
which callbacks into architecture code were available from init/main.c
and where in the initialisation sequence I wanted the L2 cache to be
initialised _for_ _everyone_.

That being, before SMP is brought up, preferably before the delay
loop calibration (so we don't calibrate the loop without the L2 cache,
and then invalidate that calibration when we enable the cache), but
sufficiently late that various services that the L2 cache code wants
(like kmalloc) have been initialised.

That rules out setup_arch(), leaving trap_init(), init_IRQ(), time_init()
and late_time_init().  I chose init_IRQ() out of that lot because it
seemed to be a sensible point to initialise it, though trap_init()
looks like it could have been another good site.

All L2 caches should be initialised at a similar point IMHO - not only
does this give us a more consistent initialisation sequence, but it
avoids issues such as the one I mention above with delay loop calibration
being wrong.

> A first step would be to add the tauros2 and uniphier outer cache
> init to the init_IRQ() function, and then have another patch
> that moves all the outercache initialization into a new place
> like arch/arm/mm/outercache.c so we don't clutter up irq.c

arch/arm/mm/l2c-common.c

> with unrelated stuff.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
