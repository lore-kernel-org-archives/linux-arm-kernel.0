From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 23 Apr 2015 12:24:58 +0100
Subject: [PATCH 5/6] ARM: re-implement physical address space switching
In-Reply-To: <552E9F9B.2040400@oracle.com>
References: <20150408094438.GM12732@n2100.arm.linux.org.uk>
 <E1YfmY6-0006X3-1N@rmk-PC.arm.linux.org.uk>
 <20150408173656.GF5977@leverpostej>
 <20150408175533.GN12732@n2100.arm.linux.org.uk>
 <552C14F0.7020006@oracle.com> <20150415120738.GD2866@leverpostej>
 <552E9F9B.2040400@oracle.com>
Message-ID: <20150423112449.GB17361@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> >>>>> +ENTRY(lpae_pgtables_remap_asm)
> >>>>> +       stmfd   sp!, {r4-r8, lr}
> >>>>> +
> >>>>> +       mrc     p15, 0, r8, c1, c0, 0           @ read control reg
> >>>>> +       bic     ip, r8, #CR_M                   @ disable caches and MMU
> >>>>> +       mcr     p15, 0, ip, c1, c0, 0
> >>>>> +       dsb
> >>>>> +       isb
> >>>>
> >>>> Shouldn't the DSB be between the STMFD and the MCR (given the SP doesn't
> >>>> point to an idmap/physical address)?
> >>>>
> >>>> I don't see why we need a DSB after the write to the SCTLR.
> >>>>
> >> dsb can be moved up after stmfd but leaving as above should be fine
> >> as well.
> >
> > I don't think that it's safe to leave it where it is. Currently the
> > STMFD could be reordered w.r.t. the cp15 accesses, and hence the write
> > may occur with translation disabled (and would go to the wrong physical
> > address).
> >
> > We need to ensure that the STMFD is executed before the MCR potentially
> > changes the execution context. The DSB will ensure that in addition to
> > ensuring completion of the write (i.e. it isn't left sat in a write
> > buffer).
> >
> I see your point. Thanks for expanding it.

It turns out that I was incorrect in my assertion, and the reordering I
suggested above can't happen. The ARMv7 ARM states:

	Any direct write to a system control register is guaranteed not
	to affect any instruction that appears, in program
	order, before the instruction that performed the direct write

Which means that the STMFD cannot be affected by the later cp15 write to
the SCTLR, and so the DSB does not need to be moved before the MCR.

I apologise for adding to the confusion there.

Mark.
