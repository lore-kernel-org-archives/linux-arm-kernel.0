From: robh@kernel.org (Rob Herring)
Date: Tue, 20 Dec 2016 21:29:21 -0600
Subject: [RFC PATCH] iommu/arm-smmu: Add global SMR masking property
In-Reply-To: <ad6b6a4937b1fe183e6d48ccbaf4cb46db92fed4.1481893907.git.robin.murphy@arm.com>
References: <ad6b6a4937b1fe183e6d48ccbaf4cb46db92fed4.1481893907.git.robin.murphy@arm.com>
Message-ID: <20161221032921.hdcnyiq6m224ejlv@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 16, 2016 at 01:19:29PM +0000, Robin Murphy wrote:
> The current SMR masking support using a 2-cell iommu-specifier is
> primarily intended to handle individual masters with large and/or
> complex Stream ID assignments; it quickly gets a bit clunky in other SMR
> use-cases where we just want to consistently mask out the same part of
> every Stream ID (e.g. for MMU-500 configurations where the appended TBU
> number gets in the way unnecessarily). Let's add a new property to allow
> a single global mask value to better fit the latter situation.
> 
> CC: Stuart Yoder <stuart.yoder@nxp.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> Compile-tested only...
> 
>  Documentation/devicetree/bindings/iommu/arm,smmu.txt | 8 ++++++++
>  drivers/iommu/arm-smmu.c                             | 4 +++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> index e862d1485205..98f5cbe5fdb4 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> @@ -60,6 +60,14 @@ conditions.
>                    aliases of secure registers have to be used during
>                    SMMU configuration.
>  
> +- stream-match-mask : Specifies a fixed SMR mask value to combine with

Needs a vendor prefix.

Otherwise looks fine.

> +                  the Stream ID value from every iommu-specifier. This
> +                  may be used instead of an "#iommu-cells" value of 2
> +                  when there is no need for per-master SMR masks, but
> +                  it is still desired to mask some portion of every
> +                  Stream ID (e.g. for certain MMU-500 configurations
> +                  given globally unique external IDs).
> +
>  ** Deprecated properties:
>  
>  - mmu-masters (deprecated in favour of the generic "iommus" binding) :
