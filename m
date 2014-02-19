From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed, 19 Feb 2014 20:16:02 +0900
Subject: [PATCH 2/2] arm64: is_compat_task is defined both in asm/compat.h
 and linux/compat.h
In-Reply-To: <20140217193210.GI26590@mudshark.cambridge.arm.com>
References: <1391767892-5395-1-git-send-email-takahiro.akashi@linaro.org>
 <1391767892-5395-3-git-send-email-takahiro.akashi@linaro.org>
 <20140217193210.GI26590@mudshark.cambridge.arm.com>
Message-ID: <53049272.8030706@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/18/2014 04:32 AM, Will Deacon wrote:
> On Fri, Feb 07, 2014 at 10:11:32AM +0000, AKASHI Takahiro wrote:
>> kernel/seccomp.c includes linux/compat.h and, indicrectly, asm/compat.h
>> via asm/syscall.h. Due to the duplicated definition of is_compat_task,
>> compiling this file will fail in the case of !CONFIG_COMPAT.
>> This patch makes the definition in asm/compat.h valid only if necessary.
>>
>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>> ---
>>   arch/arm64/include/asm/compat.h |    2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
>> index fda2704..72f3b18 100644
>> --- a/arch/arm64/include/asm/compat.h
>> +++ b/arch/arm64/include/asm/compat.h
>> @@ -305,10 +305,12 @@ static inline int is_compat_thread(struct thread_info *thread)
>>
>>   #else /* !CONFIG_COMPAT */
>>
>> +#ifndef is_compat_task /* it's there in linux/compat.h */
>>   static inline int is_compat_task(void)
>>   {
>>   	return 0;
>>   }
>> +#endif
>
> This is horrible! Can we instead include linux/compat.h where we need this
> macro and then remove this definition?

It's fine with me, but asm/compat.h is also included in
   hw_breakpoint.c, process.c, ptrace.c and signal.c.

After replacing asm/compat.h to linux/compat.h in these files, I could successfully built
the kernel, but I can't guarantee that the kernel works without any problem :-)

Anyway I will go forward with this change.

-Takahiro AKASHI

> Will
>
