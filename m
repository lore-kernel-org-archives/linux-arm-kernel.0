From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 16 Nov 2013 15:12:42 +0000
Subject: [PATCH] ARM: fix /proc/$PID/stack to work on SMP
In-Reply-To: <CAP+bzvWtq9PrcAmyVMxjGu9OCaiH9mPwo-WjQJBz9LyXDSER+w@mail.gmail.com>
References: <CAP+bzvWtq9PrcAmyVMxjGu9OCaiH9mPwo-WjQJBz9LyXDSER+w@mail.gmail.com>
Message-ID: <20131116151242.GV16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 16, 2013 at 10:58:44PM +0800, ivan lam wrote:
> In arm, we can't get stack info of the other tasks via
> /proc/$PID/stack file. for example:
> 
> # sleep 1000 &
> # ps -ef | grep sleep
>   536 0          0:00 sleep 1000
>   538 0          0:00 grep sleep
> # cat /proc/536/stack
> [<ffffffff>] 0xffffffff
> 
> If a thread was scheduled out, this proc should provide
> useful backtrace for debug. Try to unwind the stack based
> on the previous scheduled out register file whatever a
> thread is in Running state or not.
> 
> After this fix, result as:
> 
> # cat /proc/536/stack
> [<8003f018>] hrtimer_nanosleep+0x8c/0x108
> [<8003f134>] SyS_nanosleep+0xa0/0xb0
> [<8000e220>] ret_fast_syscall+0x0/0x30
> [<ffffffff>] 0xffffffff
> 
> If a thread is Running on the oher CPUs, the result is not accurate,
> but this is acceptable. This behaviors are same as x86 and arm64 arch.

As we have people running around trying to add additional checks to
the unwinder to stop it going wrong, I've no plans to apply any patch
like this until we're more sure that it won't open up the possibility
for any user process to crash the kernel.  That in itself is a massive
security issue because its an effective DoS attack.

Moreover, your emailer has totally screwed the patch, so it's impossible
to apply.
