From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 08 May 2015 16:08:53 +0200
Subject: [Linaro-acpi] [PATCH 2/2] ACPI / scan: Parse _CCA and setup
 device coherency
In-Reply-To: <20150501110644.GF27755@e104818-lin.cambridge.arm.com>
References: <D1665A4F.19E17%suravee.suthikulpanit@amd.com>
 <2817500.sgztgK2NzB@wuerfel>
 <20150501110644.GF27755@e104818-lin.cambridge.arm.com>
Message-ID: <2927907.rePQ55aASC@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 01 May 2015 12:06:44 Catalin Marinas wrote:
> 
> > Note that there are lots of ways in which you could have noncoherent DMA:
> > the default on ARM32 is that it requires uncached access or explicit
> > cache flushes, but it's also possible to have an SMP system where a device
> > is only coherent with some of the CPUs and requires explicit synchronization
> > (not flushes) otherwise. In a multi-level cache hierarchy, there could be
> > all sorts of combinations of flushes and syncs you would need to do.
> > 
> > With DT, we handle this using SoC-specific overrides for platforms that
> > are noncoherent in funny ways, see
> > http://lxr.free-electrons.com/source/arch/arm/mach-mvebu/coherency.c?v=3.18#L263
> > for instance.
> 
> It looks like mach-mvebu no longer needs this, according to commit
> 1bd4d8a6de5c (ARM: mvebu: use arm_coherent_dma_ops and re-enable hardware
> I/O coherency).

Yes, Thomas Petazzoni found a way to configure that chip to essentially
provide PCI semantics where an MMIO read from a devices ensures that all
previous DMA has completed, which made the sync unnecessary. I believe
Marvell recommends against using that mode for performance reasons,
and they still use their own manual syncs in their vendor kernel.

> Even if some hardware needs this, it's usually because it has some
> broken assumptions about barriers which most likely are architecture
> non-compliant. We can work around it on a case by case basis (SoC
> quirks). One option would be to disable coherency altogether for that
> device, even if the performance is affected (e.g. no partial coherency).
> Another possibility may be to add a bus driver for that broken
> interconnect which installs its own dma ops for each device attached.

Whether the Armada XP example is broken or not is really a matter of
perspective. I would count it broken on the basis that is does not
match what the Linux DMA and MMIO APIs expect, but you can well build
an OS around their semantics.

> > If we just disallow DMA to devices that are marked with _CCA=0
> > in ACPI, we can avoid this case, or discuss it by the time someone has hardware
> > that wants it, and then make a more informed decision about it.
> 
> I don't think we should disallow DMA to devices with _CCA == 0 (only to
> those that don't have a _CCA property at all) as long as _CCA == 0 has
> clear semantics like only architected cache maintenance required (and
> that's what the ARMv8 ARM requires from compliant system caches).

Even if we exclude all cases in which the behavior may be unexpected,
there is still the other point I raised initially:

             what would that be good for?

Can you think of a case where a server system has a reason to use
a device in noncoherent mode? I think it's more likely to be a case
where a device got misconfigured accidentally by the firmware, and
we're better off warning about that in the kernel than trying to prepare
for an unknown hardware that might use an obscure feature of the spec.

	Arnd
