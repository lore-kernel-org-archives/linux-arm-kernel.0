From: herve.codina@celad.com (Herve Codina)
Date: Thu, 6 Mar 2014 18:42:05 +0100
Subject: nand pmecc crash detected
In-Reply-To: <5313FACC.8030202@atmel.com>
References: <5310B108.8040800@celad.com> <5313FACC.8030202@atmel.com>
Message-ID: <5318B36D.4020700@celad.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Josh

As suggested, i made a patch and sent it this week to
linux-mtd at lists.infradead.org and linux-arm-kernel at lists.infradead.org.
Hope you have seen it. Is subject is : "[PATCH] Disable Subpage nand
write when using Atmel PMECC".

Best regards,
Herve




Le 03/03/2014 04:45, Josh Wu a ?crit :
> Dear Herve
> 
> On 2/28/2014 11:53 PM, Herve Codina wrote:
>> Hi,
>>
>> I am using an sam5d35 and its pmecc nand ecc controller.
>>
>> In barebox, using similar atmel_nand.c the system crashes.
>>
>> The problem was a call to chip->ecc.hwctl from nand_write_subpage_hwecc
>> (nand_base.c) when we write a sub page.
>>
>> chip->ecc.hwctl function is not set when we are using PMECC controller.
>>
>> As a workaround, i set NAND_NO_SUBPAGE_WRITE for PMECC controller in
>> order to disable sub page access in nand_write_page.
>>
>> I think we can have the same problem in Linux. I do not performed
>> subpage nand writes from Linux but i made the following patch according
>> to my Barebox defect.
> 
> Thank you for catching this crash bug. The fix is fine for me. But I 
> think it's better to send out the Linux kernel patch alone.
> 
> You can rebase your patch on the top of Linux-mtd git 
> repo(git://git.infradead.org/l2-mtd.git) instead of your local Linux.
> Then use 'git send-email' send to linux-mtd at lists.infradead.org and 
> linux-arm-kernel at lists.infradead.org. I will ack your patch.
> 
> If the patch is merged in Linux-mtd, it should be easier port to barebox 
> then.
> 
>>
>> Here after are my patches (same modification) for 1st my local Barebox
>> and 2nd my local Linux :
>>
>> ---8<-------------------
>>  From 757e8dbf141619a55b7a5b1ca11780b2589eacc1 Mon Sep 17 00:00:00 2001
>> From: Herve Codina <Herve.CODINA@celad.com>
>> Date: Fri, 28 Feb 2014 08:39:08 +0100
>> Subject: [PATCH 5/5] Disable Subpage nand write when using Atmel PMECC.
>>
>>
>> Signed-off-by: Herve Codina <Herve.CODINA@celad.com>
>> ---
>>   drivers/mtd/nand/atmel_nand.c |    1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
>> index 2ff7427..cdbe685 100644
>> --- a/drivers/mtd/nand/atmel_nand.c
>> +++ b/drivers/mtd/nand/atmel_nand.c
>> @@ -837,6 +837,7 @@ static int __init
>> atmel_pmecc_nand_init_params(struct device_d *dev,
>>   		return err_no;
>>   	}
>>
>> +	nand_chip->options |= NAND_NO_SUBPAGE_WRITE;
>>   	nand_chip->ecc.read_page = atmel_nand_pmecc_read_page;
>>   	nand_chip->ecc.write_page = atmel_nand_pmecc_write_page;
>>
> 
> Best Regards,
> Josh Wu
> 
