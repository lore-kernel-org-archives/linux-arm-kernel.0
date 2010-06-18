From: redhatter@gentoo.org (Stuart Longland)
Date: Fri, 18 Jun 2010 21:33:35 +1000
Subject: [PATCH] ASoC: Add new TI TLV320AIC3204 CODEC driver
In-Reply-To: <1276858862.3054.28.camel@odin>
References: <1276833465-31702-1-git-send-email-redhatter@gentoo.org>
	<1276858862.3054.28.camel@odin>
Message-ID: <20100618113335.GB30868@www.longlandclan.yi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

To others: In case you're wondering where the patch is... I pulled it
from the moderation queue because there were a few style errors, and
some definitions I forgot to delete.  A fresh one that meets coding
style requirements is on its way, as soon as scripts/checkpatch.pl is
finished (this seems to take a while on my hardware).

On Fri, Jun 18, 2010 at 12:01:02PM +0100, Liam Girdwood wrote:
> On Fri, 2010-06-18 at 13:57 +1000, Stuart Longland wrote:
> > The TLV320AIC3204 is a low-power stereo audio CODEC capable of sample
> > rates of up to 192kHz.  This driver implements basic functionality,
> > using I??C for the control channel.
> > 
> > The audio interface supports many data bus formats, including I??S
> > master/slave, DSP, left/right justified and TDM.
> 
> Just had a quick check and the register caching needs addressed.
> 
> I agree with your comments, I don't think we really want to cache all
> 16K of codec registers here as we will probably only ever use a handful
> of them. I think a smaller lookup table containing only the registers
> that we care about will do.

Yeah, I wasn't sure how to go about it.  It's inefficient, but it's
simple, and works.  Other options I've considered;

(1) Mark's suggestion of using per-page arrays
(2) Using address translation. that is:
	- Page 0 registers 0-127 stored in cache array elements 0-127
	- Page 1 registers 0-127 stored in cache array elements 128-255
	- Page 2..7 are skipped
	- Page 8 registers 0-127 stored in cache array elements 256-383
	... etc.

> Fwiw, a generic ASoC lookup table would be best as this could be used by
> other codecs with large register maps too. The table should be ordered
> (for quick lookup) and also contain a readable/writeable/volatile flag
> for each register.

Indeed, the 'AIC3204 is not the only CODEC to use sparse register maps.
16KB is not a lot of RAM these days, but it's a lot more RAM than I'm
comfortable using for an audio driver.  I'll give this some thought, but
for now I'll press on with what I have since I know it works reliably.

Another thought regarding register cache, rather than hard-coding it the
way we presently do, we could also build up the cache on demand... that
is, we maintain a table of previously read registers; if a register
value is read for the first time, an actual read is done from the CODEC
(or the value is copied from a static table).  All subsequent reads then
come from cache.  On suspend; if a register has not been touched, it is
deemed to be left at default settings, and skipped on resume.

The downside of this is having to maintain a table of what registers
have been read already; which would possibly be as big as the cache is
anyway.  But the flip side; if a company brought out a new CODEC which
had differing power-up defaults to a similar CODEC handled by the same
driver, it would prevent the wrong default getting assumed or loaded in.
-- 
Stuart Longland (aka Redhatter, VK4MSL)      .'''.
Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
. . . . . . . . . . . . . . . . . . . . . .   .'.'
http://dev.gentoo.org/~redhatter             :.'

I haven't lost my mind...
  ...it's backed up on a tape somewhere.
