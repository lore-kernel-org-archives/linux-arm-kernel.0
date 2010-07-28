From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 28 Jul 2010 09:49:03 +0200
Subject: [PATCH] S5PV210: Move OneNAND platform data to plat-s5p
In-Reply-To: <AANLkTikF-tWtHb=16FGNnHb5ioTs5zqA5+d_ioi16yyF@mail.gmail.com>
References: <20100728011714.GA1882@july>
	<00af01cb2e1d$79c8e790$6d5ab6b0$%kim@samsung.com>
	<AANLkTikF-tWtHb=16FGNnHb5ioTs5zqA5+d_ioi16yyF@mail.gmail.com>
Message-ID: <005001cb2e29$5bc64b50$1352e1f0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wednesday, July 28, 2010 9:45 AM Kukjin Kim wrote:

> On Wed, Jul 28, 2010 at 3:23 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > Kyungmin Park wrote:
> >>
> >> From: Kyungmin Park <kyungmin.park@samsung.com>
> >>
> >> S5PV310 has the same OneNAND controller and can use it commonly.
> >>
> >> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> >> ---
> >> ?arch/arm/mach-s5pv210/Kconfig ? ? ? ? ? ?| ? ?5 ---
> >> ?arch/arm/mach-s5pv210/Makefile ? ? ? ? ? | ? ?1 -
> >> ?arch/arm/mach-s5pv210/include/mach/map.h | ? ?3 --
> >> ?arch/arm/plat-s5p/Makefile ? ? ? ? ? ? ? | ? ?2 +-
> >> ?arch/arm/plat-s5p/dev-onenand.c ? ? ? ? ?| ? 52
> >> ++++++++++++++++++++++++++++++
> >
> > Is this just moving dev-onenand.c from mach-s5pv210 to plat-s5p to
> support
> > further SoC?
> > So...where is removing 'mach-s5pv210/dev-onenand.c'...I found just adding
> > dev-onenand.c to plat-s5p.
> 
> Right, will fix it.
> >
> >> ?5 files changed, 53 insertions(+), 10 deletions(-)
> >> ?create mode 100644 arch/arm/plat-s5p/dev-onenand.c
> >>
> >> diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-
> s5pv210/Kconfig
> >> index 0761eac..96f4d9b 100644
> >> --- a/arch/arm/mach-s5pv210/Kconfig
> >> +++ b/arch/arm/mach-s5pv210/Kconfig
> >> @@ -62,11 +62,6 @@ config MACH_GONI
> >> ? ? ? ? Machine support for Samsung GONI board
> >> ? ? ? ? S5PC110(MCP) is one of package option of S5PV210
> >>
> >> -config S5PC110_DEV_ONENAND
> >> - ? ? bool
> >> - ? ? help
> >> - ? ? ? Compile in platform device definition for OneNAND1 controller
> >> -
> >> ?config MACH_SMDKV210
> >> ? ? ? bool "SMDKV210"
> >> ? ? ? select CPU_S5PV210
> >> diff --git a/arch/arm/mach-s5pv210/Makefile
> > b/arch/arm/mach-s5pv210/Makefile
> >> index 30be9a6..6a6dea1 100644
> >> --- a/arch/arm/mach-s5pv210/Makefile
> >> +++ b/arch/arm/mach-s5pv210/Makefile
> >> @@ -26,7 +26,6 @@ obj-$(CONFIG_MACH_GONI) ? ? ? ? ? ? += mach-goni.o
> >>
> >> ?obj-y ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?+= dev-audio.o
> >> ?obj-$(CONFIG_S3C64XX_DEV_SPI) ? ? ? ?+= dev-spi.o
> >> -obj-$(CONFIG_S5PC110_DEV_ONENAND) += dev-onenand.o
> >>
> >> ?obj-$(CONFIG_S5PV210_SETUP_FB_24BPP) += setup-fb-24bpp.o
> >> ?obj-$(CONFIG_S5PV210_SETUP_I2C1) ? ? += setup-i2c1.o
> >> diff --git a/arch/arm/mach-s5pv210/include/mach/map.h b/arch/arm/mach-
> >> s5pv210/include/mach/map.h
> >> index 34eb168..3a44e1e 100644
> >> --- a/arch/arm/mach-s5pv210/include/mach/map.h
> >> +++ b/arch/arm/mach-s5pv210/include/mach/map.h
> >> @@ -16,9 +16,6 @@
> >> ?#include <plat/map-base.h>
> >> ?#include <plat/map-s5p.h>
> >>
> >> -#define S5PC110_PA_ONENAND ? (0xB0000000)
> >> -#define S5PC110_PA_ONENAND_DMA ? ? ? (0xB0600000)
> >> -
> >> ?#define S5PV210_PA_CHIPID ? ?(0xE0000000)
> >> ?#define S5P_PA_CHIPID ? ? ? ? ? ? ? ?S5PV210_PA_CHIPID
> >>
> >> diff --git a/arch/arm/plat-s5p/Makefile b/arch/arm/plat-s5p/Makefile
> >> index 39c242b..d9f6890 100644
> >> --- a/arch/arm/plat-s5p/Makefile
> >> +++ b/arch/arm/plat-s5p/Makefile
> >> @@ -12,7 +12,7 @@ obj- ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?:=
> >>
> >> ?# Core files
> >>
> >> -obj-y ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?+= dev-uart.o
> >> +obj-y ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?+= dev-uart.o dev-onenand.o
> >
> > Really, always need building dev-onenand for all S5P SoCs?
> 
> will be handled in dev-onenand.c file.

I would also prefer common style over all file. ifdefs in .c files should
be avoided. Just move&rename S5PC110_DEV_ONENAND KConfig entry from
mach-s5pv210/Kconfig to plat-s5p/KConfig and use for conditional
compilation.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
