From: zhangfei.gao@linaro.org (zhangfei)
Date: Fri, 16 Dec 2016 10:45:02 +0800
Subject: [PATCH v2] i2c: designware: add reset interface
In-Reply-To: <fda7e3ef-5bc1-9837-b421-4293baa3de34@synopsys.com>
References: <1479789700-19532-1-git-send-email-zhangfei.gao@linaro.org>
 <1481792388-13781-1-git-send-email-zhangfei.gao@linaro.org>
 <1481805227.9552.15.camel@linux.intel.com>
 <fda7e3ef-5bc1-9837-b421-4293baa3de34@synopsys.com>
Message-ID: <fd0afd5f-6ee4-a06f-2d03-444f71662c1b@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016?12?15? 23:30, Ramiro Oliveira wrote:
> Hi Andy and Zhangfei
>
> On 12/15/2016 12:33 PM, Andy Shevchenko wrote:
>> On Thu, 2016-12-15 at 16:59 +0800, Zhangfei Gao wrote:
>>> Some platforms like hi3660 need do reset first to allow accessing
>>> registers
>> Patch itself looks good, but would be nice to have it tested.
>>
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>
> I tested the patch and it's working for the ARC architecture.
>
>>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>>> ---
>>>   drivers/i2c/busses/i2c-designware-core.h    |  1 +
>>>   drivers/i2c/busses/i2c-designware-platdrv.c | 28
>>> ++++++++++++++++++++++++----
>>>   2 files changed, 25 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/i2c/busses/i2c-designware-core.h
>>> b/drivers/i2c/busses/i2c-designware-core.h
>>> index 0d44d2a..94b14fa 100644
>>> --- a/drivers/i2c/busses/i2c-designware-core.h
>>> +++ b/drivers/i2c/busses/i2c-designware-core.h
>>> @@ -80,6 +80,7 @@ struct dw_i2c_dev {
>>>   	void __iomem		*base;
>>>   	struct completion	cmd_complete;
>>>   	struct clk		*clk;
>>> +	struct reset_control	*rst;
>>>   	u32			(*get_clk_rate_khz) (struct
>>> dw_i2c_dev *dev);
>>>   	struct dw_pci_controller *controller;
>>>   	int			cmd_err;
>>> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c
>>> b/drivers/i2c/busses/i2c-designware-platdrv.c
>>> index 0b42a12..e9016ae 100644
>>> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
>>> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
>>> @@ -38,6 +38,7 @@
>>>   #include <linux/pm_runtime.h>
>>>   #include <linux/property.h>
>>>   #include <linux/io.h>
>>> +#include <linux/reset.h>
>>>   #include <linux/slab.h>
>>>   #include <linux/acpi.h>
>>>   #include <linux/platform_data/i2c-designware.h>
>>> @@ -176,6 +177,14 @@ static int dw_i2c_plat_probe(struct
>>> platform_device *pdev)
>>>   	dev->irq = irq;
>>>   	platform_set_drvdata(pdev, dev);
>>>   
>>> +	dev->rst = devm_reset_control_get_optional(&pdev->dev, NULL);
> devm_reset_control_get_optional() is deprecated as explained in linux/reset.h,
> you should use devm_reset_control_get_optional_exclusive() or
> devm_reset_control_get_optional_shared() instead, as applicable.
>
> I submitted a similar patch earlier today and I made the same mistake.

Thanks Ramiro for the info
Will use devm_reset_control_get_optional_exclusive instead.
But should the interface be as simple as possible?

Thanks
