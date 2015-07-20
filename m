From: olof@lixom.net (Olof Johansson)
Date: Mon, 20 Jul 2015 09:33:22 -0700
Subject: [PATCH] arm64: Minor refactoring of cpu_switch_to() to fix build
 breakage
In-Reply-To: <20150720142042.GA10685@roeck-us.net>
References: <1437359377-39932-1-git-send-email-olof@lixom.net>
 <20150720073647.GA10504@gmail.com> <20150720105345.GC9908@arm.com>
 <20150720142042.GA10685@roeck-us.net>
Message-ID: <CAOesGMgYsS_cdATZaHBcxpLQDrq1vEw-HwJ2GKWD9J7=a486ng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 20, 2015 at 7:20 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Mon, Jul 20, 2015 at 11:53:45AM +0100, Will Deacon wrote:
>> On Mon, Jul 20, 2015 at 08:36:47AM +0100, Ingo Molnar wrote:
>> > * Olof Johansson <olof@lixom.net> wrote:
>> >
>> > > Commit 0c8c0f03e3a2 ("x86/fpu, sched: Dynamically allocate 'struct fpu'")
>> > > moved the thread_struct to the bottom of task_struct. As a result, the
>> > > offset is now too large to be used in an immediate add on arm64 with
>> > > some kernel configs:
>> > >
>> > > arch/arm64/kernel/entry.S: Assembler messages:
>> > > arch/arm64/kernel/entry.S:588: Error: immediate out of range
>> > > arch/arm64/kernel/entry.S:597: Error: immediate out of range
>> > >
>> > > There's really no reason for cpu_switch_to to take a task_struct pointer
>> > > in the first place, since all it does is access the thread.cpu_context
>> > > member. So, just pass that in directly.
>> > >
>> > > Fixes: 0c8c0f03e3a2 ("x86/fpu, sched: Dynamically allocate 'struct fpu'")
>> > > Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> > > Signed-off-by: Olof Johansson <olof@lixom.net>
>> > > ---
>> > >  arch/arm64/include/asm/processor.h |    4 ++--
>> > >  arch/arm64/kernel/asm-offsets.c    |    2 --
>> > >  arch/arm64/kernel/entry.S          |   34 ++++++++++++++++------------------
>> > >  arch/arm64/kernel/process.c        |    3 ++-
>> > >  4 files changed, 20 insertions(+), 23 deletions(-)
>> >
>> > So why not pass in 'thread_struct' as the patch below does - it looks much
>> > simpler to me. This way the assembly doesn't have to be changed at all.
>>
>> Unfortunately, neither of these approaches really work:
>>
>>   - We need to return last from __switch_to, which means not corrupting
>>     x0 in cpu_switch_to and then having an ugly container_of to get back
>>     at the task_struct
>>
>>   - ret_from_fork needs to pass the task_struct of prev to schedule_tail,
>>     so we have the same issue there
>>
> Confirmed; both Ingo's patch (after fixing it up) and Olof's patch
> fail my qemu tests (qemu hangs with both patches and does not produce
> any console output).
>
>> Patch below fixes things, but it's a shame we have to use an extra register
>> like this.
>>
> Yes, your patch works, at least with my qemu tests, and the allmodconfig build
> no longer fails.
>
> Tested-by: Guenter Roeck <linux@roeck-us.net>

Yep, my bad for not looking harder (and resurrecting my only arm64
test system that's currently down).

Thanks all. :)


-Olof
