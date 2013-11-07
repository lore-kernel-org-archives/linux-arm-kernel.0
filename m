From: josh.wu@atmel.com (Josh Wu)
Date: Thu, 7 Nov 2013 18:26:39 +0800
Subject: [PATCH] mtd: atmel_nand: fix bug driver will in a dead lock if
 no nand detected
In-Reply-To: <20131107083932.GJ3805@norris.computersforpeace.net>
References: <1383645547-21813-1-git-send-email-josh.wu@atmel.com>
 <20131107083932.GJ3805@norris.computersforpeace.net>
Message-ID: <527B6ADF.1090201@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Brian

On 11/7/2013 4:39 PM, Brian Norris wrote:
> Hi Josh,
>
> On Tue, Nov 05, 2013 at 05:59:07PM +0800, Josh Wu wrote:
>> In the atmel driver probe function, the code shows like following:
>>    atmel_nand_probe(...) {
>>          ...
>>
>>    err_nand_ioremap:
>>          platform_driver_unregister(&atmel_nand_nfc_driver);
>>          return res;
>>    }
>>
>> If no nand flash detected, the driver probe function will goto
>> err_nand_ioremap label.
>> Then platform_driver_unregister() will be called. It will get the
>> lock of atmel_nand device since it is parent of nfc_device. The
>> problem is the lock is already hold by atmel_nand_probe itself.
>> So system will be in a dead lock.
>>
>> This patch just simply removed to platform_driver_unregister() call.
>> When atmel_nand driver is quit the platform_driver_unregister() will
>> be called in atmel_nand_remove().
> The real key, here, is that the platform-driver probe() has no business
> un-registering another driver, right?

right.

> Shouldn't both drivers just be
> registered/unregistered in the module init/exit, and not in probe()?

currently the NFC driver is registered in the beginning of nand probe 
function. After NFC driver is initialized, the rest of the nand probe 
function
will check the NFC driver status.
I am not sure it is proper to registered another driver in a probe().

>
> Also, should this be marked for -stable?

Shouldn't cc to stable after the patch is merged in mtd mail list?

Best Regards,
Josh Wu

>
>> Signed-off-by: Josh Wu <josh.wu@atmel.com>
>> ---
>>   drivers/mtd/nand/atmel_nand.c |    1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
>> index ef9c9f5..469d4e2 100644
>> --- a/drivers/mtd/nand/atmel_nand.c
>> +++ b/drivers/mtd/nand/atmel_nand.c
>> @@ -2142,7 +2142,6 @@ err_no_card:
>>   	if (host->dma_chan)
>>   		dma_release_channel(host->dma_chan);
>>   err_nand_ioremap:
>> -	platform_driver_unregister(&atmel_nand_nfc_driver);
>>   	return res;
>>   }
>>   
> Brian
