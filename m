From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 12 Feb 2014 11:47:40 +0000
Subject: [PATCH 4/7] spi: pl022: attempt to get sspclk by name
In-Reply-To: <201402121221.51233.arnd@arndb.de>
References: <1392118632-11312-1-git-send-email-mark.rutland@arm.com>
 <201402111508.06267.arnd@arndb.de>
 <20140212103329.GC21992@e106331-lin.cambridge.arm.com>
 <201402121221.51233.arnd@arndb.de>
Message-ID: <20140212114740.GE21992@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 12, 2014 at 11:21:50AM +0000, Arnd Bergmann wrote:
> On Wednesday 12 February 2014, Mark Rutland wrote:
> > To me it feels odd to require the last clock in the list (apb_pclk) to
> > be named, and the rest to be in a particular order. For the dt case it
> > seems saner to add new clocks with names as it allows arbitrary subsets
> > of clocks to be wired up and described (though obviously in this case a
> > missing sspclk would be problematic).
> 
> Yes, good point about the missing clocks, and I also agree mixing ordered
> and named clocks in one device is rather odd and can lead to trouble.
> 
> I guess there isn't really a good way out here, and I certainly won't
> ask for it to be done one way or the other if someone else has a 
> good argument which way it should be implemented.

Having thought about it, all dts that for the ssp_pclk must have some
name for the sspclk (though the specific name is arbitrary). I could get
the driver to try each of those before falling back to the index
(perhaps with a helper that takes a list of known aliases), so all
existing dts (that we are aware of) would work with the clock requested
by name.

I assume that for the non-dt case it's possible to name clock inputs to
a device without the clock being associated with the name globally? If
so we could get rid of the index usage entirely in this case.

Does that sound workable?

Thanks,
Mark.
