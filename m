From: will.deacon@arm.com (Will Deacon)
Date: Thu, 15 Nov 2012 10:17:52 +0000
Subject: [PATCH V2 1/5] arm: mvebu: Added support for coherency fabric in
 mach-mvebu
In-Reply-To: <50A3F860.5010601@free-electrons.com>
References: <1351545108-18954-1-git-send-email-gregory.clement@free-electrons.com>
 <1351545108-18954-2-git-send-email-gregory.clement@free-electrons.com>
 <20121105140258.GO3351@mudshark.cambridge.arm.com>
 <50A15A33.60405@free-electrons.com>
 <20121113104340.GD3940@mudshark.cambridge.arm.com>
 <50A3F860.5010601@free-electrons.com>
Message-ID: <20121115101752.GA26453@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 14, 2012 at 08:00:32PM +0000, Gregory CLEMENT wrote:
> On 11/13/2012 11:43 AM, Will Deacon wrote:
> > On Mon, Nov 12, 2012 at 08:21:07PM +0000, Gregory CLEMENT wrote:
> >> On 11/05/2012 03:02 PM, Will Deacon wrote:
> >>> These writels may expand to code containing calls to outer_sync(), which
> >>> will attempt to take a spinlock for the aurora l2. Given that the CPU isn't
> >>> coherent, how does this play out with the exclusive store instruction in the
> >>> lock?
> >>
> >> I dug a little this subject: and I am not sure there is problem. In SMP mode,
> >> only the system cache mode of Aurora is used. In this mode, outer_cache.sync
> >> is void then outer_sync() won't call any function, so there will be no
> >> access to any spinlock.
> > 
> > Hmm, that is pretty subtle and it doesn't really solve the bigger picture.
> > printk takes logbuf_lock, for example, and I'm sure that by the time you get
> > to this code you will have relied on exclusives behaving correctly.
> > 
> 
> Hi Will,
> I get an answer from Marvell engineers:
> "STREX on non-shareable and/or non-cacheable memory regions is supported."

Interesting, thanks for asking them about this. Does this mean that:

	1. When not running coherently (i.e. before initialising the
	   coherency fabric), memory is treated as non-shareable,
	   non-cacheable?

	2. If (1), then are exclusive accesses the only way to achieve
	   coherent memory accesses in this scenario?

If so, you still have a problem with write locks, where the unlock code does
a regular str to clear the status. atomic_{read,set} also uses regular
memory accesses, so I think you'll get some surprises there when you add
explicit memory barriers and expect things to be visible between threads.

Do memory barriers have different semantics depending on the state of your
coherency fabric?

Cheers,

Will
