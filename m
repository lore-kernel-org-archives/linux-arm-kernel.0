From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 21 Jan 2013 11:07:20 -0800
Subject: [PATCH v5 00/12] clk: exynos4: migrate to common clock framework
In-Reply-To: <2433961.3Qz5gqDyvb@amdc1227>
References: <1356827621-27617-1-git-send-email-thomas.abraham@linaro.org>
 <50FD50BC.4020902@samsung.com> <2433961.3Qz5gqDyvb@amdc1227>
Message-ID: <20130121190720.3982.81903@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Tomasz Figa (2013-01-21 08:22:39)
> Hi Thomas, Sylwester,
> 
> On Monday 21 of January 2013 15:29:16 Sylwester Nawrocki wrote:
> > On 12/30/2012 01:33 AM, Thomas Abraham wrote:
> > > Changes since v4:
> > > - Rebased to linux-3.8-rc1.
> > > 
> > > Changes since v3:
> > > - Includes changes suggested by Tomasz Figa <tomasz.figa@gmail.com>
> > > 
> > > This patch series migrates the Samsung Exynos4 SoC clock code to adopt
> > > the common clock framework. The use of Samsung specific clock
> > > structures has been removed and all board support code has been
> > > updated. imx-style of clock registration and lookup has been adopted
> > > for device tree based exynos4 platforms.
> > > 
> > > This patch series depends on this series:
> > > http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg14471
> > > .html and this patch
> > > http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg14472
> > > .html> 
> > > Thomas Abraham (12):
> > >   clk: samsung: add common clock framework helper functions for
> > >   Samsung platforms clk: samsung: add pll clock registration helper
> > >   functions
> > >   clk: exynos4: register clocks using common clock framework
> > >   ARM: Exynos: Rework timer initialization sequence
> > >   ARM: Exynos4: Migrate clock support to common clock framework
> > >   ARM: dts: add exynos4 clock controller nodes
> > >   ARM: dts: add xxti and xusbxti fixed rate clock nodes for exynos4
> > >   based platforms ARM: Exynos4: allow legacy board support to specify
> > >   xxti and xusbxti clock speed ARM: dts: add clock provider
> > >   information for all controllers in Exynos4 SoC ARM: Exynos4: remove
> > >   auxdata table from machine file
> > >   ARM: Exynos: use fin_pll clock as the tick clock source for mct
> > >   ARM: Exynos: add support for mct clock setup
> > >  
> > >  .../devicetree/bindings/clock/exynos4-clock.txt    |  215 +++++++
> > >  arch/arm/boot/dts/exynos4.dtsi                     |   50 ++
> > >  arch/arm/boot/dts/exynos4210-origen.dts            |   12 +
> > >  arch/arm/boot/dts/exynos4210-smdkv310.dts          |   12 +
> > >  arch/arm/boot/dts/exynos4210.dtsi                  |    6 +
> > >  arch/arm/boot/dts/exynos4412-origen.dts            |   12 +
> > >  arch/arm/boot/dts/exynos4412-smdk4412.dts          |   12 +
> > >  arch/arm/boot/dts/exynos4x12.dtsi                  |    6 +
> > >  arch/arm/mach-exynos/Kconfig                       |    1 +
> > >  arch/arm/mach-exynos/Makefile                      |    3 -
> > >  arch/arm/mach-exynos/clock-exynos4.h               |   35 -
> > >  arch/arm/mach-exynos/clock-exynos4210.c            |  188 ------
> > >  arch/arm/mach-exynos/clock-exynos4212.c            |  192 ------
> > >  arch/arm/mach-exynos/common.c                      |   57 ++-
> > >  arch/arm/mach-exynos/common.h                      |   21 +-
> > >  arch/arm/mach-exynos/mach-armlex4210.c             |    3 +-
> > >  arch/arm/mach-exynos/mach-exynos4-dt.c             |   72 +--
> > >  arch/arm/mach-exynos/mach-exynos5-dt.c             |    2 +-
> > >  arch/arm/mach-exynos/mach-nuri.c                   |    5 +-
> > >  arch/arm/mach-exynos/mach-origen.c                 |    5 +-
> > >  arch/arm/mach-exynos/mach-smdk4x12.c               |    5 +-
> > >  arch/arm/mach-exynos/mach-smdkv310.c               |    7 +-
> > >  arch/arm/mach-exynos/mach-universal_c210.c         |    3 +-
> > >  arch/arm/mach-exynos/mct.c                         |   32 +-
> > >  arch/arm/plat-samsung/Kconfig                      |    4 +-
> > >  drivers/clk/Makefile                               |    1 +
> > >  drivers/clk/samsung/Makefile                       |    6 +
> > >  drivers/clk/samsung/clk-exynos4.c                  |  655
> > >  ++++++++++++++++++++ drivers/clk/samsung/clk-pll.c                  
> > >     |  400 ++++++++++++ drivers/clk/samsung/clk-pll.h                
> > >       |   38 ++
> > >  drivers/clk/samsung/clk.c                          |  180 ++++++
> > >  drivers/clk/samsung/clk.h                          |  216 +++++++
> > >  32 files changed, 1919 insertions(+), 537 deletions(-)
> > >  create mode 100644
> > >  Documentation/devicetree/bindings/clock/exynos4-clock.txt delete
> > >  mode 100644 arch/arm/mach-exynos/clock-exynos4.h
> > >  delete mode 100644 arch/arm/mach-exynos/clock-exynos4210.c
> > >  delete mode 100644 arch/arm/mach-exynos/clock-exynos4212.c
> > >  create mode 100644 drivers/clk/samsung/Makefile
> > >  create mode 100644 drivers/clk/samsung/clk-exynos4.c
> > >  create mode 100644 drivers/clk/samsung/clk-pll.c
> > >  create mode 100644 drivers/clk/samsung/clk-pll.h
> > >  create mode 100644 drivers/clk/samsung/clk.c
> > >  create mode 100644 drivers/clk/samsung/clk.h
> > 
> > Thanks Thomas! The patch series generally looks good to me, I've tested
> > it on an Exynos4412 based board. I have applied couple fixes that Tomasz
> > Figa has sent you off the mailing list. And to make a MIPI-CSI2 camera
> > working a small fixup patch as below.
> > 
> > I have just one remark, but this could possibly be done as a follow up
> > patch. Namely it may make sense to rename various sclk_* clocks to just
> > "sclk", so for instance we don't have "fimd", "sclk_fimd", "fimc",
> > "sclk_fimc" but e.g. "bus" or "gate" and "sclk" for each device. Such
> > naming might be better for handling devices at core subsystems level,
> > e.g. Runtime PM or devfreq.
> > 
> > Please feel free to add:
> > 
> > Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> > Tested-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> 
> I fully agree with Sylwester. After adding mentioned fixup patches, feel 
> free to add my Reviewed-by and Tested-by as well.
> 
> > 
> > I would be great to have this patch set merged for 3.9, so people can
> > switch earlier to the common clock API, rather than modifying files
> > that will be removed soon.
> 
> Yes, it would be great to have this series merged earlier, because it's 
> very important for further development of Device Tree support on Samsung 
> platforms. Possibly for 3.9 it could be merged as an alternative to the 
> legacy clock code and after enough testing legacy code could be dropped in 
> next kernel release.
> 

I thought that the Exynos4 and Exynos5 ports to the common clk framework
were going to be merged.  Is that still the plan?

Regards,
Mike

> Best regards
> -- 
> Tomasz Figa
> Samsung Poland R&D Center
> SW Solution Development, Linux Platform
