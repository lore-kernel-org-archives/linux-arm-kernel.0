From: aryabinin@virtuozzo.com (Andrey Ryabinin)
Date: Thu, 18 Feb 2016 14:45:31 +0300
Subject: KASAN issues with idle / hotplug area
In-Reply-To: <20160218093938.GB12476@red-moon>
References: <56BDFC86.5010705@arm.com>
 <20160212160652.GL31665@e104818-lin.cambridge.arm.com>
 <56C1E072.2090909@virtuozzo.com>
 <20160215185957.GB19413@e104818-lin.cambridge.arm.com>
 <56C31D1D.50708@virtuozzo.com> <20160217143950.GC32647@leverpostej>
 <20160217170110.GE32647@leverpostej> <20160217175656.GJ32647@leverpostej>
 <20160217191643.GK32647@leverpostej> <56C57F40.3050500@virtuozzo.com>
 <20160218093938.GB12476@red-moon>
Message-ID: <56C5AEDB.1070507@virtuozzo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/18/2016 12:39 PM, Lorenzo Pieralisi wrote:
> On Thu, Feb 18, 2016 at 11:22:24AM +0300, Andrey Ryabinin wrote:
> 
> [...]
> 
>>> I also tried using __attribute__((no_sanitize_address)) directly, in
>>> case there was some header issue, but that doesn't seem to be the case.
>>>
>>> I'm using the Linaro 15.08 AArch64 GCC 5.1. Is anyone else able to
>>> confirm whether they see the same? Does the same happen for x86?
>>>
>>
>> Confirming, this happens on every GCC I have (including x86).
>> It seems that 'no_sanitize_address' in gcc removes only memory access checks
>> but it doesn't remove stack redzones.
>> I think this is wrong, e.g. clang removes instrumentation completely. I'll submit a bug.
>>
>> But we need fix this in kernel.
>> I see two options here:
>>  * completely disable instrumentation for drivers/firmware/psci.c
> 
> We have to have a way to disable instrumentation for functions that
> are used to call into FW and return via different code paths.
> 

Unfortunately gcc doesn't allow us to do this yet.


>>  * get back to assembly implementation
> 
> No, we are certainly not reverting the SMCCC work because Kasan adds
> instrumentation to C functions, that's not even an option.
> 
> Is it possible at all to implement a function to remove instrumentation
> for a chunk of memory (ie resetting the shadow memory to a clean slate
> for a range of stack addresses) ?
> 


Yes, that's possible. We can tell that function resume SP, it can zero out all shadow for stack bellow that SP.

> Thanks,
> Lorenzo
> 
