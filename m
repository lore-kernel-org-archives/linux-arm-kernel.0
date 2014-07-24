From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 24 Jul 2014 14:57:11 +0900
Subject: [PATCH v5 1/3] arm64: ptrace: reload a syscall number after ptrace
 operations
In-Reply-To: <53D08358.4020902@amacapital.net>
References: <1406020499-5537-1-git-send-email-takahiro.akashi@linaro.org>
 <1406020499-5537-2-git-send-email-takahiro.akashi@linaro.org>
 <53D08358.4020902@amacapital.net>
Message-ID: <53D0A037.2060308@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/24/2014 12:54 PM, Andy Lutomirski wrote:
> On 07/22/2014 02:14 AM, AKASHI Takahiro wrote:
>> Arm64 holds a syscall number in w8(x8) register. Ptrace tracer may change
>> its value either to:
>>    * any valid syscall number to alter a system call, or
>>    * -1 to skip a system call
>>
>> This patch implements this behavior by reloading that value into syscallno
>> in struct pt_regs after tracehook_report_syscall_entry() or
>> secure_computing(). In case of '-1', a return value of system call can also
>> be changed by the tracer setting the value to x0 register, and so
>> sys_ni_nosyscall() should not be called.
>>
>> See also:
>>      42309ab4, ARM: 8087/1: ptrace: reload syscall number after
>>           secure_computing() check
>>
>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>> ---
>>   arch/arm64/kernel/entry.S  |    2 ++
>>   arch/arm64/kernel/ptrace.c |   13 +++++++++++++
>>   2 files changed, 15 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
>> index 5141e79..de8bdbc 100644
>> --- a/arch/arm64/kernel/entry.S
>> +++ b/arch/arm64/kernel/entry.S
>> @@ -628,6 +628,8 @@ ENDPROC(el0_svc)
>>   __sys_trace:
>>       mov    x0, sp
>>       bl    syscall_trace_enter
>> +    cmp    w0, #-1                // skip syscall?
>> +    b.eq    ret_to_user
>
> Does this mean that skipped syscalls will cause exit tracing to be skipped?

Yes. (and I guess yes on arm, too)

 > If so, then you risk (at least) introducing
> a nice user-triggerable OOPS if audit is enabled.

Can you please elaborate this?
Since I didn't find any definition of audit's behavior when syscall is
rewritten to -1, I thought it is reasonable to skip "exit tracing" of
"skipped" syscall.
(otherwise, "fake" seems to be more appropriate :)

-Takahiro AKASHI

> This bug existed for *years* on x86_32, and it amazes me that no one
> ever triggered it by accident. (Grr, audit.)
>
> --Andy
