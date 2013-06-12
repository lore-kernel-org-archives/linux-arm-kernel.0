From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 12 Jun 2013 15:26:42 -0600
Subject: [PATCH 04/14] bus: mvebu-mbus: Add static window allocation to
 the DT binding
In-Reply-To: <20130612211221.GB23012@localhost>
References: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <4160363.LWJuHATm2F@wuerfel> <20130612111441.E6D603E0A56@localhost>
 <201306122245.55960.arnd@arndb.de>
 <20130612211221.GB23012@localhost>
Message-ID: <20130612212641.GB8625@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 12, 2013 at 06:12:22PM -0300, Ezequiel Garcia wrote:

> > Actually, the best thing about this solution is that we don't even
> > have to bother setting up the mappings when loading the mbus driver:
> > We don't need any ranges (other than internal-regs) in DT, and we
> > don't need complex logic to search through the child devices to
> > figure out what the mappings should be. The only thing one needs

To get optimal packing you need to have the list in advance so it can
be sorted and best fit.

Further, remember that to allocate the window we need to learn the
maximum end offset of *all* reg users for that target id, not just the
first one to request translation. Not sure how the of_bus stuff gets
that for you??

> > to do here is check if a mapping already exists when we get into the
> > of_bus handler and create one for the device being translated if
> > there isn't one!
> 
> This departs considerably from what I'm aiming right now.
> 
> Are you suggesting to not put *any* mapping in the mbus 'ranges' node in
> the DT (other than internal-regs)?

My view is that the ranges should be respected. If an address is
present, it should be used, unless there is a conflict.

If no address is present (unclear why anyone would do this, but OK)
then demand allocate via the linux resource allocator through the
of_bus stuff seems reasonable to me..

Just to re-iterate Arnd's earlier comment: The DT representation
must handle dynamic allocation, but we can defer implementing the
kernel side until there is a need.

It isn't clear to me there is a need.....

Jason
