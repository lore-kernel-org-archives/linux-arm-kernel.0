From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 12 Feb 2014 10:33:29 +0000
Subject: [PATCH 4/7] spi: pl022: attempt to get sspclk by name
In-Reply-To: <201402111508.06267.arnd@arndb.de>
References: <1392118632-11312-1-git-send-email-mark.rutland@arm.com>
 <1392118632-11312-5-git-send-email-mark.rutland@arm.com>
 <20140211120645.GH13533@sirena.org.uk>
 <201402111508.06267.arnd@arndb.de>
Message-ID: <20140212103329.GC21992@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 11, 2014 at 02:08:06PM +0000, Arnd Bergmann wrote:
> On Tuesday 11 February 2014, Mark Brown wrote:
> > On Tue, Feb 11, 2014 at 11:37:09AM +0000, Mark Rutland wrote:
> > 
> > > -     pl022->clk = devm_clk_get(&adev->dev, NULL);
> > > +     /*
> > > +      * For compatibility with old DTBs and platform data, fall back to the
> > > +      * first clock if there's not an explicitly named "sspclk" entry.
> > > +      */
> > > +     pl022->clk = devm_clk_get(&adev->dev, "sspclk");
> > > +     if (IS_ERR(pl022->clk))
> > > +             pl022->clk = devm_clk_get(&adev->dev, NULL);
> > > +
> > 
> > I'll just have a bit of a grumble here and point out that this sort of
> > stuff always worries me with the convention of using nameless clocks -
> > it causes hassle adding further clocks.
> 
> I think the best solution for this is to continue with anonymous clocks
> rather than adding names after the fact. This could be done (for DT-only
> drivers) using the of_clk_get() interface that takes an index, or
> we could add a generic dev_clk_get_index() or similar interface that
> has the same behavior but also works for clkdev.

That works, and if taken alone patch 7 would codify that existing
behaviour as the standard.

To me it feels odd to require the last clock in the list (apb_pclk) to
be named, and the rest to be in a particular order. For the dt case it
seems saner to add new clocks with names as it allows arbitrary subsets
of clocks to be wired up and described (though obviously in this case a
missing sspclk would be problematic).

For new bindings I'd really like to push people to always use named
clocks as it makes things far more flexible, but I appreciate that here
there are issues associated with modifying an existing binding.

Mark, do you have specific issues that named clocks cause that I could
look into?

Cheers,
Mark.
