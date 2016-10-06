From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 6 Oct 2016 09:52:08 -0600
Subject: [PATCH v3] Adding missing features of Coresight PTM components
In-Reply-To: <60a1f04c-1e73-0ff1-dfee-775b875d2c4a@centralesupelec.fr>
References: <f029bcee-696f-3519-b0f1-4cdcf24ad3f8@centralesupelec.fr>
 <60a1f04c-1e73-0ff1-dfee-775b875d2c4a@centralesupelec.fr>
Message-ID: <CANLsYkyPTtiGsfKg13ZY2pgCC3rh+MfirMwTrLG1=TZ5gUJqzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 October 2016 at 06:18, Muhammad Abdul WAHAB
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
> changes in v3 :
>         - deleted warning message
>         - bit field definition of Branch Broadcast and Return Stack
>
>  drivers/hwtracing/coresight/coresight-etm.h         |  5 +++++
>  drivers/hwtracing/coresight/coresight-etm3x-sysfs.c | 10 ++++++++++
>  2 files changed, 15 insertions(+)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm.h
> b/drivers/hwtracing/coresight/coresight-etm.h
> index 4a18ee4..ad063d7 100644
> --- a/drivers/hwtracing/coresight/coresight-etm.h
> +++ b/drivers/hwtracing/coresight/coresight-etm.h
> @@ -89,11 +89,13 @@
>  /* ETMCR - 0x00 */
>  #define ETMCR_PWD_DWN          BIT(0)
>  #define ETMCR_STALL_MODE       BIT(7)
> +#define ETMCR_BRANCH_BROADCAST BIT(8)
>  #define ETMCR_ETM_PRG          BIT(10)
>  #define ETMCR_ETM_EN           BIT(11)
>  #define ETMCR_CYC_ACC          BIT(12)
>  #define ETMCR_CTXID_SIZE       (BIT(14)|BIT(15))
>  #define ETMCR_TIMESTAMP_EN     BIT(28)
> +#define ETMCR_RETURN_STACK     BIT(29)
>  /* ETMCCR - 0x04 */
>  #define ETMCCR_FIFOFULL                BIT(23)
>  /* ETMPDCR - 0x310 */
> @@ -110,8 +112,11 @@
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
> index 5ea0909..a76009a 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> @@ -164,6 +164,16 @@ static ssize_t mode_store(struct device *dev,
>         else
>                 config->ctrl &= ~ETMCR_CTXID_SIZE;
>
> +       if (config->mode & ETM_MODE_BBROAD)
> +               config->ctrl |= ETMCR_BRANCH_BROADCAST;
> +       else
> +               config->ctrl &= ~ETMCR_BRANCH_BROADCAST;
> +
> +       if (config->mode & ETM_MODE_RET_STACK)
> +               config->ctrl |= ETMCR_RETURN_STACK_EN;
> +       else
> +               config->ctrl &= ~ETMCR_RETURN_STACK_EN;
> +

Where is ETMCR_RETURN_STACK_EN defined?  Did you send me code that
doesn't compile?

>         if (config->mode & (ETM_MODE_EXCL_KERN | ETM_MODE_EXCL_USER))
>                 etm_config_trace_mode(config);
>
> --
> 1.9.1
