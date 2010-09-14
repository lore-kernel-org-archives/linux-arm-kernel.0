From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 14 Sep 2010 13:54:09 +0100
Subject: Maximum bootable kernel size in current ARM linux
In-Reply-To: <000001cb5409$4726e000$4b4d010a@Emea.Arm.com>
References: <4C8DD588.7040009@endruntechnologies.com>
	<201009131043.48688.marek.vasut@gmail.com>
	<AANLkTimti4ajAOR0_aZ8aeGu9PN4a0MX8dbpg6dpZJYf@mail.gmail.com>
	<20100913101039.GC2614@kw.sim.vm.gnt>
	<000001cb5409$4726e000$4b4d010a@Emea.Arm.com>
Message-ID: <1284468849.933.2.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-09-14 at 13:35 +0100, Dave P. Martin wrote:
> > The initramfs is located at the end of the init section and 
> > before the text section. Because the kernel must be able to 
> > 'branch' between the init and text sections, the initramfs 
> > size can't be greater than the 'branch' maximum offset. 32MB ?
> 
> We can also build kernels in Thumb-2 (where the long branch range is +/- 4MB
> IIRC)

I think the Thumb-2 branch goes up to 16MB range. The Thumb-1 may be
smaller but we don't support this in the kernel. That's why Thumb-2
modules are within 8MB below PAGE_OFFSET. But this leaves us with
maximum 8MB of kernel size.

> I believe the linker should always generate trampolines to extend the range
> of those branches where necessary, even when branching from assembler.  The
> only case where this won't work is if you have individual objects whose text
> section is so large there's nowhere to put the trampolines within the
> required range, or where branch targets are fixed up by something other than
> the linker (I'm guessing that's either a very rare situation or
> nonexistent.)

We would need some additional relocations handling in the modules
loading code.

-- 
Catalin
