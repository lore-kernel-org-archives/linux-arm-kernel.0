From: will.deacon@arm.com (Will Deacon)
Date: Tue, 23 Apr 2013 10:09:43 +0100
Subject: [RFC PATCH v2 00/13] ARM: DT cpu bindings updates
In-Reply-To: <201304222118.41262.arnd@arndb.de>
References: <1366644455-16550-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20130422164112.GB3076@mudshark.cambridge.arm.com>
 <20130422180057.GB17071@e102568-lin.cambridge.arm.com>
 <201304222118.41262.arnd@arndb.de>
Message-ID: <20130423090942.GA17593@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

On Mon, Apr 22, 2013 at 08:18:41PM +0100, Arnd Bergmann wrote:
> On Monday 22 April 2013, Lorenzo Pieralisi wrote:
> > > Thoughts? I notice Catalin has some patches queued for arm64 which
> > > unconditionally use of_property_read_u64, but I have a patch to honour the
> > > #address-cells property instead.
> > 
> > Basically you want me to rule out passing a dtb with cpus node having
> > #address-cells == 2 to a 32-bit kernel, correct ? Or put it another way:

No, I'm not proposing that! I don't see why we couldn't make the same change
for 32-bit kernels and honour the address-cells field there too.

> > 
> > - a 32-bit kernel must always get passed a dtb with cpus node
> >   #address-cells == 1. 
> 
> Why that? For other registers, we allow leading zeroes. This is
> already required for MMIO registers on LPAE capable machines.

Indeed, we should probably allow any old #address-cells and parse the reg
property accordingly. Of course, if any bits above bit 31 are non-zero, then
we should complain loudly on an AArch32 system.

> >   If the system is ARMv8 with CPUs having
> >   MPIDR_EL1[63:32] != 0x0, well, running 32-bit kernel on it is not
> >   the safest thing to do anyway.
> 
> I would assume the hypervisor to provide a virtual MPIDR_EL1 for
> a 32 bit kernel in that case.

Correct, but that doesn't help with the bare-metal/host case (where we will
need to scream, as described above).

Also, when I mentioned the mpidr check, I was just referring to the boot
CPU -- you're right about the secondaries.

Will
