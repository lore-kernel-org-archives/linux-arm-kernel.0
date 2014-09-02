From: will.deacon@arm.com (Will Deacon)
Date: Tue, 2 Sep 2014 09:31:39 +0100
Subject: [RFC PATCH 0/7] Introduce automatic DMA configuration for IOMMU
 masters
In-Reply-To: <540562F9.2030508@samsung.com>
References: <1409327670-3495-1-git-send-email-will.deacon@arm.com>
 <540562F9.2030508@samsung.com>
Message-ID: <20140902083138.GA25379@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 02, 2014 at 07:26:01AM +0100, Marek Szyprowski wrote:
> Hi Will,

Hi Marek,

> On 2014-08-29 17:54, Will Deacon wrote:
> > This patch series is an RFC to implement IOMMU master configuration into
> > of_dma_configure. I haven't yet ported any IOMMU drivers to it, so it
> > remains untested, but I wanted to get some early feedback to ensure that
> > this doesn't end up going in the wrong direction.
> >
> > The idea comes out of my understanding following discussions with Arnd
> > and David at Kernel Summit / LinuxCon in Chicago. Essentially:
> >
> >    - Allow IOMMUs to be probed early and set up per-instance data on their
> >      of_node
> >
> >    - Add a new callback to the iommu_ops structure for adding a device
> >      with a set of opaque IDs (e.g. Stream IDs or Requester IDs)
> >
> >    - Add an of_iommu_configure function, called from of_dma_configure,
> >      which registers the master IDs with the correspond IOMMU before
> >      probing the master itself
> >
> >    - Where applicable, create an IOMMU domain per device and swizzle the
> >      DMA ops for that device to use the IOMMU variants.
> >
> > I haven't bothered doing anything clever with the DMA masks yet, so I
> > wouldn't be surprised if we end up chewing through tonnes of memory
> > allocating IOMMU domains that are far too big at the moment. Again, this
> > is just an RFC and I'd welcome comments on the general direction of the
> > series.
> 
> Thanks for your patches, I wasn't aware the fact that you are working on
> this. When do you plan to send a second version? I would like to rebase
> my Exynos IOMMU patches (https://lkml.org/lkml/2014/8/5/183) on top of
> your work, but I wonder if I should select this version as a base or wait
> a bit for an update.

I'll try and get something out today/tomorrow depending on how easily the
review comments fall out. It would be really great if you get an IOMMU
working with this (I was going to look at the ARM SMMU once this stops
moving) -- I have concerns that allocating one domain per master might be
too much, but it's hard to tell without an IOMMU driver ported over.

I'll CC you on v2.

Cheers,

Will
