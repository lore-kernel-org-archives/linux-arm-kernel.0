From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 13 Oct 2011 18:14:41 +0200
Subject: [PATCH v5 00/10] Per SoC descriptor
In-Reply-To: <20111013153449.GG21648@n2100.arm.linux.org.uk>
References: <1318255342-17451-1-git-send-email-marc.zyngier@arm.com>
	<4E9702F0.4070000@arm.com>
	<20111013153449.GG21648@n2100.arm.linux.org.uk>
Message-ID: <201110131814.42216.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 13 October 2011, Russell King - ARM Linux wrote:
> On Thu, Oct 13, 2011 at 04:25:36PM +0100, Marc Zyngier wrote:
> > On 13/10/11 11:32, Russell King - ARM Linux wrote:
> > > On Mon, Oct 10, 2011 at 03:02:12PM +0100, Marc Zyngier wrote:
> > 
> > [...]
> > 
> > >>  65 files changed, 569 insertions(+), 149 deletions(-)
> > > 
> > > This isn't particularly appealing for something that's supposed to
> > > be a clean up - it's introducing 400+ new lines of code.  It looks like
> > > most of this comes from the platform stuff rather than core stuff.
> > > 
> > > Can't we do any better with this?  We really need things to be going
> > > in the other direction.
> > 
> > There is definitely room for improvement, by factoring in some common
> > code across platforms. But I see that as a second phase, and started by
> > just moving things to the SoC descriptor, all the code staying mostly
> > the same.
> 
> I was meaning without that - what concerns me is the size of increase
> just to introduce this.  It seems needlessly large.

I think the main benefit of this series is that it allows the
cross-platform consolidation patches to be smaller, which unfortunately
is not easy to measure. The idea is that stuff that is currently
hardcoded per platform but should better be run-time determined
can be moved into a per-soc structure rather than the per-board
machine_desc. It would be good to list all this "stuff" to see how
much it will eventually be.

A number of things that we discussed about putting here have since
been obsoleted by better suggestions (e.g. arch_ioremap, VMALLOC_END,
__io, NR_IRQS, ...), but I would hope the tradeoff to still be
positive for this patch series.

On a related topic, I wonder how much of the existing machine_desc
we would actually be able to move out into a soc_desc, which is
something that would immediately save code lines and object size.

If it ends up being just the SMP and CPU-hotplug functions, then
the tradeoff is probably negative and we discard the series, but
if we expect it to have a postive long-term effect, I would still
merge it right away rather than waiting for the series to become
long enough to show the benefits in the diffstat.

> I've also never been convinced by attempts to consolidate the hotplug
> code - I've said this every time it's been suggested: I believe many
> platforms just aren't trying to support hotplug CPU properly.
> 
> They've just copied the noddy Realview platform version - which is
> noddy because ARMs platforms tend to have a total lack of power
> management support on them.  The best we can do is put them in a WFI
> loop waiting to be re-awoken.
> 
> Real platforms surely must have better PM support than that, and so
> copying the Realview implementation does not make sense - it's good
> to see that _some_ platforms have made an effort, though they still
> just return from platform_cpu_die(), rather than the intended path of
> re-awaking via the standard bringup path.  The return path from
> platform_cpu_die() is supposed to be the last-ditch attempt if all else
> has failed.

Good point, but I think that is another topic: 
Given that a bunch of architectures implement the same silly functions,
I think it definitely makes sense to consolidate them, even if we know
that they should actually be doing something else. By turning these
into function pointers, we can at least force platforms to include
a line like

	.cpu_disable = generic_silly_cpu_disable,

which hopefully leads people to think about why they are using this
version.

	Arnd
