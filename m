From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 5 Oct 2016 15:15:39 -0600
Subject: [PATCH v2] Adding missing features of Coresight PTM components
In-Reply-To: <f029bcee-696f-3519-b0f1-4cdcf24ad3f8@centralesupelec.fr>
References: <f029bcee-696f-3519-b0f1-4cdcf24ad3f8@centralesupelec.fr>
Message-ID: <CANLsYkxepzF1VuU6uDSrMEmd6F5ET_yyM73eBSvypaTJCu4eyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 October 2016 at 05:42, Muhammad Abdul WAHAB
<muhammadabdul.wahab@centralesupelec.fr> wrote:
> In the current driver for Coresight components, two features of PTM
> components are missing:
>
> 1. Branch Broadcasting (present also in ETM but called Branch Output)
> 2. Return Stack (only present in PTM v1.0 and PTMv1.1)
>
> These features can be added simply to the code using `mode` field of
> `etm_config` struct.
>
> 1. **Branch Broadcast** : The branch broadcast feature is present in ETM
> components as well and is called Branch output. It allows to retrieve
> addresses for direct branch addresses alongside the indirect branch
> addresses. For example, it could be useful in cases when tracing without
> source code.
> 2. **Return Stack** : The return stack option allows to retrieve the return
>  addresses of function calls. It can be useful to avoid CRA
> (Code Reuse Attacks) by keeping a shadowstack.
>
> Signed-off-by: Muhammad Abdul Wahab <muhammadabdul.wahab@centralesupelec.fr>
> ---
> changes in v2 :
>         - modified patch description
>         - removed additional comments on testing
>         - removed a check on architecture version of ETM
>         - generated using "git format-patch"
>         - same email address in from: and SOB
>
>  drivers/hwtracing/coresight/coresight-etm.h         |  3 +++
>  drivers/hwtracing/coresight/coresight-etm3x-sysfs.c | 12 ++++++++++++
>  2 files changed, 15 insertions(+)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm.h
> b/drivers/hwtracing/coresight/coresight-etm.h
> index 4a18ee4..7a34860 100644
> --- a/drivers/hwtracing/coresight/coresight-etm.h
> +++ b/drivers/hwtracing/coresight/coresight-etm.h
> @@ -110,8 +110,11 @@
>  #define ETM_MODE_STALL         BIT(2)
>  #define ETM_MODE_TIMESTAMP     BIT(3)
>  #define ETM_MODE_CTXID         BIT(4)
> +#define ETM_MODE_BBROAD                BIT(5)
> +#define ETM_MODE_RET_STACK     BIT(6)
>  #define ETM_MODE_ALL           (ETM_MODE_EXCLUDE | ETM_MODE_CYCACC | \
>                                  ETM_MODE_STALL | ETM_MODE_TIMESTAMP | \
> +                                ETM_MODE_BBROAD | ETM_MODE_RET_STACK | \
>                                  ETM_MODE_CTXID | ETM_MODE_EXCL_KERN | \
>                                  ETM_MODE_EXCL_USER)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> index 5ea0909..4e0eab7 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> @@ -164,6 +164,18 @@ static ssize_t mode_store(struct device *dev,
>         else
>                 config->ctrl &= ~ETMCR_CTXID_SIZE;
>
> +       if (config->mode & ETM_MODE_BBROAD)
> +               config->ctrl |= ETMCR_BRANCH_BROADCAST;
> +       else
> +               config->ctrl &= ~ETMCR_BRANCH_BROADCAST;
> +
> +       if (config->mode & ETM_MODE_RET_STACK) {
> +               if (config->mode & ETM_MODE_BBROAD)
> +                       dev_warn(drvdata->dev, "behavior is
> unpredictable\n");

Please remove the warning message as well - there is no point having
it there because:

1) From sysFS users are supposed to know what they're doing.
2) If we start warning users on all the things that can go wrong the
code will become unbelievably cluttered.

Thanks,
Mathieu

> +               config->ctrl |= ETMCR_RETURN_STACK_EN;
> +       } else
> +               config->ctrl &= ~ETMCR_RETURN_STACK_EN;
> +
>         if (config->mode & (ETM_MODE_EXCL_KERN | ETM_MODE_EXCL_USER))
>                 etm_config_trace_mode(config);
>
> --
> 1.9.1
