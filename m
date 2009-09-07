From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 07 Sep 2009 16:29:32 +0100
Subject: Kernel related (?) user space crash at ARM11 MPCore
In-Reply-To: <1251707405.7930.7.camel@pc1117.cambridge.arm.com>
References: <4A7AEEB6.5060903@googlemail.com>
	<1250184014.14019.40.camel@pc1117.cambridge.arm.com>
	<1250501311.9858.24.camel@pc1117.cambridge.arm.com>
	<20090817140422.GA10764@n2100.arm.linux.org.uk>
	<1251548848.5030.11.camel@pc1117.cambridge.arm.com>
	<1251707405.7930.7.camel@pc1117.cambridge.arm.com>
Message-ID: <1252337372.23780.73.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Mon, 2009-08-31 at 09:30 +0100, Catalin Marinas wrote: 
> On Sat, 2009-08-29 at 13:27 +0100, Catalin Marinas wrote:
> > It looks like this is causing the problem. Setting the protection to RW
> > and writing data (not instructions) causes the text page to be COW'ed
> > (page mapped with MAP_PRIVATE). Some cache flushing is missing on VIPT
> > caches during page copying for COW. With ARM11MPCore, the D-cache is
> > write-allocate so it never makes it to the main memory for the I-cache
> > to pick.
> > 
> > I'll look again next week on where to best add the flushing (or just
> > modify the dynamic linker to avoid COW on text pages). Any suggestions?
> 
> After talking to the toolchain people, it seems that the dynamic linker
> is just doing whatever the ELF file says regarding the relocations. The
> problem in this case is that when compiling with -pie, one of the crt*.o
> files (and _start) used in PIE applications is not position-independent.
> 
> I think this was fixed (but not released yet) by CodeSourcery but you
> can get this behaviour if some files of an executable were not compiled
> with -fpic. So the mprotect cache flushing patch that I posted looks
> like a valid workaround.

There is a glibc patch to allow fully position-independent code and
avoid CoW for text pages:

http://sourceware.org/ml/libc-ports/2008-10/msg00009.html

We tested it and it seems to solve the problem without requiring a
kernel patch.

Any opinion on whether the ARM kernel should support dynamic shared
objects where not all objects are position-independent? IOW, whether
text relocations are allowed to be resolved at run-time rather than
compile (static link) time for the dynamic shared objects? AFAICT, there
isn't anything in the ARM EABI which would prevent this, so a kernel
patch may be needed.

There is a similar situation for RWX pages and CoW. In this case, the
copy_user_highpage() function should probably be modified to clean the
D-cache and invalidate the I-cache.

Thanks.

-- 
Catalin
