From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed, 12 Nov 2014 19:46:01 +0900
Subject: [RFC] ptrace: add generic SET_SYSCALL request
In-Reply-To: <20141107140405.GA30156@redhat.com>
References: <1415346443-28915-1-git-send-email-takahiro.akashi@linaro.org>
 <20141107140405.GA30156@redhat.com>
Message-ID: <54633A69.6090202@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will,

On 11/07/2014 11:04 PM, Oleg Nesterov wrote:
> On 11/07, AKASHI Takahiro wrote:
>>
>> --- a/arch/arm/kernel/ptrace.c
>> +++ b/arch/arm/kernel/ptrace.c
>> @@ -853,11 +853,6 @@ long arch_ptrace(struct task_struct *child, long request,
>>   				       datap);
>>   			break;
>>
>> -		case PTRACE_SET_SYSCALL:
>> -			task_thread_info(child)->syscall = data;
>> -			ret = 0;
>> -			break;
>> -
>>   #ifdef CONFIG_CRUNCH
>>   		case PTRACE_GETCRUNCHREGS:
>>   			ret = ptrace_getcrunchregs(child, datap);
>> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
>> index 54e7522..d7048fa 100644
>> --- a/kernel/ptrace.c
>> +++ b/kernel/ptrace.c
>> @@ -1001,6 +1001,12 @@ int ptrace_request(struct task_struct *child, long request,
>>   		break;
>>   	}
>>   #endif
>> +
>> +#ifdef PTRACE_SET_SYSCALL
>> +	case PTRACE_SET_SYSCALL:
>> +		ret = syscall_set_nr(child, task_pt_regs(child), data);
>> +		break;
>> +#endif
>
> I too do not understand why it makes sense to move PTRACE_SET_SYSCALL into
> the common kernel/ptrace.c.

I think I explained why we need a new (atomic) interface of changing a system
call number while tracing with ptrace. But I don't have a strong preference,
either ptrace(SET_SYSCALL) or ptrace(SETREGSET, NT_SYSTEM_CALL).

> To me the fact that PTRACE_SET_SYSCALL can be undefined and syscall_set_nr()
> is very much arch-dependant (but most probably trivial) means that this  code
> should live in arch_ptrace().

Thinking of Oleg's comment above, it doesn't make sense neither to define generic
NT_SYSTEM_CALL (user_regset) in uapi/linux/elf.h and implement it in ptrace_regset()
in kernel/ptrace.c with arch-defined syscall_(g)set_nr().

Since we should have the same interface on arm and arm64, we'd better implement
ptrace(PTRACE_SET_SYSCALL) locally on arm64 for now (as I originally submitted).

-Takahiro AKASHI

> In any case, I think it doesn't make sense to pass task_pt_regs(child), this
> helper can do this itself if it needs struct pt_regs.
>
> Oleg.
>
