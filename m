From: yangbo.lu@nxp.com (Y.B. Lu)
Date: Sat, 8 Oct 2016 03:28:01 +0000
Subject: [v12, 0/8] Fix eSDHC host version register bug
References: <1474441040-11946-1-git-send-email-yangbo.lu@nxp.com> 
Message-ID: <DB6PR0401MB2536F6224B12A62D0A0FBCBAF8D90@DB6PR0401MB2536.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uffe, Arnd and Scott,

Any comments on this latest patcheset?
Could we consider to merge it if no any other changes needed?
:)


Thanks.

Best regards,
Yangbo Lu

> -----Original Message-----
> From: Y.B. Lu
> Sent: Monday, September 26, 2016 11:15 AM
> To: linux-mmc at vger.kernel.org; ulf.hansson at linaro.org; Scott Wood; Arnd
> Bergmann
> Cc: linuxppc-dev at lists.ozlabs.org; devicetree at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org; linux-
> clk at vger.kernel.org; linux-i2c at vger.kernel.org; iommu at lists.linux-
> foundation.org; netdev at vger.kernel.org; Mark Rutland; Rob Herring;
> Russell King; Jochen Friedrich; Joerg Roedel; Claudiu Manoil; Bhupesh
> Sharma; Qiang Zhao; Kumar Gala; Santosh Shilimkar; Leo Li; X.B. Xie; M.H.
> Lian
> Subject: RE: [v12, 0/8] Fix eSDHC host version register bug
> 
> Any comments about this version patchset ?
> 
> :)
> 
> 
> > -----Original Message-----
> > From: Yangbo Lu [mailto:yangbo.lu at nxp.com]
> > Sent: Wednesday, September 21, 2016 2:57 PM
> > To: linux-mmc at vger.kernel.org; ulf.hansson at linaro.org; Scott Wood;
> > Arnd Bergmann
> > Cc: linuxppc-dev at lists.ozlabs.org; devicetree at vger.kernel.org;
> > linux-arm- kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> > linux- clk at vger.kernel.org; linux-i2c at vger.kernel.org;
> > iommu at lists.linux- foundation.org; netdev at vger.kernel.org; Mark
> > Rutland; Rob Herring; Russell King; Jochen Friedrich; Joerg Roedel;
> > Claudiu Manoil; Bhupesh Sharma; Qiang Zhao; Kumar Gala; Santosh
> Shilimkar; Leo Li; X.B. Xie; M.H.
> > Lian; Y.B. Lu
> > Subject: [v12, 0/8] Fix eSDHC host version register bug
> >
> > This patchset is used to fix a host version register bug in the T4240-
> > R1.0-R2.0 eSDHC controller. To match the SoC version and revision, 10
> > previous version patchsets had tried many methods but all of them were
> > rejected by reviewers.
> > Such as
> > 	- dts compatible method
> > 	- syscon method
> > 	- ifdef PPC method
> > 	- GUTS driver getting SVR method
> > Anrd suggested a soc_device_match method in v10, and this is the only
> > available method left now. This v11 patchset introduces the
> > soc_device_match interface in soc driver.
> >
> > The first six patches of Yangbo are to add the GUTS driver. This is
> > used to register a soc device which contain soc version and revision
> > information.
> > The other two patches introduce the soc_device_match method in soc
> > driver and apply it on esdhc driver to fix this bug.
> >
> > Arnd Bergmann (1):
> >   base: soc: introduce soc_device_match() interface
> >
> > Yangbo Lu (7):
> >   dt: bindings: update Freescale DCFG compatible
> >   ARM64: dts: ls2080a: add device configuration node
> >   dt: bindings: move guts devicetree doc out of powerpc directory
> >   powerpc/fsl: move mpc85xx.h to include/linux/fsl
> >   soc: fsl: add GUTS driver for QorIQ platforms
> >   MAINTAINERS: add entry for Freescale SoC drivers
> >   mmc: sdhci-of-esdhc: fix host version for T4240-R1.0-R2.0
> >
> >  Documentation/devicetree/bindings/arm/fsl.txt      |   6 +-
> >  .../bindings/{powerpc => soc}/fsl/guts.txt         |   3 +
> >  MAINTAINERS                                        |  11 +-
> >  arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi     |   6 +
> >  arch/powerpc/kernel/cpu_setup_fsl_booke.S          |   2 +-
> >  arch/powerpc/sysdev/fsl_pci.c                      |   2 +-
> >  drivers/base/Kconfig                               |   1 +
> >  drivers/base/soc.c                                 |  66 ++++++
> >  drivers/clk/clk-qoriq.c                            |   3 +-
> >  drivers/i2c/busses/i2c-mpc.c                       |   2 +-
> >  drivers/iommu/fsl_pamu.c                           |   3 +-
> >  drivers/mmc/host/Kconfig                           |   1 +
> >  drivers/mmc/host/sdhci-of-esdhc.c                  |  20 ++
> >  drivers/net/ethernet/freescale/gianfar.c           |   2 +-
> >  drivers/soc/Kconfig                                |   2 +-
> >  drivers/soc/fsl/Kconfig                            |  19 ++
> >  drivers/soc/fsl/Makefile                           |   1 +
> >  drivers/soc/fsl/guts.c                             | 257
> > +++++++++++++++++++++
> >  include/linux/fsl/guts.h                           | 125 ++++++----
> >  .../asm/mpc85xx.h => include/linux/fsl/svr.h       |   4 +-
> >  include/linux/sys_soc.h                            |   3 +
> >  21 files changed, 478 insertions(+), 61 deletions(-)  rename
> > Documentation/devicetree/bindings/{powerpc => soc}/fsl/guts.txt (91%)
> > create mode 100644 drivers/soc/fsl/Kconfig  create mode 100644
> > drivers/soc/fsl/guts.c  rename arch/powerpc/include/asm/mpc85xx.h =>
> > include/linux/fsl/svr.h (97%)
> >
> > --
> > 2.1.0.27.g96db324
