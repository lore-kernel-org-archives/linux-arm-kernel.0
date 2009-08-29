From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sat, 29 Aug 2009 13:27:28 +0100
Subject: Kernel related (?) user space crash at ARM11 MPCore
In-Reply-To: <20090817140422.GA10764@n2100.arm.linux.org.uk>
References: <4A7AEEB6.5060903@googlemail.com>
	<1250184014.14019.40.camel@pc1117.cambridge.arm.com>
	<1250501311.9858.24.camel@pc1117.cambridge.arm.com>
	<20090817140422.GA10764@n2100.arm.linux.org.uk>
Message-ID: <1251548848.5030.11.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2009-08-17 at 15:04 +0100, Russell King - ARM Linux wrote:
> On Mon, Aug 17, 2009 at 10:28:31AM +0100, Catalin Marinas wrote:
> > On Thu, 2009-08-13 at 18:20 +0100, Catalin Marinas wrote:
> > > Since I can't statically link the above code (ld complaining about some
> > > relocation), it means that the dynamic linker needs to do some
> > > relocations at run-time. Would it need to flush the cache for those
> > > relocations? I don't see any calls to the ARM-specific cache flushing
> > > syscall and the difference on ARM11MPCore from other CPUs is that the
> > > caches are always write-allocate. This may explain why adding a full
> > > cache flush apparently solves the problem, but it's not a solution.
> > 
> > At a first look, it's only data which is relocated rather than code, so
> > cache flushing should be required. More investigation into the dynamic
> > linker is needed here.
> > 
> > What I noticed when running through strace is that the dynamic loader
> > executes a few mprotect() calls on the application code mapped at
> > 0x2a000000. The first one sets permissions to PROT_READ|PROT_WRITE,
> > which implies that it may need to do some modifications. This is
> > followed by setting the PROT_READ|PROT_EXEC back.
> 
> This is probably for one of the GOT such like tables.  I seem to
> remember that function calls to libraries are implemented as something
> like:
> 
> 	ldr	pc, . + 4
> 	.word	0
> 
> and the dynamic linker fixes up the ".word 0" to be the actual address.
> This means that the dynamic linker requires RW access to this table,
> but then has to set it back to RX access so that the instructions can
> be executed.

It looks like this is causing the problem. Setting the protection to RW
and writing data (not instructions) causes the text page to be COW'ed
(page mapped with MAP_PRIVATE). Some cache flushing is missing on VIPT
caches during page copying for COW. With ARM11MPCore, the D-cache is
write-allocate so it never makes it to the main memory for the I-cache
to pick.

I'll look again next week on where to best add the flushing (or just
modify the dynamic linker to avoid COW on text pages). Any suggestions?

-- 
Catalin
