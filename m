From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 2 Dec 2009 12:10:53 +0000
Subject: [PATCH 4/7] S3C64XX: Declare IISv4 PCLK for S3C6410
In-Reply-To: <1b68c6790912011650p58cc6b27n90b032167ebb9bc8@mail.gmail.com>
References: <20091127164312.GA11913@rakim.wolfsonmicro.main>
	<1259340239-12067-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20091201214201.GP4808@trinity.fluff.org>
	<1b68c6790912011650p58cc6b27n90b032167ebb9bc8@mail.gmail.com>
Message-ID: <20091202121053.GC12661@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 02, 2009 at 09:50:15AM +0900, jassi brar wrote:
> On Wed, Dec 2, 2009 at 6:42 AM, Ben Dooks <ben-linux@fluff.org> wrote:

> > 1) If changing the .id field of the iisv4 device really a good idea,
> > ? especially if there might be more than one of them in the future?

> Also, changing indices of devices with disregard to their respective clock
> might force further adhoc changes in system resources.

Well, from that point of view we'd be much better off with clkdev which
completely avoids the need to fiddle with id numbers to match clocks and
devices; the fact that this is a concern is really a limitation of the
clock API and open to fragility.  There would also be issues if someone
decided to do something like hang the PCM controllers off CLKAUDIO1 and
2 instead of 0 and 1, for example.  It's only a concern because there is
insufficient abstracton between the devices and clocks.

> I think, best wud be to modify s3c64xx_i2s.c to support 2 channel, 6
> channel, h/w mixing(maybe LP-Audio feature too) and pass flag for each
> feature via platform data
> by something like:-  .has_6_channels, .has_hw_mixer, .has_lp_audio etc

> The point to note here is to write drivers around functionality, rather than
> version, of the controller.

This can also be addressed via use of library code (which is what's
happening at the minute for the stuff that's shared between the 24xx and
64xx series).  You can also look at this from the point of view of
saying that IP blocks that are documented as having separate programming
interfaces should be presented in a similar way to the user so that it's
easier for them to find the functionality they need.

None of the approach I'm suggesting means that we can't have a single
driver file which handles more than one revision of the controller, we
can always move the registration of multiple variants into a single
source file.  The benefit is that we're not forced to do that so if the
conditional code gets to be too much which does seem likely - there's
already differences going from 24xx to 64xx, and I seem to recall that
there are some incompatibilities between IISv2 and IISv4 on the 6410 too.

Since Samsung have not been willing to share documentation (I do have
access to some but not all) it's hard to comment in detail on the most
tasteful way of handling all these things but I have particular concerns
about trying to fit more substantial functionality like hardware mixing
support into the existing driver.
