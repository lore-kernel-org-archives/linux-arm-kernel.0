From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 Nov 2013 19:57:25 +0000
Subject: mm: get_user_pages_fast()
In-Reply-To: <527A9AB9.8060306@cs.bris.ac.uk>
References: <52797483.2000105@cs.bris.ac.uk>
 <20131106105400.GV16735@n2100.arm.linux.org.uk>
 <527A9AB9.8060306@cs.bris.ac.uk>
Message-ID: <20131106195725.GD16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 06, 2013 at 07:38:33PM +0000, Michael McTernan wrote:
> On 11/06/2013 10:54 AM, Russell King - ARM Linux wrote:
>> Firstly, please stop this madness.
>
> In the context of an embedded system, where memory is shared between  
> CPUs, DSP, FPGAs and some peripherals, and where the SCU is maintaining  
> coherency on selected areas, this is a feature of the platform, not  
> madness.

Please expose the memory in a saner way rather than re-using /dev/mem.
/dev/mem is all well and good, but it has side effects with the way it
maps memory.  Having your own driver gives you control over that.  It's
also better practice because it avoids a whole load of security issues.

> > Placing futexes in IO memory is not supported, period.
>
> Except the _PRIVATE futex calls do work fine in IO memory since they  
> don't walk the process page tables to determine the 'key' from the  
> address.  These a limited to only sync between threads in the same  
> processes though.

Sorry, I should have said mutexes.  The point here is that userspace
pthreads can ldrex/strex on that memory before issuing any futex calls.

> > You can't map random bits of /dev/mem and expect
> > this stuff to work.
>
> Nothing I am mapping is random.

As far as I'm concerned, it's random areas of system memory - random in
the sense that it's not well defined what it is and what attributes it
should have in the page tables for things like memory type etc.  I
somehow doubt that you've thought about this at all, you just decided
that opening /dev/mem is a solution to your problem.

>> (b) means that the load/store exclusives, which userspace mutexes will
>> use on ARMv6+, will not work correctly.
>> (they're not supported to strongly ordered memory by the architecture.)
>
> I don't see this stated in the ARM Architecture Reference Manual.  
> Instead I see it saying that it is implementation dependent whether  
> LDREX and STREX work on strongly ordered memory (section A3.4.5).

Here's the latest wording:

  It is IMPLEMENTATION DEFINED whether LDREX and STREX operations can be
  performed to a memory region with the Device or Strongly-ordered memory
  attribute. Unless the implementation documentation explicitly states
  that LDREX and STREX operations to a memory region with the Device or
  Strongly-ordered attribute are permitted, the effect of such operations
  is UNPREDICTABLE.

In other words, it is only supported where it is explicitly documented
that it works on these memory types; otherwise it must be assumed that
they do not work...

However, that concern goes away if you provide your own device driver
in Linux to provide _just_ a mechanism to map this memory.  Plus, you
can restrict it to just being able to map this specific memory without
exposing the entire system RAM to anything which happens to exploit
your application.

>> In other words, don't put mutexes in memory you've remapped from /dev/mem.
>> In fact, as an application, you should not be mapping /dev/mem at all.
>
> It's certainly more standard to map the mutexes() out of something like  
> file backed mmap(), but that isn't as elegant for my application.
>
> To give a bit of background, what we have is some memory at a know  
> address which controls a peripheral.  Part of the peripheral addresses  
> are buffers and registers, but some is set aside for use by software.  
> Being able to map this whole section into userspace makes for really  
> fast fast-paths where the driver is basically outside the kernel.  Also  
> keeping driver state variables in the peripheral RAM means things can be  
> restarted if the Linux processes crash or die, or even if the whole of  
> Linux were to be restarted for some reason.  So it's more than  
> convenient to have the mutexes work there, though as an easier goal I'll  
> probably just get the futex calls to work for my applications.

So, what happens if Linux crashes having taken a pthread mutex in this
region, and your application then comes along and tries to regain that
lock?

Do you always re-initialise the mutexes (you technically have to if you
read the man page for pthread_mutex_lock() which tells you about a whole
raft of undefined behaviours concerning the pthread mutex implementation.)
