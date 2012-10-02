From: wade_farnsworth@mentor.com (Wade Farnsworth)
Date: Tue, 2 Oct 2012 08:43:44 -0700
Subject: [PATCH] arm: include linux/sched.h in syscall.h
In-Reply-To: <20121002122124.GB11278@mudshark.cambridge.arm.com>
References: <5069F8A0.5020801@mentor.com>
 <20121002122124.GB11278@mudshark.cambridge.arm.com>
Message-ID: <506B0BB0.5060707@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

Will Deacon wrote:
> Hi Wade,
>
> On Mon, Oct 01, 2012 at 09:10:08PM +0100, Wade Farnsworth wrote:
>> task_thread_info() is defined in linux/sched.h.  Explicitly include this
>> file in arch/arm/include/asm/syscall.h.  This fixes an lttng-modules compile error.
>
> Can you be more specific about the error? From your description, it sounds
> like it should be fixed in lttng rather than here.
>
> Cheers,
>
> Will

My apologies for the lack of clarity.

My syscall tracing patch introduces a compile bug in lttng-modules when 
the latter calls syscall_get_nr(), similar to the following:

<path-to-linux>/arch/arm/include/asm/syscall.h:21:2: error: implicit 
declaration of function 'task_thread_info' 
[-Werror=implicit-function-declaration]

The issue is that we are using task_thread_info() in the 
syscall_get_nr() function in asm/syscall.h, but not explicitly including 
sched.h from this file, so we can expect this bug might surface any time 
that syscall_get_nr() is called.

Hopefully that clarifies things somewhat.

Thanks,

Wade

>
>> Signed-off-by: Wade Farnsworth<wade_farnsworth@mentor.com>
>> ---
>>   arch/arm/include/asm/syscall.h |    1 +
>>   1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/syscall.h b/arch/arm/include/asm/syscall.h
>> index c334a23..fce38a6 100644
>> --- a/arch/arm/include/asm/syscall.h
>> +++ b/arch/arm/include/asm/syscall.h
>> @@ -8,6 +8,7 @@
>>   #define _ASM_ARM_SYSCALL_H
>>
>>   #include<linux/err.h>
>> +#include<linux/sched.h>
>>
>>   extern const unsigned long sys_call_table[];
>>
>> --
>> 1.7.0.4
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
