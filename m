From: mw@semihalf.com (Marcin Wojtas)
Date: Wed, 21 Oct 2015 13:59:44 +0200
Subject: [PATCH v3 0/5] Armada 38x SDHCI driver improvements
In-Reply-To: <1444926346-29763-1-git-send-email-mw@semihalf.com>
References: <1444926346-29763-1-git-send-email-mw@semihalf.com>
Message-ID: <CAPv3WKe9dqqjL-LCMLtpgm7Xuszor430ZY6VbJKFDshDqrPuJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf,

Do you have any remarks or comments to the series?

Best regards,
Marcin

2015-10-15 18:25 GMT+02:00 Marcin Wojtas <mw@semihalf.com>:
> Hi,
>
> Thank you for reviewing the patches. According to your remarks and some
> new ideas I prepared third patchset. I modified my HW and now I could
> check operation when using all three modes of detection (polling, gpio
> and dat3) - it all seems working fine. Any remarks will be wellcome.
>
> Best regards,
> Marcin
>
> Changes:
> v1 -> v2
> * enable SW polling as card detection
> * in resume function change condition for mbus windows reconfiguration
>
> v2 -> v3
> * remove redundant print after fail of mbus_win_regs obtaining
> * add big comment on possible card detection options in armada-388-gp.dts
> * reconstruct dat3-cd support
>         - use dedicated flag in sdhci_pxa structure instead of checking
>           property in DT
>         - instead of global SDHCI quirk add wrapper for sdhci_set_clock
>           function in order to keep internal clock enabled
>         - prevent using pm_runtime in case of using dat3-cd
> * improve MMC_CARD bit modification - do not check Armada 38x compatible
>   string in pxav3_init_card callback, but use pxa->mbus_win_regs as a flag
>
> Marcin Wojtas (5):
>   mmc: sdhci-pxav3: enable proper resuming on Armada 38x SoC
>   mmc: sdhci-pxav3: enable usage of DAT3 pin as HW card detect
>   ARM: mvebu: set SW polling as SDHCI card detection on A388-GP
>   mmc: sdhci: add init_card callback to sdhci
>   mmc: sdhci-pxav3: enable modifying MMC_CARD bit during card
>     initialization
>
>  .../devicetree/bindings/mmc/sdhci-pxa.txt          |   5 +
>  arch/arm/boot/dts/armada-388-gp.dts                |  15 +-
>  drivers/mmc/host/sdhci-pxav3.c                     | 157 ++++++++++++++++-----
>  drivers/mmc/host/sdhci.c                           |   9 ++
>  drivers/mmc/host/sdhci.h                           |   1 +
>  5 files changed, 149 insertions(+), 38 deletions(-)
>
> --
> 1.8.3.1
>
