From: will.deacon@arm.com (Will Deacon)
Date: Thu, 7 Jul 2016 18:00:26 +0100
Subject: [PATCH 0/3] Add support for privileged mappings
In-Reply-To: <20160706235136.27854-1-mitchelh@codeaurora.org>
References: <20160706235136.27854-1-mitchelh@codeaurora.org>
Message-ID: <20160707170026.GG20682@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 06, 2016 at 04:51:33PM -0700, Mitchel Humpherys wrote:
> The following patch to the ARM SMMU driver:
> 
>     commit d346180e70b91b3d5a1ae7e5603e65593d4622bc
>     Author: Robin Murphy <robin.murphy@arm.com>
>     Date:   Tue Jan 26 18:06:34 2016 +0000
>     
>         iommu/arm-smmu: Treat all device transactions as unprivileged
> 
> started forcing all SMMU transactions to come through as "unprivileged".
> The rationale given was that:
> 
>   (1) There is no way in the IOMMU API to even request privileged mappings.
> 
>   (2) It's difficult to implement a DMA mapper that correctly models the
>       ARM VMSAv8 behavior of unprivileged-writeable =>
>       privileged-execute-never.
> 
> This series attempts to rectify (1) by introducing an IOMMU API for
> privileged mappings (and implementing it in io-pgtable-arm).  It seems like
> (2) can be safely ignored for now under the assumption that any users of
> the IOMMU_PRIV flag will be using the low-level IOMMU APIs directly, rather
> than going through the DMA APIs.
> 
> Robin, Will, what do you think?  Jordan and Jeremy can provide more info on
> the use case if needed, but the high level is that it's a security feature
> to prevent attacks such as [1].

So I think the problem that the offending patch tried to fix is that
the PL330 DMA controller (drivers/dma/pl330.c) uses dma_alloc_coherent
to allocate its microcode buffer, but the so-called "manager" thread
that fetches the microcode does so with privileged accesses and
consequently fails.

Whilst this series is a step in the right direction for fixing that, I
don't think you can claim that only low-level users need this, given that
we have in-tree code which would break without it. Perhaps you just need
to extend things slightly more to expose this to the DMA API as well (or,
alternatively, hack the PL330 driver some how).

Will
