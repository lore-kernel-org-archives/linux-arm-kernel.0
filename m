From: Michael.McTernan.2001@cs.bris.ac.uk (Michael McTernan)
Date: Wed, 06 Nov 2013 22:31:22 +0000
Subject: mm: get_user_pages_fast()
In-Reply-To: <20131106195725.GD16735@n2100.arm.linux.org.uk>
References: <52797483.2000105@cs.bris.ac.uk>
 <20131106105400.GV16735@n2100.arm.linux.org.uk>
 <527A9AB9.8060306@cs.bris.ac.uk>
 <20131106195725.GD16735@n2100.arm.linux.org.uk>
Message-ID: <527AC33A.5080103@cs.bris.ac.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/06/2013 07:57 PM, Russell King - ARM Linux wrote:
> Please expose the memory in a saner way rather than re-using /dev/mem.
> /dev/mem is all well and good, but it has side effects with the way it
> maps memory.  Having your own driver gives you control over that.  It's
> also better practice because it avoids a whole load of security issues.

Sure - that's where I'm heading now.  The security isn't an issue for 
this application, though I accept it's good practice.

>>> Placing futexes in IO memory is not supported, period.
>>
>> Except the _PRIVATE futex calls do work fine in IO memory since they
>> don't walk the process page tables to determine the 'key' from the
>> address.
...
> Sorry, I should have said mutexes.  The point here is that userspace
> pthreads can ldrex/strex on that memory before issuing any futex calls.

Mutexes do access the memory, yes.

There is still inconsistency in futex behaviour, with _PRIVATE calls 
working for IO memory, non-private not.  This isn't ARM specific though.

>>> You can't map random bits of /dev/mem and expect
>>> this stuff to work.
>>
>> Nothing I am mapping is random.
>
> As far as I'm concerned, it's random areas of system memory - random in
> the sense that it's not well defined what it is and what attributes it
> should have in the page tables for things like memory type etc.  I
> somehow doubt that you've thought about this at all, you just decided
> that opening /dev/mem is a solution to your problem.

I didn't want to bore the list with gory details, but I didn't earlier 
state that I added a /dev/shmem and defined memory regions and types for 
the areas, with the required attributes for sharability and caching - so 
it isn't really random, though I see how it sounds like that from my 
original post.  /dev/shmem is a close cousin of /dev/mem, and has picked 
up the VM_PFNMAP and VM_IO flags which cause me inconvenience.

>>> (b) means that the load/store exclusives, which userspace mutexes will
>>> use on ARMv6+, will not work correctly.
>>> (they're not supported to strongly ordered memory by the architecture.)
>>
>> I don't see this stated in the ARM Architecture Reference Manual.
>> Instead I see it saying that it is implementation dependent whether
>> LDREX and STREX work on strongly ordered memory (section A3.4.5).
>
> Here's the latest wording:
>
>    It is IMPLEMENTATION DEFINED whether LDREX and STREX operations can be
>    performed to a memory region with the Device or Strongly-ordered memory
>    attribute. Unless the implementation documentation explicitly states
>    that LDREX and STREX operations to a memory region with the Device or
>    Strongly-ordered attribute are permitted, the effect of such operations
>    is UNPREDICTABLE.
>
> In other words, it is only supported where it is explicitly documented
> that it works on these memory types; otherwise it must be assumed that
> they do not work...

What you've quoted is not the same as your first statement that "they're 
not supported to strongly ordered memory by the architecture."  It's 
implementation defined, which means it is a possibility.

> So, what happens if Linux crashes having taken a pthread mutex in this
> region, and your application then comes along and tries to regain that
> lock?

Well there's a whole restart procedure needed to pick up state from the 
memory area and get back to sensible operation.  Re-initialising 
pthread_mutexes and some other counters and indices is all part of that 
- for a simple enough FIFO type interface it's not that difficult to 
cover potentially corrupt state variables, though getting good testing 
coverage is hard.  Fuzzing the restart state helps a lot, though the key 
is to keep the state space as small as possible.

Kind Regards,

Mike
