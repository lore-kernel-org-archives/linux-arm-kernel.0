From: leif.lindholm@arm.com (Leif Lindholm)
Date: Wed, 6 Jan 2010 19:19:36 -0000
Subject: [PATCH] ARM: Add SWP/SWPB emulation for ARMv7 processors (v3)
In-Reply-To: <20100105194328.GG14376@shareable.org>
References: <20100105182447.5374.79579.stgit@e101986-lin>
	<20100105194328.GG14376@shareable.org>
Message-ID: <000001ca8f05$2fbb4150$8f31c3f0$@lindholm@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Jamie Lokier [mailto:jamie at shareable.org]
> Sent: 05 January 2010 19:43

> They are almost identical.  The duplication could be removed by
> folding it into a single macro with another argument, like this:
> 
> #define __user_swp_asm(data, addr, res, B)			\
> 	"	mov	r3, %1\n"				\
> 	"0:	ldrex"B"	%1, [%2]\n"			\
> 	"1:	strex"B"	%0, r3, [%2]\n"			\
> 
> Then calling it like this:
> 
> 		__user_swp_asm(data, address, res, "");
> 		__user_swp_asm(data, address, res, "b");

Neat.
But how about, for clarity, keeping the calling syntax in the calling
functions and add macros for the variants?:

#define __user_swp_asm_generic(data, addr, res, B) \
...
#define __user_swp_asm(data, addr, res) \
        __user_swp_asm_generic(data, addr, res, "")
#define __user_swpb_asm(data, addr, res) \
        __user_swp_asm_generic(data, addr, res, "b")
 
> > +	if (abtcounter == UINT_MAX)
> > +		printk(KERN_WARNING \
> > +		       "SWP{B} emulation abort counter wrapped!\n");
> > +	abtcounter++;
> 
> It's not atomic therefore not precise anyway.  Why not just use u64,
> and skip the test and printk?  The code will be shorter and
> ironically, faster with u64 because of omitting the test.

Fair enough. Will do.
 
> > +static int emulate_swp(struct pt_regs *regs, unsigned int address,
> > +		       unsigned int destreg, unsigned int data)
> 
> > +static int emulate_swpb(struct pt_regs *regs, unsigned int address,
> > +			unsigned int destreg, unsigned int data)
> 
> Two almost identical functions.  I wonder if it would be better to
> merge them and take a flag.  It would also reduce the compiled code
> size.

I'm hesitant to add more than 4 arguments (adds stack overhead).
Also, at least cs2009q3 gcc (4.3.3) seems to inline both of these, so
not sure a codesize improvement would occur in practise.

An alternative would of course be to merge them into swp_handler(), but
that would make that function a bit messy.

> Why is the smp_mb() needed?  I don't doubt there's a reason, but I
> don't see what it is.

A DMB is required between acquiring a lock and accessing the protected
resource, as well as between modifying a protected resource and
releasing its lock. Because there is no way to tell whether the SWP
performed a lock or unlock operation, inserting the barriers on
either side seemed the safest way to ensure that code written for ARMv5
or earlier would work as expected.

I guess a case could be made that this is an application problem and
should be resolved at that end.

> The loop looks ok, but it could be simpler in the common path:
> 
> 	while (1) {
> 		smp_mb();
> 		__user_swp_asm(data, address, res);
> 		if (likely(res != -EAGAIN) || signal_pending(current))
> 			break;
> 		cond_resched();
> 	}

Good point, will do that in the next version.
 
> > +#ifndef CONFIG_ALIGNMENT_TRAP
> > +	res = proc_mkdir("cpu", NULL);

> ?  Is that to work with different kernel versions?

It's to ensure it would work (without console warnings) even if someone
decides to disable ALIGNMENT_TRAP. An alternative would be to strip the
creation of /proc/cpu out from mm/alignment.c and put it somewhere else
(or move the stats file somewhere else - but it seemed logical to group
with /proc/alignment).

/
	Leif
