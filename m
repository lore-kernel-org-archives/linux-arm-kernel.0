From: Dave.Martin@arm.com (Dave P. Martin)
Date: Tue, 14 Sep 2010 13:35:02 +0100
Subject: Maximum bootable kernel size in current ARM linux
In-Reply-To: <20100913101039.GC2614@kw.sim.vm.gnt>
References: <4C8DD588.7040009@endruntechnologies.com>	<201009131043.48688.marek.vasut@gmail.com>	<AANLkTimti4ajAOR0_aZ8aeGu9PN4a0MX8dbpg6dpZJYf@mail.gmail.com>
	<20100913101039.GC2614@kw.sim.vm.gnt>
Message-ID: <000001cb5409$4726e000$4b4d010a@Emea.Arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org 
> [mailto:linux-arm-kernel-bounces at lists.infradead.org] On 
> Behalf Of Simon Guinot
> Sent: 13 September 2010 11:11
> To: Haojian Zhuang
> Cc: Marek Vasut; Russell King - ARM Linux; 
> linux-arm-kernel at lists.infradead.org; Bruce M. Penrod
> Subject: Re: Maximum bootable kernel size in current ARM linux

[...]

> The initramfs is located at the end of the init section and 
> before the text section. Because the kernel must be able to 
> 'branch' between the init and text sections, the initramfs 
> size can't be greater than the 'branch' maximum offset. 32MB ?

We can also build kernels in Thumb-2 (where the long branch range is +/- 4MB
IIRC)

I believe the linker should always generate trampolines to extend the range
of those branches where necessary, even when branching from assembler.  The
only case where this won't work is if you have individual objects whose text
section is so large there's nowhere to put the trampolines within the
required range, or where branch targets are fixed up by something other than
the linker (I'm guessing that's either a very rare situation or
nonexistent.)

These kind of fixup problems would result in link-time errors, but I don't
think I've observed this happening in practice.

Cheers
---Dave
