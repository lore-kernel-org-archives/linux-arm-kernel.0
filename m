From: will.deacon@arm.com (Will Deacon)
Date: Thu, 8 Feb 2018 11:25:41 +0000
Subject: [PATCH 00/16] kvm: arm64: Support for dynamic IPA size
In-Reply-To: <20180208111844.GN29286@cbox>
References: <20180109190414.4017-1-suzuki.poulose@arm.com>
 <20180208111844.GN29286@cbox>
Message-ID: <20180208112540.GA17775@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I can comment on one part here:

On Thu, Feb 08, 2018 at 12:18:44PM +0100, Christoffer Dall wrote:
> Wasn't this also the decision taken for IOMMU page table allocation, and
> why was that the right approach for the IOMMU but not for KVM stage 2
> page tables?  Is there room for reuse of the IOMMU page table allocation
> logic in KVM as well?

There were a few reasons we did this for IOMMU page tables:

  * Ability to use different page size/VA bits/levels from the CPU
  * Ability to support different page table formats (e.g. short descriptor)
  * Ability to determine page table attributes at runtime
  * Requirement to map/unmap in atomic context
  * Ability to cope with non-coherent page table walkers
  * Ability to create both stage-1 and stage-2 mappings
  * Easier to hook in our own TLB invalidation routines
  * Support for lockless concurrent map/unmap within confines of the DMA API
    usage

Will
