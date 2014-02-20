From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 20 Feb 2014 09:34:00 +0900
Subject: [PATCH 1/2] arm64: Add seccomp support
In-Reply-To: <20140219164125.GD22252@arm.com>
References: <1391767892-5395-1-git-send-email-takahiro.akashi@linaro.org>
 <1391767892-5395-2-git-send-email-takahiro.akashi@linaro.org>
 <20140218153856.GB904@localhost> <530497DD.2020806@linaro.org>
 <20140219164125.GD22252@arm.com>
Message-ID: <53054D78.9090000@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/20/2014 01:41 AM, Catalin Marinas wrote:
> On Wed, Feb 19, 2014 at 11:39:09AM +0000, AKASHI Takahiro wrote:
>> On 02/19/2014 12:38 AM, Catalin Marinas wrote:
>>> On Fri, Feb 07, 2014 at 10:11:31AM +0000, AKASHI Takahiro wrote:
>>>> --- a/arch/arm64/kernel/ptrace.c
>>>> +++ b/arch/arm64/kernel/ptrace.c
>>>> @@ -26,6 +26,7 @@
>>>>    #include <linux/smp.h>
>>>>    #include <linux/ptrace.h>
>>>>    #include <linux/user.h>
>>>> +#include <linux/seccomp.h>
>>>>    #include <linux/security.h>
>>>>    #include <linux/init.h>
>>>>    #include <linux/signal.h>
>>>> @@ -1064,6 +1065,10 @@ asmlinkage int syscall_trace(int dir, struct pt_regs *regs)
>>>>    {
>>>>    	unsigned long saved_reg;
>>>>
>>>> +	if (!dir && secure_computing((int)regs->syscallno))
>>>> +		/* seccomp failures shouldn't expose any additional code. */
>>>> +		return -1;
>>>
>>> That's only restricted to the arm64 code but could we use a more
>>> meaningful error number?
>>
>> Other architectures, including arm, also return just -1 in syscall_trace_enter(),
>> but of course, we can use another value, say, -EPERM or -ENOSYS?
>
> Actually we have another case of setting regs->syscallno = ~0UL in the
> same function, so we could do the same (also in line with entry.S).

I believe that I got you now, but we need to distinguish failure case of
seccomp and the existing (~0UL) case. In former case, depending on a bpf
rule loaded into the kernel, errno may be assigned to any arbitrary number
(not necessarily ENOSYS).
So I will use another value for this specific seccomp case.

Thanks,
-Takahiro AKASHI
