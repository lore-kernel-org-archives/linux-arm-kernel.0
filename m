From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Wed, 10 Jun 2015 10:27:26 +0100
Subject: [PATCH] arm64: dts: add device tree for ARM SMM-A53x2 on
 LogicTile Express 20MG
In-Reply-To: <20150610091234.GA1517@leverpostej>
References: <1433864311-2326-1-git-send-email-kristina.martsenko@arm.com>
 <20150610085825.GS12807@e106497-lin.cambridge.arm.com>
 <20150610091234.GA1517@leverpostej>
Message-ID: <20150610092726.GV12807@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 10, 2015 at 10:12:34AM +0100, Mark Rutland wrote:
> On Wed, Jun 10, 2015 at 09:58:25AM +0100, Liviu Dudau wrote:
> > Hi Kristina,
> > 
> > On Tue, Jun 09, 2015 at 04:38:31PM +0100, Kristina Martsenko wrote:
> > > Add a DTS file for the MP2 Cortex-A53 Soft Macrocell Model implemented
> > > on a LogicTile Express 20MG (V2F-1XV7) daughterboard. This is based on
> > > the version that's currently available from the ARM DTS repository [1].
> > > 
> > > [1] git://linux-arm.org/arm-dts.git
> > 
> > I thought the plan was to keep new DTs in this repository, not to add
> > them into the kernel. Has this changed?
> > 
> > > 
> > > Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
> > > ---
> > >  MAINTAINERS                                        |   1 +
> > >  arch/arm64/boot/dts/arm/Makefile                   |   1 +
> > >  .../boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts      | 196 +++++++++++++++++++++
> > >  3 files changed, 198 insertions(+)
> > >  create mode 100644 arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 9180f46..1fb07e0 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -1613,6 +1613,7 @@ M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > >  L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> > >  S:	Maintained
> > >  F:	arch/arm/boot/dts/vexpress*
> > > +F:	arch/arm64/boot/dts/arm/vexpress*
> > >  F:	arch/arm/mach-vexpress/
> > >  F:	*/*/vexpress*
> > >  F:	*/*/*/vexpress*
> > 
> > You might want to Cc Lorenzo on this patch if you add him as maintainer :)
> > 
> > > diff --git a/arch/arm64/boot/dts/arm/Makefile b/arch/arm64/boot/dts/arm/Makefile
> > > index c5c98b9..bb3c072 100644
> > > --- a/arch/arm64/boot/dts/arm/Makefile
> > > +++ b/arch/arm64/boot/dts/arm/Makefile
> > > @@ -1,6 +1,7 @@
> > >  dtb-$(CONFIG_ARCH_VEXPRESS) += foundation-v8.dtb
> > >  dtb-$(CONFIG_ARCH_VEXPRESS) += juno.dtb juno-r1.dtb
> > >  dtb-$(CONFIG_ARCH_VEXPRESS) += rtsm_ve-aemv8a.dtb
> > > +dtb-$(CONFIG_ARCH_VEXPRESS) += vexpress-v2f-1xv7-ca53x2.dtb
> > >  
> > >  always		:= $(dtb-y)
> > >  subdir-y	:= $(dts-dirs)
> > > diff --git a/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts b/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
> > > new file mode 100644
> > > index 0000000..bbe28aa
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
> > > @@ -0,0 +1,196 @@
> > > +/*
> > > + * ARM Ltd. Versatile Express
> > > + *
> > > + * LogicTile Express 20MG
> > > + * V2F-1XV7
> > > + *
> > > + * Cortex-A53 (2 cores) Soft Macrocell Model
> > > + *
> > > + * HBI-0247C
> > > + */
> > > +
> > > +/dts-v1/;
> > > +
> > > +/* In use by spinning secondaries */
> > > +/memreserve/ 0x80000000 0x00010000;
> > 
> > Where does the kernel get loaded to? If 0x80000000 is the start of memory and the kernel is
> > loaded at 0x80000 offset as usual, then that memory is protected anyway.
> 
> That's simply not true. The kernel may use _any_ memory which is
> described to it and not explicitly reserved.
> 
> We only reserve the kernel's static image (see arm64_memblock_init),
> which does not cover that region. We can easily map that memory and
> allocate it to something.
> 
> While we used to place page tables in the end of that region, we only
> reserved the page tables, and it was problematic because you had no idea
> how much of that memory the kernel might use.
> 
> Regardless, DTs should not rely on Linux implementation details like
> magic implicit reservations.

Things might have changed since v3.18 but I remember having a hell of a time trying to
access memory that was at the bottom of address space before the kernel start image.

But I agree that things should be explicitly stated in the DT.

Question for Kristina now: why spin method and not PSCI for this CoreTile?

Best regards,
Liviu

> 
> Mark.
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
