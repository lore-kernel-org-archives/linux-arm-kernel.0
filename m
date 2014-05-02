From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 02 May 2014 11:25:26 +0900
Subject: [PATCH 1/2] ARM: EXYNOS: Map SYSRAM through generic SRAM bindings
In-Reply-To: <11106990.1tS5A7pf5r@diego>
References: <1398941085-10224-1-git-send-email-sachin.kamat@linaro.org>
 <11106990.1tS5A7pf5r@diego>
Message-ID: <045301cf65ad$c95badd0$5c130970$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko St?bner wrote:
> 
> Hi Sachin,
> 
> Am Donnerstag, 1. Mai 2014, 16:14:44 schrieb Sachin Kamat:
> > Instead of hardcoding the SYSRAM details for each SoC,
> > pass this information through device tree (DT) and make
> > the code SoC agnostic. Generic SRAM bindings are used
> > for achieving this.
> >
> > Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> > Cc: Heiko Stuebner <heiko@sntech.de>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> 
> very cool :-).
> 
> I've found one little thing I do not understand, which I describe below.
> Otherwise
> Acked-by: Heiko Stuebner <heiko@sntech.de>
> 
> > ---
> > This patch is based on linux next (next-20140501) on top of
> > my Kconfig consolidation patch
> > http://comments.gmane.org/gmane.linux.kernel.samsung-soc/28642
> >
> > Tested on 4210/4412 Origen, 5250/5420 Arndale and SMDK5420 boards.
> > ---
> >  arch/arm/Kconfig                                |    1 +
> >  arch/arm/boot/dts/exynos4210-universal_c210.dts |   17 ++++++
> >  arch/arm/boot/dts/exynos4210.dtsi               |   18 +++++++
> >  arch/arm/boot/dts/exynos4x12.dtsi               |   18 +++++++
> >  arch/arm/boot/dts/exynos5250.dtsi               |   18 +++++++
> >  arch/arm/boot/dts/exynos5420.dtsi               |   18 +++++++
> >  arch/arm/mach-exynos/common.h                   |    1 +
> >  arch/arm/mach-exynos/exynos.c                   |   64
> > ----------------------- arch/arm/mach-exynos/firmware.c
|
> >  5 +-
> >  arch/arm/mach-exynos/include/mach/map.h         |    7 ---
> >  arch/arm/mach-exynos/platsmp.c                  |   39 +++++++++++++-
> >  11 files changed, 133 insertions(+), 73 deletions(-)
> >
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index a6aaaad19b1a..f66ea9453df9 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -855,6 +855,7 @@ config ARCH_EXYNOS
> >  	select S5P_DEV_MFC
> >  	select SAMSUNG_DMADEV
> >  	select SPARSE_IRQ
> > +	select SRAM
> >  	select USE_OF
> >  	help
> >  	  Support for SAMSUNG's EXYNOS SoCs (EXYNOS4/5)
> > diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts
> > b/arch/arm/boot/dts/exynos4210-universal_c210.dts index
> > 63e34b24b04f..8d4de5c0d0c7 100644
> > --- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
> > +++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
> > @@ -28,6 +28,23 @@
> >  		bootargs = "console=ttySAC2,115200N8 root=/dev/mmcblk0p5 rw
> rootwait
> > earlyprintk panic=5 maxcpus=1"; };
> >
> > +	sram at 02020000 {
> > +		status = "disabled";
> > +	};
> > +
> > +	sram at 02025000 {
> > +		compatible = "mmio-sram";
> > +		reg = <0x02025000 0x1000>;
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		ranges = <0 0x02025000 0x1000>;
> > +
> > +		smp-sram at 0 {
> > +			compatible = "samsung,exynos4210-sram";
> > +			reg = <0x0 0x1000>;
> > +		};
> > +	};
> 
> exynos_smp_prepare_sram returns -ENODEV if it can't find
> samsung,exynos4210-sram-ns, so are you sure your universal_c210 will run
> without it? I didn't dig to deep into this, so it can also simply be
> something
> I overlooked :-)
> 
Hi Andrzej and Tomasz,

Can you please check above?

- Kukjin
