From: dan@debian.org (Daniel Jacobowitz)
Date: Mon, 11 Jan 2010 16:58:16 -0500
Subject: 32-bit Thumb-2 breakpoints
Message-ID: <20100111215816.GA1068@caradoc.them.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I have been working the past week on GDB support for Thumb-2.  It
turns out that there's a case where we need a 32-bit software
breakpoint instruction to get things right (explanation below).

The kernel currently reserves two architecturally undefined
instructions for breakpoints, one ARM and one Thumb.  I suggest
another for Thumb-2, provisionally 0xfff7 0xffcf, but I'm open
to any other suggestion.  Any comments?  If that sounds OK,
I can put together a patch.

The problem I'm solving is that of stepping through IT blocks.  We
shouldn't use the BKPT instruction, which would interfere with an
attached hardware debugger.  The undefined instruction pattern
currently used as a breakpoint will not trigger an exception if the IT
block flags prevent its execution.  And without adding most of a
Thumb-2 simulator to GDB, we can't statically predict what the
next instruction will do to the CPSR flags, so we don't know which
of the following instructions in the IT block will be executed.
For example:

   cmp   r0, r0
   itt   eq
A: cmpeq r0, r1
B: moveq r0, r2
C: nop

At A, we try to single-step.  Unless we simulate the cmp instruction,
we do not know whether B or C will be executed next.  So we have to
set a breakpoint at each of the two possibilities.  If we set a 16-bit
breakpoint on a 32-bit instruction and it is not taken, then the
second half of that 32-bit instruction will be treated as the next
instruction.

This approach keeps the single-stepping code considerably simpler than
if it had to recognize and simulate every flag-setting instruction (~
40 instruction forms).  It's not the only approach, obviously; if
someone has a good reason why I ought to simulate every possible
flag-setting instruction, I can write the code to do that instead.

GDB can work around receiving a SIGILL so a patched GDB will mostly
work on existing kernels; for best results and abstract correctness,
though, there should be a reserved instruction pattern for SIGTRAP.

-- 
Daniel Jacobowitz
CodeSourcery
