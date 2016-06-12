From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Sun, 12 Jun 2016 14:36:55 -0600
Subject: [PATCH v2 9/9] coresight: Add better messages for
 coresight_timeout
In-Reply-To: <1465204301-24184-10-git-send-email-suzuki.poulose@arm.com>
References: <1465204301-24184-1-git-send-email-suzuki.poulose@arm.com>
 <1465204301-24184-10-git-send-email-suzuki.poulose@arm.com>
Message-ID: <CANLsYkyA1UgZq1QLdOVO9iDfUq8M=ZdM=8S+HrvjGzv2hMVAAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 June 2016 at 03:11, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> When we encounter a timeout waiting for a status change via
> coresight_timeout, the caller always print the offset which
> was tried. This is pretty much useless as it doesn't specify
> the bit position we wait for. Also, one needs to lookup the
> TRM to figure out, what was wrong. This patch changes all
> such error messages to print something more meaningful.
>
> Cc: joe at perches.com
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-etb10.c | 7 +++----
>  drivers/hwtracing/coresight/coresight-etm4x.c | 6 ++----
>  drivers/hwtracing/coresight/coresight-tmc.c   | 7 +++----
>  3 files changed, 8 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
> index 4d20b0b..839c2ab 100644
> --- a/drivers/hwtracing/coresight/coresight-etb10.c
> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
> @@ -184,8 +184,8 @@ static void etb_disable_hw(struct etb_drvdata *drvdata)
>
>         if (coresight_timeout(drvdata->base, ETB_FFCR, ETB_FFCR_BIT, 0)) {
>                 dev_err(drvdata->dev,
> -                       "timeout observed when probing at offset %#x\n",
> -                       ETB_FFCR);
> +                       "timeout while waiting for %s\n",
> +                       "completion of Manual Flush");

It seems like we misunderstood each other - the above format makes
string searching in the kernel difficult.  Why not simply do:

dev_err(drvdata->dev, timeout while waiting for completion of Manual Flush);



>         }
>
>         /* disable trace capture */
> @@ -193,8 +193,7 @@ static void etb_disable_hw(struct etb_drvdata *drvdata)
>
>         if (coresight_timeout(drvdata->base, ETB_FFSR, ETB_FFSR_BIT, 1)) {
>                 dev_err(drvdata->dev,
> -                       "timeout observed when probing at offset %#x\n",
> -                       ETB_FFCR);
> +                       "timeout while waiting for %s\n", "Formatter to Stop");
>         }
>
>         CS_LOCK(drvdata->base);
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
> index 88947f3..43fa3be 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> @@ -111,8 +111,7 @@ static void etm4_enable_hw(void *info)
>         /* wait for TRCSTATR.IDLE to go up */
>         if (coresight_timeout(drvdata->base, TRCSTATR, TRCSTATR_IDLE_BIT, 1))
>                 dev_err(drvdata->dev,
> -                       "timeout observed when probing at offset %#x\n",
> -                       TRCSTATR);
> +                       "timeout while waiting for %s\n", "Idle Trace Status");
>
>         writel_relaxed(config->pe_sel, drvdata->base + TRCPROCSELR);
>         writel_relaxed(config->cfg, drvdata->base + TRCCONFIGR);
> @@ -184,8 +183,7 @@ static void etm4_enable_hw(void *info)
>         /* wait for TRCSTATR.IDLE to go back down to '0' */
>         if (coresight_timeout(drvdata->base, TRCSTATR, TRCSTATR_IDLE_BIT, 0))
>                 dev_err(drvdata->dev,
> -                       "timeout observed when probing at offset %#x\n",
> -                       TRCSTATR);
> +                       "timeout while waiting for %s\n", "Idle Trace Status");
>
>         CS_LOCK(drvdata->base);
>
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
> index b3275bb..c2f64f3 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc.c
> @@ -38,8 +38,7 @@ void tmc_wait_for_tmcready(struct tmc_drvdata *drvdata)
>         if (coresight_timeout(drvdata->base,
>                               TMC_STS, TMC_STS_TMCREADY_BIT, 1)) {
>                 dev_err(drvdata->dev,
> -                       "timeout observed when probing at offset %#x\n",
> -                       TMC_STS);
> +                       "timeout while waiting for %s\n", "TMC to be Ready");
>         }
>  }
>
> @@ -56,8 +55,8 @@ void tmc_flush_and_stop(struct tmc_drvdata *drvdata)
>         if (coresight_timeout(drvdata->base,
>                               TMC_FFCR, TMC_FFCR_FLUSHMAN_BIT, 0)) {
>                 dev_err(drvdata->dev,
> -                       "timeout observed when probing at offset %#x\n",
> -                       TMC_FFCR);
> +                       "timeout while waiting for %s\n",
> +                       "completion of Manual Flush");
>         }
>
>         tmc_wait_for_tmcready(drvdata);
> --
> 1.9.1
>
