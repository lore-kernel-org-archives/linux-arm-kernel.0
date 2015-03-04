From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Wed, 4 Mar 2015 10:31:07 +0800
Subject: [PATCH 1/3] arm64: mediatek: Add config option for mt8173.
In-Reply-To: <20150225111107.GA29206@localhost>
References: <1422342836-27689-1-git-send-email-hongzhou.yang@mediatek.com>
 <1422342836-27689-2-git-send-email-hongzhou.yang@mediatek.com>
 <1424855242.7845.9.camel@mtksdaap41> <5948977.qlhSVy9R5i@wuerfel>
 <20150225111107.GA29206@localhost>
Message-ID: <1425436267.21342.39.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-02-25 at 11:11 +0000, Catalin Marinas wrote:
> On Wed, Feb 25, 2015 at 11:51:57AM +0100, Arnd Bergmann wrote:
> > On Wednesday 25 February 2015 17:07:22 Yingjoe Chen wrote:
> > > On Tue, 2015-01-27 at 15:13 +0800, Hongzhou Yang wrote:
> > > > From: Hongzhou Yang <hongzhou.yang@mediatek.com>
> > > > 
> > > > The upcoming MTK pinctrl driver have a big pin table for each SoC,
> > > > and we don't want to bloat the kernel binary if we don't need it.
> > > > Add config options so we can build for one SoC only.
> > > > 
> > > > Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>
> > > > ---
> > > >  arch/arm64/Kconfig | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > > 
> > > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > > index e627ead..6213dac 100644
> > > > --- a/arch/arm64/Kconfig
> > > > +++ b/arch/arm64/Kconfig
> > > > @@ -151,9 +151,15 @@ menu "Platform selection"
> > > >  config ARCH_MEDIATEK
> > > >       bool "Mediatek MT65xx & MT81xx ARMv8 SoC"
> > > >       select ARM_GIC
> > > > +     select PINCTRL
> > > >       help
> > > >         Support for Mediatek MT65xx & MT81xx ARMv8 SoCs
> > > >  
> > > > +config MACH_MT8173
> > > > +     bool "Mediatek 8173 Soc Supprt"
> > > > +     depends on ARCH_MEDIATEK
> > > > +     default y
> > > > +
> > > >  config ARCH_SEATTLE
> > > >       bool "AMD Seattle SoC Family"
> > > >       help
> > > 
> > > Hi Arnd/Matthias,
> > > 
> > > Any comments on this patch?
> > 
> > Hi Joe,
> > 
> > Actually I just commented on a similar patch from Samsung the other
> > day, and I think we should make a more general decision about these:
> > 
> > I would rather see only one Kconfig option per SoC family and use
> > ARCH_MEDIATEK without any MACH_* options. We can have other options
> > for e.g. networking chips from Mediatek that are not closely related
> > but I would group all the phone and tablet chips under one option
> > here. Same for the other vendors of course.
> 
> I agree.
> 

Hi,

Since we support devicetree, we don't need MACH_* to build a working
kernel. This is true even for our v7 soc. We intend to use it to reduce
numbers of drivers in product kernel binary.
Most drivers are shared among the same SoCs family, but some are not.
Currently for pinctrl driver, we are doing this so user don't need to
select them one by one:

config PINCTRL_MT8173
        def_bool MACH_MT8173
        select PINCTRL_MTK_COMMON

Alternatively, we could add these MACH_* to some other places, eg,
drivers/soc/mediatek. Or we don't add MACH_* at all, and have all
drivers export their own Kconfig option. User will need to select each
of them one-by-one.

What do you think?

Joe.C
