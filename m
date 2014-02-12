From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 12 Feb 2014 16:12:06 +0000
Subject: [PATCH 4/7] spi: pl022: attempt to get sspclk by name
In-Reply-To: <1786282.mNUF0ZaUg2@wuerfel>
References: <1392118632-11312-1-git-send-email-mark.rutland@arm.com>
 <201402121221.51233.arnd@arndb.de>
 <20140212114740.GE21992@e106331-lin.cambridge.arm.com>
 <1786282.mNUF0ZaUg2@wuerfel>
Message-ID: <20140212161206.GD25957@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 12, 2014 at 01:03:26PM +0000, Arnd Bergmann wrote:
> On Wednesday 12 February 2014 11:47:40 Mark Rutland wrote:
> > On Wed, Feb 12, 2014 at 11:21:50AM +0000, Arnd Bergmann wrote:
> > > On Wednesday 12 February 2014, Mark Rutland wrote:
> > > > To me it feels odd to require the last clock in the list (apb_pclk) to
> > > > be named, and the rest to be in a particular order. For the dt case it
> > > > seems saner to add new clocks with names as it allows arbitrary subsets
> > > > of clocks to be wired up and described (though obviously in this case a
> > > > missing sspclk would be problematic).
> > > 
> > > Yes, good point about the missing clocks, and I also agree mixing ordered
> > > and named clocks in one device is rather odd and can lead to trouble.
> > > 
> > > I guess there isn't really a good way out here, and I certainly won't
> > > ask for it to be done one way or the other if someone else has a 
> > > good argument which way it should be implemented.
> > 
> > Having thought about it, all dts that for the ssp_pclk must have some
> > name for the sspclk (though the specific name is arbitrary). I could get
> > the driver to try each of those before falling back to the index
> > (perhaps with a helper that takes a list of known aliases), so all
> > existing dts (that we are aware of) would work with the clock requested
> > by name.
> 
> Strange. Why do the even have names in there? What are those strings?

I guess they're there as spacers to allow the AMBA bus code to get the
right clock when it calls clk_get(&pcdev->dev, "apb_pclk").  Everyone
seems to have worked around the binding rather than reporting the issue
or fixing it.

>From a quick grep, for pl022's SSPCLK we currently have the strings:

* ssp{0,1}clk
* spi_clk
* spi{0,1,2,3}clk

Though I may have missed a string or two where nodes get amended in more
specific files. A grep for apb_clk to find neighbours didn't highlight
any obvious ones.

> 
> I noticed that ux500 has uses four different strings, one for each
> instance, which is obviously a bug and should just be fixed. There is
> no way this was intentional, and we can just rely on teh fallback
> if you want to have that anyway.

Sure, I'll fix those up once we have a preferred name. I guess this
would be SSPCLK by Russell's comments, I wasn't able to find a prior use
in the git history, but it would be in keeping with KMIREFCLK as used by
the pl050 driver.

Given the general policy of trying to not break support for existing
DTBs we'll need some fallback, either using the first clock or getting
the driver to try the names above.

> 
> > I assume that for the non-dt case it's possible to name clock inputs to
> > a device without the clock being associated with the name globally? If
> > so we could get rid of the index usage entirely in this case.
> 
> Sorry, I don't understand the question.

I thought one of the issues before dt was that clocks were in a global
namespace. Mark's reply implies that's not necessarily the case, so I'll
take a tour through clkdev to educate myself.

Cheers,
Mark.
