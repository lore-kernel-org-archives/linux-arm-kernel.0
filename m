From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 13 Nov 2014 16:02:49 +0900
Subject: [RFC] ptrace: add generic SET_SYSCALL request
In-Reply-To: <6358312.yt5WU3kBm9@wuerfel>
References: <1415346443-28915-1-git-send-email-takahiro.akashi@linaro.org>
 <54633F53.8020507@linaro.org> <20141112111352.GC26437@arm.com>
 <6358312.yt5WU3kBm9@wuerfel>
Message-ID: <54645799.5010409@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/12/2014 08:19 PM, Arnd Bergmann wrote:
> On Wednesday 12 November 2014 11:13:52 Will Deacon wrote:
>> On Wed, Nov 12, 2014 at 11:06:59AM +0000, AKASHI Takahiro wrote:
>>> On 11/12/2014 08:00 PM, Will Deacon wrote:
>>>> On Wed, Nov 12, 2014 at 10:46:01AM +0000, AKASHI Takahiro wrote:
>>>>> On 11/07/2014 11:04 PM, Oleg Nesterov wrote:
>>>>>> To me the fact that PTRACE_SET_SYSCALL can be undefined and syscall_set_nr()
>>>>>> is very much arch-dependant (but most probably trivial) means that this  code
>>>>>> should live in arch_ptrace().
>>>>>
>>>>> Thinking of Oleg's comment above, it doesn't make sense neither to define generic
>>>>> NT_SYSTEM_CALL (user_regset) in uapi/linux/elf.h and implement it in ptrace_regset()
>>>>> in kernel/ptrace.c with arch-defined syscall_(g)set_nr().
>>>>>
>>>>> Since we should have the same interface on arm and arm64, we'd better implement
>>>>> ptrace(PTRACE_SET_SYSCALL) locally on arm64 for now (as I originally submitted).
>>>>
>>>> I think the regset approach is cleaner. We already do something similar for
>>>> TLS. That would be implemented under arch/arm64/ with it's own NT type.
>>>
>>> Okey, so arm64 goes its own way
>>> Or do you want to have a similar regset on arm, too?
>>> (In this case, NT_ARM_SYSTEM_CALL can be shared in uapi/linux/elf.h)
>>
>> Just do arm64. We already have the dedicated request for arch/arm/.
>
> I wonder if we should define NT_ARM64_SYSTEM_CALL to the same value
> as NT_S390_SYSTEM_CALL (0x307), or even define it as an architecture-
> independent NT_SYSTEM_CALL number with that value, so other architectures
> don't have to introduce new types when they also want to implement it.

I digged into gdb code (gdb/bfd/elf.c):
https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=blob;f=bfd/elf.c;h=8b207ad872a3992381e93bdfa0a75ef444651613;hb=HEAD
   elf_parse_notes()->elfcore_grok_note()->elfcore_grok_s390_system_call()

It seems to me that NT_S390_SYSTEM_CALL(=0x307) is recognized as a s390 specific
value (without checking for machine type). So thinking of potential conflict, it might not be
a good idea to use this value as a common number (of NT_SYSTEM_CALL).
It's very unlikely that a "note" section for NT_(S390_)SYSTEM_CALL appears in a coredump file, though.

What do you think?

-Takahiro AKASHI

>
> 	Arnd
>
