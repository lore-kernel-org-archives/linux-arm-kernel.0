From: manjugk@ti.com (G, Manjunath Kondaiah)
Date: Mon, 7 Mar 2011 16:36:12 +0530
Subject: [PATCH 0/3] OMAP: DMA: mstandby mode and runtime pm support
In-Reply-To: <20110304041826.GA7025@m-desktop>
References: <1298542475-1460-1-git-send-email-manjugk@ti.com>
	<87hbbkqcgk.fsf@ti.com> <20110304041826.GA7025@m-desktop>
Message-ID: <20110307110611.GA8743@m-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 04, 2011 at 09:48:26AM +0530, G, Manjunath Kondaiah wrote:
> On Thu, Mar 03, 2011 at 10:35:23AM -0800, Kevin Hilman wrote:
> > "G, Manjunath Kondaiah" <manjugk@ti.com> writes:
> > 
> > > This patch series is remaining part of dma hwmod to support pm runtime 
> > > and for handling mstandby mode for all applicable DMA mstandby mode errata.
> > 
> > This is still not runtime-suspending when I use my DMA test in linking
> > mode.
> > 
> > If I put a large enough period between transfers, it should autosuspend
> > during transfers.  It seems to do auto-suspend and resume once, but then
> > it never suspends again.
> > 
> > I tested with my dmatest module[1], and loaded with:
> > 
> >   # insmod ./dmatest.ko linking=1 forever=1 forever_period=1024
> > 
> > Not only does it not auto-suspend between transfers (which I expected),
> > it also doesn't suspend after removing the module which stops all active
> > channels.
> 
> The normal chaining test cases are executed and which used to show the
> proper status. Let me reproduce this issue with your test procedure.

ok. I am able to reproduce this issue and fixed _get_sync usage in
omap_start_dma if channel linking is used. Earlier it was handled for
the cases with chaining API's. If linking is done without chaining
API's, it will result in _get_sync and _put mismatch.

Thanks for the test case and I will be re posting the patches with the 
above fix.

-Manjunath
