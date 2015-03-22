From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 22 Mar 2015 02:31:40 +0100
Subject: [PATCH] Add support for CONFIG_ARM64_DMA_USE_IOMMU.
In-Reply-To: <CAOHikRCSYy6Zd=Oi34-KnyhG=bY8-XdD_QpdndbC_dCox8sJEQ@mail.gmail.com>
References: <1422379495-10268-1-git-send-email-stripathi@apm.com>
 <CAOHikRCSoijzZ8oKEtMadEHOvLiWLO6fWkqiGEiPyb+Egb_1rw@mail.gmail.com>
 <CAOHikRCSYy6Zd=Oi34-KnyhG=bY8-XdD_QpdndbC_dCox8sJEQ@mail.gmail.com>
Message-ID: <201503220231.40375.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 March 2015, Suman Tripathi wrote:
> I guess there is an overlap with this thread:
> 
> http://thread.gmane.org/gmane.linux.kernel.iommu/8213
> 
> I would rather go for a more generic solution that Robin (cc'ed) is
> trying to implement.
> 
> I followed the above thread but our requirement deviates from normal
> IOMMU conventions.
> For our case we need a 1:1 mapping of PA to IOVA. Actually our's is
> not a real IOMMU (ie not having a cap of page table walk). It's a
> simple 32-bit from (device side ) ot 64-bit (cpu side) address
> translation with the help of a set of window registers. So we want to
> bypass the entire iova .
> 
> Any suggestions on this ?

My first suggestion would be to separate this from IOMMU support completely
as you don't really have an IOMMU. The easiest way to deal with hardware
like this is to use swiotlb with a fixed mapping. This is also the only
way to deal with any devices that may have multiple outstanding DMAs
(PCI, SATA, USB, ...). 

If you have any high-speed devices that only do a single request at a
time connected to this remapper, I would suggest you implement your own
set of dma_map_ops and come back with performance data showing whether it's
worth merging this compared to the trivial iommu support.

	Arnd
