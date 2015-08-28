From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 28 Aug 2015 10:28:13 -0600
Subject: [PATCH v2] Coresight: ETMv4: Prevent TRCRSCTLR0&1 from being
 accessed
In-Reply-To: <1440735001-29760-1-git-send-email-zhang.chunyan@linaro.org>
References: <1440735001-29760-1-git-send-email-zhang.chunyan@linaro.org>
Message-ID: <CANLsYkxhvf5n8HW51xT83K_=WrJ=1PG8=3q=_L9GEN7RFFzAFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 August 2015 at 22:10, Chunyan Zhang <zhang.chunyan@linaro.org> wrote:
> 1. TRCRSCTLRn - Resource Selection Control Registers n=0~1 are reserved,
>    we shouldn't access them.
> 2. The max number of 'n' here is defined in TRCIDR4.NUMRSPAIR whoes value
>    indicates the number of resource selection *pairs*, and 0 indicates
>    one resource selection pair, 1 indicates two pairs, and so on ...
>
> So, the total number of resource selection control registers which we can
> access is (TRCIDR4.NUMRSPAIR * 2)
>
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
> index 1312e99..fe93b47 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> @@ -136,7 +136,9 @@ static void etm4_enable_hw(void *info)
>                 writel_relaxed(drvdata->cntr_val[i],
>                                drvdata->base + TRCCNTVRn(i));
>         }
> -       for (i = 0; i < drvdata->nr_resource; i++)
> +
> +       /* Resource selector pair 0 is always implemented and reserved */
> +       for (i = 2; i < drvdata->nr_resource * 2; i++)
>                 writel_relaxed(drvdata->res_ctrl[i],
>                                drvdata->base + TRCRSCTLRn(i));
>
> @@ -489,8 +491,9 @@ static ssize_t reset_store(struct device *dev,
>                 drvdata->cntr_val[i] = 0x0;
>         }
>
> -       drvdata->res_idx = 0x0;
> -       for (i = 0; i < drvdata->nr_resource; i++)
> +       /* Resource selector pair 0 is always implemented and reserved */
> +       drvdata->res_idx = 0x2;
> +       for (i = 2; i < drvdata->nr_resource * 2; i++)
>                 drvdata->res_ctrl[i] = 0x0;
>
>         for (i = 0; i < drvdata->nr_ss_cmp; i++) {
> @@ -1729,7 +1732,7 @@ static ssize_t res_idx_store(struct device *dev,
>         if (kstrtoul(buf, 16, &val))
>                 return -EINVAL;
>         /* Resource selector pair 0 is always implemented and reserved */
> -       if ((val == 0) || (val >= drvdata->nr_resource))
> +       if (val < 2 || val >= drvdata->nr_resource * 2)
>                 return -EINVAL;
>
>         /*
> @@ -2410,8 +2413,8 @@ static void etm4_init_arch_data(void *info)
>         drvdata->nr_addr_cmp = BMVAL(etmidr4, 0, 3);
>         /* NUMPC, bits[15:12] number of PE comparator inputs for tracing */
>         drvdata->nr_pe_cmp = BMVAL(etmidr4, 12, 15);
> -       /* NUMRSPAIR, bits[19:16] the number of resource pairs for tracing */
> -       drvdata->nr_resource = BMVAL(etmidr4, 16, 19);
> +       /* NUMRSPAIR, bits[19:16] the number of resource pairs minus one */
> +       drvdata->nr_resource = BMVAL(etmidr4, 16, 19) + 1;
>         /*
>          * NUMSSCC, bits[23:20] the number of single-shot
>          * comparator control for tracing
> @@ -2498,6 +2501,8 @@ static void etm4_init_default_data(struct etmv4_drvdata *drvdata)
>                 drvdata->cntr_val[i] = 0x0;
>         }
>
> +       /* Resource selector pair 0 is always implemented and reserved */
> +       drvdata->res_idx = 0x2;
>         for (i = 2; i < drvdata->nr_resource * 2; i++)
>                 drvdata->res_ctrl[i] = 0x0;
>
> --
> 1.9.1
>

Applied with a modification to the "NUMRSPAIR" comment - thanks,

Mathieu
