From: stefan@agner.ch (Stefan Agner)
Date: Sun, 25 Mar 2018 20:19:09 +0200
Subject: [PATCH v2 1/6] bus: arm-cci: use asm unreachable
In-Reply-To: <nycvar.YSQ.7.76.1803251413010.19824@knanqh.ubzr>
References: <20180325180959.28008-1-stefan@agner.ch>
 <20180325180959.28008-2-stefan@agner.ch>
 <nycvar.YSQ.7.76.1803251413010.19824@knanqh.ubzr>
Message-ID: <bf915fd9ba981f9ab4c720e897c06b16@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25.03.2018 20:14, Nicolas Pitre wrote:
> On Sun, 25 Mar 2018, Stefan Agner wrote:
> 
>> Mixing asm and C code is not recommended in a naked function by
>> gcc and leads to an error when using clang:
>>   drivers/bus/arm-cci.c:2107:2: error: non-ASM statement in naked
>>   function is not supported
>>         unreachable();
>>         ^
>>
>> While the function is marked __naked it actually properly return
>> in asm. There is no need for the unreachable() call.
>>
>> Suggested-by: Russell King <linux@arm.linux.org.uk>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
> 
> If that doesn't introduce any warning with gcc then I'm fine with it.
> 

At least with GCC 6.2 it did not introduce a new warning with gcc.

> Acked-by: Nicolas Pitre <nico@linaro.org>

Thanks!

--
Stefan

> 
> 
>> ---
>> Changes in v2:
>> - Don't add assembly ASM_UNREACHABLE, just drop unreachable()
>>
>>  drivers/bus/arm-cci.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
>> index 5426c04fe24b..fc2da3a617ac 100644
>> --- a/drivers/bus/arm-cci.c
>> +++ b/drivers/bus/arm-cci.c
>> @@ -2103,8 +2103,6 @@ asmlinkage void __naked cci_enable_port_for_self(void)
>>  	[sizeof_struct_cpu_port] "i" (sizeof(struct cpu_port)),
>>  	[sizeof_struct_ace_port] "i" (sizeof(struct cci_ace_port)),
>>  	[offsetof_port_phys] "i" (offsetof(struct cci_ace_port, phys)) );
>> -
>> -	unreachable();
>>  }
>>
>>  /**
>> --
>> 2.16.2
>>
>>
