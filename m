From: srinidhi.kasagar@stericsson.com (Srinidhi KASAGAR)
Date: Mon, 16 Jan 2012 16:35:29 +0530
Subject: [PATCH 1/2] mach-ux500: cache operations are atomic on PL310
In-Reply-To: <20120113181422.GB24373@mudshark.cambridge.arm.com>
References: <1326346663-6112-1-git-send-email-srinidhi.kasagar@stericsson.com>
 <20120113181422.GB24373@mudshark.cambridge.arm.com>
Message-ID: <20120116110528.GA24824@bnru02>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2012 at 19:14:22 +0100, Will Deacon wrote:
> Hi guys,
> 
> On Thu, Jan 12, 2012 at 05:37:42AM +0000, Srinidhi KASAGAR wrote:
> > Apply ERRATA_753970 for ux500 variant of cache sync too
> > 
> > Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> >  arch/arm/mach-ux500/cache-l2x0.c |   11 ++++++++---
> >  1 files changed, 8 insertions(+), 3 deletions(-)
> 
> I hadn't noticed the existence of this file before, but this patch really
> shows why it's not a good idea to copy files out of core ARM code and into
> the mach-* directories. I see that the commit introducing this file 458eef2f
> ("mach-ux500: factor out l2x0 handling code") mentions that mach-imx does
> the same thing, but I can't find the code there.
> 
> On top of that, it seems as though you provide an inv_all implementation
> but your disable function is empty. Surely this can lead to data loss?

We can't disable l2x0 from non secure mode and either we do not have
special SMI to handle the same and hence it is empty. So for kexec
to work on this platform we need to have a non-locking variant of
inv_all() otherwise we seems to be looping forever in spin locks
as such L1 caches are disabled at that moment in cpu_proc_fin().
So we had to override this inv_all for this machine.

Otherwise, what do you suggest? Whats the effect if we remove
that spin lock in inv_all as such I don't see much users using
inv_all.

srinidhi
