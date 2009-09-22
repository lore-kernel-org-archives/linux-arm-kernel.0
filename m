From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 22 Sep 2009 10:21:13 +0100
Subject: Kernel related (?) user space crash at ARM11 MPCore
In-Reply-To: <20090921223338.GH14700@shareable.org>
References: <1253435940.498.15.camel@pc1117.cambridge.arm.com>
	<20090920093139.GA1704@n2100.arm.linux.org.uk>
	<20090920190227.GB5413@n2100.arm.linux.org.uk>
	<4AB6B0AB.8040307@arm.com> <20090921083109.GC20006@shareable.org>
	<1253522944.1541.3.camel@pc1117.cambridge.arm.com>
	<20090921085425.GC27357@n2100.arm.linux.org.uk>
	<1253526263.1541.32.camel@pc1117.cambridge.arm.com>
	<20090921100751.GF27357@n2100.arm.linux.org.uk>
	<20090921213802.GH30821@n2100.arm.linux.org.uk>
	<20090921223338.GH14700@shareable.org>
Message-ID: <1253611273.14049.30.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2009-09-21 at 23:33 +0100, Jamie Lokier wrote:
> Russell King - ARM Linux wrote:
> > So, mprotect(rw) actually ends up as mprotect(rwx), which means that
> > effectively _all_ VMAs have been executable.
> > 
> > This approach won't work as well as I'd hope, since this means every
> > COW fault ends up triggering the cache flush.
> > 
> > However, the same problem affects Catalin's approach too - with these
> > binaries, every VMA has VM_EXEC set, which means every VMA gets the
> > cache flushing treatment whenever flush_cache_range() is called.
> > 
> > This is a nasty problem to solve...
> 
> Would it be so harmful if mprotect(rw) were treated as mprotect(rw),
> while mprotect(r) is treated as mprotect(rx)?  Sure, someone _could_
> exec from rw pages, but they _should not_ be doing so if they haven't
> set PROT_EXEC.

For OABI, I think we rely on executable user stack for signal handling
and the arm_elf_read_implies_exec() always returns 1. There are also
tools like like this - http://linux.die.net/man/8/execstack - or maybe
the toolchain setting the PT_GNU_STACK which would also set the
read_implies_exec for the stack. And the stack must be writable.

-- 
Catalin
