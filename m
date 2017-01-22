From: mzoran@crowfest.net (Michael Zoran)
Date: Sun, 22 Jan 2017 03:22:53 -0800
Subject: ARM64: Disabling warnings about deprecated armv8 instructions
In-Reply-To: <1485083115.1308.10.camel@crowfest.net>
References: <1485072424.14066.2.camel@crowfest.net>
 <9647813.NZ2c5cYUSH@localhost> <1485075528.14345.1.camel@crowfest.net>
 <20170122170523.3b4b1235@xhacker> <1485077887.1308.2.camel@crowfest.net>
 <CAKv+Gu9gBPenhOBj9G7rrqi3h_oMi3X7qpmsK+SB1dgBtzfKTg@mail.gmail.com>
 <1485078760.1308.6.camel@crowfest.net>
 <CAKv+Gu8rM9b2QrkKRVW=7FQLherg9fcv+H+01s+axsN9uZCBmg@mail.gmail.com>
 <1485083115.1308.10.camel@crowfest.net>
Message-ID: <1485084173.1308.12.camel@crowfest.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2017-01-22 at 03:05 -0800, Michael Zoran wrote:
> On Sun, 2017-01-22 at 10:54 +0000, Ard Biesheuvel wrote:
> > Did you try linux32?
> > 
> > pi at raspberrypi:~$ uname -a
> > Linux raspberrypi 4.10.0-rc3-v8+ #3 SMP PREEMPT Sun Jan 15 15:22:12
> > WET 2017 aarch64 GNU/Linux
> > pi at raspberrypi:~ $ linux32 uname -a
> > Linux raspberrypi 4.10.0-rc3-v8+ #3 SMP PREEMPT Sun Jan 15 15:22:12
> > WET 2017 armv8l GNU/Linux
> > 
> > If the app in question cannot deal with the armv8l personality, the
> > app should be fixed instead.
> 
> Thanks, I didn't know about the tool.
> 
> I'm looking at the code in arch/arm64/include/asm/elf.h. I'm looking
> at
> the COMPAT_SET_PERSONALITY macro.??It appears to be broken.??It
> seems?
> like it should have a call to set_personality with PER_LINUX32.??
> 
> If I look in include/uapi/linux/personality.h, I see some very
> interesting things. Quite the complex set of options I would say.
> 
> /*
> ?* Flags for bug emulation.
> ?*
> ?* These occupy the top three bytes.
> ?*/
> enum {
> 	UNAME26	=???????????????0x0020000,
> 	ADDR_NO_RANDOMIZE =?	0x0040000,	/* disable
> randomization of VA space */
> 	FDPIC_FUNCPTRS =	0x0080000,	/* userspace function
> ptrs point to descriptors
> 						?* (signal handling)
> 						?*/
> 	MMAP_PAGE_ZERO =	0x0100000,
> 	ADDR_COMPAT_LAYOUT =	0x0200000,
> 	READ_IMPLIES_EXEC =	0x0400000,
> 	ADDR_LIMIT_32BIT =	0x0800000,
> 	SHORT_INODE =		0x1000000,
> 	WHOLE_SECONDS =		0x2000000,
> 	STICKY_TIMEOUTS	=	0x4000000,
> 	ADDR_LIMIT_3GB =?	0x8000000,
> };
> 
> /*
> ?* Security-relevant compatibility flags that must be
> ?* cleared upon setuid or setgid exec:
> ?*/
> #define PER_CLEAR_ON_SETID (READ_IMPLIES_EXEC??| \
> 			????ADDR_NO_RANDOMIZE??| \
> 			????ADDR_COMPAT_LAYOUT | \
> 			????MMAP_PAGE_ZERO)
> 
> /*
> ?* Personality types.
> ?*
> ?* These go in the low byte.??Avoid using the top bit, it will
> ?* conflict with error returns.
> ?*/
> enum {
> 	PER_LINUX =		0x0000,
> 	PER_LINUX_32BIT =	0x0000 | ADDR_LIMIT_32BIT,
> 	PER_LINUX_FDPIC =	0x0000 | FDPIC_FUNCPTRS,
> 	PER_SVR4 =		0x0001 | STICKY_TIMEOUTS |
> MMAP_PAGE_ZERO,
> 	PER_SVR3 =		0x0002 | STICKY_TIMEOUTS |
> SHORT_INODE,
> 	PER_SCOSVR3 =		0x0003 | STICKY_TIMEOUTS |
> 					?WHOLE_SECONDS | SHORT_INODE,
> 	PER_OSR5 =		0x0003 | STICKY_TIMEOUTS |
> WHOLE_SECONDS,
> 	PER_WYSEV386 =		0x0004 | STICKY_TIMEOUTS |
> SHORT_INODE,
> 	PER_ISCR4 =		0x0005 | STICKY_TIMEOUTS,
> 	PER_BSD =		0x0006,
> 	PER_SUNOS =		0x0006 | STICKY_TIMEOUTS,
> 	PER_XENIX =		0x0007 | STICKY_TIMEOUTS |
> SHORT_INODE,
> 	PER_LINUX32 =		0x0008,
> 	PER_LINUX32_3GB =	0x0008 | ADDR_LIMIT_3GB,
> 	PER_IRIX32 =		0x0009 | STICKY_TIMEOUTS,/* IRIX5
> 32-bit */
> 	PER_IRIXN32 =		0x000a | STICKY_TIMEOUTS,/* IRIX6
> new 32-bit */
> 	PER_IRIX64 =		0x000b | STICKY_TIMEOUTS,/* IRIX6
> 64-bit */
> 	PER_RISCOS =		0x000c,
> 	PER_SOLARIS =		0x000d | STICKY_TIMEOUTS,
> 	PER_UW7 =		0x000e | STICKY_TIMEOUTS |
> MMAP_PAGE_ZERO,
> 	PER_OSF4 =		0x000f,			?/*
> OSF/1 v4 */
> 	PER_HPUX =		0x0010,
> 	PER_MASK =		0x00ff,
> };
> 

OK, I got mathematica to load without using the linux32 tool.

I changed the macro to this. 

#define COMPAT_SET_PERSONALITY(ex)					
\
({									
\
	set_bit(TIF_32BIT, &current->mm->context.flags);		
\
	set_thread_flag(TIF_32BIT);					
\
	set_personality(current->personality??=
PER_LINUX32);???????????\
})

 But I'm not sure that is really the correct set of options.   Why not
PER_LINUX32_3GB or PER_LINUX_32BIT?
