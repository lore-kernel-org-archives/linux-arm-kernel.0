From: will.deacon@arm.com (Will Deacon)
Date: Fri, 26 Jan 2018 18:11:49 +0000
Subject: [PATCH RFC 0/3] API for 128-bit IO access
In-Reply-To: <20180126090542.bsza7hqqinqwllcr@yury-thinkpad>
References: <20180124090519.6680-1-ynorov@caviumnetworks.com>
 <20180124102212.GC20586@arm.com>
 <20180126090542.bsza7hqqinqwllcr@yury-thinkpad>
Message-ID: <20180126181149.GA17922@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 26, 2018 at 12:05:42PM +0300, Yury Norov wrote:
> On Wed, Jan 24, 2018 at 10:22:13AM +0000, Will Deacon wrote:
> > On Wed, Jan 24, 2018 at 12:05:16PM +0300, Yury Norov wrote:
> > > This series adds API for 128-bit memory IO access and enables it for ARM64.
> > > The original motivation for 128-bit API came from new Cavium network device
> > > driver. The hardware requires 128-bit access to make things work. See
> > > description in patch 3 for details.
> > > 
> > > Also, starting from ARMv8.4, stp and ldp instructions become atomic, and
> > > API for 128-bit access would be helpful in core arm64 code.
> > 
> > Only for normal, cacheable memory, so they're not suitable for IO accesses
> > as you're proposing here.
> 
> Hi Will,
> 
> Thanks for clarification.
> 
> Could you elaborate, do you find 128-bit read/write API useless, or
> you just correct my comment?
> 
> I think that ordered uniform 128-bit access API would be helpful, even
> if not atomic.

Sorry, but I strongly disagree here. Having an IO accessor that isn't
guaranteed to be atomic is a recipe for disaster if it's not called out
explicitly. You're much better off implementing something along the lines
of <linux/io-128-nonatomic-hi-lo.h> using 2x64-bit accessors like we already
have for the 2x32-bit case.

However, that doesn't solve your problem and is somewhat of a distraction.
I'd suggest that in your case, where you have a device that relies on
128-bit atomic access that is assumedly tightly integrated into your SoC,
then the driver just codes it's own local implementation of the accessor,
given that there isn't a way to guarantee the atomicity architecturally
(and even within your SoC it might not be atomic to all endpoints).

Will
