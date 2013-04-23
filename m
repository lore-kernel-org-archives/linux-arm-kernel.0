From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 23 Apr 2013 10:34:49 +0100
Subject: [RFC PATCH v2 00/13] ARM: DT cpu bindings updates
In-Reply-To: <20130423090942.GA17593@mudshark.cambridge.arm.com>
References: <1366644455-16550-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20130422164112.GB3076@mudshark.cambridge.arm.com>
 <20130422180057.GB17071@e102568-lin.cambridge.arm.com>
 <201304222118.41262.arnd@arndb.de>
 <20130423090942.GA17593@mudshark.cambridge.arm.com>
Message-ID: <20130423093449.GD22946@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 23, 2013 at 10:09:43AM +0100, Will Deacon wrote:
> Hi Lorenzo,
> 
> On Mon, Apr 22, 2013 at 08:18:41PM +0100, Arnd Bergmann wrote:
> > On Monday 22 April 2013, Lorenzo Pieralisi wrote:
> > > > Thoughts? I notice Catalin has some patches queued for arm64 which
> > > > unconditionally use of_property_read_u64, but I have a patch to honour the
> > > > #address-cells property instead.
> > > 
> > > Basically you want me to rule out passing a dtb with cpus node having
> > > #address-cells == 2 to a 32-bit kernel, correct ? Or put it another way:
> 
> No, I'm not proposing that! I don't see why we couldn't make the same change
> for 32-bit kernels and honour the address-cells field there too.

Ok, that was a misunderstanding. I do honour the address-cells field in
the arm32 kernel, but there is code that does not and must be fixed (or
removed, I have to knock together an RFC to do that or ping the authors
and let them do it).

> > > - a 32-bit kernel must always get passed a dtb with cpus node
> > >   #address-cells == 1. 
> > 
> > Why that? For other registers, we allow leading zeroes. This is
> > already required for MMIO registers on LPAE capable machines.
> 
> Indeed, we should probably allow any old #address-cells and parse the reg
> property accordingly. Of course, if any bits above bit 31 are non-zero, then
> we should complain loudly on an AArch32 system.

That's what I do, but again there is code that does not check that and
honestly what I would like to do is parsing the reg property once for
all at cpu_logical_map init time to avoid reg property parsing proliferation
in the kernel.

> > >   If the system is ARMv8 with CPUs having
> > >   MPIDR_EL1[63:32] != 0x0, well, running 32-bit kernel on it is not
> > >   the safest thing to do anyway.
> > 
> > I would assume the hypervisor to provide a virtual MPIDR_EL1 for
> > a 32 bit kernel in that case.
> 
> Correct, but that doesn't help with the bare-metal/host case (where we will
> need to scream, as described above).
> 
> Also, when I mentioned the mpidr check, I was just referring to the boot
> CPU -- you're right about the secondaries.

Ok, that's agreed.

Thanks,
Lorenzo
