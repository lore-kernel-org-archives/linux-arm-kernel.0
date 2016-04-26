From: jan.glauber@caviumnetworks.com (Jan Glauber)
Date: Tue, 26 Apr 2016 14:08:09 +0200
Subject: [PATCH v2 0/5] Cavium ThunderX uncore PMU support
In-Reply-To: <20160425131907.GB30830@arm.com>
References: <cover.1457539621.git.jglauber@cavium.com>
 <20160404121954.GA9300@hardcore> <20160425112207.GL16065@arm.com>
 <20160425120222.GA2552@hardcore> <20160425131907.GB30830@arm.com>
Message-ID: <20160426120809.GA9796@hardcore>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 25, 2016 at 02:19:07PM +0100, Will Deacon wrote:
> On Mon, Apr 25, 2016 at 02:02:22PM +0200, Jan Glauber wrote:
> > On Mon, Apr 25, 2016 at 12:22:07PM +0100, Will Deacon wrote:
> > > On Mon, Apr 04, 2016 at 02:19:54PM +0200, Jan Glauber wrote:
> > > > can you have a look at these patches?
> > > 
> > > Looks like Mark reviewed this last week -- are you planning to respin?
> > 
> > Yes, of course. I just had no time yet and I'm a bit lost on how to
> > proceed without using the NUMA node information which Mark did not like
> > to be used.
> > 
> > The only way to know which device is on which node would be to look
> > at the PCI topology (which is also the source of the NUMA node_id).
> > We could do this manually in order to not depend on CONFIG_NUMA,
> > but I would like to know if that is acceptable before respinning the
> > patches.
> 
> That doesn't feel like it really addresses Mark's concerns -- it's just
> another way to get the information that isn't a first-class PMU topology
> description from firmware.
> 
> Now, I don't actually mind using the NUMA topology so much in the cases
> where it genuinely correlates with the PMU topology. My objection is more
> that we end up sticking everything on node 0 if !CONFIG_NUMA, which could
> result in working with an incorrect PMU topology and passing all of that
> through to userspace.
> 
> So I'd prefer either making the driver depend on NUMA, or at the very least
> failing to probe  the PMU if we discover a socketed system and NUMA is not
> selected. Do either of those work as a compromise?
> 
> Will

That sounds like a good compromise.

So I could do the following:

1) In the uncore setup check for CONFIG_NUMA, if set use the NUMA
   information to determine the device node

2) If CONFIG_NUMA is not set we check if we run on a socketed system

   a) In that case we return an error and give a message that CONFIG_NUMA needs
      to be enabled
   b) Otherwise we have a single node system and use node_id = 0

David noted that it would also be possible to extract the node id from
the physical address of the device, but I'm not sure that classifies as
'first-class' topology description...

--Jan
