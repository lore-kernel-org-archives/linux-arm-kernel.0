From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 22 Jun 2010 11:15:00 +0100
Subject: [PATCH] ASoC: Add new TI TLV320AIC3204 CODEC driver
In-Reply-To: <20100621234314.GZ7759@www.longlandclan.yi.org>
References: <1276833465-31702-1-git-send-email-redhatter@gentoo.org>
	<1276899876-19001-1-git-send-email-redhatter@gentoo.org>
	<20100619011221.GC2463@opensource.wolfsonmicro.com>
	<20100621234314.GZ7759@www.longlandclan.yi.org>
Message-ID: <20100622101500.GA15255@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 22, 2010 at 09:43:14AM +1000, Stuart Longland wrote:
> On Sat, Jun 19, 2010 at 02:12:21AM +0100, Mark Brown wrote:
> > On Sat, Jun 19, 2010 at 08:24:36AM +1000, Stuart Longland wrote:
> > > +	/* Page 1 */
> > > +	if (page == 1) {
> > > +		if (reg <= 4)
> > > +			return 1;

> > I can't help but think that this'd be more legible with switch ()
> > statements (GCC has an extension for ranges in switch statements which
> > you could use).

> One is to go on a page-by-page basis, which is how I do it using the if
> statements.  Here; I define my ranges so that I start from the very
> end... anything beyond page 70 is invalid ... voila, I eliminate those
> early on.  A number of pages have a similar register pattern, and so I
> make use of nested if statements to explain this.  The if block for
> pages following always use the block before to define the upper,
> non-inclusive bound.

It's not so much the outer ifs that were bothering me, it's the inner
ones where you're doing the final register ranges as just a sequence of
if statements (not even if ... else) which really bothered me here.  The
code just doesn't look like what it's trying to do.

> This is a function largely intended for debugging, in fact, I'm thinking
> I should probably wrap it in #ifdef CONFIG_DEBUG_FS, since the function
> isn't called unless debugfs is enabled.  So I'm not certain that
> performance is worth chasing here given the intended purpose -- it's not
> something that's called all the time, nor something that will be used in
> a production environment.

Oh, I thought you were using it to filter the CODEC register displays?

> That's my thoughts on the issue, perhaps na??ve, but I'm not sure
> there's any real gain in refactoring this.

It's fairly hard to read at the minute - 
