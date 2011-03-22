From: andreiw@motorola.com (Andrei Warkentin)
Date: Tue, 22 Mar 2011 17:26:18 -0500
Subject: Single-stepping ARMv7 with KDB...
In-Reply-To: <8808174326287130926@unknownmsgid>
References: <AANLkTimBAm-Eaordw-KSPnEycQYz2z4QM+Dc5nauLFxh@mail.gmail.com>
	<766766263404232078@unknownmsgid>
	<AANLkTikL0KUdY5Ggv1BRfRQiwxyd9B6ooMXT2rPoVAxA@mail.gmail.com>
	<8808174326287130926@unknownmsgid>
Message-ID: <AANLkTim3uhH-LwM=-cx7CjRvCKSt3doeo9BiPXjFAYd0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 22, 2011 at 2:52 PM, Will Deacon <will.deacon@arm.com> wrote:
> Hi Andrei,
>
>> > x86 uses the hw_breakpoint framework for handling hardware breakpoints
>> > in KGDB (see kgdb_correct_hw_break for how it converts breakinfo
>> > structures into perf_events) so it might be possible to do something
>> > similar for single-step on ARM if we allow the kernel to specify that
>> > the breakpoint is to be a mismatch by poking the step_ctrl field in
>> > the arch_hw_breakpoint struct.
>>
>> ...in this case monitor mode will have to be turned on outside SVC,
>> else it will immediately trigger a debug abort inside the code
>> programming BRV/BRC for mismatch... I guess that's the point I wanted
>> to bring up. I suppose it's only really useful for KDB, as with KGDB
>> you can have a debugger take care of branches, and all you would need
>> to ensure is to save/restore breakpoints across context switches (and
>> reentrancy). I'll play with enabling 'ss' with KDB as soon as I get
>> linux-next running on our platform...
>
> At the moment monitor mode is enabled all of the time, so you might
> want to add a thread flag when a thread is using hardware debugging
> resources. You can check that on return to userspace and enable monitor
> mode only then (I'm not sure about your ABT trick, need to check the
> docs). There will still be places in the hardware breakpoint code where
> we need monitor mode enabled so you'll need to bank any mismatch
> breakpoints over these regions of code and disable monitor mode before
> reinstalling them again.
>

I had an ugly proof-of-concept that worked on a Cortex A9 (more or
less...as long as you didn't step on clrex/strex or used Thumb code).
I guess I mostly thought people would be averse to adding
exit-through-ABT code, but there isn't really a better way to
otherwise be able to step through most of the Linux kernel from KDB
(that I am aware of), and it would be conditionally compiled if KDB
support is enabled.

If you look on Cortex A9 TRM (10.3.3), the SP [2:1] field in the BRC
register let's you condition the breakpoint for either USR/SVC/SYS,
SVC/SYS, USR or 'any'. 'any' is not  usable outside of halting mode
for single-stepping purposes, so USR/SVC/SYS it is, and it's not so
bad - you lose the ability to trace the little bit of exception code
that runs before switching to SVC, as well as FIQ handlers, but I feel
that's pretty minor.

> Note that enabling monitor mode is pretty error prone and might not
> even be possible on your CPU so the failure path needs to be graceful.

Toggling it is not a good idea, then, especially since you still want
other active break/watch-points to trigger, so I would just reserve a
BRC/BRV pair if KDB was compiled in and bank the values...

A
