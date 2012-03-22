From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 22 Mar 2012 15:04:31 +0100
Subject: [PATCH] avr32: fix build failures from mis-naming of atmel_nand.h
In-Reply-To: <20120322123327.GA14690@samfundet.no>
References: <1332296128-16262-1-git-send-email-paul.gortmaker@windriver.com>
 <20120321072632.GA15703@samfundet.no> <4F6990AF.2000004@atmel.com>
 <20120322051840.GC923@windriver.com> <20120322123327.GA14690@samfundet.no>
Message-ID: <4F6B316F.5080307@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/22/2012 01:33 PM, Hans-Christian Egtvedt :
> Around Thu 22 Mar 2012 01:18:40 -0400 or thereabout, Paul Gortmaker wrote:
>> [Re: [PATCH] avr32: fix build failures from mis-naming of atmel_nand.h] On 21/03/2012 (Wed 09:26) Nicolas Ferre wrote:
>>
>>> On 03/21/2012 08:26 AM, Hans-Christian Egtvedt :
>>>> Around Tue 20 Mar 2012 22:15:28 -0400 or thereabout, Paul Gortmaker wrote:
>>>>> Commit bf4289cba02b8cf770ecd7959ca70839f0dd9d3c (linux-next)
>>>>>
>>>>>     "ATMEL: fix nand ecc support"
>>>>>
>>>>> indicated that it wanted to "Move platform data to a common
>>>>> header include/linux/platform_data/atmel_nand.h" and the new
>>>>> header even had re-include protectors with:
>>>>>
>>>>>     #ifndef __ATMEL_NAND_H__
>>>>>
>>>>> However, the file that was added was simply called atmel.h
>>>>> and this caused avr32 defconfig to fail with:
>>>>>
>>>>>   In file included from arch/avr32/boards/atstk1000/setup.c:22:
>>>>>   arch/avr32/mach-at32ap/include/mach/board.h:10:44: error: linux/platform_data/atmel_nand.h: No such file or directory
>>>>>   In file included from arch/avr32/boards/atstk1000/setup.c:22:
>>>>>   arch/avr32/mach-at32ap/include/mach/board.h:121: warning: 'struct atmel_nand_data' declared inside parameter list
>>>>>   arch/avr32/mach-at32ap/include/mach/board.h:121: warning: its scope is only this definition or declaration, which is probably not what you want
>>>>>   make[2]: *** [arch/avr32/boards/atstk1000/setup.o] Error 1
>>>>>
>>>>> Rename the file to match the original intention, and fix up the
>>>>> users who reference the bad name without the _nand suffix.
>>>>
>>>> Thanks fixing this.
>>>
>>>
>>> Yes, we need to fix this. But I would not like to see this
>>> "platform_data/atmel.h" renamed: I think that this file was designed to
>>> collect several common platform data (ie: not just NAND related).
>>>
>>> So maybe we should just rename the entry that exists in
>>> mach-at32ap/include/mach/board.h
>>> and remove all occurrences of platform_data/atmel_nand.h
>>
>> Funny, since this is what I did 1st before I re-read the original commit
>> log in more detail. :)  Oh well.  Here is the alternate solution.  You
>> guys can pick whichever one you like best.  I compile tested this one
>> as well.
> 
> I'll leave it to Nicolas to sign-off on this, but the changes look fine for
> me.

Ok, which way do you want to follow for inclusion in mainline? I take it
through arm-soc?

>> ---
>>
>> From 73c01b7ed8fd2732661fa1ca726c48096f4651f2 Mon Sep 17 00:00:00 2001
>> From: Paul Gortmaker <paul.gortmaker@windriver.com>
>> Date: Tue, 20 Mar 2012 21:55:46 -0400
>> Subject: [PATCH] avr32: fix build failures from mis-naming of atmel_nand.h
>>
>> Commit bf4289cba02b8cf770ecd7959ca70839f0dd9d3c (linux-next)
>>
>>     "ATMEL: fix nand ecc support"
>>
>> indicated that it wanted to "Move platform data to a common
>> header include/linux/platform_data/atmel_nand.h" and the new
>> header even had re-include protectors with:
>>
>>     #ifndef __ATMEL_NAND_H__
>>
>> However, the file that was added was simply called atmel.h
>> and this caused avr32 defconfig to fail with:
>>
>>   In file included from arch/avr32/boards/atstk1000/setup.c:22:
>>   arch/avr32/mach-at32ap/include/mach/board.h:10:44: error: linux/platform_data/atmel_nand.h: No such file or directory
>>   In file included from arch/avr32/boards/atstk1000/setup.c:22:
>>   arch/avr32/mach-at32ap/include/mach/board.h:121: warning: 'struct atmel_nand_data' declared inside parameter list
>>   arch/avr32/mach-at32ap/include/mach/board.h:121: warning: its scope is only this definition or declaration, which is probably not what you want
>>   make[2]: *** [arch/avr32/boards/atstk1000/setup.o] Error 1
>>
>> It seems the scope of the file contents will expand beyond
>> just nand, so ignore the original intention, and fix up the
>> users who reference the bad name with the _nand suffix.
>>
>> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
>> CC: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
>> CC: Hans-Christian Egtvedt <egtvedt@samfundet.no>
>> CC: David Woodhouse <dwmw2@infradead.org>
> 
> Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> 
>> diff --git a/arch/avr32/mach-at32ap/include/mach/board.h b/arch/avr32/mach-at32ap/include/mach/board.h
>> index 7173386..70742ec 100644
>> --- a/arch/avr32/mach-at32ap/include/mach/board.h
>> +++ b/arch/avr32/mach-at32ap/include/mach/board.h
>> @@ -7,7 +7,7 @@
>>  #include <linux/types.h>
>>  #include <linux/serial.h>
>>  #include <linux/platform_data/macb.h>
>> -#include <linux/platform_data/atmel_nand.h>
>> +#include <linux/platform_data/atmel.h>
>>  
>>  #define GPIO_PIN_NONE	(-1)
>>  
>> diff --git a/include/linux/platform_data/atmel.h b/include/linux/platform_data/atmel.h
>> index d056263..b0f2c56 100644
>> --- a/include/linux/platform_data/atmel.h
>> +++ b/include/linux/platform_data/atmel.h
>> @@ -4,8 +4,8 @@
>>   * GPL v2 Only
>>   */
>>  
>> -#ifndef __ATMEL_NAND_H__
>> -#define __ATMEL_NAND_H__
>> +#ifndef __ATMEL_H__
>> +#define __ATMEL_H__
>>  
>>  #include <linux/mtd/nand.h>
>>  
>> @@ -24,4 +24,4 @@ struct atmel_nand_data {
>>  	unsigned int	num_parts;
>>  };
>>  
>> -#endif /* __ATMEL_NAND_H__ */
>> +#endif /* __ATMEL_H__ */


-- 
Nicolas Ferre
