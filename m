From: jamie@shareable.org (Jamie Lokier)
Date: Mon, 26 Nov 2012 21:58:26 +0000
Subject: [PATCH] ARM: implement optimized percpu variable access
In-Reply-To: <20121126151534.GA13620@mudshark.cambridge.arm.com>
References: <1352604040-10014-1-git-send-email-robherring2@gmail.com>
 <20121122113401.GC3113@mudshark.cambridge.arm.com>
 <50B2679F.3070107@gmail.com>
 <20121126111337.GA13312@mudshark.cambridge.arm.com>
 <20121126151534.GA13620@mudshark.cambridge.arm.com>
Message-ID: <20121126215826.GA21160@jl-vm1.vm.bytemark.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will Deacon wrote:
> That was a fun bit of debugging -- my hunch was right, but I was looking in the
> wrong place because I had an unrelated problem with my bootloader.
> 
> What happens is that every man and his dog is inlined into __schedule,
> including all the runqueue accessors, such as this_rq(), which make use of
> per-cpu offsets to get the correct pointer. The compiler then spits out
> something like this near the start of the function:
> 
[...]
>
> so the address of the current runqueue has been calculated and stored, with
> a bunch of other stuff, in a structure on the stack.
>
[...]
>
> 	barrier();
> 	/*
> 	 * this_rq must be evaluated again because prev may have moved
> 	 * CPUs since it called schedule(), thus the 'rq' on its stack
> 	 * frame will be invalid.
> 	 */
> 	finish_task_switch(this_rq(), prev);
> 
> The problem here is that, because our CPU accessors don't actually make any
> memory references, the barrier() has no effect and the old value is just
> reloaded off the stack:
>
[...]
> 
> which obviously causes complete chaos if the new task has been pulled from
> a different runqueue! (this appears as a double spin unlock on rq->lock).
> 
> Fixing this without giving up the performance improvement we gain by *avoiding*
> the memory access in the first place is going to be tricky...

Perhaps look at x86's approach, in arch/x86/include, <asm/current.h>,
<asm/percpu.h> and <asm/switch_to.h>.

current uses this_cpu_read_stable():

/*
 * this_cpu_read() makes gcc load the percpu variable every time it is
 * accessed while this_cpu_read_stable() allows the value to be cached.
 * this_cpu_read_stable() is more efficient and can be used if its value
 * is guaranteed to be valid across cpus.  The current users include
 * get_current() and get_thread_info() both of which are actually
 * per-thread variables implemented as per-cpu variables and thus
 * stable for the duration of the respective task.
 */

So how does x86 do it?

After lots of staring at the x86 headers, I think
this_read_cpu_stable() is a non-volatile asm which depends only on the
address &current_task, which is constant (GCC doesn't know the address
is dereferenced), and I can't see how reloading the value after
switch_to() (32 or 64 bit versions) is guaranteed, unless the "p" asm
is constraint implies something more than "the value is a pointer".

I assume I've missed something very subtle, but if not x86 has the
same bug/issue as discussed in this thread.

-- Jamie
