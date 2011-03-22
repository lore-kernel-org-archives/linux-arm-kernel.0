From: andreiw@motorola.com (Andrei Warkentin)
Date: Tue, 22 Mar 2011 02:43:57 -0500
Subject: Single-stepping ARMv7 with KDB...
In-Reply-To: <766766263404232078@unknownmsgid>
References: <AANLkTimBAm-Eaordw-KSPnEycQYz2z4QM+Dc5nauLFxh@mail.gmail.com>
	<766766263404232078@unknownmsgid>
Message-ID: <AANLkTikL0KUdY5Ggv1BRfRQiwxyd9B6ooMXT2rPoVAxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 11, 2011 at 10:33 AM, Will Deacon <will.deacon@arm.com> wrote:
> Hi Andrei,
>
>> I know that there has been a lot of work recently in cleaning -up
>> hardware single stepping / bp support, and from what I have seen this
>> has been to support user mode stepping. I'm sorry ahead of time if
>> someone already had done something to implement hardware single
>> stepping for kernel code. It would be great to be able to single-step
>> kernel code from KDB with the 'ss' command.
>
> ARM now has support for hardware breakpoints and watchpoints using
> the new hw_breakpoint framework (which in turn is built on top of perf).
>
> On v7 debug with the co-processor interface (for example, Cortex-A9) we
> use mismatch breakpoints for single-stepping over a hit breakpoint before
> reinserting it again. For breakpoints inside the kernel, we require the
> debugger to register an `overflow handler' which must handle this
> single-stepping itself.
>
> x86 uses the hw_breakpoint framework for handling hardware breakpoints
> in KGDB (see kgdb_correct_hw_break for how it converts breakinfo
> structures into perf_events) so it might be possible to do something
> similar for single-step on ARM if we allow the kernel to specify that
> the breakpoint is to be a mismatch by poking the step_ctrl field in
> the arch_hw_breakpoint struct.

...in this case monitor mode will have to be turned on outside SVC,
else it will immediately trigger a debug abort inside the code
programming BRV/BRC for mismatch... I guess that's the point I wanted
to bring up. I suppose it's only really useful for KDB, as with KGDB
you can have a debugger take care of branches, and all you would need
to ensure is to save/restore breakpoints across context switches (and
reentrancy). I'll play with enabling 'ss' with KDB as soon as I get
linux-next running on our platform...

A
