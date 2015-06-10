From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 10 Jun 2015 10:39:30 +0100
Subject: [PATCH] arm64: dts: add device tree for ARM SMM-A53x2 on
 LogicTile Express 20MG
In-Reply-To: <20150610092726.GV12807@e106497-lin.cambridge.arm.com>
References: <1433864311-2326-1-git-send-email-kristina.martsenko@arm.com>
 <20150610085825.GS12807@e106497-lin.cambridge.arm.com>
 <20150610091234.GA1517@leverpostej>
 <20150610092726.GV12807@e106497-lin.cambridge.arm.com>
Message-ID: <20150610093930.GC1517@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > > +/* In use by spinning secondaries */
> > > > +/memreserve/ 0x80000000 0x00010000;
> > > 
> > > Where does the kernel get loaded to? If 0x80000000 is the start of memory and the kernel is
> > > loaded at 0x80000 offset as usual, then that memory is protected anyway.
> > 
> > That's simply not true. The kernel may use _any_ memory which is
> > described to it and not explicitly reserved.
> > 
> > We only reserve the kernel's static image (see arm64_memblock_init),
> > which does not cover that region. We can easily map that memory and
> > allocate it to something.
> > 
> > While we used to place page tables in the end of that region, we only
> > reserved the page tables, and it was problematic because you had no idea
> > how much of that memory the kernel might use.
> > 
> > Regardless, DTs should not rely on Linux implementation details like
> > magic implicit reservations.
> 
> Things might have changed since v3.18 but I remember having a hell of a time trying to
> access memory that was at the bottom of address space before the kernel start image.

Memory more than 0x80000 bytes below the kernel wouldn't have been
mapped because of the way the linear map is built, which might have been
your issue. This is an implementation detail which _will_ change (see
Ard's patches) and should not be relied upon.

> But I agree that things should be explicitly stated in the DT.
> 
> Question for Kristina now: why spin method and not PSCI for this CoreTile?

Unfortunately the boot monitor only ever implemented spin-table. If
you're offering to port and maintain ARM Trusted Firmware, we can look
at having the DT report PSCI. ;)

Ideally we'd avoid placing the enable-method in the DTS at all, but I
believe the boot monitor isn't smart enough to fix that up.

Thanks,
Mark.
