From: will.deacon@arm.com (Will Deacon)
Date: Tue, 20 Dec 2016 10:22:09 +0000
Subject: [PATCH] iommu/arm-smmu-v3: avoid over allocating for l2 stream
 tables
In-Reply-To: <1482179200-4264-1-git-send-email-nwatters@codeaurora.org>
References: <1482179200-4264-1-git-send-email-nwatters@codeaurora.org>
Message-ID: <20161220102209.GC10132@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nate,

On Mon, Dec 19, 2016 at 03:26:40PM -0500, Nate Watterson wrote:
> Currently, all l2 stream tables are being allocated with space for
> (1<<split) stes without regard to the number of sid bits the smmu
> physically supports. To avoid allocating memory for inaccessible
> stes, this patch limits the span of an l2 table to be no larger
> than the sid size of the smmu to which it belongs.
> 
> Signed-off-by: Nate Watterson <nwatters@codeaurora.org>
> ---
>  drivers/iommu/arm-smmu-v3.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

I can't help but think you'd be better off using a linear stream table
in this scenario. If we hack the feature check for
ARM_SMMU_FEAT_2_LVL_STRTAB so that it doesn't report support for 2 level
tables if the number of sids is less than that covered by a single l2
entry, would that solve your problem?

Will
