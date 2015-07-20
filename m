From: linux@roeck-us.net (Guenter Roeck)
Date: Mon, 20 Jul 2015 07:20:43 -0700
Subject: [PATCH] arm64: Minor refactoring of cpu_switch_to() to fix build
 breakage
In-Reply-To: <20150720105345.GC9908@arm.com>
References: <1437359377-39932-1-git-send-email-olof@lixom.net>
 <20150720073647.GA10504@gmail.com> <20150720105345.GC9908@arm.com>
Message-ID: <20150720142042.GA10685@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 20, 2015 at 11:53:45AM +0100, Will Deacon wrote:
> On Mon, Jul 20, 2015 at 08:36:47AM +0100, Ingo Molnar wrote:
> > * Olof Johansson <olof@lixom.net> wrote:
> > 
> > > Commit 0c8c0f03e3a2 ("x86/fpu, sched: Dynamically allocate 'struct fpu'")
> > > moved the thread_struct to the bottom of task_struct. As a result, the
> > > offset is now too large to be used in an immediate add on arm64 with
> > > some kernel configs:
> > > 
> > > arch/arm64/kernel/entry.S: Assembler messages:
> > > arch/arm64/kernel/entry.S:588: Error: immediate out of range
> > > arch/arm64/kernel/entry.S:597: Error: immediate out of range
> > > 
> > > There's really no reason for cpu_switch_to to take a task_struct pointer
> > > in the first place, since all it does is access the thread.cpu_context
> > > member. So, just pass that in directly.
> > > 
> > > Fixes: 0c8c0f03e3a2 ("x86/fpu, sched: Dynamically allocate 'struct fpu'")
> > > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > > Signed-off-by: Olof Johansson <olof@lixom.net>
> > > ---
> > >  arch/arm64/include/asm/processor.h |    4 ++--
> > >  arch/arm64/kernel/asm-offsets.c    |    2 --
> > >  arch/arm64/kernel/entry.S          |   34 ++++++++++++++++------------------
> > >  arch/arm64/kernel/process.c        |    3 ++-
> > >  4 files changed, 20 insertions(+), 23 deletions(-)
> > 
> > So why not pass in 'thread_struct' as the patch below does - it looks much
> > simpler to me. This way the assembly doesn't have to be changed at all.
> 
> Unfortunately, neither of these approaches really work:
> 
>   - We need to return last from __switch_to, which means not corrupting
>     x0 in cpu_switch_to and then having an ugly container_of to get back
>     at the task_struct
> 
>   - ret_from_fork needs to pass the task_struct of prev to schedule_tail,
>     so we have the same issue there
> 
Confirmed; both Ingo's patch (after fixing it up) and Olof's patch
fail my qemu tests (qemu hangs with both patches and does not produce
any console output).

> Patch below fixes things, but it's a shame we have to use an extra register
> like this.
> 
Yes, your patch works, at least with my qemu tests, and the allmodconfig build
no longer fails.

Tested-by: Guenter Roeck <linux@roeck-us.net>

> Will
> 
> --->8
> 
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index f860bfda454a..e16351819fed 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -585,7 +585,8 @@ ENDPROC(el0_irq)
>   *
>   */
>  ENTRY(cpu_switch_to)
> -	add	x8, x0, #THREAD_CPU_CONTEXT
> +	mov	x10, #THREAD_CPU_CONTEXT
> +	add	x8, x0, x10
>  	mov	x9, sp
>  	stp	x19, x20, [x8], #16		// store callee-saved registers
>  	stp	x21, x22, [x8], #16
> @@ -594,7 +595,7 @@ ENTRY(cpu_switch_to)
>  	stp	x27, x28, [x8], #16
>  	stp	x29, x9, [x8], #16
>  	str	lr, [x8]
> -	add	x8, x1, #THREAD_CPU_CONTEXT
> +	add	x8, x1, x10
>  	ldp	x19, x20, [x8], #16		// restore callee-saved registers
>  	ldp	x21, x22, [x8], #16
>  	ldp	x23, x24, [x8], #16
