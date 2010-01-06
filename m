From: jamie@shareable.org (Jamie Lokier)
Date: Wed, 6 Jan 2010 21:53:36 +0000
Subject: [PATCH] ARM: Add SWP/SWPB emulation for ARMv7 processors (v3)
Message-ID: <20100106215336.GA19488@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Leif Lindholm wrote:
> > From: Jamie Lokier [mailto:jamie at shareable.org]
> > Then calling it like this:
> > 
> > 		__user_swp_asm(data, address, res, "");
> > 		__user_swp_asm(data, address, res, "b");
> 
> Neat.
> But how about, for clarity, keeping the calling syntax in the calling
> functions and add macros for the variants?:
> 
> #define __user_swp_asm_generic(data, addr, res, B) \
> ...
> #define __user_swp_asm(data, addr, res) \
>         __user_swp_asm_generic(data, addr, res, "")
> #define __user_swpb_asm(data, addr, res) \
>         __user_swp_asm_generic(data, addr, res, "b")

I'd just call the generic one __user_swpX_data and call it - I don't
think the additional tiny macros add any clarity, particularly with
being used in one place just a few lines down.  But it's totally
subjective and up to you.

> > > +static int emulate_swp(struct pt_regs *regs, unsigned int address,
> > > +		       unsigned int destreg, unsigned int data)
> > 
> > > +static int emulate_swpb(struct pt_regs *regs, unsigned int address,
> > > +			unsigned int destreg, unsigned int data)
> > 
> > Two almost identical functions.  I wonder if it would be better to
> > merge them and take a flag.  It would also reduce the compiled code
> > size.
> 
> I'm hesitant to add more than 4 arguments (adds stack overhead).
> Also, at least cs2009q3 gcc (4.3.3) seems to inline both of these, so
> not sure a codesize improvement would occur in practise.

If they are inlined, there is no stack overhead.  Mainly I thought
it would make the source smaller/tidier tidier :-)

> > Why is the smp_mb() needed?  I don't doubt there's a reason, but I
> > don't see what it is.
> 
> A DMB is required between acquiring a lock and accessing the protected
> resource, as well as between modifying a protected resource and
> releasing its lock. Because there is no way to tell whether the SWP
> performed a lock or unlock operation, inserting the barriers on
> either side seemed the safest way to ensure that code written for ARMv5
> or earlier would work as expected.
> 
> I guess a case could be made that this is an application problem and
> should be resolved at that end.

That's a really good reason, and thanks for thinking of it: To make
ARMv5 application code that doesn't know about DMB work properly.  Any
code which is DMB-aware is likely to use LDREX/STREX itself, so this
is great match. :-)

However, please follow this advice from Documentation/SubmitChecklist:

>>    24: All memory barriers {e.g., barrier(), rmb(), wmb()} need a
>>        comment in the source code that explains the logic of what
>>        they are doing and why.

I think a comment is even more important in this case, because the
barriers are an ABI design decision you've made; nobody could deduce
why they are there from SMP correctness alone.

Unfortunately there are other places in threaded code that need DMB
(for example any good implementation of pthread_once), so ARMv5
threaded code can still fail in subtle, unpredictable ways :-( Is it
possible to turn off weak memory ordering, after a SWP instruction is
detected?  Though even that would not ensure correctness of
pthread_once equivalent if it comes before any mutex locks in a program :(

I wonder, too, about what ARM ARM says about LDREX/STREX only working
on memory with the "Shared TLB attribute".  Will single-threaded code
using SWP on mapped shared memory get its expected atomic behaviour at
all with your emulation?

> Good point, will do that in the next version.
>  
> > > +#ifndef CONFIG_ALIGNMENT_TRAP
> > > +	res = proc_mkdir("cpu", NULL);
> 
> > ?  Is that to work with different kernel versions?
> 
> It's to ensure it would work (without console warnings) even if someone
> decides to disable ALIGNMENT_TRAP. An alternative would be to strip the
> creation of /proc/cpu out from mm/alignment.c and put it somewhere else
> (or move the stats file somewhere else - but it seemed logical to group
> with /proc/alignment).

Seems to me both should be sysfs CPU attributes anyway, but I don't
know much about that so don't take my word for it.  The ifdef is kind
of ugly but maybe unavoidable.

-- Jamie
