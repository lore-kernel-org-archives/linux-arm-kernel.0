From: will.deacon@arm.com (Will Deacon)
Date: Mon, 26 Feb 2018 18:04:56 +0000
Subject: [PATCH v2 1/4] iommu/arm-smmu-v3: Clean up address masking
In-Reply-To: <24f90689e35a90a337601943a48902a7ab6a7c4d.1512038236.git.robin.murphy@arm.com>
References: <cover.1512038236.git.robin.murphy@arm.com>
 <24f90689e35a90a337601943a48902a7ab6a7c4d.1512038236.git.robin.murphy@arm.com>
Message-ID: <20180226180455.GB26147@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

On Thu, Dec 14, 2017 at 04:58:50PM +0000, Robin Murphy wrote:
> Before trying to add the SMMUv3.1 support for 52-bit addresses, make
> things bearable by cleaning up the various address mask definitions to
> use GENMASK_ULL() consistently. The fact that doing so reveals (and
> fixes) a latent off-by-one in Q_BASE_ADDR_MASK only goes to show what a
> jolly good idea it is...
> 
> Tested-by: Nate Watterson <nwatters@codeaurora.org>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> v2: Clean up one more now-unnecessary linewrap
> 
>  drivers/iommu/arm-smmu-v3.c | 53 ++++++++++++++++++---------------------------
>  1 file changed, 21 insertions(+), 32 deletions(-)

Whilst I agree that using GENMASK is better, this patch does mean that the
driver is (more) inconsistent with its _MASK terminology in that you can't
generally tell whether a definition that ends in _MASK is shifted or not,
and this isn't even consistent for fields within the same register.

Should we be using GENMASK/BIT for all fields instead and removing all of
the _SHIFT definitions?

Will
