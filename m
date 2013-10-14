From: will.deacon@arm.com (Will Deacon)
Date: Mon, 14 Oct 2013 13:48:16 +0100
Subject: [PATCH 1/2] ARM: SMMU: add devices attached to the SMMU to an
 IOMMU group
In-Reply-To: <1381497887-14586-1-git-send-email-a.motakis@virtualopensystems.com>
References: <1381497887-14586-1-git-send-email-a.motakis@virtualopensystems.com>
Message-ID: <20131014124815.GC10491@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Antonios,

On Fri, Oct 11, 2013 at 02:24:46PM +0100, Antonios Motakis wrote:
> IOMMU groups are expected by certain users of the IOMMU API,
> e.g. VFIO. Add new devices found by the SMMU driver to an IOMMU
> group to satisfy those users.

Cheers for looking at this: VFIO has been on my TODO list for some time.

> Signed-off-by: Antonios Motakis <a.motakis@virtualopensystems.com>
> ---
>  drivers/iommu/arm-smmu.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 0f45a48..8b71332 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1502,6 +1502,8 @@ static int arm_smmu_add_device(struct device *dev)
>  {
>  	struct arm_smmu_device *child, *parent, *smmu;
>  	struct arm_smmu_master *master = NULL;
> +	struct iommu_group *group;
> +	int ret;
>  
>  	spin_lock(&arm_smmu_devices_lock);
>  	list_for_each_entry(parent, &arm_smmu_devices, list) {
> @@ -1534,13 +1536,27 @@ static int arm_smmu_add_device(struct device *dev)
>  	if (!master)
>  		return -ENODEV;
>  
> +	group = iommu_group_get(dev);

I'm not especially familiar with IOMMU groups (I understand them as the
minimum translation granularity, which would mean single StreamID for the
ARM SMMU), but under what circumstances would you expect to receive a
non-NULL group here? I can't see any other code adding devices to groups
(outside of other drivers)...

Will
