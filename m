From: preid@electromag.com.au (Phil Reid)
Date: Thu, 15 Dec 2016 22:11:06 +0800
Subject: [PATCH v2] i2c: designware: add reset interface
In-Reply-To: <1481805227.9552.15.camel@linux.intel.com>
References: <1479789700-19532-1-git-send-email-zhangfei.gao@linaro.org>
 <1481792388-13781-1-git-send-email-zhangfei.gao@linaro.org>
 <1481805227.9552.15.camel@linux.intel.com>
Message-ID: <66e86b18-c6d5-4290-5e93-dcae50596da6@electromag.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/12/2016 20:33, Andy Shevchenko wrote:
> On Thu, 2016-12-15 at 16:59 +0800, Zhangfei Gao wrote:
>> Some platforms like hi3660 need do reset first to allow accessing
>> registers
>
> Patch itself looks good, but would be nice to have it tested.
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
>>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>> ---
>>  drivers/i2c/busses/i2c-designware-core.h    |  1 +
>>  drivers/i2c/busses/i2c-designware-platdrv.c | 28
>> ++++++++++++++++++++++++----
>>  2 files changed, 25 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-designware-core.h
>> b/drivers/i2c/busses/i2c-designware-core.h
>> index 0d44d2a..94b14fa 100644
>> --- a/drivers/i2c/busses/i2c-designware-core.h
>> +++ b/drivers/i2c/busses/i2c-designware-core.h
>> @@ -80,6 +80,7 @@ struct dw_i2c_dev {
>>  	void __iomem		*base;
>>  	struct completion	cmd_complete;
>>  	struct clk		*clk;
>> +	struct reset_control	*rst;
>>  	u32			(*get_clk_rate_khz) (struct
>> dw_i2c_dev *dev);
>>  	struct dw_pci_controller *controller;
>>  	int			cmd_err;
>> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c
>> b/drivers/i2c/busses/i2c-designware-platdrv.c
>> index 0b42a12..e9016ae 100644
>> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
>> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
>> @@ -38,6 +38,7 @@
>>  #include <linux/pm_runtime.h>
>>  #include <linux/property.h>
>>  #include <linux/io.h>
>> +#include <linux/reset.h>
>>  #include <linux/slab.h>
>>  #include <linux/acpi.h>
>>  #include <linux/platform_data/i2c-designware.h>
>> @@ -176,6 +177,14 @@ static int dw_i2c_plat_probe(struct
>> platform_device *pdev)
>>  	dev->irq = irq;
>>  	platform_set_drvdata(pdev, dev);
>>
>> +	dev->rst = devm_reset_control_get_optional(&pdev->dev, NULL);
>> +	if (IS_ERR(dev->rst)) {
>> +		if (PTR_ERR(dev->rst) == -EPROBE_DEFER)
>> +			return -EPROBE_DEFER;
>> +	} else {
>> +		reset_control_deassert(dev->rst);
>> +	}
>> +
More for my education. But some drivers seem to handle the error codes a little more explicitly.
Whats the best approach?

eg: From usb/dwc2 driver it continues only if ENOENT / ENOTSUPP errors are return
and ENOMEM / EINVAL etc is a fatal error.

hsotg->reset = devm_reset_control_get_optional(hsotg->dev, "dwc2");
if (IS_ERR(hsotg->reset)) {
         ret = PTR_ERR(hsotg->reset);
         switch (ret) {
         case -ENOENT:
         case -ENOTSUPP:
                 hsotg->reset = NULL;
                 break;
         default:
                 dev_err(hsotg->dev, "error getting reset control %d\n",
                         ret);
                 return ret;
         }
}

if (hsotg->reset)
         reset_control_deassert(hsotg->reset);

Regards
Phil
