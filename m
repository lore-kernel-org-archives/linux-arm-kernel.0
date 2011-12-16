From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Dec 2011 15:22:42 +0000
Subject: [GIT PULL] Samsung devel-1 for v3.3
In-Reply-To: <014a01ccbbc6$7b036300$710a2900$%kim@samsung.com>
References: <014a01ccbbc6$7b036300$710a2900$%kim@samsung.com>
Message-ID: <201112161522.42721.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 16 December 2011, Kukjin Kim wrote:
> Please pull next-samsung-devel for v3.3.
> It includes DT support for EXYNOS, update Cragganmore board and SPI clkdev
> support. As a note, out of arch/arm/samsung stuff got the ack from regarding
> maintainers and actually, it has been included in linux-next for long time
> so I think, it has no problem for v3.3.
> 
> One more, I need to follow up Russell and some arm consolidation work and
> one plat-samsung directory and apply some patches in my mail-box ;) It will
> be sent to you soon.
> 
> If any problems, please let me know.

The patches look really good for the most part, but I'd rather not take
them like this because you have put so many different things into a single
branch. Your branch is much larger than any of the others that are currently
queued in arm-soc.

Can you split it up into separate branches for dt, board and clkdev and
driver changes or something along those lines?
A number of changes in here also seem to qualify as cleanups,
so they might better be held in a branch for that.

I also found one commit that I think should not be there: 25767e69 "ARM:
EXYNOS: Add ioremap interceptor for statically remapped regions" from
Thomas Abraham. As far as I know, the work that Nico did on the vmalloc_end
elimination will conflict with this patch and solve the problem in a better
way.

I have now pulled in everything up to 39cb263ecc "ARM: S3C64XX: Hook up
VDDINT on Cragganmore" into a samsung/board branch and merged that into
the next/board branch, because that was easy to do without rebasing.

The rest should be fairly easy to split up into the branches I mentioned
if you don't mind rebasing them (best leaving them on v3.2-rc1 though).
Without rebasing, it would get a bit trickier but we could easily make
39ae3685 "ARM: dts: Add intial dts file for EXYNOS4210 SoC, SMDKV310 and
ORIGEN" the samsung/dt branch and revert the ioremap interceptor on top
of that. The samsung/clkdev branch probably should depend on the samsung/dt
branch anyway, so it can remain on top without getting rebased.

I can probably fix this all up (this time) in the way I want it, or let you
take care of it and send me new pull requests, whichever you prefer.

	Arnd
