From: robh+dt@kernel.org (Rob Herring)
Date: Tue, 22 Mar 2016 13:38:06 -0500
Subject: [PATCH 6/6] iommu/arm-smmu: Make use of phandle iterators in
 device-tree parsing
In-Reply-To: <1458669509-7178-7-git-send-email-joro@8bytes.org>
References: <1458669509-7178-1-git-send-email-joro@8bytes.org>
 <1458669509-7178-7-git-send-email-joro@8bytes.org>
Message-ID: <CAL_JsqLncSjd7gyyN0FxfaBOWDbWz+qS_NKmVTsH4g0S_2ysww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 22, 2016 at 12:58 PM, Joerg Roedel <joro@8bytes.org> wrote:
> From: Joerg Roedel <jroedel@suse.de>
>
> Remove the usage of of_parse_phandle_with_args() and replace
> it by the phandle-iterator implementation so that we can
> parse out all of the potentially present 128 stream-ids.
>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/iommu/arm-smmu.c | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 59ee4b8..413bd64 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -48,7 +48,7 @@
>  #include "io-pgtable.h"
>
>  /* Maximum number of stream IDs assigned to a single device */
> -#define MAX_MASTER_STREAMIDS           MAX_PHANDLE_ARGS
> +#define MAX_MASTER_STREAMIDS           128
>
>  /* Maximum number of context banks per SMMU */
>  #define ARM_SMMU_MAX_CBS               128
> @@ -349,6 +349,12 @@ struct arm_smmu_domain {
>         struct iommu_domain             domain;
>  };
>
> +struct arm_smmu_phandle_args {
> +       struct device_node *np;
> +       int args_count;
> +       uint32_t args[MAX_MASTER_STREAMIDS];
> +};
> +
>  static struct iommu_ops arm_smmu_ops;
>
>  static DEFINE_SPINLOCK(arm_smmu_devices_lock);
> @@ -458,7 +464,7 @@ static int insert_smmu_master(struct arm_smmu_device *smmu,
>
>  static int register_smmu_master(struct arm_smmu_device *smmu,
>                                 struct device *dev,
> -                               struct of_phandle_args *masterspec)
> +                               struct arm_smmu_phandle_args *masterspec)
>  {
>         int i;
>         struct arm_smmu_master *master;
> @@ -1716,7 +1722,8 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
>         struct arm_smmu_device *smmu;
>         struct device *dev = &pdev->dev;
>         struct rb_node *node;
> -       struct of_phandle_args masterspec;
> +       struct of_phandle_iterator it;
> +       struct arm_smmu_phandle_args masterspec;

Isn't this a bit big to put on the stack being ~512 bytes?

>         int num_irqs, i, err;
>
>         smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
