From: Varun.Sethi@freescale.com (Varun Sethi)
Date: Tue, 2 Sep 2014 14:47:54 +0000
Subject: [RFC PATCH 1/7] iommu: provide early initialisation hook for
 IOMMU drivers
In-Reply-To: <1409327670-3495-2-git-send-email-will.deacon@arm.com>
References: <1409327670-3495-1-git-send-email-will.deacon@arm.com>
 <1409327670-3495-2-git-send-email-will.deacon@arm.com>
Message-ID: <04b313674bc14231a47570f91336c6e6@BL2PR03MB468.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

> -----Original Message-----
> From: Will Deacon [mailto:will.deacon at arm.com]
> Sent: Friday, August 29, 2014 9:24 PM
> To: linux-arm-kernel at lists.infradead.org; iommu at lists.linux-foundation.org
> Cc: arnd at arndb.de; dwmw2 at infradead.org; jroedel at suse.de;
> hdoyu at nvidia.com; Sethi Varun-B16395; thierry.reding at gmail.com;
> laurent.pinchart at ideasonboard.com; Will Deacon
> Subject: [RFC PATCH 1/7] iommu: provide early initialisation hook for IOMMU
> drivers
> 
> IOMMU drivers must be initialised before any of their upstream devices,
> otherwise the relevant iommu_ops won't be configured for the bus in
> question. To solve this, a number of IOMMU drivers use initcalls to
> initialise the driver before anything has a chance to be probed.
> 
> Whilst this solves the immediate problem, it leaves the job of probing
> the IOMMU completely separate from the iommu_ops to configure the
> IOMMU,
> which are called on a per-bus basis and require the driver to figure out
> exactly which instance of the IOMMU is being requested. In particular,
> the add_device callback simply passes a struct device to the driver,
> which then has to parse firmware tables or probe buses to identify the
> relevant IOMMU instance.
> 
> This patch takes the first step in addressing this problem by adding an
> early initialisation pass for IOMMU drivers, giving them the ability to
> set some per-instance data on their of_node. This data can then be
> passed back to a new add_device function (added in a later patch) to
> identify the IOMMU instance in question.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  drivers/iommu/of_iommu.c          | 14 ++++++++++++++
>  include/asm-generic/vmlinux.lds.h |  2 ++
>  include/linux/of_iommu.h          | 21 +++++++++++++++++++++
>  3 files changed, 37 insertions(+)
> 
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index e550ccb7634e..f9209666157c 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -89,3 +89,17 @@ int of_get_dma_window(struct device_node *dn, const
> char *prefix, int index,
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(of_get_dma_window);
> +
> +void __init of_iommu_init(void)
> +{
> +	struct device_node *np;
> +	const struct of_device_id *match, *matches = &__iommu_of_table;
> +
> +	for_each_matching_node_and_match(np, matches, &match) {
> +		const int (*init_fn)(struct device_node *) = match->data;

Is the init function also responsible for setting iommu_ops (per bus)? We need to take in to consideration that iommu API (iommu.c) initialization happens during  "arch_init". When we setup bus iommu ops add_device would be called for devices which have already been probed. Also, as I can see from the code we have of_platform_populate which gets called right after of_iommu_init, which would in turn also lead to add_device invocation (after add_device_master_ids). I believe this would happen before iommu API initialization which would cause issues.

-Varun
