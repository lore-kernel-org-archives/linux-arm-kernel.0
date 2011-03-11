From: will.deacon@arm.com (Will Deacon)
Date: Fri, 11 Mar 2011 16:33:01 -0000
Subject: Single-stepping ARMv7 with KDB...
In-Reply-To: <AANLkTimBAm-Eaordw-KSPnEycQYz2z4QM+Dc5nauLFxh@mail.gmail.com>
References: <AANLkTimBAm-Eaordw-KSPnEycQYz2z4QM+Dc5nauLFxh@mail.gmail.com>
Message-ID: <000501cbe009$fd53b4c0$f7fb1e40$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrei,

> I know that there has been a lot of work recently in cleaning -up
> hardware single stepping / bp support, and from what I have seen this
> has been to support user mode stepping. I'm sorry ahead of time if
> someone already had done something to implement hardware single
> stepping for kernel code. It would be great to be able to single-step
> kernel code from KDB with the 'ss' command.

ARM now has support for hardware breakpoints and watchpoints using
the new hw_breakpoint framework (which in turn is built on top of perf).

On v7 debug with the co-processor interface (for example, Cortex-A9) we
use mismatch breakpoints for single-stepping over a hit breakpoint before
reinserting it again. For breakpoints inside the kernel, we require the
debugger to register an `overflow handler' which must handle this
single-stepping itself.
 
x86 uses the hw_breakpoint framework for handling hardware breakpoints
in KGDB (see kgdb_correct_hw_break for how it converts breakinfo
structures into perf_events) so it might be possible to do something
similar for single-step on ARM if we allow the kernel to specify that
the breakpoint is to be a mismatch by poking the step_ctrl field in
the arch_hw_breakpoint struct.

> The other difficulty is handling ldrex/strex, since blindly stepping
> over them will result in a persistent acquire failure (due to the
> clrex in svc_exit), but this can be worked around by doing something
> like -
> 1) If next instruction is strex, we know it will fail. Wait for next
> instruction.
> 2) This is the instruction we want to put a matching bp on, but can't
> do it now since we haven't run it yet, and we will
>     just trip on it. Wait for next instruction.
> 3) Set matching bp on prev instruction.
> 4) Let the ldrex/strex code repeat itself. Hit the matching bp.
> 5) Continue single-stepping.

IIRC the powerpc code in GDB does something similar to this (actually, it
looks ahead to try and find the store to pair with the load).

Will
