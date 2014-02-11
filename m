From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 11 Feb 2014 15:04:38 +0000
Subject: [PATCH 4/7] spi: pl022: attempt to get sspclk by name
In-Reply-To: <201402111508.06267.arnd@arndb.de>
References: <1392118632-11312-1-git-send-email-mark.rutland@arm.com>
 <1392118632-11312-5-git-send-email-mark.rutland@arm.com>
 <20140211120645.GH13533@sirena.org.uk> <201402111508.06267.arnd@arndb.de>
Message-ID: <20140211150438.GJ26684@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 11, 2014 at 03:08:06PM +0100, Arnd Bergmann wrote:
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

Mixing devm_* and non-devm_* interfaces doesn't work.  If you want to do
that, devm_of_clk_get() would be a prerequisit.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
