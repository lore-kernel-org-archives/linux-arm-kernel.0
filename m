From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Tue, 31 Jul 2018 09:55:24 +0200
Subject: [PATCH v7 1/4] remoteproc/davinci: use the reset framework
In-Reply-To: <20180731042539.GE5090@builder>
References: <20180621073706.22812-1-brgl@bgdev.pl>
 <20180621073706.22812-2-brgl@bgdev.pl>
 <20180731042539.GE5090@builder>
Message-ID: <CAMRc=MdwCruRZ_EQ3Pzq-=HdhiA6pfSZczRKMa5i9Rju0JgHig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-07-31 6:25 GMT+02:00 Bjorn Andersson <bjorn.andersson@linaro.org>:
> On Thu 21 Jun 00:37 PDT 2018, Bartosz Golaszewski wrote:
>
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> Switch to using the reset framework instead of handcoded reset routines
>> we used so far.
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> Reviewed-by: Sekhar Nori <nsekhar@ti.com>
>> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
>
> Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>

Sekhar,

can you take this through your tree or is it already too late?

Bart

> Regards,
> Bjorn
>
>> ---
>>  drivers/remoteproc/da8xx_remoteproc.c | 34 +++++++++++++++++++++++----
>>  1 file changed, 29 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
>> index b668e32996e2..76c06b70a1c6 100644
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
>> @@ -287,6 +310,7 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
>>       drproc = rproc->priv;
>>       drproc->rproc = rproc;
>>       drproc->dsp_clk = dsp_clk;
>> +     drproc->dsp_reset = dsp_reset;
>>       rproc->has_iommu = false;
>>
>>       ret = da8xx_rproc_get_internal_memories(pdev, drproc);
>> @@ -309,7 +333,7 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
>>        * *not* in reset, but da8xx_rproc_start() needs the DSP to be
>>        * held in reset at the time it is called.
>>        */
>> -     ret = davinci_clk_reset_assert(drproc->dsp_clk);
>> +     ret = reset_control_assert(dsp_reset);
>>       if (ret)
>>               goto free_rproc;
>>
>> --
>> 2.17.1
>>
