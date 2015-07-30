From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 30 Jul 2015 17:12:11 +0100
Subject: [RFC] arm64: defconfig: enable 48-bit VA by default
In-Reply-To: <CY1PR0301MB074850E27D5D298D1B8495D2878B0@CY1PR0301MB0748.namprd03.prod.outlook.com>
References: <CY1PR0301MB07488D6DC5F0B171D6B290E187830@CY1PR0301MB0748.namprd03.prod.outlook.com>
 <55B0E1AD.60409@arm.com>
 <BY2PR0301MB0743CBCFC5476E39A5D1EC0B878C0@BY2PR0301MB0743.namprd03.prod.outlook.com>
 <CAKv+Gu9LHBd7wM6P4H0X5WigzDETtpr2++_Ebo=adg5QtTOW2w@mail.gmail.com>
 <BY2PR0301MB074300C5F31701D9211827F0878C0@BY2PR0301MB0743.namprd03.prod.outlook.com>
 <20150730101358.GA30796@e104818-lin.cambridge.arm.com>
 <CY1PR0301MB074850E27D5D298D1B8495D2878B0@CY1PR0301MB0748.namprd03.prod.outlook.com>
Message-ID: <20150730161210.GE407@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 30, 2015 at 02:52:40PM +0000, Stuart Yoder wrote:
> > -----Original Message-----
> > From: Catalin Marinas [mailto:catalin.marinas at arm.com]
> > > Yes, our physical memory layout for RAM looks like this:
> > > 2 GB at 0x8000_0000
> > > 510 GB at 0x80_8000_0000
> > 
> > So your platform currently only has 16GB of RAM. Shouldn't the last 14GB
> > be placed at 34GB offset (according to the "Principles of ARM Memory
> > Maps")?
> 
> Yes, but it looks like our hardware designer didn't follow it exactly.  And
> instead created a variant by dropping the middle region.  The reasoning
> seems to be that our SoC architecture is 40-bit PA only and thus it seemed
> unnecessary to have the middle region at 34GB offset.  Plus, they wanted
> that middle region for other I/O.

Ah, so you can't blame the ARM Memory Maps document since you haven't
followed it properly ;).

> > > > To be honest, I think this is poorly designed, and I am not sure we
> > > > should cater for such configurations in the defconfig.
> > >
> > > Agree, if this is a one-off weird platform then we shouldn't.
> > >
> > > But, the 'Principles of ARM Memory Maps' doc proposes this:
> > > 2 GB at 0x8000_0000
> > > 30 GB at 0x8_8000_0000
> > > 480 GB at 0x88_0000_0000
> > 
> > I'm not particularly recommending this layout, at least not without some
> > clarifications on DRAM aliases (I'll ping people internally about it
> > again). The original layout pre-dates ARMv8, it was meant for ARMv7/LPAE
> > and all the memory beyond 32-bit was highmem anyway. It was later
> > updated for AArch64 but only to allow 44/48-bit PA (a few sections
> > added).
> 
> Published guidance from ARM I think is important here.  If the aarch64
> kernel maintainers have issues with the proposed map in the 'Principles' doc,
> I consider that's a problem.

As I said, the problem I have with it is around the mandated aliases and
holes (and I'll raise it internally). But I won't complain about SoC
vendors following the recommendation (correctly; which doesn't seem to
be the case here).

> > How I understood it at the time is that in hardware you place the large
> > DRAM (chip select) at high addresses, e.g. 64GB would be at a 512GB
> > offset, but lower 2GB+30GB aliased in the lower space with the
> > corresponding high address remaining a hole (that produces external
> > aborts if accessed). The first alias at 2GB was meant for 32-bit
> > initialisation code before the MMU is enabled. With AArch64, you don't
> > really need this low alias (assuming your EL3/EL2/secure-EL1 code is
> > 64-bit) since PC can use >32-bit addresses.
> 
> I think the intent with our SoC was to do that, but ommitting the
> middle alias, because there was no obivous reason why it was needed.

Can you avoid the low alias as well and keep all the RAM at
0x80_0000_0000? That's pretty much what we have on AMD's Seattle.

> > > ...i.e. if you have > 32 GB then your RAM regions are split into 3
> > > chunks.  The aarch64 kernel will support > than 32GB right?  A
> > > basic server will have that much or more.
> > >
> > > How will we deal with systems with > 32GB of memory that follow that
> > > map?
> > 
> > My recommendation would be to avoid the lower alias (in hardware or some
> > EL3 configuration change) and keep all the RAM at 0x80_0000_0000, just
> > boot the system in AArch64 mode.
> 
> Unfortunately, for our existing armv8 silicon I am not aware any mechanism to
> change the aliasing and keeping all RAM at 512GB offset.  So, we're stuck
> for now with 2 discontiguous regions.  And things are ok as long as we
> turn on 48-bit VA or 64K pages, but that's not the case with the default
> defconfig.

OK, so there is no hardware configuration you can change at this stage.
You could ignore the lower 2GB and only use 14GB (load the kernel at the
high address and it should ignore the lower memory block in the DT).

> My interest in the default defconfig is related to distro support.  When
> a distro (Fedora, Debian, Ubuntu,etc) has a binary kernel image we want
> it to run on our hardware.  I don't know to what degree the upstream
> defconfig informs distros on what defconfig options are enabled in their
> kernels...but we want to be as compatible as possible with the default
> defconfig.

For the time being, I would keep defconfig to 39-bit VA. If we start
seeing systems with lots of RAM (over 256GB), we'll probably change the
defconfig. Enabling another page table level has implications on
performance.

> (BTW, Fedora 22 for aarch64 appears to have 64KB pages enabled, which
> is good for our memory map)

Yes, Fedora should work. I'm not sure what other distros do but in
general they ship their own config.

-- 
Catalin
