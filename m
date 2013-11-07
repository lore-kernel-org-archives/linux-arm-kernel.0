From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Thu, 7 Nov 2013 18:27:56 +0200
Subject: [PATCH v4] ARM: omap: edma: add suspend suspend/resume hooks
In-Reply-To: <527BB307.7090401@ti.com>
References: <1383164468-4610-1-git-send-email-zonque@gmail.com>
 <527BB307.7090401@ti.com>
Message-ID: <527BBF8C.4060409@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/07/2013 05:34 PM, Nishanth Menon wrote:
> On 10/30/2013 03:21 PM, Daniel Mack wrote:
> [...]
>> diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
>> index 8e1a024..f15cdb9 100644
>> --- a/arch/arm/common/edma.c
>> +++ b/arch/arm/common/edma.c
>
> [...]
>
>> +static int edma_pm_suspend(struct device *dev)
>> +{
>> +	int j;
>> +
>> +	pm_runtime_get_sync(dev);
>> +
> error checks?
>> +	for (j = 0; j < arch_num_cc; j++) {
>> +		struct edma *ecc = edma_cc[j];
>> +
>> +		disable_irq(ecc->irq_res_start);
>> +		disable_irq(ecc->irq_res_end);
>> +	}
>> +
>> +	pm_runtime_put_sync(dev);

Also, it make no sense to call pm_runtime_putXXX() in suspend handlers
- it will not work because PM core calls pm_runtime_get_noresume()
from device_prepare().

Now, for OMAP the edma Device will be finally disabled by OMAP device 
core at suspend_noirq stage (if it's connected to HW_mode).
But, in other cases it need to be handled somehow :)

>> +
>> +	return 0;
>> +}
>> +
>> +static int edma_pm_resume(struct device *dev)
>> +{
>> +	int i, j;
>> +
>> +	pm_runtime_get_sync(dev);
> error checks?
>
> [...]
>
>
