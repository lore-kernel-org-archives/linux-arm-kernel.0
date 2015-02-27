From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 27 Feb 2015 10:14:22 +0100
Subject: [PATCH v2 2/2] hwrng: iproc-rng200 - Add Broadcom IPROC RNG driver
In-Reply-To: <54EF9D7A.3090707@broadcom.com>
References: <1424888184-22180-3-git-send-email-sbranden@broadcom.com>
 <4488852.TuVxKbAYde@wuerfel> <54EF9D7A.3090707@broadcom.com>
Message-ID: <2093191.gujNGSl66k@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 26 February 2015 14:26:02 Scott Branden wrote:
> On 15-02-26 12:15 PM, Arnd Bergmann wrote:
> >> On 15-02-25 11:17 AM, Arnd Bergmann wrote:
> >>> On Wednesday 25 February 2015 10:16:24 Scott Branden wrote:
> >> This code was following examples of other open source drivers - bcm2835
> >> and exynos both use cpu_relax.  I'll have to look into this more to
> >> understand.
> >>
> >
> > The majority of the driver apparently use udelay(10) to wait, which is
> > not much better but at least consistent. The cpu_relax() call probably
> > gives better throughput.
> >
> > I don't understand why none of the drivers actually attempts to
> > msleep(), but that may be because the delay is much too long.
> >
> > Can you find out what the expected latency is for new data to
> > become available on your hardware?
> RNG generates at a nominal 1 Mbps.  So to generate 32 bits of data takes
> approximately 32 us.

The udelay(10) that the other drivers have seems about appropriate then,
and we can independently think of a way to refine the interface.
Please add a comment that explains the rate. Also, is there some kind
of FIFO present in the hwrng device? If it can store close to 1ms work
of data (1000 bits), you can just use an msleep(1) to wait for the
pool to recover.

Another option would be to use usleep_range() with the exact amount
of time to wait for, the lower bound being the minimum number of
bytes asked for and the fifo size, the upper bound being the fifo
size.

	Arnd
