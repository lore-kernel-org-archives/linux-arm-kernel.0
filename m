From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 8 Apr 2016 11:03:44 -0600
Subject: [PATCH RESEND] coresight-etm4x: Change ETM setting.
In-Reply-To: <1460107150-241958-1-git-send-email-lipengcheng8@huawei.com>
References: <1460107150-241958-1-git-send-email-lipengcheng8@huawei.com>
Message-ID: <CANLsYky_ExziS_QtHgMsE4iUdrUieo_fkJtvrc7802so5MU4dw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 April 2016 at 03:19, lipengcheng <lipengcheng8@huawei.com> wrote:
> From: Pengcheng Li <lipengcheng8@huawei.com>
>
> Force ETM idle acknowleghe when CPU enter WFI.
> writel_relaxed(0x2, drvdata->base + TRCAUXCTLR);
>
> Because linux kernel execute on EL1,
> so we just need to open EL1 trace?close EL1 trace.
> drvdata->vinst_ctrl |= BIT(20);
>
> Because this operation exceed the range of boolean,
> so we should modify q_support to unit32 bit.
> drvdata->q_support = BMVAL(etmidr0, 15, 16)
>
> Adding PM runtime operations in Coresight devices.
>         -static int etmv4_suspend(struct device *dev)
>         -static int etmv4_resume(struct device *dev)
>
> Signed-off-by: Li Pengcheng <lipengcheng8@huawei.com>
> Signed-off-by: Li Zhong <lizhong11@hisilicon.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x.c | 58 +++++++++++++++++++++++++--
>  drivers/hwtracing/coresight/coresight-etm4x.h |  2 +-
>  drivers/hwtracing/coresight/coresight.c       | 10 +++--
>  3 files changed, 62 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
> index 1c59bd3..3a21409 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> @@ -33,7 +33,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/perf_event.h>
>  #include <asm/sections.h>
> -
> +#include<linux/cpuidle.h>
>  #include "coresight-etm4x.h"
>
>  static int boot_enable;
> @@ -111,8 +111,8 @@ static void etm4_enable_hw(void *info)
>
>         writel_relaxed(drvdata->pe_sel, drvdata->base + TRCPROCSELR);
>         writel_relaxed(drvdata->cfg, drvdata->base + TRCCONFIGR);
> -       /* nothing specific implemented */
> -       writel_relaxed(0x0, drvdata->base + TRCAUXCTLR);
> +       /* Force ETM idle acknowleghe when CPU enter WFI */
> +       writel_relaxed(0x2, drvdata->base + TRCAUXCTLR);

Register TRCAUXCTRL is implementation defined.  As such the code above
means that all implementation should define this register and have the
same implementation, something that is not possible.

>         writel_relaxed(drvdata->eventctrl0, drvdata->base + TRCEVENTCTL0R);
>         writel_relaxed(drvdata->eventctrl1, drvdata->base + TRCEVENTCTL1R);
>         writel_relaxed(drvdata->stall_ctrl, drvdata->base + TRCSTALLCTLR);
> @@ -2491,6 +2491,8 @@ static void etm4_init_default_data(struct etmv4_drvdata *drvdata)
>          *  started state
>          */
>         drvdata->vinst_ctrl |= BIT(0);
> +       /* Not generate EL0-NS trace */
> +       drvdata->vinst_ctrl |= BIT(20);

The content of  TRCVICTLR:EXLEVEL_NS is implementation defined and
dependant on TRCIDR3.EXLEVEL_NS.  Once again we can't turn this on
here since other systems may not carry the functionality.

That being said this highlights a situation I have foreseen a long
time ago but never got around to address: board specific
configuration.  Given the amount of implementation defined registers
it is just a matter of time before people (just like you) need a
different default configuration than the one currently enacted in the
driver.

This should go through the DT via a new binding, something like
"coresight-default-cfg".  The format for this binding would be list of
couples, i.e address offset + value.  We'd also need a way to specify
whether the new default configuration should replace the driver's
default or complement it.

The alternative, for now, is to read the new configuration using a
bash script and using the sysFS interface to communicate the new
values to the driver.

>         /* set initial state of start-stop logic */
>         if (drvdata->nr_addr_cmp)
>                 drvdata->vinst_ctrl |= BIT(9);
> @@ -2595,6 +2597,42 @@ static struct notifier_block etm4_cpu_notifier = {
>         .notifier_call = etm4_cpu_callback,
>  };
>
> +#ifdef CONFIG_PM
> +
> +static int etmv4_suspend(struct device *dev)
> +{
> +       int ret = 0;
> +       struct etmv4_drvdata *drvdata = dev_get_drvdata(dev);
> +
> +       dev_info(drvdata->dev, "%s: CPU+%d\n", __func__, drvdata->cpu);
> +       if (drvdata->enable) {
> +               cpuidle_pause();

Calling cpuidle here means that each time a CPU is in the process of
going down all the other CPUs are prevented from either going into or
coming out of idle.  On top of thing, in the down path forces all the
other CPUs from waking up...  Power management people won't be happy.

A better way is to use notifiers and an event better is to wait for
the kernel to support power domains that can be shared between CPUs
and devices.  Rather than using an in between solution (notifiers) I
opted to wait for the real solution (shared power domains) be
implemented.  People are currently working on this.

> +               coresight_disable(drvdata->csdev);
> +               cpuidle_resume();
> +       }
> +
> +       return ret;
> +}
> +
> +static int etmv4_resume(struct device *dev)
> +{
> +       int ret = 0;
> +       struct etmv4_drvdata *drvdata = dev_get_drvdata(dev);
> +
> +       dev_info(drvdata->dev, "%s: CPU+%d\n", __func__, drvdata->cpu);
> +       if (!drvdata->enable && drvdata->boot_enable) {
> +               cpuidle_pause();
> +               coresight_enable(drvdata->csdev);
> +               cpuidle_resume();
> +       }
> +
> +       return ret;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(etm4x_dev_pm_ops, etmv4_suspend, etmv4_resume);
> +
> +#endif
> +
>  static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
>  {
>         int ret;
> @@ -2673,7 +2711,9 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
>         dev_info(dev, "%s initialized\n", (char *)id->data);
>
>         if (boot_enable) {
> +               cpuidle_pause();
>                 coresight_enable(drvdata->csdev);
> +               cpuidle_resume();
>                 drvdata->boot_enable = true;
>         }
>
> @@ -2698,7 +2738,17 @@ static struct amba_id etm4_ids[] = {
>                 .mask   = 0x000fffff,
>                 .data   = "ETM 4.0",
>         },
> -       { 0, 0},
> +       {       /* ETM 4.0 - A72 board */
> +               .id = 0x000bb95a,
> +               .mask = 0x000fffff,
> +               .data = "ETM 4.0",
> +       },
> +       {       /* ETM 4.0 - Atermis board */
> +               .id = 0x000bb959,
> +               .mask = 0x000fffff,
> +               .data = "ETM 4.0",
> +       },
> +       {0, 0},

That I'm very interested in.  Please make a separate patch for this
and re-submit with the DT implementation.  I suppose the DT
implementation is not mandatory but definitely preferable.

>  };
>
>  static struct amba_driver etm4x_driver = {
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index c341002..305b29a 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -330,7 +330,7 @@ struct etmv4_drvdata {
>         u32                             ccctlr;
>         bool                            trcbb;
>         u32                             bb_ctrl;
> -       bool                            q_support;
> +       u32                             q_support;

That is a valid change - please send me a separate patch.

>         u32                             vinst_ctrl;
>         u32                             viiectlr;
>         u32                             vissctlr;
> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
> index 2ea5961..8b9fda4 100644
> --- a/drivers/hwtracing/coresight/coresight.c
> +++ b/drivers/hwtracing/coresight/coresight.c
> @@ -24,6 +24,7 @@
>  #include <linux/of_platform.h>
>  #include <linux/delay.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/cpuidle.h>
>
>  #include "coresight-priv.h"
>
> @@ -514,7 +515,7 @@ static ssize_t enable_sink_show(struct device *dev,
>  {
>         struct coresight_device *csdev = to_coresight_device(dev);
>
> -       return scnprintf(buf, PAGE_SIZE, "%u\n", (unsigned)csdev->activated);
> +       return scnprintf(buf, PAGE_SIZE, "%u\n", csdev->activated);
>  }
>
>  static ssize_t enable_sink_store(struct device *dev,
> @@ -544,7 +545,7 @@ static ssize_t enable_source_show(struct device *dev,
>  {
>         struct coresight_device *csdev = to_coresight_device(dev);
>
> -       return scnprintf(buf, PAGE_SIZE, "%u\n", (unsigned)csdev->enable);
> +       return scnprintf(buf, PAGE_SIZE, "%u\n", csdev->enable);
>  }

Once again I need a separate patch for this.

Thanks,
Mathieu

>
>  static ssize_t enable_source_store(struct device *dev,
> @@ -559,6 +560,8 @@ static ssize_t enable_source_store(struct device *dev,
>         if (ret)
>                 return ret;
>
> +       /* suspend cpuidle */
> +       cpuidle_pause();
>         if (val) {
>                 ret = coresight_enable(csdev);
>                 if (ret)
> @@ -566,7 +569,8 @@ static ssize_t enable_source_store(struct device *dev,
>         } else {
>                 coresight_disable(csdev);
>         }
> -
> +       /* resume cpuidle */
> +       cpuidle_resume();
>         return size;
>  }
>  static DEVICE_ATTR_RW(enable_source);
> --
> 1.8.3.2
>
