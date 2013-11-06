From: Michael.McTernan.2001@cs.bris.ac.uk (Michael McTernan)
Date: Wed, 06 Nov 2013 19:38:33 +0000
Subject: mm: get_user_pages_fast()
In-Reply-To: <20131106105400.GV16735@n2100.arm.linux.org.uk>
References: <52797483.2000105@cs.bris.ac.uk>
 <20131106105400.GV16735@n2100.arm.linux.org.uk>
Message-ID: <527A9AB9.8060306@cs.bris.ac.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/06/2013 10:54 AM, Russell King - ARM Linux wrote:
> Firstly, please stop this madness.

In the context of an embedded system, where memory is shared between 
CPUs, DSP, FPGAs and some peripherals, and where the SCU is maintaining 
coherency on selected areas, this is a feature of the platform, not 
madness.

 > Placing futexes in IO memory is not supported, period.

Except the _PRIVATE futex calls do work fine in IO memory since they 
don't walk the process page tables to determine the 'key' from the 
address.  These a limited to only sync between threads in the same 
processes though.

 > You can't map random bits of /dev/mem and expect
 > this stuff to work.

Nothing I am mapping is random.

> (b) you are allowed to map memory outside of that, but you get it as
> strongly ordered memory.
>
> (b) means that the load/store exclusives, which userspace mutexes will
> use on ARMv6+, will not work correctly.
> (they're not supported to strongly ordered memory by the architecture.)

I don't see this stated in the ARM Architecture Reference Manual. 
Instead I see it saying that it is implementation dependent whether 
LDREX and STREX work on strongly ordered memory (section A3.4.5).

> In other words, don't put mutexes in memory you've remapped from /dev/mem.
> In fact, as an application, you should not be mapping /dev/mem at all.

It's certainly more standard to map the mutexes() out of something like 
file backed mmap(), but that isn't as elegant for my application.

To give a bit of background, what we have is some memory at a know 
address which controls a peripheral.  Part of the peripheral addresses 
are buffers and registers, but some is set aside for use by software. 
Being able to map this whole section into userspace makes for really 
fast fast-paths where the driver is basically outside the kernel.  Also 
keeping driver state variables in the peripheral RAM means things can be 
restarted if the Linux processes crash or die, or even if the whole of 
Linux were to be restarted for some reason.  So it's more than 
convenient to have the mutexes work there, though as an easier goal I'll 
probably just get the futex calls to work for my applications.

Hopefully this doesn't sound as mad as first assumed & thanks for your time.

Kind Regards,

Mike
