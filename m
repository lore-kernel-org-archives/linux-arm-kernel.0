From: andreiw@motorola.com (Andrei Warkentin)
Date: Thu, 10 Mar 2011 03:12:54 -0600
Subject: Single-stepping ARMv7 with KDB...
Message-ID: <AANLkTimBAm-Eaordw-KSPnEycQYz2z4QM+Dc5nauLFxh@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I know that there has been a lot of work recently in cleaning -up
hardware single stepping / bp support, and from what I have seen this
has been to support user mode stepping. I'm sorry ahead of time if
someone already had done something to implement hardware single
stepping for kernel code. It would be great to be able to single-step
kernel code from KDB with the 'ss' command.

x86-like single-stepping could be implemented with non-matching IVA,
but there is the problem that enabling monitor mode in SVC mode will
immediately result in a trap. That can be worked around by always
exiting SVC through ABT mode, where we can then turn on the debug
monitor... On every CPU exception we'd make sure to clear the monitor,
since with single-stepping on that would immediately fault again when
we switch to SVC.

To create semantics similar to single-stepping TF flag in x86 EFLAGS,
the kernel single-stepping BRV/BRC pair would be saved/restored in
__switch_to, single-stepping would skip the user-mode switches (would
step across), and single-stepping would step across preemption
(preemption transparent or even disabled).

The other difficulty is handling ldrex/strex, since blindly stepping
over them will result in a persistent acquire failure (due to the
clrex in svc_exit), but this can be worked around by doing something
like -
1) If next instruction is strex, we know it will fail. Wait for next
instruction.
2) This is the instruction we want to put a matching bp on, but can't
do it now since we haven't run it yet, and we will
    just trip on it. Wait for next instruction.
3) Set matching bp on prev instruction.
4) Let the ldrex/strex code repeat itself. Hit the matching bp.
5) Continue single-stepping.

I originally thought of this for KGDB, but gdb seems to want to send
anything but an "s-packet" (it tries various BP instructions like X
and Z-packets, then just scribbles over memory to create an invld
exc.). It's still useful for KDB and GDB could be made aware I
suppose...

Thoughts?
A
