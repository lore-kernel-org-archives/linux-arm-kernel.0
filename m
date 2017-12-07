From: mike.leach@linaro.org (Mike Leach)
Date: Thu, 7 Dec 2017 16:14:03 +0000
Subject: [PATCH] coresight: Fix disabling of CoreSight TPIU
In-Reply-To: <1511517525-3270-1-git-send-email-robert.walker@arm.com>
References: <1511517525-3270-1-git-send-email-robert.walker@arm.com>
Message-ID: <CAJ9a7VgWdDL0aBg=XyNcb9iH6ZHCWEMosLPX8PnBurCjkE6ZbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tested by: Mike Leach <mike.leach@linaro.org>

On 24 November 2017 at 09:58, Robert Walker <robert.walker@arm.com> wrote:
> The CoreSight TPIU should be disabled when tracing to other sinks to allow
> them to operate at full bandwidth.
>
> This patch fixes tpiu_disable_hw() to correctly disable the TPIU by
> configuring the TPIU to stop on flush, initiating a manual flush, waiting
> for the flush to complete and then waits for the TPIU to indicate it has
> stopped.
>
> Signed-off-by: Robert Walker <robert.walker@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-tpiu.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
> index bef49a3..4b46c49 100644
> --- a/drivers/hwtracing/coresight/coresight-tpiu.c
> +++ b/drivers/hwtracing/coresight/coresight-tpiu.c
> @@ -46,8 +46,11 @@
>  #define TPIU_ITATBCTR0         0xef8
>
>  /** register definition **/
> +/* FFSR - 0x300 */
> +#define FFSR_FT_STOPPED                BIT(1)
>  /* FFCR - 0x304 */
>  #define FFCR_FON_MAN           BIT(6)
> +#define FFCR_STOP_FI           BIT(12)
>
>  /**
>   * @base:      memory mapped base address for this component.
> @@ -85,10 +88,14 @@ static void tpiu_disable_hw(struct tpiu_drvdata *drvdata)
>  {
>         CS_UNLOCK(drvdata->base);
>
> -       /* Clear formatter controle reg. */
> -       writel_relaxed(0x0, drvdata->base + TPIU_FFCR);
> +       /* Clear formatter and stop on flush */
> +       writel_relaxed(FFCR_STOP_FI, drvdata->base + TPIU_FFCR);
>         /* Generate manual flush */
> -       writel_relaxed(FFCR_FON_MAN, drvdata->base + TPIU_FFCR);
> +       writel_relaxed(FFCR_STOP_FI | FFCR_FON_MAN, drvdata->base + TPIU_FFCR);
> +       /* Wait for flush to complete */
> +       coresight_timeout(drvdata->base, TPIU_FFCR, FFCR_FON_MAN, 0);
> +       /* Wait for formatter to stop */
> +       coresight_timeout(drvdata->base, TPIU_FFSR, FFSR_FT_STOPPED, 1);
>
>         CS_LOCK(drvdata->base);
>  }
> --
> 1.9.1
>
> _______________________________________________
> CoreSight mailing list
> CoreSight at lists.linaro.org
> https://lists.linaro.org/mailman/listinfo/coresight



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Blackburn Design Centre. UK
