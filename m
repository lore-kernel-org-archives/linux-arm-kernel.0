From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 06 Mar 2014 11:34:46 +0900
Subject: [PATCH v2 2/3] arm64: Add seccomp support
In-Reply-To: <20140228172006.GF30996@mudshark.cambridge.arm.com>
References: <1391767892-5395-1-git-send-email-takahiro.akashi@linaro.org>
 <1393320025-2855-1-git-send-email-takahiro.akashi@linaro.org>
 <1393320025-2855-3-git-send-email-takahiro.akashi@linaro.org>
 <20140228172006.GF30996@mudshark.cambridge.arm.com>
Message-ID: <5317DEC6.4060103@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/01/2014 02:20 AM, Will Deacon wrote:
> On Tue, Feb 25, 2014 at 09:20:24AM +0000, AKASHI Takahiro wrote:
>> secure_computing() should always be called first in syscall_trace(), and
>> if it returns non-zero, we should stop further handling. Then that system
>> call may eventually fail, be trapped or the process itself be killed
>> depending on loaded rules.
>
> [...]
>
>> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
>> index d4ce70e..f2a74bc 100644
>> --- a/arch/arm64/kernel/ptrace.c
>> +++ b/arch/arm64/kernel/ptrace.c
>> @@ -20,12 +20,14 @@
>>    */
>>
>>   #include <linux/audit.h>
>> +#include <linux/errno.h>
>>   #include <linux/kernel.h>
>>   #include <linux/sched.h>
>>   #include <linux/mm.h>
>>   #include <linux/smp.h>
>>   #include <linux/ptrace.h>
>>   #include <linux/user.h>
>> +#include <linux/seccomp.h>
>>   #include <linux/security.h>
>>   #include <linux/init.h>
>>   #include <linux/signal.h>
>> @@ -1064,6 +1066,10 @@ asmlinkage int syscall_trace(int dir, struct pt_regs *regs)
>>   {
>>   	unsigned long saved_reg;
>>
>> +	if (!dir && secure_computing((int)regs->syscallno))
>
> Why do you need this cast to (int)?

OK. I will remove it because gcc doesn't complain about it anyway.

> Also, it's probably better to check for
> -1 explicitly here.

I wil fix it.

> I'm slightly surprised that we do the secure computing check first. Doesn't
> this allow a debugger to change the syscall to something else after we've
> decided that it's ok?

To be honest, I just followed other architectures' implementation.
Can you elaborate any use case that you have in your mind?

-Takahiro AKASHI

> Will
>
