From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 11 Jul 2018 12:05:03 -0600
Subject: [PATCH] coresight: tpiu: Fix disabling timeouts
In-Reply-To: <9f296d734cef2d34ad2e2a5d93a1e56c5c8b1df9.1531231150.git.robin.murphy@arm.com>
References: <9f296d734cef2d34ad2e2a5d93a1e56c5c8b1df9.1531231150.git.robin.murphy@arm.com>
Message-ID: <CANLsYky70OuHBtK8F0MwhvWU03_tmyjOP9kawNFxr=8avsx9vQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 10 Jul 2018 at 08:01, Robin Murphy <robin.murphy@arm.com> wrote:
>
> Probing the TPIU driver under UBSan triggers an out-of-bounds shift
> warning in coresight_timeout():
>
> ...
> [    5.677530] UBSAN: Undefined behaviour in drivers/hwtracing/coresight/coresight.c:929:16
> [    5.685542] shift exponent 64 is too large for 64-bit type 'long unsigned int'
> ...
>
> On closer inspection things are exponentially out of whack because we're
> passing a bitmask where a bit number should be. Amusingly, it seems that
> both calls will find their expected values by sheer luck and appear to
> succeed: 1 << FFCR_FON_MAN ends up@bit 64 which whilst undefined
> evaluates as zero in practice, while 1 << FFSR_FT_STOPPED finds bit 2
> (TCPresent) which apparently is usually tied high.
>
> Following the examples of other drivers, define separate FOO and FOO_BIT
> macros for masks vs. indices, and put things right.
>
> CC: Robert Walker <robert.walker@arm.com>
> CC: Mike Leach <mike.leach@linaro.org>
> CC: Mathieu Poirier <mathieu.poirier@linaro.org>
> Fixes: 11595db8e17f ("coresight: Fix disabling of CoreSight TPIU")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-tpiu.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
> index 01b7457fe8fc..459ef930d98c 100644
> --- a/drivers/hwtracing/coresight/coresight-tpiu.c
> +++ b/drivers/hwtracing/coresight/coresight-tpiu.c
> @@ -40,8 +40,9 @@
>
>  /** register definition **/
>  /* FFSR - 0x300 */
> -#define FFSR_FT_STOPPED                BIT(1)
> +#define FFSR_FT_STOPPED_BIT    1
>  /* FFCR - 0x304 */
> +#define FFCR_FON_MAN_BIT       6
>  #define FFCR_FON_MAN           BIT(6)
>  #define FFCR_STOP_FI           BIT(12)
>
> @@ -86,9 +87,9 @@ static void tpiu_disable_hw(struct tpiu_drvdata *drvdata)
>         /* Generate manual flush */
>         writel_relaxed(FFCR_STOP_FI | FFCR_FON_MAN, drvdata->base + TPIU_FFCR);
>         /* Wait for flush to complete */
> -       coresight_timeout(drvdata->base, TPIU_FFCR, FFCR_FON_MAN, 0);
> +       coresight_timeout(drvdata->base, TPIU_FFCR, FFCR_FON_MAN_BIT, 0);
>         /* Wait for formatter to stop */
> -       coresight_timeout(drvdata->base, TPIU_FFSR, FFSR_FT_STOPPED, 1);
> +       coresight_timeout(drvdata->base, TPIU_FFSR, FFSR_FT_STOPPED_BIT, 1);
>
>         CS_LOCK(drvdata->base);
>  }
> --

Yes, "amusingly".

Applied - thanks.
Mathieu

> 2.17.1.dirty
>
