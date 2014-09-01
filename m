From: guodong.xu@linaro.org (Guodong Xu)
Date: Mon, 01 Sep 2014 16:17:10 +0800
Subject: [PATCH 2/3] mfd: Add hi6421 PMIC core driver
In-Reply-To: <20140827141127.GA24579@lee--X1>
References: <1408973982-2072-1-git-send-email-guodong.xu@linaro.org>
 <1408973982-2072-3-git-send-email-guodong.xu@linaro.org>
 <20140827141127.GA24579@lee--X1>
Message-ID: <54042B86.4060008@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/27/2014 10:11 PM, Lee Jones wrote:
>> This adds driver to support HiSilicon Hi6421 PMIC. Hi6421 includes multi-
>> functions, such as regulators, codec, ADCs, Coulomb counter, etc.
>> This driver includes core APIs _only_.
>>
>> Drivers for individul components, like voltage regulators, are
>> implemented in corresponding driver directories and files.
>>
>> Registers in Hi6421 are memory mapped, so using regmap-mmio API.
>>
>> Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
>> ---
> 
> The patch is missing version information normally indicated to in the
> ?SUBJECT line with a full description added here.  This looks like a
> first submission, but we both know that it's not. 
> 

Ok. I will add it back, continuing the versions. Actually I purposely
restarted version number in this submission because the Hi6421 regulator
driver part has been accepted in v5, so this patchset is not inheriting
'exactly' to the previous ones. But seems I am thinking in a wrong way.

I will take this as my v7. And next patchset I send will be v8.

Thanks.

>>  drivers/mfd/Kconfig             |  13 +++++
>>  drivers/mfd/Makefile            |   1 +
>>  drivers/mfd/hi6421-pmic-core.c  | 112 ++++++++++++++++++++++++++++++++++++++++
>>  include/linux/mfd/hi6421-pmic.h |  42 +++++++++++++++
>>  4 files changed, 168 insertions(+)
>>  create mode 100644 drivers/mfd/hi6421-pmic-core.c
>>  create mode 100644 include/linux/mfd/hi6421-pmic.h
> 
> [...]
> 
>> diff --git a/drivers/mfd/hi6421-pmic-core.c b/drivers/mfd/hi6421-pmic-core.c
>> new file mode 100644
>> index 0000000..c6cba8f
>> --- /dev/null
>> +++ b/drivers/mfd/hi6421-pmic-core.c
>> @@ -0,0 +1,112 @@
> 
> [...]
> 
>> +#include <linux/device.h>
>> +#include <linux/err.h>
>> +#include <linux/mfd/core.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +#include <linux/mfd/hi6421-pmic.h>
>> +
>> +static struct of_device_id of_hi6421_pmic_match_tbl[] = {
>> +	{ .compatible = "hisilicon,hi6421-pmic", },
>> +	{ },
>> +};
> 
> Unless you're going to use this to of_match() on in future, this
> should be down by the definition of 'struct platform_driver'.
> 

Ok, Will do.

>> +static int hi6421_pmic_probe(struct platform_device *pdev)
>> +{
> 
> [...]
> 
>> +	/* set over-current protection debounce 8ms */
>> +	regmap_update_bits(pmic->regmap, HI6421_OCP_DEB_CTRL_REG,
>> +		(HI6421_OCP_DEB_SEL_MASK | HI6421_OCP_EN_DEBOUNCE_MASK |
>> +		 HI6421_OCP_AUTO_STOP_MASK),
>> +		(HI6421_OCP_DEB_SEL_8MS | HI6421_OCP_EN_DEBOUNCE_ENABLE));
> 
> These might read a little better stacked and aligned.
>

Will do.

>
>> +	pmic->dev = &pdev->dev;
>
> Can't you retrieve this via dev->parent?
>

It is not used. I will remove dev from 'struct hi6421_pmic'.

Thanks.

Best regards,
Guodong Xu
