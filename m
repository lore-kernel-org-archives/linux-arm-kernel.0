From: yangbo.lu@nxp.com (Y.B. Lu)
Date: Fri, 17 Mar 2017 03:01:53 +0000
Subject: [v2, 0/7] Add SD UHS-I and eMMC HS200 support for eSDHC
In-Reply-To: <DB6PR0401MB253672A97F3E14C2BEFF946EF8210@DB6PR0401MB2536.eurprd04.prod.outlook.com>
References: <1488529129-23560-1-git-send-email-yangbo.lu@nxp.com>
 <DB6PR0401MB253672A97F3E14C2BEFF946EF8210@DB6PR0401MB2536.eurprd04.prod.outlook.com>
Message-ID: <DB6PR0401MB2536C06643318C075620B0E4F8390@DB6PR0401MB2536.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Adrian,

Could you help to review the new version patch-set?
Thanks a lot.


Best regards,
Yangbo Lu

> -----Original Message-----
> From: Y.B. Lu
> Sent: Thursday, March 09, 2017 10:23 AM
> To: linux-mmc at vger.kernel.org; ulf.hansson at linaro.org; Adrian Hunter; Rob
> Herring; Mark Rutland; Catalin Marinas; Will Deacon
> Cc: devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> Xiaobo Xie
> Subject: RE: [v2, 0/7] Add SD UHS-I and eMMC HS200 support for eSDHC
> 
> Any comments on this patchset ?
> Thanks :)
> 
> 
> Best regards,
> Yangbo Lu
> 
> > -----Original Message-----
> > From: Yangbo Lu [mailto:yangbo.lu at nxp.com]
> > Sent: Friday, March 03, 2017 4:19 PM
> > To: linux-mmc at vger.kernel.org; ulf.hansson at linaro.org; Adrian Hunter;
> > Rob Herring; Mark Rutland; Catalin Marinas; Will Deacon
> > Cc: devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> > Xiaobo Xie; Y.B. Lu
> > Subject: [v2, 0/7] Add SD UHS-I and eMMC HS200 support for eSDHC
> >
> > It's complicated to support SD UHS-I and eMMC HS200 for eSDHC because
> > there're many differences between eSDHC and SD/eMMC spec. Several
> > differences as below must be considered:
> > 1. Peripheral clock must be used instead of platform clock.
> >     - eSDHC could select peripheral clock or platform clock as its
> clock
> >       source. According to RM, UHS-I/HS200 must use peripheral clock
> > since
> >       it supports higher frequency than platform clock.
> >     - Patch 1 and patch 6 is to support this.
> > 2. Signal voltage switching requires a control circuit out of eSDHC.
> >     - eSDHC supports signal voltage switch from 3.3v to 1.8v by
> >       eSDHC_PROCTL[VOLT_SEL] bit. This bit changes the value of output
> >       signal SDHC_VS, and there must be a control circuit out of eSDHC
> >       to change the signal voltage according to SDHC_VS output signal.
> >     - Patch 2 is to support this.
> > 3. eSDHC uses tuning block for tuning procedure.
> >     - Tuning clock control register must be configured before tuning.
> >     - Patch 3 is to support this.
> > 4. Delay is needed between tuning cycles for HS200 tuning.
> >     - Once a patch removed mdelay between tuning cycles.
> >       But eSDHC needs it.
> >     - Patch 4 and patch 5 is to support this.
> > 5. UHS-I/HS200 modes could be enabled in dts node.
> >     - Patch 7 is to support this.
> >
> > Please review and merge these patches on mmc git tree if no changes
> > are required.
> >
> > Yangbo Lu (7):
> >   mmc: sdhci-of-esdhc: add peripheral clock support
> >   mmc: sdhci-of-esdhc: add support for signal voltage switch
> >   mmc: sdhci-of-esdhc: add tuning support
> >   mmc: sdhci: add a quirk to restore delay in tuning
> >   mmc: sdhci-of-esdhc: add delay between tuning cycles
> >   arm64: dts: ls1046a: add clocks property and compatible for eSDHC
> node
> >   arm64: dts: ls1046ardb: add MMC HS200/UHS-1 modes support
> >
> >  arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts |   8 ++
> >  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi    |   3 +-
> >  drivers/mmc/host/sdhci-esdhc.h                    |   7 +
> >  drivers/mmc/host/sdhci-of-esdhc.c                 | 167
> > +++++++++++++++++++++-
> >  drivers/mmc/host/sdhci.c                          |   3 +-
> >  drivers/mmc/host/sdhci.h                          |   2 +
> >  6 files changed, 186 insertions(+), 4 deletions(-)
> >
> > --
> > 2.1.0.27.g96db324
