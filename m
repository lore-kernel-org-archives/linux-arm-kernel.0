From: jamie@shareable.org (Jamie Lokier)
Date: Mon, 26 Nov 2012 23:50:27 +0000
Subject: [PATCH] ARM: implement optimized percpu variable access
In-Reply-To: <20121126215826.GA21160@jl-vm1.vm.bytemark.co.uk>
References: <1352604040-10014-1-git-send-email-robherring2@gmail.com>
 <20121122113401.GC3113@mudshark.cambridge.arm.com>
 <50B2679F.3070107@gmail.com>
 <20121126111337.GA13312@mudshark.cambridge.arm.com>
 <20121126151534.GA13620@mudshark.cambridge.arm.com>
 <20121126215826.GA21160@jl-vm1.vm.bytemark.co.uk>
Message-ID: <20121126235027.GB21160@jl-vm1.vm.bytemark.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jamie Lokier wrote:
> So how does x86 do it?
> 
> After lots of staring at the x86 headers, I think
> this_read_cpu_stable() is a non-volatile asm which depends only on the
> address &current_task, which is constant (GCC doesn't know the address
> is dereferenced), and I can't see how reloading the value after
> switch_to() (32 or 64 bit versions) is guaranteed, unless the "p" asm
> is constraint implies something more than "the value is a pointer".
> 
> I assume I've missed something very subtle, but if not x86 has the
> same bug/issue as discussed in this thread.

Well I wasn't thinking too clearly there.

As long as the various scheduler functions don't _care_ that anything
which calls this_read_cpu_stable() is a function of the current task,
and hence current stack, it's fine to have them cached on the stack
and/or in registers across the context switch.

The general rule: When this_cpu... is used for something which is a
constant function of the current stack (task), not really a function
of the CPU (that being just an optimisation), this_cpu_read_stable()
is fine.  When it's for something CPU dependent, non-caching
this_cpu... is needed.  Not caching the per-CPU variable address isn't
special to context switching.  It's unsafe to cache the address in any
preemptible context, and across anything which may call schedule().

Groovy.

-- Jamie
