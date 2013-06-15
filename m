From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 15 Jun 2013 17:03:53 +0100
Subject: [PATCH 04/14] bus: mvebu-mbus: Add static window allocation to
 the DT binding
In-Reply-To: <20130612212641.GB8625@obsidianresearch.com>
References: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <4160363.LWJuHATm2F@wuerfel> <20130612111441.E6D603E0A56@localhost>
 <201306122245.55960.arnd@arndb.de> <20130612211221.GB23012@localhost>
 <20130612212641.GB8625@obsidianresearch.com>
Message-ID: <20130615160353.C97DA3E0A2E@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 12 Jun 2013 15:26:42 -0600, Jason Gunthorpe <jgunthorpe@obsidianresearch.com> wrote:
> On Wed, Jun 12, 2013 at 06:12:22PM -0300, Ezequiel Garcia wrote:
> 
> > > Actually, the best thing about this solution is that we don't even
> > > have to bother setting up the mappings when loading the mbus driver:
> > > We don't need any ranges (other than internal-regs) in DT, and we
> > > don't need complex logic to search through the child devices to
> > > figure out what the mappings should be. The only thing one needs
> 
> To get optimal packing you need to have the list in advance so it can
> be sorted and best fit.
> 
> Further, remember that to allocate the window we need to learn the
> maximum end offset of *all* reg users for that target id, not just the
> first one to request translation. Not sure how the of_bus stuff gets
> that for you??
> 
> > > to do here is check if a mapping already exists when we get into the
> > > of_bus handler and create one for the device being translated if
> > > there isn't one!
> > 
> > This departs considerably from what I'm aiming right now.
> > 
> > Are you suggesting to not put *any* mapping in the mbus 'ranges' node in
> > the DT (other than internal-regs)?
> 
> My view is that the ranges should be respected. If an address is
> present, it should be used, unless there is a conflict.
> 
> If no address is present (unclear why anyone would do this, but OK)
> then demand allocate via the linux resource allocator through the
> of_bus stuff seems reasonable to me..

Care is needed here however. As far as complexity; I would score it thus
(where lower numbers mean lower complexity):

1:   Fully described in DT; no dynamic resolution
5:   Fully /unresolved/ in DT; everything must be dynamically resolved
100: Mixed mode; some stuff fully resolved, others dynamically resolved.

The moment you start to do mixed mode, the whole thing gets really hairy
and difficult to get right. I you do proceed down this path, then it
would be a really good idea to put together a generic resolved library
that knows how to find and resolve all the static mappings before
resolving dynamic ones. Then write test cases for the thing so we can
know that it actually does what we want it to do.

> Just to re-iterate Arnd's earlier comment: The DT representation
> must handle dynamic allocation, but we can defer implementing the
> kernel side until there is a need.
> 
> It isn't clear to me there is a need.....

I also am nervous about depending on dynamic resolution on something
that isn't a dynamic bus... [although we're probably going to get pushed
in this direction anyway when support for device tree overlays gets
merged]

g.
