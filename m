From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 7 Jun 2011 09:17:41 +0200
Subject: [PATCH v3 2/4] mmc: support sdhci-pxav2.c
In-Reply-To: <BANLkTik9an1N8914nC5MVL7+nHh+NhDNAA@mail.gmail.com>
References: <1307094606-8692-1-git-send-email-zhangfei.gao@marvell.com>
	<1E53FF9F-5C6A-4AA2-B441-DD712C5D6715@marvell.com>
	<BANLkTik9an1N8914nC5MVL7+nHh+NhDNAA@mail.gmail.com>
Message-ID: <201106070917.41691.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 07 June 2011 08:08:27 zhangfei gao wrote:
> >> +config MMC_SDHCI_PXAV2
> >> +     tristate "Marvell PXAV2 SD Host Controller support"
> >> +     select MMC_SDHCI
> >> +     select MMC_SDHCI_PLTFM
> >> +     help
> >> +       This selects the Marvell(R) PXAV2 SD Host Controller.
> >> +       If you have a PXAV2 platform (such as pxa910) with SD Host Controller
> >> +       and a card slot, say Y or M here.
> >> +
> >> +       If unsure, say N.
> >> +
> >
> > The following might be a better approach.  This way we preserve the existing SDHCI_PXA definition
> > and allow users to see what CPU's are supported.
> >
> > config MMC_SDHCI_PXA
> >>       tristate "Marvell MMP SD Host Controller support"
> >>       depends on ARCH_MMP2
> >>      select MMC_SDHCI_PXAV3
> >
> >
> >> config MMC_SDHCI_PXA168
> >>       tristate "Marvell PXA168 SD Host Controller support"
> >>       depends on ARCH_PXA
> >>      select MMC_SDHCI_PXAV2
> >>
> >> config MMC_SDHCI_PXA9XX
> >>       tristate "Marvell PXA910 SD Host Controller support"
> >>       depends on ARCH_PXA
> >>      select MMC_SDHCI_PXAV3
> >>
> >> config MMC_SDHCI_MMP2
> >>       tristate "Marvell MMP SD Host Controller support"
> >>       depends on ARCH_MMP2
> >>      select MMC_SDHCI_PXAV3
> >
> Still prefer the original method, it is simple and no dependence.
> >

How about changing the title of the option though? A user will
usually not know if he is using the v2 or v3 controller without
reading the help text. If you change it to

config MMC_SDHCI_PXAV2
	tristate "Marvell PXA168 SD Host Controller support (PXAV2)"
	default CPU_PXA168

config MMC_SDHCI_PXAV3
	tristate "Marvell MMP2/PX9XX SD Host Controller support (PXAV3)"
	default CPU_MMP2 || CPU_PXA910

you increase the chances of users getting the configuration right.

	Arnd

BTW, both of you: Please always remove the lines that you don't refer to
when you reply to an email. It's very annoying having to scroll through
dozens of lines of citations to see what you are actually writing.
