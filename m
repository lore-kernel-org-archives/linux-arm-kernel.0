From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 18 Jun 2010 16:53:23 +0100
Subject: [PATCH] ASoC: Add new TI TLV320AIC3204 CODEC driver
In-Reply-To: <20100618113335.GB30868@www.longlandclan.yi.org>
References: <1276833465-31702-1-git-send-email-redhatter@gentoo.org>
	<1276858862.3054.28.camel@odin>
	<20100618113335.GB30868@www.longlandclan.yi.org>
Message-ID: <20100618155322.GB16941@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 18, 2010 at 09:33:35PM +1000, Stuart Longland wrote:
> On Fri, Jun 18, 2010 at 12:01:02PM +0100, Liam Girdwood wrote:
> > On Fri, 2010-06-18 at 13:57 +1000, Stuart Longland wrote:

> > > The audio interface supports many data bus formats, including I??S
> > > master/slave, DSP, left/right justified and TDM.

> > Just had a quick check and the register caching needs addressed.

> > I agree with your comments, I don't think we really want to cache all
> > 16K of codec registers here as we will probably only ever use a handful
> > of them. I think a smaller lookup table containing only the registers
> > that we care about will do.

> Yeah, I wasn't sure how to go about it.  It's inefficient, but it's
> simple, and works.  Other options I've considered;

> (1) Mark's suggestion of using per-page arrays
> (2) Using address translation. that is:
> 	- Page 0 registers 0-127 stored in cache array elements 0-127
> 	- Page 1 registers 0-127 stored in cache array elements 128-255
> 	- Page 2..7 are skipped
> 	- Page 8 registers 0-127 stored in cache array elements 256-383
> 	... etc.

Option 2 is what others have used here.  I do think that anything we do
here really ought to have some sort of page mapping support whatever the
actual implementation it uses - TI in particular have a bunch of chips
which do this so there's a general call for something that can handle
them.

If you are going to do a lookup table one way of doing this would be to
have the lookup table be a table of range mappings (I've not looked at
the patch, perhaps that's what you've done already) - just so long as
it's got the concept of pages covered somehow.

> Another thought regarding register cache, rather than hard-coding it the
> way we presently do, we could also build up the cache on demand... that
> is, we maintain a table of previously read registers; if a register
> value is read for the first time, an actual read is done from the CODEC
> (or the value is copied from a static table).  All subsequent reads then
> come from cache.  On suspend; if a register has not been touched, it is
> deemed to be left at default settings, and skipped on resume.

The only problem with this is that for a number of reasons a lot of
devices have no read functionality at all.  These need us to supply the
defaults from outside the device, though other devices could use what
you suggest.  I'd not be so bothered about the performance here - this
has to be high performance in comparison with doing I/O on a slow bus
such as I2C.  If we do run into performance issues we can always work on
substituting in a higher performance algorithm later, if everything is
well encapsulated this should be doable without much disruption.

It's also useful to have the actual defaults available for allowing
writes to be skipped when powering up the device (eg, on resume) - these
could be cached on first write so it's not insurmountable but it does
need to be considered.

> The downside of this is having to maintain a table of what registers
> have been read already; which would possibly be as big as the cache is
> anyway.  But the flip side; if a company brought out a new CODEC which
> had differing power-up defaults to a similar CODEC handled by the same
> driver, it would prevent the wrong default getting assumed or loaded in.

I'm not sure that's a big risk to be honest - the reuse you see tends to
be much more complete than this.
