From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Thu, 29 Mar 2018 09:16:33 +0200
Subject: [PATCH v3 7/8] remoteproc/davinci: use the reset framework
In-Reply-To: <51e33d41-37b1-9e88-4a13-503bb39e2e40@ti.com>
References: <20180327092031.11251-1-brgl@bgdev.pl>
 <20180327092031.11251-8-brgl@bgdev.pl>
 <51e33d41-37b1-9e88-4a13-503bb39e2e40@ti.com>
Message-ID: <CAMRc=Me6giXHneuuRTPSwfw8HxwbDVCTgReZ_6HBv90ushf+-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-03-29 0:30 GMT+02:00 Suman Anna <s-anna@ti.com>:
> Hi Bart,
>
> On 03/27/2018 04:20 AM, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> Switch to using the reset framework instead of handcoded reset routines
>> we used so far.
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> ---
>>  drivers/remoteproc/da8xx_remoteproc.c | 33 ++++++++++++++++++++++++++++-----
>>  1 file changed, 28 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
>> index b668e32996e2..788f59809c02 100644
>> --- a/drivers/remoteproc/da8xx_remoteproc.c
>> +++ b/drivers/remoteproc/da8xx_remoteproc.c
>> @@ -10,6 +10,7 @@
>>
>>  #include <linux/bitops.h>
>>  #include <linux/clk.h>
>> +#include <linux/reset.h>
>>  #include <linux/err.h>
>>  #include <linux/interrupt.h>
>>  #include <linux/io.h>
>> @@ -20,8 +21,6 @@
>>  #include <linux/platform_device.h>
>>  #include <linux/remoteproc.h>
>>
>> -#include <mach/clock.h>   /* for davinci_clk_reset_assert/deassert() */
>> -
>>  #include "remoteproc_internal.h"
>>
>>  static char *da8xx_fw_name;
>> @@ -72,6 +71,7 @@ struct da8xx_rproc {
>>       struct da8xx_rproc_mem *mem;
>>       int num_mems;
>>       struct clk *dsp_clk;
>> +     struct reset_control *dsp_reset;
>>       void (*ack_fxn)(struct irq_data *data);
>>       struct irq_data *irq_data;
>>       void __iomem *chipsig;
>> @@ -138,6 +138,7 @@ static int da8xx_rproc_start(struct rproc *rproc)
>>       struct device *dev = rproc->dev.parent;
>>       struct da8xx_rproc *drproc = (struct da8xx_rproc *)rproc->priv;
>>       struct clk *dsp_clk = drproc->dsp_clk;
>> +     struct reset_control *dsp_reset = drproc->dsp_reset;
>>       int ret;
>>
>>       /* hw requires the start (boot) address be on 1KB boundary */
>> @@ -155,7 +156,12 @@ static int da8xx_rproc_start(struct rproc *rproc)
>>               return ret;
>>       }
>>
>> -     davinci_clk_reset_deassert(dsp_clk);
>> +     ret = reset_control_deassert(dsp_reset);
>> +     if (ret) {
>> +             dev_err(dev, "reset_control_deassert() failed: %d\n", ret);
>> +             clk_disable_unprepare(dsp_clk);
>> +             return ret;
>> +     }
>>
>>       return 0;
>>  }
>> @@ -163,8 +169,15 @@ static int da8xx_rproc_start(struct rproc *rproc)
>>  static int da8xx_rproc_stop(struct rproc *rproc)
>>  {
>>       struct da8xx_rproc *drproc = rproc->priv;
>> +     struct device *dev = rproc->dev.parent;
>> +     int ret;
>> +
>> +     ret = reset_control_assert(drproc->dsp_reset);
>> +     if (ret) {
>> +             dev_err(dev, "reset_control_assert() failed: %d\n", ret);
>> +             return ret;
>> +     }
>>
>> -     davinci_clk_reset_assert(drproc->dsp_clk);
>>       clk_disable_unprepare(drproc->dsp_clk);
>>
>>       return 0;
>> @@ -232,6 +245,7 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
>>       struct resource *bootreg_res;
>>       struct resource *chipsig_res;
>>       struct clk *dsp_clk;
>> +     struct reset_control *dsp_reset;
>>       void __iomem *chipsig;
>>       void __iomem *bootreg;
>>       int irq;
>> @@ -268,6 +282,15 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
>>               return PTR_ERR(dsp_clk);
>>       }
>>
>> +     dsp_reset = devm_reset_control_get_exclusive(dev, NULL);
>> +     if (IS_ERR(dsp_reset)) {
>> +             if (PTR_ERR(dsp_reset) != -EPROBE_DEFER)
>> +                     dev_err(dev, "unable to get reset control: %ld\n",
>> +                             PTR_ERR(dsp_reset));
>> +
>> +             return PTR_ERR(dsp_reset);
>> +     }
>> +
>>       if (dev->of_node) {
>>               ret = of_reserved_mem_device_init(dev);
>>               if (ret) {
>> @@ -309,7 +332,7 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
>>        * *not* in reset, but da8xx_rproc_start() needs the DSP to be
>>        * held in reset at the time it is called.
>>        */
>> -     ret = davinci_clk_reset_assert(drproc->dsp_clk);
>> +     ret = reset_control_assert(dsp_reset);
>>       if (ret)
>>               goto free_rproc;
>>
>
> Tested your previous branch, need one more change in this patch to have
> the remoteproc boot be actually executing some code. The acquired
> dsp_reset is not stored in the drproc, so the start and stop were not
> effective. The issue was masked because reset_control_assert() and
> deassert() return 0 when a NULL pointer is passed in.
>
> --- a/drivers/remoteproc/da8xx_remoteproc.c
> +++ b/drivers/remoteproc/da8xx_remoteproc.c
> @@ -311,6 +311,7 @@ static int da8xx_rproc_probe(struct platform_device
> *pdev)
>         drproc = rproc->priv;
>         drproc->rproc = rproc;
>         drproc->dsp_clk = dsp_clk;
> +       drproc->dsp_reset = dsp_reset;
>         rproc->has_iommu = false;
>
> regards
> Suman
>

Oh snap, thanks for spotting it.

I'll just resend last two patches, since the previous six will be
picked up at different places.

Thanks,
Bartosz
