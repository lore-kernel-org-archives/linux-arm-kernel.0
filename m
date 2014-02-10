From: lauraa@codeaurora.org (Laura Abbott)
Date: Sun, 09 Feb 2014 19:25:34 -0800
Subject: [PATCHv2 2/2] arm: Get rid of meminfo
In-Reply-To: <20140207020949.GQ1706@sonymobile.com>
References: <1391558551-31395-1-git-send-email-lauraa@codeaurora.org>
 <1391558551-31395-3-git-send-email-lauraa@codeaurora.org>
 <20140207020949.GQ1706@sonymobile.com>
Message-ID: <52F846AE.3050800@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/6/2014 6:09 PM, Courtney Cavin wrote:
> On Wed, Feb 05, 2014 at 01:02:31AM +0100, Laura Abbott wrote:
>> memblock is now fully integrated into the kernel and is the prefered
>> method for tracking memory. Rather than reinvent the wheel with
>> meminfo, migrate to using memblock directly instead of meminfo as
>> an intermediate.
>>
>> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
> [...]
>> diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
>> index 0b11c1a..51d814e 100644
>> --- a/arch/arm/mach-pxa/spitz.c
>> +++ b/arch/arm/mach-pxa/spitz.c
>> @@ -32,6 +32,7 @@
>>   #include <linux/io.h>
>>   #include <linux/module.h>
>>   #include <linux/reboot.h>
>> +#include <linux/memblock.h>
>>
>>   #include <asm/setup.h>
>>   #include <asm/mach-types.h>
>> @@ -971,13 +972,9 @@ static void __init spitz_init(void)
>>          spitz_i2c_init();
>>   }
>>
>> -static void __init spitz_fixup(struct tag *tags, char **cmdline,
>> -                              struct meminfo *mi)
>> +static void __init spitz_fixup(struct tag *tags, char **cmdline)
>>   {
>> -       sharpsl_save_param();
>> -       mi->nr_banks = 1;
>> -       mi->bank[0].start = 0xa0000000;
>> -       mi->bank[0].size = (64*1024*1024);
>> +       memblock_addr(0xa0000000, SZ_64M);
>
> memblock_add() ?
Yes, that was a typo on my part. I'll send out a v3 with collected acks.

>
> -Courtney
>


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
