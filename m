From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 12 Jan 2016 09:35:11 +0100
Subject: [PATCH] arm: irq: l2c: do not print error in case of missing l2c
 from dtb
In-Reply-To: <1452582683.7773.102.camel@perches.com>
References: <1452580473-10073-1-git-send-email-andi.shyti@samsung.com>
 <1452582683.7773.102.camel@perches.com>
Message-ID: <5694BABF.3070200@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2016-01-12 08:11, Joe Perches wrote:
> On Tue, 2016-01-12 at 15:34 +0900, Andi Shyti wrote:
>> In some architectures the L2 cache controller is integrated in the
>> processor's block itself and it doesn't use any external cache
>> controller. This means that an entry in the board's dtb related
>> to the l2c is not necessary.
>>
>> Distinguish between error codes and print just an information in
>> case of -ENODEV.
> trivia:
>
>> diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
> []
>> @@ -95,7 +95,9 @@ void __init init_IRQ(void)
>>   			outer_cache.write_sec = machine_desc->l2c_write_sec;
>>   		ret = l2x0_of_init(machine_desc->l2c_aux_val,
>>   				   machine_desc->l2c_aux_mask);
>> -		if (ret)
>> +		if (ret == -ENODEV)
>> +			pr_info("no L2C controller entry found in the dtb\n");
> Perhaps this would be more consistent if it was
> 			pr_info("L2C: no controller entry found in the dtb\n");

Frankly I see no benefit of such message. It still might confuse users 
that there
is something wrong with your DT. When driver initialization fails with 
-ENODEV,
then no message is usually displayed.

>> +		else if (ret)
>>   			pr_err("L2C: failed to init: %d\n", ret);
>>   	}
>>   
>
>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
