From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 21 Mar 2013 20:04:12 +0800
Subject: [PATCH] dmaengine:sirf:take clock and enable it while probing
In-Reply-To: <20130321100716.GP10326@intel.com>
References: <1363595623-6887-1-git-send-email-Barry.Song@csr.com>
 <20130321100716.GP10326@intel.com>
Message-ID: <CAGsJ_4wrkfpW7txzsje11A624Dpg0J8o5gzxwTe3G17_OY0msA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

2013/3/21 Vinod Koul <vinod.koul@intel.com>:
> On Mon, Mar 18, 2013 at 04:33:43PM +0800, Barry Song wrote:
>> From: Barry Song <Baohua.Song@csr.com>
>>
>> there is hardcode which enabled the clock of dmaengine before,
>> this patch takes the clock by standard clock API and enable it
>> in probe.
>>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>> ---
>>  drivers/dma/sirf-dma.c |   11 +++++++++++
>>  1 files changed, 11 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/dma/sirf-dma.c b/drivers/dma/sirf-dma.c
>> index 1d627e2..c439529 100644
>> --- a/drivers/dma/sirf-dma.c
>> +++ b/drivers/dma/sirf-dma.c
>> @@ -16,6 +16,7 @@
>>  #include <linux/of_address.h>
>>  #include <linux/of_device.h>
>>  #include <linux/of_platform.h>
>> +#include <linux/clk.h>
>>  #include <linux/sirfsoc_dma.h>
>>
>>  #include "dmaengine.h"
>> @@ -78,6 +79,7 @@ struct sirfsoc_dma {
>>       struct sirfsoc_dma_chan         channels[SIRFSOC_DMA_CHANNELS];
>>       void __iomem                    *base;
>>       int                             irq;
>> +     struct clk                      *clk;
>>       bool                            is_marco;
>>  };
>>
>> @@ -639,6 +641,12 @@ static int sirfsoc_dma_probe(struct platform_device *op)
>>               return -EINVAL;
>>       }
>>
>> +     sdma->clk = devm_clk_get(dev, NULL);
> NULL? Arent you supposed to send a avlid non global string with. It may work now
> but do you really want to go that path?

yes. the NULL is right. the binding between clock and device has been mapped.
>
>> +     if (IS_ERR(sdma->clk)) {
>> +             dev_err(dev, "failed to get a clock.\n");
>> +             return PTR_ERR(sdma->clk);
>> +     }
>> +
>>       ret = of_address_to_resource(dn, 0, &res);
>>       if (ret) {
>>               dev_err(dev, "Error parsing memory region!\n");
>> @@ -698,6 +706,8 @@ static int sirfsoc_dma_probe(struct platform_device *op)
>>
>>       tasklet_init(&sdma->tasklet, sirfsoc_dma_tasklet, (unsigned long)sdma);
>>
>> +     clk_prepare_enable(sdma->clk);
> shouldnt you be enabling clock when you start a txn. Keeping clock on in probe
> doesnt seem too smart

currently we don't have runtime PM tested and supported yet. so i'd
like to handle this in runtime PM callbacks later.
for the moment, i prefer we have enable/disable in probing/removing
like most drivers which don't have runtime pm at first.

>
>> +
>>       /* Register DMA engine */
>>       dev_set_drvdata(dev, sdma);
>>       ret = dma_async_device_register(dma);
>> @@ -720,6 +730,7 @@ static int sirfsoc_dma_remove(struct platform_device *op)
>>       struct device *dev = &op->dev;
>>       struct sirfsoc_dma *sdma = dev_get_drvdata(dev);
>>
>> +     clk_disable_unprepare(sdma->clk);
>>       dma_async_device_unregister(&sdma->dma);
>>       free_irq(sdma->irq, sdma);
>>       irq_dispose_mapping(sdma->irq);
>> --
>> 1.7.5.4
>>
>>
-barry
