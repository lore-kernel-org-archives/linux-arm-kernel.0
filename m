From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 16 Dec 2014 13:08:15 +0100
Subject: [PATCH v6 6/8] dma-mapping: detect and configure IOMMU in
 of_dma_configure
In-Reply-To: <20141215180933.GW20738@arm.com>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
 <1612493.xCj1Tx0M4k@avalon> <20141215180933.GW20738@arm.com>
Message-ID: <2447060.c0PHi7y3cP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 15 December 2014 18:09:33 Will Deacon wrote:
> > Using a single domain is a bit of a waste of resources in my case, so an 
> > evolution would be to create four domains and assign devices to them based on 
> > a policy. The policy could be fixed (round-robin for instance), or 
> > configurable (possibly through DT, although it's really a policy, not a 
> > hardware description).

I think in case of the ARM SMMU, we concluded that the grouping is indeed
best done in DT, because of there is no good algorithmic way to come
up with a set of bitmasks that make up a proper grouping into domains.
 
> I think having one default domain, which is home to all of the masters that
> don't have any DMA restrictions is a good use of the hardware. That then
> leaves you with three domains to cover VFIO, devices with DMA limitations
> and potentially device isolation (if we had a way to describe that).

Yes, I agree. There are also a number of degrees to which one might want
to enable IOMMUs at boot time:

- force-disable: use swiotlb only and turn off all IOMMUs or program them
  with a static linear mapping if they cannot be disabled in hardware
- soft-enable: use IOMMUs only for devices whose dma-mask does not cover
  all the physical memory. This would provide the highest performance
- force-enable: use the IOMMU for any device that has an 'iommus' property,
  to catch any wild DMA pointer accesses.
- secure-enable: like force-enable, but use as many separate domains as
  possible to provide isolation between devices as well.

	Arnd
