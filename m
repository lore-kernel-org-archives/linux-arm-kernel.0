From: tixy@yxit.co.uk (Tixy)
Date: Fri, 11 Mar 2011 17:01:21 +0000
Subject: [RFC] kprobes with thumb2 conditional code
Message-ID: <1299862881.2512.314.camel@computer2.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello All

I'm about to start work on getting kprobes working with thumb2.

One of the issues I have is that when probes are placed onto
conditionally executed instructions in a IT block, they may not fire if
the condition is not met. This is because on ARM we use invalid
instructions for breakpoints, and the ARM ARM says:

  "it is IMPLEMENTATION DEFINED whether the instruction executes as a
   NOP or causes an Undefined Instruction exception"

This is a similar issue to that already encountered by GDB [1][2]

If we take this code as an example...

probe1:
if(condition) {
probe2:
    some_code;
}

It seams reasonable at first sight that probe2 would only fire if the
condition is true. This will always be the case if the compiler
generates test-and-branch code, but if it generates conditionally
executed instructions for 'some_code' then it gets complicated...

The current arm kprobes implementation will always fire probe2 because
it uses unconditional instructions for its breakpoints. With thumb
instructions we can't force unconditional execution, so we would have an
'implementation defined' situation whether it would fire or not when the
condition is false. (Thought you would hope it would be consistent on a
particular device.)

Some options for dealing with this, in increasing order of
complexity... 

1. Accept the situation as described.

2. Change arm probes to use conditional instructions so we would
(hopefully) have consistent undefined behaviour in both arm and thumb
code. (If that isn't an oxymoron :-)

3. Do 2, and modify kprobe_handler to test for false firings (breakpoint
when condition false) and not execute the probe's callback functions in
these cases. E.g. consistently make probe2 appear to not fire when
condition is false.

4. Make thumb probes fire unconditionally like current arm
implementation...

4a. Use breakpoint instructions rather than undefined instructions for
kprobes. Apparently this doesn't play nicely with hardware debuggers [2]
though I don't have enough experience in this area to otherwise comment.

4b. Rewrite IT blocks when probes are inserted into them to make the
breakpoint unconditional. This would require parsing backwards through
the instruction stream to find the IT instruction, which I don't believe
is possible with variable length thumb instructions. Or, another
possibility which was suggested to me, use the unwind table to find the
start of the containing function and parse forwards to find the IT
instruction. Though the kernel doesn't currently have enough information
to skip things like inline data that may be the function.

The effort, complexity and bloat involved in 4b seems to be rather
excessive to me, even before getting into the book-keeping required to
handle multiple probes in the same IT block. So 4b is a bit of a straw
man.

BTW, does anyone know of any test code for kprobes, particularly with
regard to checking emulation/single-stepping of the different CPU
instructions?

Thanks for any feedback

-- 
Tixy


[1] http://permalink.gmane.org/gmane.comp.gdb.patches/54862  
[2]
http://thread.gmane.org/gmane.linux.ports.arm.kernel/72199/focus=73489
