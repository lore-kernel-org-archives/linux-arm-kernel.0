From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 05 Jul 2016 13:40:16 +0200
Subject: [PATCH 3/3] reset: socfpga: use readl/writel_relaxed
In-Reply-To: <10266400.9nrl73J4sT@wuerfel>
References: <1467713872-4051-1-git-send-email-p.zabel@pengutronix.de>
 <1467713872-4051-3-git-send-email-p.zabel@pengutronix.de>
 <10266400.9nrl73J4sT@wuerfel>
Message-ID: <1467718816.2978.41.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 05.07.2016, 13:20 +0200 schrieb Arnd Bergmann:
> On Tuesday, July 5, 2016 12:17:52 PM CEST Philipp Zabel wrote:
> > This just removes the rmb()/wmb() pair between register read and
> > write. Since no relevant reads follow the rmb and no relevant writes
> > precede the wmb, they should be safe to remove.
> > 
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> 
> We should only do this if you are fixing a bug (which you don't mention
> in the changelog), or if you can show a relevant performance
> improvement. Is this code ever used in a fast path? If it is,
> wouldn't that indicate a problem in some driver?

It does not fix a bug, and it's not about performance either. I'd like
to align code with the recently posted stm32 driver, to unify them in a
future patch.
Of course we can change the stm32 driver to use readl/writel instead of
the relaxed variants, it just seemed useless to have those barriers
between the read and write.

If anything, we'd need to try to make sure that the writel in assert
hits the hardware before the function returns, so that a
assert-delay-deassert doesn't accidentally spend half its delay with the
writel still in the store buffer, and we'd need a full barrier after the
writel in deassert so that there can be no successive reads from still
disabled IP cores.

regards
Philipp
