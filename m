From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 1 Jun 2016 11:16:34 -0600
Subject: [PATCH] coresight: Remove erroneous dma_free_coherent in tmc_probe
In-Reply-To: <1464716849-32066-1-git-send-email-suzuki.poulose@arm.com>
References: <1464716849-32066-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <CANLsYkzFC93YO=FNY-Nju3FgMLO9mU191XW0B=JCy-WdPJp49w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 May 2016 at 11:47, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> commit de5461970b3e9e194 ("coresight: tmc: allocating memory when needed")
> removed the static allocation of buffer for the trace data in ETR mode in
> tmc_probe. However it failed to remove the "devm_free_coherent" in tmc_probe
> when the probe fails due to other reasons. This patch gets rid of the
> incorrect dma_free_coherent() call. Also consolidates the error return
> paths.
>
> Fixes: commit de5461970b3e9e194 ("coresight: tmc: allocating memory when needed")
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-tmc.c | 32 ++++++++++++++---------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
> index c7d8ba6..ca38144 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc.c
> @@ -307,22 +307,31 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
>
>         if (np) {
>                 pdata = of_get_coresight_platform_data(dev, np);
> -               if (IS_ERR(pdata))
> -                       return PTR_ERR(pdata);
> +               if (IS_ERR(pdata)) {
> +                       ret = PTR_ERR(pdata);
> +                       goto out;
> +               }
>                 adev->dev.platform_data = pdata;
>         }
>
> +       ret = -ENOMEM;
>         drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>         if (!drvdata)
> -               return -ENOMEM;
> +               goto out;
> +
> +       desc = devm_kzalloc(dev, sizeof(*desc), GFP_KERNEL);
> +       if (!desc)
> +               goto out;
>
>         drvdata->dev = &adev->dev;
>         dev_set_drvdata(dev, drvdata);
>
>         /* Validity for the resource is already checked by the AMBA core */
>         base = devm_ioremap_resource(dev, res);
> -       if (IS_ERR(base))
> -               return PTR_ERR(base);
> +       if (IS_ERR(base)) {
> +               ret = PTR_ERR(base);
> +               goto out;
> +       }
>
>         drvdata->base = base;
>
> @@ -345,12 +354,6 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
>
>         pm_runtime_put(&adev->dev);
>
> -       desc = devm_kzalloc(dev, sizeof(*desc), GFP_KERNEL);
> -       if (!desc) {
> -               ret = -ENOMEM;
> -               goto err_devm_kzalloc;
> -       }
> -
>         desc->pdata = pdata;
>         desc->dev = dev;
>         desc->subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_BUFFER;
> @@ -371,7 +374,7 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
>         drvdata->csdev = coresight_register(desc);
>         if (IS_ERR(drvdata->csdev)) {
>                 ret = PTR_ERR(drvdata->csdev);
> -               goto err_devm_kzalloc;
> +               goto out;
>         }
>
>         drvdata->miscdev.name = pdata->name;
> @@ -385,10 +388,7 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
>
>  err_misc_register:
>         coresight_unregister(drvdata->csdev);
> -err_devm_kzalloc:
> -       if (drvdata->config_type == TMC_CONFIG_TYPE_ETR)
> -               dma_free_coherent(dev, drvdata->size,
> -                               drvdata->vaddr, drvdata->paddr);
> +out:
>         return ret;
>  }
>
> --
> 1.9.1
>

I agree with these changes but please split this in two separate
patches (one for the exit path and the other for the
dma_free_coherent()) and fix the checkpatch warning.

Thanks,
Mathieu
