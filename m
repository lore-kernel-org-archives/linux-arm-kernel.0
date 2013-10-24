From: tom.leiming@gmail.com (Ming Lei)
Date: Thu, 24 Oct 2013 13:42:14 +0800
Subject: [RFC PATCH] kernel/kallsyms.c: only show legal kernel symbol
In-Reply-To: <87eh7bfoq9.fsf@rustcorp.com.au>
References: <1382498320-26594-1-git-send-email-tom.leiming@gmail.com>
 <87eh7bfoq9.fsf@rustcorp.com.au>
Message-ID: <CACVXFVOA+VOWcbaiG=RSR+WVRK70UcX3cnucO-W0GtPezHzA0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 24, 2013 at 9:21 AM, Rusty Russell <rusty@rustcorp.com.au> wrote:
> Ming Lei <tom.leiming@gmail.com> writes:
>> Address of non-module kernel symbol should always be located
>> from CONFIG_PAGE_OFFSET on, so only show these legal kernel
>> symbols in /proc/kallsyms.
>>
>> On ARM, some symbols(see below) may drop in relocatable code, so
>> perf can't parse kernel symbols any more from /proc/kallsyms, this
>> patch fixes the problem.
>>
>>       00000000 t __vectors_start
>>       00000020 A cpu_v7_suspend_size
>>       00001000 t __stubs_start
>>       00001004 t vector_rst
>>       00001020 t vector_irq
>>       000010a0 t vector_dabt
>>       00001120 t vector_pabt
>>       000011a0 t vector_und
>>       00001220 t vector_addrexcptn
>>       00001224 t vector_fiq
>>       00001224 T vector_fiq_offset
>>
>> The issue can be fixed in scripts/kallsyms.c too, but looks this
>> approach is easier.
>
> This fix looks hacky; if these symbols are not available, don't just
> remove them from /proc/kallsyms, but don't put them in the kernel at
> all.
>
> That way, they won't interfere with other kallsyms uses (eg. backtrace).

Yes, I agree.

> Or, better, figure out a smart way of excluding them by knowing why
> these symbol addresses are wrong.

Actually the problem is caused by commit b9b32bf70f2(ARM: use linker
magic for vectors and vector stubs), maybe Russell can figure out a smart
way to exclude these symbols.


Thanks,
-- 
Ming Lei
