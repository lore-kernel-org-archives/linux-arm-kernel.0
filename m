From: will.deacon@arm.com (Will Deacon)
Date: Mon, 16 Jan 2012 14:50:08 +0000
Subject: [PATCH 1/2] mach-ux500: cache operations are atomic on PL310
In-Reply-To: <20120116110528.GA24824@bnru02>
References: <1326346663-6112-1-git-send-email-srinidhi.kasagar@stericsson.com>
 <20120113181422.GB24373@mudshark.cambridge.arm.com>
 <20120116110528.GA24824@bnru02>
Message-ID: <20120116145008.GH9068@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 16, 2012 at 11:05:29AM +0000, Srinidhi KASAGAR wrote:
> On Fri, Jan 13, 2012 at 19:14:22 +0100, Will Deacon wrote:
> > Hi guys,
> > 
> > On Thu, Jan 12, 2012 at 05:37:42AM +0000, Srinidhi KASAGAR wrote:
> > > Apply ERRATA_753970 for ux500 variant of cache sync too
> > > 
> > > Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
> > > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > > ---
> > >  arch/arm/mach-ux500/cache-l2x0.c |   11 ++++++++---
> > >  1 files changed, 8 insertions(+), 3 deletions(-)
> > 
> > I hadn't noticed the existence of this file before, but this patch really
> > shows why it's not a good idea to copy files out of core ARM code and into
> > the mach-* directories. I see that the commit introducing this file 458eef2f
> > ("mach-ux500: factor out l2x0 handling code") mentions that mach-imx does
> > the same thing, but I can't find the code there.
> > 
> > On top of that, it seems as though you provide an inv_all implementation
> > but your disable function is empty. Surely this can lead to data loss?
> 
> We can't disable l2x0 from non secure mode and either we do not have
> special SMI to handle the same and hence it is empty. So for kexec
> to work on this platform we need to have a non-locking variant of
> inv_all() otherwise we seems to be looping forever in spin locks
> as such L1 caches are disabled at that moment in cpu_proc_fin().
> So we had to override this inv_all for this machine.

Actually, now that I've fixed kexec, we don't use inv_all in that path. It's
only used in the power management code now, it seems. But my point still
stands - invalidating a cache that is enabled is a *really* bad idea, that's
why we have this in cache-l2x0.c:

	/* Invalidating when L2 is enabled is a nono */
	BUG_ON(readl(l2x0_base + L2X0_CTRL) & 1);

> Otherwise, what do you suggest? Whats the effect if we remove
> that spin lock in inv_all as such I don't see much users using
> inv_all.

The lock needs to stay. Besides, the problem isn't with inv_all, the problem
is with not being able to disable the outer cache. So can't you just do
something nasty like:

	outer_cache.disable = NULL;

after your call to l2x0_init?

Also, if you can't disable the L2 from non-secure, does that mean that you
boot Linux with the L2 enabled?

Will
