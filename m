From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 20 Nov 2013 14:53:09 +0100
Subject: Report from 2013 ARM kernel summit
In-Reply-To: <20131120103111.GB19352@mudshark.cambridge.arm.com>
References: <20131111.114723.1885845500744256130.hdoyu@nvidia.com>
 <20131115070627.6CF65C4079B@trevor.secretlab.ca>
 <20131119.114054.663999769447782808.hdoyu@nvidia.com>
 <20131119173524.GK11778@mudshark.cambridge.arm.com>
 <528BCDCE.6070006@gmail.com>
 <20131120103111.GB19352@mudshark.cambridge.arm.com>
Message-ID: <20131120135308.GC8279@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 20, 2013 at 10:31:11AM +0000, Will Deacon wrote:
> On Tue, Nov 19, 2013 at 08:45:02PM +0000, Rob Herring wrote:
> > On 11/19/2013 11:35 AM, Will Deacon wrote:
> > > Adding Andreas and Rob for input on potential binding additions to the SMMU.
> > 
> > The above proposal would be an incompatible change. However, I think we
> > could still deal with a change in this binding at this stage.
> > 
> > One way approach to handle this without changing the binding would be to
> > scan the DT for all iommu's up front and create a list of all nodes and
> > their iommu parent. The fact that the hierarchy is described in a way
> > that doesn't fit Linux well is really a Linux implementation detail.
> > 
> > If changing the binding, a simple approach would be to allow
> > 'smmu-parent' to be a bus and/or device property and not just for
> > chained iommu's. This could be a global or bus property that is
> > inherited. Like interrupt-parent, you would have to deal with the parent
> > being itself. Also, perhaps iommu-parent would be a better name. In any
> > case, I'd like to see this all be a generic iommu binding.
> 
> I like that idea. I've recently been toying with removing the chained IOMMU
> support, since I don't think anybody is using it who is interested in
> mainline. However, making it more general sounds like a better idea.
> 
> One potential issue is that I think the nvidia guys want to describe masters
> that master via multiple SMMUs (which I believe was the motivation for
> moving the stream-ids out into the master nodes, rather than keeping them in
> the SMMU). Again, that's not something we can easily add to the arm-smmu,
> because the incoming stream-ids are a property of the SMMU node.

If I remember correctly, one of the reasons for the proposal was also
that the interrupt-parent property turned out to be insufficient for
some use-cases, which lead to Grant's proposal of the new interrupts-
extended property. Since that comparison has already been drawn, I think
we can agree that both are used in similar ways. Therefore we should
consider what we've learned from interrupt-parent when designing this
generic IOMMU binding to avoid having to introduce iommu-extended at
some point.

> So the question is: do we actually need to describe masters that master
> through multiple SMMUs as a single node in the devicetree?

I would think so, yes. The alternative would be to have several nodes
that describe the same device, and that conflicts on a different level.

Perhaps it could be done by having separate sub-nodes that each use a
different IOMMU, but that sounds like a much grosser solution. That
pretty much boils down to interrupt-parent/interrupt-map.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131120/58474dce/attachment.sig>
