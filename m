From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 31 May 2016 11:57:58 -0600
Subject: [PATCH 4/5] coresight: Add better messages for coresight_timeout
In-Reply-To: <1464695858-29284-5-git-send-email-suzuki.poulose@arm.com>
References: <1464695858-29284-1-git-send-email-suzuki.poulose@arm.com>
 <1464695858-29284-5-git-send-email-suzuki.poulose@arm.com>
Message-ID: <CANLsYkyef0Zkvrt+7a9N2YD3z8vPSoR_m1pq5nBRRKn1Ns1LOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 May 2016 at 05:57, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> When we encounter a timeout waiting for a status change via
> coresight_timeout, the caller always print the offset which
> was tried. This is pretty much useless as it doesn't specify
> the bit position we wait for. Also, one needs to lookup the
> TRM to figure out, what was wrong. This patch changes all
> such error messages to print something more meaningful.
>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-etb10.c | 6 ++----
>  drivers/hwtracing/coresight/coresight-etm4x.c | 6 ++----
>  drivers/hwtracing/coresight/coresight-tmc.c   | 6 ++----
>  3 files changed, 6 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
> index 4d20b0b..6bd4b93 100644
> --- a/drivers/hwtracing/coresight/coresight-etb10.c
> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
> @@ -184,8 +184,7 @@ static void etb_disable_hw(struct etb_drvdata *drvdata)
>
>         if (coresight_timeout(drvdata->base, ETB_FFCR, ETB_FFCR_BIT, 0)) {
>                 dev_err(drvdata->dev,
> -                       "timeout observed when probing at offset %#x\n",
> -                       ETB_FFCR);
> +                       "timeout while waiting for completion of Manual Flush\n");
>         }
>
>         /* disable trace capture */
> @@ -193,8 +192,7 @@ static void etb_disable_hw(struct etb_drvdata *drvdata)
>
>         if (coresight_timeout(drvdata->base, ETB_FFSR, ETB_FFSR_BIT, 1)) {
>                 dev_err(drvdata->dev,
> -                       "timeout observed when probing at offset %#x\n",
> -                       ETB_FFCR);
> +                       "timeout while waiting for Formatter to Stop\n");
>         }
>
>         CS_LOCK(drvdata->base);
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
> index 88947f3..e494042 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> @@ -111,8 +111,7 @@ static void etm4_enable_hw(void *info)
>         /* wait for TRCSTATR.IDLE to go up */
>         if (coresight_timeout(drvdata->base, TRCSTATR, TRCSTATR_IDLE_BIT, 1))
>                 dev_err(drvdata->dev,
> -                       "timeout observed when probing at offset %#x\n",
> -                       TRCSTATR);
> +                       "timeout when waiting for Idle Trace Status\n");
>
>         writel_relaxed(config->pe_sel, drvdata->base + TRCPROCSELR);
>         writel_relaxed(config->cfg, drvdata->base + TRCCONFIGR);
> @@ -184,8 +183,7 @@ static void etm4_enable_hw(void *info)
>         /* wait for TRCSTATR.IDLE to go back down to '0' */
>         if (coresight_timeout(drvdata->base, TRCSTATR, TRCSTATR_IDLE_BIT, 0))
>                 dev_err(drvdata->dev,
> -                       "timeout observed when probing at offset %#x\n",
> -                       TRCSTATR);
> +                       "timeout when waiting for Idle Trace Status\n");
>
>         CS_LOCK(drvdata->base);
>
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
> index 9e02ac9..c7d8ba6 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc.c
> @@ -38,8 +38,7 @@ void tmc_wait_for_tmcready(struct tmc_drvdata *drvdata)
>         if (coresight_timeout(drvdata->base,
>                               TMC_STS, TMC_STS_TMCREADY_BIT, 1)) {
>                 dev_err(drvdata->dev,
> -                       "timeout observed when probing at offset %#x\n",
> -                       TMC_STS);
> +                       "timeout observed when waiting for TMC to be Ready\n");
>         }
>  }
>
> @@ -56,8 +55,7 @@ void tmc_flush_and_stop(struct tmc_drvdata *drvdata)
>         if (coresight_timeout(drvdata->base,
>                               TMC_FFCR, TMC_FFCR_FLUSHMAN_BIT, 0)) {
>                 dev_err(drvdata->dev,
> -                       "timeout observed when probing at offset %#x\n",
> -                       TMC_FFCR);
> +                       "timeout observed while waiting for completion of Manual Flush\n");
>         }
>
>         tmc_wait_for_tmcready(drvdata);
> --
> 1.9.1
>

I'm fine with this change but in all 3 files the beginning of the new
error message is different.  Please select one and use it throughout.

Thanks,
Mathieu
