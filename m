From: will.deacon@arm.com (Will Deacon)
Date: Tue, 31 Mar 2015 15:49:56 +0100
Subject: [GIT PULL] iommu: Kill off pgsize_bitmap field from struct
 iommu_ops
In-Reply-To: <20150331142440.GD22683@8bytes.org>
References: <20150327171946.GL1562@arm.com> <20150331142440.GD22683@8bytes.org>
Message-ID: <20150331144956.GA24094@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 31, 2015 at 03:24:40PM +0100, Joerg Roedel wrote:
> Hi Will,

Hi Joerg,

> On Fri, Mar 27, 2015 at 05:19:46PM +0000, Will Deacon wrote:
> > Please can you pull the following IOMMU changes for 4.1? They move the
> > per-iommu_ops pgsize_bitmap field into the iommu_domain, which allows
> > IOMMUs such as the ARM SMMU to support different page sizes within a
> > given SoC.
> 
> I have some concerns about the direction taken with this patch-set. The
> goal for the IOMMU-API is still to have domains that can be attached to
> arbitrary devices (even when mappings already exist). But with this
> patch-set we move into a direction where a domain can only be used on
> IOMMUs that support the page-sizes required by the domain. In the end
> this would be visible to the user of the IOMMU-API, which is not what we
> want.

But isn't this restriction already the case in practice? For example, if
I have a domain with some mapping already configured, then that mapping
will be using some fixed set of page sizes. Attaching a device behind
another IOMMU that doesn't support that page size would effectively require
the domain page tables to be freed and re-allocated from scratch.

So I don't think this patch series leaves us any worse off that we currently
are already.

Ths plus points of the patches are that:

  - We can support different page sizes per domain (the ARM SMMU hardware
    really does support this and it would be nice to exploit that to gain
    better TLB utilisation)

  - We can support systems containing IOMMUs that don't support a common
    page size (I believe the arm64 Juno platform has this feature)

  - I don't have to manipulate a const data structure (iommu_ops) at runtime
    whenever I find a new IOMMU with a different set of supported page
    sizes.

> I can understand the motivation behind these patches, but we need to
> think about how this could work with the desired semantics of the
> IOMMU-API.

Do we have any code using this feature of the IOMMU API? I don't think it's
realistic in the general case to allow arbitrary devices to be attached to a
domain unless the domain can also span multiple IOMMUs. In that case, we'd
actually need multiple sets of page tables, potentially described using
different formats...

Will
