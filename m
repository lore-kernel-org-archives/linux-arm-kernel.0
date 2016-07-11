From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Mon, 11 Jul 2016 15:03:37 -0700
Subject: [PATCH v2 15/22] usb: chipidea: msm: Mux over secondary phy at
 the right time
In-Reply-To: <20160711044327.GG30448@shlinux2>
References: <20160707222114.1673-1-stephen.boyd@linaro.org>
 <20160707222114.1673-16-stephen.boyd@linaro.org>
 <20160711044327.GG30448@shlinux2>
Message-ID: <CAJOFmgzxYutvxhBbmmYyuDd9PTgpDskzHTvCUGteATPEFTU31g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 July 2016 at 21:43, Peter Chen <hzpeterchen@gmail.com> wrote:
> On Thu, Jul 07, 2016 at 03:21:06PM -0700, Stephen Boyd wrote:
>> diff --git a/drivers/usb/chipidea/ci_hdrc_msm.c b/drivers/usb/chipidea/ci_hdrc_msm.c
>> index 7e870a253f55..7708bee3ff3e 100644
>> --- a/drivers/usb/chipidea/ci_hdrc_msm.c
>> +++ b/drivers/usb/chipidea/ci_hdrc_msm.c
>> @@ -8,29 +8,44 @@
>>  #include <linux/module.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/pm_runtime.h>
>> -#include <linux/usb/gadget.h>
>>  #include <linux/usb/chipidea.h>
>>  #include <linux/clk.h>
>>  #include <linux/reset.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/regmap.h>
>> +#include <linux/io.h>
>>
>>  #include "ci.h"
>>
>>  #define HS_PHY_AHB_MODE                      0x0098
>>
>> +/* Vendor base starts at 0x200 beyond CI base */
>> +#define HS_PHY_SEC_CTRL                      0x0078
>> +#define HS_PHY_DIG_CLAMP_N           BIT(16)
>> +
>
> Keep alignment

It's aligned in my editor, tabs vs. spaces problem?

>> @@ -123,9 +177,12 @@ static int ci_hdrc_msm_probe(struct platform_device *pdev)
>>       if (ret)
>>               goto err_iface;
>>
>> -     plat_ci = ci_hdrc_add_device(&pdev->dev,
>> -                             pdev->resource, pdev->num_resources,
>> -                             &ci_hdrc_msm_platdata);
>> +     ret = ci_hdrc_msm_mux_phy(ci, pdev);
>> +     if (ret)
>> +             goto err_mux;
>> +
>> +     plat_ci = ci_hdrc_add_device(&pdev->dev, pdev->resource,
>> +                                  pdev->num_resources, &ci_hdrc_msm_platdata);
>
> The above line has not changed.

Fixed.
