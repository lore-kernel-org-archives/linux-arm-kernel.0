From: stevenrwalter@gmail.com (Steven Walter)
Date: Tue, 29 Nov 2011 13:12:50 -0500
Subject: [PATCH 3/3] ARM: support syscall tracing
In-Reply-To: <20111129174604.GL9581@n2100.arm.linux.org.uk>
References: <1322584095-30439-1-git-send-email-stevenrwalter@gmail.com>
 <1322584095-30439-4-git-send-email-stevenrwalter@gmail.com>
 <20111129174604.GL9581@n2100.arm.linux.org.uk>
Message-ID: <CAK8d-a+o6A+E537o3i4JdzsXei2fbvqNcCLx_U8WyEMK-vL8Fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for your comments, responses below

On Tue, Nov 29, 2011 at 12:46 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Nov 29, 2011 at 11:28:15AM -0500, Steven Walter wrote:
>> diff --git a/arch/arm/include/asm/unistd.h b/arch/arm/include/asm/unistd.h
>> index 2c04ed5..1f23923 100644
>> --- a/arch/arm/include/asm/unistd.h
>> +++ b/arch/arm/include/asm/unistd.h
>> @@ -403,6 +403,8 @@
>> ?#define __NR_sendmmsg ? ? ? ? ? ? ? ? ? ? ? ?(__NR_SYSCALL_BASE+374)
>> ?#define __NR_setns ? ? ? ? ? ? ? ? ? (__NR_SYSCALL_BASE+375)
>>
>> +#define NR_syscalls (__NR_setns+1)
>
> NAK. ?This is a recipe for it being forgotten to be updated, and for it
> to become unsynchronized with what is the _real_ number of syscalls,
> which is what is in the assembly code.

Yes, I like how the assembler counts the number of syscalls for you.
However, every other architecture uses either a bare number or
__NR_last_syscall+1 for defining NR_syscalls.

> You're also exporting it to userspace. ?It has no business being in
> userspace.

That was unintentional, I'll fix.

> Lastly, it's wrong. ?__NR_SYSCALL_BASE may be 0 or 0x90000 depending on
> the ABI selected. ?If it's 0x90000, will tracepoint stuff work or will it
> explode because of a stupidly large table somewhere?

Right you are.  Didn't consider that.  Does that mean that
syscall_get_nr() should return the offset from __NR_SYSCALL_BASE, so
that it will be strictly less than NR_syscalls?

> kernel/trace/trace_syscalls.c: ? ? ?for (i = 0; i < NR_syscalls; i++) {
>
> and
>
> kernel/trace/trace_syscalls.c:static DECLARE_BITMAP(enabled_perf_enter_syscalls, NR_syscalls);
> kernel/trace/trace_syscalls.c:static DECLARE_BITMAP(enabled_perf_exit_syscalls,NR_syscalls);
>
> all point at this being very wrong.

Initially I was going to assign the assembler version of NR_syscalls
to a symbol which could be referenced from C.  However, putting the C
declaration for the variable in unistd.h made the assembler unhappy.
Is it kosher to have C stuff in unistd.h?  Since there was no prior
example of it, I assumed not.  However, perhaps I could just hide it
from the assembler with some kind of #ifdef?

Thanks again
-- 
-Steven Walter <stevenrwalter@gmail.com>
