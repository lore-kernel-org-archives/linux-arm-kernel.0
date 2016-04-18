From: stuart.yoder@nxp.com (Stuart Yoder)
Date: Mon, 18 Apr 2016 13:28:21 +0000
Subject: [RFC PATCH] arm64: defconfig: add config fragment for Freescale
 SoCs
In-Reply-To: <CABtop_F_SkKm6H-mtpK-GHDA3PBg_RTfw=CJeewV-LLEN0SHzA@mail.gmail.com>
References: <1460643685-13670-1-git-send-email-stuart.yoder@nxp.com>
 <20160414170433.GF15182@e104818-lin.cambridge.arm.com>
 <CABtop_F_SkKm6H-mtpK-GHDA3PBg_RTfw=CJeewV-LLEN0SHzA@mail.gmail.com>
Message-ID: <HE1PR04MB16415DC3F35792B50303B3D18D6B0@HE1PR04MB1641.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Martinez Kristofer [mailto:kristofer.s.martinez at gmail.com]
> Sent: Sunday, April 17, 2016 4:11 AM
> To: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Stuart Yoder <stuart.yoder@nxp.com>; mark.rutland at arm.com; marc.zyngier at arm.com;
> will.deacon at arm.com; Yang-Leo Li <leoyang.li@nxp.com>; Scott Wood <scott.wood@nxp.com>; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [RFC PATCH] arm64: defconfig: add config fragment for Freescale SoCs
> 
> On Fri, Apr 15, 2016 at 1:04 AM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > On Thu, Apr 14, 2016 at 09:21:25AM -0500, Stuart Yoder wrote:
> >> Add a config fragment enabling a reasonably useful set of
> >> devices and options for Freescale ARM v8 SoCs.
> >
> > A gentle NAK ;).
> >
> >> I realize that we are trying to avoid the defconfig hell in arch/arm with 100+
> >> defconfigs, but the single defconfig in arch/arm64 has some problems too.
> >
> > Can we address these problems in defconfig?
> >
> >> I think what we want with arch/arm64/config are some reasonable in-kernel
> >> defconfigs/fragments with built-in drivers for convenience.
> >
> > A hard requirement for arm64 is single Image and having all SoCs in
> > defconfig is a good way to regularly test this.
> >
> > I am aware that at some point the defconfig size will get too big but
> > that's when (ideally before) we should put effort into building more
> > stuff as loadable modules.
> >
> >> The proposal is to allow a chip vendor 1 vendor-specific kconfig fragment
> >> to cover all their chips, allowing them to _override_ the default config
> >> options in defconfig.  One specific issue we have is that due to the ls2080a
> >> physical address map, the combination of 4KB pages and 39-bit VA does not
> >> allow us to see all our DDR.  And, thus we need CONFIG_ARM64_VA_BITS_48=y.
> >
> > And I'm fine to add this to defconfig. We had a case for Seattle needing
> > 48-bit VA but we eventually decoupled the number of levels for idmap and
> > swapper. If it can't be addressed in a similar way on ls2080a, we may
> > need to increase the VA space to 48-bit.
> >
> 
> Here my suggestion is 48-bit VA will be depended on the CONFIG_ACPI,
> IOW, if CONFIG_ACPI
> is seleceted, then CONFIG_ARM64_VA_BITS_48 will be selected too.
> The premise is ACPI will be used in larger VA space segment as it did
> in Server area.
> Stuart, does your ls2080a need to be configured with ACPI?

No, the ls2080a does not currently use ACPI, but it may (optionally)
in the future.  For us the issue is simply having enough virtual
address bits for the kernel's linear mapping to cover 2 discontiguous
regions of DDR.

Stuart
