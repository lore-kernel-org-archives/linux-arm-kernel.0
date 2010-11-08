From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 08 Nov 2010 09:48:13 +0000
Subject: linux-next: omap2plus_defconfig not building
In-Reply-To: <eace9c309e371630528bc9f8fa208705@mail.gmail.com>
References: <4CBD707F.6050204@ti.com>
	<1287488255.18646.110.camel@e102109-lin.cambridge.arm.com>
	<eace9c309e371630528bc9f8fa208705@mail.gmail.com>
Message-ID: <1289209693.3538.5.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-11-08 at 06:05 +0000, Anand Gadiyar wrote:
> Catalin Marinas wrote:
> > On Tue, 2010-10-19 at 11:18 +0100, Anand Gadiyar wrote:
> > > Commit ba1b9be5cd in linux-next (ARM: Add SWP/SWPB emulation for ARMv7
> > > processors (v5)) introduced arch/arm/kernel/swp_emulate.c. This file
> > > gets compiled when the omap2plus_defconfig is built - the
> > > omap2plus_defconfig builds OMAP2420, OMAP2430, OMAP3 and OMAP4 in one
> > > image, and has CPU_V6 and CPU_V7 both enabled.
> >
> > This patch should fix it:
> >
> >
> > ARM: Do not enable SWP emulation if CPU_V6 && CPU_V7
> >
> > From: Catalin Marinas <catalin.marinas@arm.com>
> >
> > This option uses LDREXB/STREXB to emulate SWPB but these instructions
> > are not supported on all the ARMv6 processors.
> >
> > Reported-by: Anand Gadiyar <gadiyar@ti.com>
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Leif Lindholm <Leif.Lindholm@arm.com>
> 
> I can't find this patch in linux-next. Hope we haven't missed it.
> Tony acked this btw.
> 
> Strangely, the omap2plus_defconfig in v2.6.37-rc1 no longer gets
> CONFIG_SWP_EMULATE enabled even without this patch - I can't figure
> out why.

Russell had a better idea for handling this, not sure whether it went
into -next. It was basically adding -march=armv7-a to
CFLAGS_swp_emulate.o in arch/arm/kernel/Makefile since we can't trigger
an undef fault for SWP on ARMv6 anyway.

If it's not in yet, I can submit a patch.

Catalin
