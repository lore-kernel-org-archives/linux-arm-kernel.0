From: will.deacon@arm.com (Will Deacon)
Date: Wed, 20 May 2015 19:02:17 +0100
Subject: [EDT] [PATCH 1/1] Fix: hw watchpoint continually triggers callback
In-Reply-To: <939613287.351841431955025734.JavaMail.weblogic@ep2mlwas08c>
References: <939613287.351841431955025734.JavaMail.weblogic@ep2mlwas08c>
Message-ID: <20150520180217.GM11498@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 18, 2015 at 02:17:05PM +0100, Vaneet Narang wrote:
> >Ok, so my first point shouldn't be a problem if we're just emulating the
> >instruction. However, I still think there are corner cases. For example,
> >imagine hitting a breakpoint on a ldr pc, [&foo] instruction where we've
> >also got a watchpoint on foo. Even with emulation, it's going to be
> >difficult to ensure that watchpoint is safely delivered.
> >
> >As I say, I'd really rather have a kprobes-agnostic way of stepping an
> >instruction and let the debugger decide whether it wants to use that or
> >not.
> >
> 
> 2 breakpoints will not be any issue but watchpoint + breakpoint is
> interesting scenario with ldr pc, [&foo] instruction in place. 
> How would ARM will behave in this case without kprobe ? I think It will
> keep on generating Watch point interrupt only.

It should work ok, because the mismatch breakpoint won't fire until we've
actually stepped off the faulting instruction.

> With kprobe watchpoint interrupt gets triggered first and as soon as we
> execute ldr pc, [&foo] using kprobe it will trigger Breakpoint interrupt.  
> This can be taken care with special handling for such instruction where PC
> gets changed. Can you please suggest what should be correct behavior in
> this case ?

Ideally, kprobes wouldn't interfere with the any concurrent debugging, but
I suspect that's not actually the reality on any architectures, particularly
if we end up executing copies of instructions out of a kprobes buffer.

> Is this scenario possible with any other instruction. ? I am not able to
> think other instructions. Is it possisble with push or pop ?

Not sure, you'd need to check for anything that can access memory and
write the PC in one instruction.

> >> >  - What if the debugger didn't want to execute the instruction at all?
> >> 
> >> if debugger doesn't want to execute instruction then debugger should use
> >> single step implementation without overflow handler. 
> >
> >But the debugger might want to use the overflow handler to regain control
> >on the exception (like ptrace does for userspace).
> >
> I have tried same kernel module on x86, Linux 3.5. Behavior on x86 is to
> execute instruction.  I am not sure how ptrace works on x86, if
> instruction gets executed without any control from overflow handler.
> Behavior on ARM should be same as x86. Since perf API interface is same on
> ARM as well as x86.

Unfortunately, I don't think we can easily provide that illusion without
breaking ptrace. The proper fix would be to divorce hw_breakpoint from
perf, allowing ptrace to hook directly into the backend, but that's not
a simple task...

Will
