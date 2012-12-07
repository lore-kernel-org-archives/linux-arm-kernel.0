From: rostedt@goodmis.org (Steven Rostedt)
Date: Fri, 07 Dec 2012 09:03:05 -0500
Subject: [PATCH] ARM: ftrace: Ensure code modifications are synchronised
 across all cpus
In-Reply-To: <1354872138.3176.15.camel@computer5.home>
References: <1354817466.30905.13.camel@linaro1.home>
 <1354821581.17101.17.camel@gandalf.local.home>
 <1354872138.3176.15.camel@computer5.home>
Message-ID: <1354888985.17101.41.camel@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-12-07 at 09:22 +0000, Jon Medhurst (Tixy) wrote:
> On Thu, 2012-12-06 at 14:19 -0500, Steven Rostedt wrote:
> > Hmm, your use of "may or may not" seems as you may not know this answer.
> > I wonder if you can use the break point method as x86 does now, and
> > remove the stop machine completely. Basically this is how it works:
> > 
> > add sw breakpoints to all locations to modify (the bp handler just does
> > a nop over the instruction).
> > 
> > send an IPI to all CPUs to flush their icache.
> > 
> > Modify the non breakpoint part of the instruction with the new
> > instruction.
> > 
> > send an IPI to all CPUs to flush their icache
> > 
> > Replace the breakpoint with the finished instruction.
> 
> If I understand correctly then this method can't work on ARM because a
> 'software breakpoint' is 'replace an instruction with a known undefined
> instruction _of the same size_'. It haa to be the same size because code
> like this:
> 
> 	it eq       /* If condition code 'eq' true */
>         insA        /* then execute this instruction */
>         insB        /* Always execute this */
> 
> if we replace insA with a breakpoint which is shorter, then we have
> 
> 	it eq       /* If condition code 'eq' true */
>         bkpt        /* then execute the breakpoint */
>         insA-part2  /* Always execute this garbage */

Why always execute the garbage? Do what we do in x86, where the
breakpoint is only 1 byte and the instruction being replaced is 5 bytes.
The breakpoint handler returns to the instruction after the
"garbage" (insB).

>         insB        /* Always execute this */
> 
> and to complicate matters more, the 'it' instruction can make up to the
> next four instructions conditional, so you can't reverse decode the
> instruction stream reliably to even detect such code.
> 
> And further, it's implementation defined (up to who every creates the
> silicon) whether an undefined instructions actually causes an abort when
> it occurs in such an 'it' block, it may just execute as a nop.
> 
> Welcome to the work of ARM :-)
> 

But also realize that function tracing is special :-) We have no cases
like this. The instruction being replaced is a call to mcount. In fact,
we replace it at boot with a nop. And this method only replaces that nop
into a call to function tracer, or replaces the call to function tracer
back to a nop. Always at the start of the function, and never involved
with conditionals. This limitation that function tracing imposes on what
we replace makes things a bit more sane in how we replace it.

-- Steve
