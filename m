From: will.deacon@arm.com (Will Deacon)
Date: Wed, 4 Jun 2014 17:39:33 +0100
Subject: [PATCH v2] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <13061821.NYx1AfEhs0@wuerfel>
References: <1400877218-4113-1-git-send-email-thierry.reding@gmail.com>
 <20140604134400.GE28484@ulmo> <20140604135600.GD6644@arm.com>
 <13061821.NYx1AfEhs0@wuerfel>
Message-ID: <20140604163933.GE6644@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 04, 2014 at 03:01:15PM +0100, Arnd Bergmann wrote:
> On Wednesday 04 June 2014 14:56:01 Will Deacon wrote:
> > On Wed, Jun 04, 2014 at 02:44:03PM +0100, Thierry Reding wrote:
> > > On Fri, May 30, 2014 at 09:54:37PM +0200, Arnd Bergmann wrote:
> > > > On Friday 30 May 2014 22:29:13 Hiroshi Doyu wrote:
> > > > > The disadvantage of this is that this limits the max number of streamIDs
> > > > > to support. If # of streamID is increased later more than 64, this
> > > > > format cannot cover any more. You have to predict the max # of streamIDs
> > > > > in advance if steamID is statically assigned.
> > > > > 
> > > > 
> > > > Well, the iommu specific binding could allow a variable #address-cells.
> > > > That way, you just need to know the number of stream IDs for that instance
> > > > of the iommu.
> > > 
> > > That sounds fairly complicated to me. I don't see what that buys us over
> > > the clarity and simplicity that the above explicit notation gives us. Is
> > > it not more common for a device to have a single master rather than a
> > > whole bunch of them?
> > 
> > I've never seen a device upstream of an ARM SMMU with a single stream-id;
> > they always seem to have a whole bunch of them. Calxeda's SATA controller
> > had 10 IDs, for example, and a PL330 DMA controller tends to have at least
> > 3.
> 
> What are those good for? Would we just always use the first one?

I think It's just an artifact of how these systems tend to be built. The
StreamID is constructed out of bits on the bus (AXI and sideband), so a
DMA controller could easily have one ID for reads, one for writes,
one for execute. Masters capable of multiple outstanding transactions
could also have sets of IDs too.

The SMMU driver would point them all at the same context bank, as far as I
can tell, but that means the driver does need to be aware of the incoming
IDs.

Rob might know how they constructed the IDs on the Calxeda SATA controller?

Will
