From: will.deacon@arm.com (Will Deacon)
Date: Thu, 21 Apr 2016 17:16:45 +0100
Subject: [PATCH 3/7] iommu/arm-smmu: Work around MMU-500 prefetch errata
In-Reply-To: <0484444b6257bfb6adb68405a72c64fc4fc98142.1460391217.git.robin.murphy@arm.com>
References: <cover.1460391217.git.robin.murphy@arm.com>
 <0484444b6257bfb6adb68405a72c64fc4fc98142.1460391217.git.robin.murphy@arm.com>
Message-ID: <20160421161645.GJ929@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 13, 2016 at 06:12:59PM +0100, Robin Murphy wrote:
> MMU-500 erratum #841119 is tickled by a particular set of circumstances
> interacting with the next-page prefetcher. Since said prefetcher is
> quite dumb and actually detrimental to performance in some cases (by
> causing unwanted TLB evictions for non-sequential access patterns), we
> lose very little by turning it off, and what we gain is a guarantee that
> the erratum is never hit.
> 
> As a bonus, the same workaround will also prevent erratum #826419 once
> v7 short descriptor support is implemented.
> 
> CC: Catalin Marinas <catalin.marinas@arm.com>
> CC: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  Documentation/arm64/silicon-errata.txt |  1 +
>  drivers/iommu/arm-smmu.c               | 16 +++++++++++++++-
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
> index 806f91c..c6938e5 100644
> --- a/Documentation/arm64/silicon-errata.txt
> +++ b/Documentation/arm64/silicon-errata.txt
> @@ -53,6 +53,7 @@ stable kernels.
>  | ARM            | Cortex-A57      | #832075         | ARM64_ERRATUM_832075    |
>  | ARM            | Cortex-A57      | #852523         | N/A                     |
>  | ARM            | Cortex-A57      | #834220         | ARM64_ERRATUM_834220    |
> +| ARM            | MMU-500         | #841119,#826419 | N/A                     |

Found it :)

Will
