From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Sun, 12 Jun 2016 14:38:28 -0600
Subject: [PATCH v2 3/9] coresight: Remove erroneous dma_free_coherent in
 tmc_probe
In-Reply-To: <1465204301-24184-4-git-send-email-suzuki.poulose@arm.com>
References: <1465204301-24184-1-git-send-email-suzuki.poulose@arm.com>
 <1465204301-24184-4-git-send-email-suzuki.poulose@arm.com>
Message-ID: <CANLsYkwjXR=GfXVwn48qH6s8CS2moqvZ=qccujkjKK4G9n26-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 June 2016 at 03:11, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> commit de5461970b3e9e194 ("coresight: tmc: allocating memory when needed")
> removed the static allocation of buffer for the trace data in ETR mode in
> tmc_probe. However it failed to remove the "devm_free_coherent" in
> tmc_probe when the probe fails due to other reasons. This patch gets
> rid of the incorrect dma_free_coherent() call. Also consolidates the
> error return paths.

Since this set has to go for one more round, please remove the last
line in the commit message.  The error path is consolidated in patch
8/9.

>
> Fixes: commit de5461970b3e9e194 ("coresight: tmc: allocating memory when needed")
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-tmc.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
> index 9e02ac9..3978cbb 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc.c
> @@ -388,9 +388,6 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
>  err_misc_register:
>         coresight_unregister(drvdata->csdev);
>  err_devm_kzalloc:
> -       if (drvdata->config_type == TMC_CONFIG_TYPE_ETR)
> -               dma_free_coherent(dev, drvdata->size,
> -                               drvdata->vaddr, drvdata->paddr);
>         return ret;
>  }
>
> --
> 1.9.1
>
