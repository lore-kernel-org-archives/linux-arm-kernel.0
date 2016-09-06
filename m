From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 6 Sep 2016 09:28:57 -0600
Subject: [PATCH] coresight: tmc: mark symbols static where possible
In-Reply-To: <1473149030-25576-1-git-send-email-baoyou.xie@linaro.org>
References: <1473149030-25576-1-git-send-email-baoyou.xie@linaro.org>
Message-ID: <CANLsYkw+kHpdate2UAb8BFViaqgYkAmrvsYCBumgPXKa_cWYHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 September 2016 at 02:03, Baoyou Xie <baoyou.xie@linaro.org> wrote:
> We get a few warnings when building kernel with W=1:
> drivers/hwtracing/coresight/coresight-tmc-etr.c:23:6: warning: no previous prototype for 'tmc_etr_enable_hw' [-Wmissing-prototypes]
> drivers/hwtracing/coresight/coresight-tmc-etf.c:25:6: warning: no previous prototype for 'tmc_etb_enable_hw' [-Wmissing-prototypes]
> ...
>
> In fact, these functions are only used in the file in which they are
> declared and don't need a declaration, but can be made static.
> so this patch marks these functions with 'static'.
>
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
> ---
>  drivers/hwtracing/coresight/coresight-tmc-etf.c | 2 +-
>  drivers/hwtracing/coresight/coresight-tmc-etr.c | 2 +-
>  drivers/hwtracing/coresight/coresight-tmc.c     | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> index 466af86..a9a525f 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> @@ -22,7 +22,7 @@
>  #include "coresight-priv.h"
>  #include "coresight-tmc.h"
>
> -void tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
> +static void tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
>  {
>         CS_UNLOCK(drvdata->base);
>
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index 688be9e..1ff5451 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -20,7 +20,7 @@
>  #include "coresight-priv.h"
>  #include "coresight-tmc.h"
>
> -void tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
> +static void tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
>  {
>         u32 axictl;
>
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
> index 9e02ac9..45947f3 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc.c
> @@ -249,8 +249,8 @@ static struct attribute *coresight_tmc_mgmt_attrs[] = {
>         NULL,
>  };
>
> -ssize_t trigger_cntr_show(struct device *dev,
> -                         struct device_attribute *attr, char *buf)
> +static ssize_t trigger_cntr_show(struct device *dev,
> +                                struct device_attribute *attr, char *buf)
>  {
>         struct tmc_drvdata *drvdata = dev_get_drvdata(dev->parent);
>         unsigned long val = drvdata->trigger_cntr;
> --
> 2.7.4
>

I have applied this patch but modified the commit log to include the
warning triggered by the last snipped.

Thanks,
Mathieu
