From: jcrouse@codeaurora.org (Jordan Crouse)
Date: Mon, 11 Jul 2016 09:00:34 -0600
Subject: [PATCH v2 0/6] Add support for privileged mappings
In-Reply-To: <5783A6F0.7040903@arm.com>
References: <20160709020919.6760-1-mitchelh@codeaurora.org>
 <5783A6F0.7040903@arm.com>
Message-ID: <20160711150034.GA6526@jcrouse-lnx.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2016 at 03:02:24PM +0100, Robin Murphy wrote:
> Hey Mitch,
> 
> Thanks for having the necessary go at the DMA API - I think the series
> looks broadly workable now.
> 
> On 09/07/16 03:09, Mitchel Humpherys wrote:
> > The following patch to the ARM SMMU driver:
> > 
> >     commit d346180e70b91b3d5a1ae7e5603e65593d4622bc
> >     Author: Robin Murphy <robin.murphy@arm.com>
> >     Date:   Tue Jan 26 18:06:34 2016 +0000
> >     
> >         iommu/arm-smmu: Treat all device transactions as unprivileged
> > 
> > started forcing all SMMU transactions to come through as "unprivileged".
> > The rationale given was that:
> > 
> >   (1) There is no way in the IOMMU API to even request privileged mappings.
> > 
> >   (2) It's difficult to implement a DMA mapper that correctly models the
> >       ARM VMSAv8 behavior of unprivileged-writeable =>
> >       privileged-execute-never.
> > 
> > This series rectifies (1) by introducing an IOMMU API for privileged
> > mappings and implements it in io-pgtable-arm.
> > 
> > This series rectifies (2) by introducing a new dma attribute
> > (DMA_ATTR_PRIVILEGED_EXECUTABLE) for users of the DMA API that need
> > privileged, executable mappings, and implements it in the arm64 IOMMU DMA
> > mapper.  The one known user (pl330.c) is converted over to the new
> > attribute.
> > 
> > Jordan and Jeremy can provide more info on the use case if needed, but the
> > high level is that it's a security feature to prevent attacks such as [1].
> 
> My understanding of that hack is that it involves switching the GPU into
> privileged mode to get at the mapping of the IOMMU registers in the
> first place, so I don't see at a glance how having privileged mappings
> defends against that. What it clearly does do, however, is get us _to_
> the point where it's necessary to do such a privilege switch in the
> first place, as opposed to everything being trivially wide-open, which
> is no bad thing.

It was a two pronged attack.  First the attacker had to use the GPU to construct
a new pagetable and some various GPU command buffers and then they could switch
the context to the new pagetable to complete the attack.

The first part was made possible by vast tracts of read/write memory that is
mapped globally and accessible to all users so it was easy and legal to write
whatever the user wished including a pusedo-pagetable.

As you said, while the actual fix for the exploit was blocking access to the SMMU
registers it isn't a bad thing if we get in the habit of assuming that we shouldn't
leave a bunch of scratch memory around for somebody clever to take advantage of.

Jordan
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
