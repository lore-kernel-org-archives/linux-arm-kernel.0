From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 30 Jul 2015 11:13:58 +0100
Subject: [RFC] arm64: defconfig: enable 48-bit VA by default
In-Reply-To: <BY2PR0301MB074300C5F31701D9211827F0878C0@BY2PR0301MB0743.namprd03.prod.outlook.com>
References: <CY1PR0301MB07488D6DC5F0B171D6B290E187830@CY1PR0301MB0748.namprd03.prod.outlook.com>
 <55B0E1AD.60409@arm.com>
 <BY2PR0301MB0743CBCFC5476E39A5D1EC0B878C0@BY2PR0301MB0743.namprd03.prod.outlook.com>
 <CAKv+Gu9LHBd7wM6P4H0X5WigzDETtpr2++_Ebo=adg5QtTOW2w@mail.gmail.com>
 <BY2PR0301MB074300C5F31701D9211827F0878C0@BY2PR0301MB0743.namprd03.prod.outlook.com>
Message-ID: <20150730101358.GA30796@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 29, 2015 at 08:49:57PM +0000, Stuart Yoder wrote:
> > From: Ard Biesheuvel [mailto:ard.biesheuvel at linaro.org]
> > On 29 July 2015 at 21:27, Stuart Yoder <stuart.yoder@freescale.com> wrote:
> > >> From: Marc Zyngier [mailto:marc.zyngier at arm.com]
> > >> On 22/07/15 20:49, Stuart Yoder wrote:
> > >> > This is not a patch mean to be applied, but a query about whether there
> > >> > is any reason to not enable 48-bit VA by default in the arm64 defconfig.
> > >> >
> > >> > The Freescale LS2085A physical memory map requires 48-bit VA in Linux for the
> > >> > reasons mentioned in [1].
> > >> >
> > >> > Based on the comment in [1] by Catalin, it seems that the intent
> > >> > is to turn this on by default.
> > >> >
> > >> > Is there any issues anyone sees with a patch that does this:
> > >> >
> > >> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > >> > index 4e17e7e..5acf75d 100644
> > >> > @@ -47,6 +47,7 @@ CONFIG_ARCH_ZYNQMP=y
> > >> >  CONFIG_PCI=y
> > >> >  CONFIG_PCI_MSI=y
> > >> >  CONFIG_PCI_XGENE=y
> > >> > +CONFIG_ARM64_VA_BITS_48=y
> > >> >  CONFIG_SMP=y
> > >> >  CONFIG_PREEMPT=y
> > >> >  CONFIG_KSM=y
> > >> >
> > >> > Thanks,
> > >> > Stuart
> > >> >
> > >> > [1] https://www.marc.info/?l=linux-arm-kernel&m=140965303205473&w=1
> > >>
> > >> Is that still a requirement now that our idmap can use 4 levels (as part
> > >> of dd006da)?
> > >
> > > So, yes it appears still to be a requirement.  The idmap support is not
> > > the issue, it's the linear mapping.
> > >
> > > Has there been discussion or thinking about enabling 48-bit VA in the
> > > default defconfig?  As mentioned before, it seemed that supporting 48-bit
> > > VA was the planned default (~1 year ago), and was waiting on KVM issues to get
> > > resolved.
> > >
> > > A related question is what the thinking around enabling 64KB pages
> > > by default.  Any chance of that happening?
> > >
> > > I would like to see our platform work with the default defconfig, which
> > > is the reason for the questions.
> > 
> > Perhaps you should mention, for the benefit of those not following the
> > other thread, that the platform in question has 2 chunks of memory,
> > i.e., 2 GB and 14 GB, with a 508 GB hole in between.
> 
> Yes, our physical memory layout for RAM looks like this:
> 2 GB at 0x8000_0000
> 510 GB at 0x80_8000_0000

So your platform currently only has 16GB of RAM. Shouldn't the last 14GB
be placed at 34GB offset (according to the "Principles of ARM Memory
Maps")?

> > To be honest, I think this is poorly designed, and I am not sure we
> > should cater for such configurations in the defconfig.
> 
> Agree, if this is a one-off weird platform then we shouldn't.
> 
> But, the 'Principles of ARM Memory Maps' doc proposes this:
> 2 GB at 0x8000_0000
> 30 GB at 0x8_8000_0000
> 480 GB at 0x88_0000_0000

I'm not particularly recommending this layout, at least not without some
clarifications on DRAM aliases (I'll ping people internally about it
again). The original layout pre-dates ARMv8, it was meant for ARMv7/LPAE
and all the memory beyond 32-bit was highmem anyway. It was later
updated for AArch64 but only to allow 44/48-bit PA (a few sections
added).

How I understood it at the time is that in hardware you place the large
DRAM (chip select) at high addresses, e.g. 64GB would be at a 512GB
offset, but lower 2GB+30GB aliased in the lower space with the
corresponding high address remaining a hole (that produces external
aborts if accessed). The first alias at 2GB was meant for 32-bit
initialisation code before the MMU is enabled. With AArch64, you don't
really need this low alias (assuming your EL3/EL2/secure-EL1 code is
64-bit) since PC can use >32-bit addresses.

> ...i.e. if you have > 32 GB then your RAM regions are split into 3 
> chunks.  The aarch64 kernel will support > than 32GB right?  A
> basic server will have that much or more.
> 
> How will we deal with systems with > 32GB of memory that follow that
> map?

My recommendation would be to avoid the lower alias (in hardware or some
EL3 configuration change) and keep all the RAM at 0x80_0000_0000, just
boot the system in AArch64 mode.

> When do we expect the default page size for the aarch64 kernel to be
> changed to 64KB?  Any workload that puts pressure on the TLBs will benefit
> from this.

This comes with its own set problems. 64KB is useful for specific
use-cases (e.g. large databases) but not general purpose where you waste
a large amount of RAM. So there are no plans to change the default page
size to 64KB.

-- 
Catalin
