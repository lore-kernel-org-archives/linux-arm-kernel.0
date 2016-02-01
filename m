From: majun258@huawei.com (majun (F))
Date: Mon, 1 Feb 2016 21:06:38 +0800
Subject: [RFC PATCH] irq/mbigen:Fix the problem of IO remap for duplicated
 physical address in mbigen driver
In-Reply-To: <20160201115717.GD674@leverpostej>
References: <1454327094-7848-1-git-send-email-majun258@huawei.com>
 <20160201115717.GD674@leverpostej>
Message-ID: <56AF585E.6050005@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2016/2/1 19:57, Mark Rutland ??:
> On Mon, Feb 01, 2016 at 07:44:54PM +0800, MaJun wrote:
>> From: Ma Jun <majun258@huawei.com>
>>
>> For mbigen module, there is a special case that more than one mbigen 
>> device nodes use the same reg definition in DTS when these devices
>> exist in the same mbigen hardware module. 
>>
>> mbigen_dev1:intc_dev1 {
>> 	...
>> 	reg = <0x0 0xc0080000 0x0 0x10000>;
>> 	...
>> };
>>
>> mbigen_dev2:intc_dev2 {
>> 	...
>> 	reg = <0x0 0xc0080000 0x0 0x10000>;
>> 	...
>> };
> 
> This doesn't sound right. If they exist in the same place, and have the
> same reg, they _are_ the same device.
> 
> You'll need to explain this better.
> 

For a mbigen hardware module which connecte with several devices,
because these devices has different device ID,
I need to define a device node for each device in DTS file.

	mbigen
	|
------------------
| 	| 	|
dev1 	dev2 	dev3

Because of register layout,the registers related with these devices
are put together, I can't split them clearly.
So, I only make these devices which connect with
same mbigen hardware module usethe same address.

>> On this case, devm_ioremap_resource() returns fail with info
>> "can't request region for resource" because of memory region check.
>>
>> Because we only need to program 1 into corresponding bit into status 
>> register of mbigen to clear the interrupt status during runtime,
>> I think we can replace devm_ioremap_resource() by devm_ioremap().
>>
>> Signed-off-by: Ma Jun <majun258@huawei.com>
>> ---
>>  drivers/irqchip/irq-mbigen.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
>> index 4dd3eb8..b19e528 100644
>> --- a/drivers/irqchip/irq-mbigen.c
>> +++ b/drivers/irqchip/irq-mbigen.c
>> @@ -250,7 +250,7 @@ static int mbigen_device_probe(struct platform_device *pdev)
>>  	mgn_chip->pdev = pdev;
>>  
>>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> -	mgn_chip->base = devm_ioremap_resource(&pdev->dev, res);
>> +	mgn_chip->base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
> 
> These two behaving differently doesn't seem correct either...

The problem is caused by memory region check fail because of duplicated address in devm_ioremap_resource().
For mbigen special case, there is no necessary to do this check.

Thanks
Ma Jun
> 
> Mark.
> 
>>  	if (IS_ERR(mgn_chip->base))
>>  		return PTR_ERR(mgn_chip->base);
>>  
>> -- 
>> 1.7.1
>>
>>
> 
> .
> 
