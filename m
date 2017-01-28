From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 28 Jan 2017 20:44:02 +0800
Subject: [PATCH v5 0/13] arm64: allwinner: a64: Enable MMC support
In-Reply-To: <cover.6f3d82744628848e2182720c35f13e87e8b62258.1485553113.git-series.maxime.ripard@free-electrons.com>
References: <cover.6f3d82744628848e2182720c35f13e87e8b62258.1485553113.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v67stC=EaFMpTSrOirSqQL6r_jPDKsKQNishb=8g=278Gw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 28, 2017 at 5:38 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> Here is a new attempt at getting the MMC controllers running, following the
> work done by Andre.
>
> This has been tested on a board with one SDIO device (a Marvell WiFi chip)
> and a Kingston eMMC with 1.8V IOs.
>
> For SDIO, the HS DDR mode works just fine. That serie also enables the
> SDR104 mode to work on the devices that are capable of this.
>
> For the eMMC, HS200 with the voltage switch works. HS400 doesn't at the
> moment, but since it's significantly more complex, and at the same time
> Allwinner recommends to limit its frequency to 100MHz, this doesn't have
> any benefits. If there's any at some point, this can be added later.

Whole series is

Acked-by: Chen-Yu Tsai <wens@csie.org>

Seems that we don't need to increase the signal drive strength for eMMC
on the A64? This is probably a good thing.

> Let me know what you think,
> Maxime
>
> Changes from v4:
>   - Added Florian Tested-by
>   - Removed duplicate commit log
>
> Changes from v3:
>   - Reordered the MMC nodes
>   - Added the specification section the first commit log
>   - Supported mmc->actual_rate
>   - Clarified a bit what we (don't) know about DATA0
>
> Changes from v2:
>   - Enabled SDR104, limited the frequency to 150MHz. 200MHz was too high.
>   - Added more fixes to the gating and frequency rate change sequence
>   - Added one more patch to mask DATA0 when updating the clock that was
>     needed to get SDR104 to run
>   - Added the patches to enable it on a few boards done by Andre
>   - Amended the comments as suggested by Andre.
>   - Added some tags
>
> Andre Przywara (4):
>   arm64: allwinner: a64: Add MMC nodes
>   arm64: allwinner: pine64: add MMC support
>   arm64: allwinner: a64: add UART1 pin nodes
>   arm64: allwinner: add BananaPi-M64 support
>
> Maxime Ripard (9):
>   mmc: sunxi: Fix clock frequency change sequence
>   mmc: sunxi: Gate the clock when rate is 0
>   mmc: sunxi: Always set signal delay to 0 for A64
>   mmc: sunxi: Enable the new timings for the A64 MMC controllers
>   mmc: sunxi: Mask DATA0 when updating the clock
>   mmc: sunxi: Add EMMC (MMC2) controller compatible
>   mmc: sunxi: Add more debug informations
>   arm64: allwinner: a64: Add MMC pinctrl nodes
>   arm64: allwinner: a64: Increase the MMC max frequency
>
>  arch/arm64/boot/dts/allwinner/Makefile                    |   1 +-
>  arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts | 120 +++++++-
>  arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts       |  20 +-
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi             |  77 ++++-
>  drivers/mmc/host/sunxi-mmc.c                              | 114 ++++---
>  5 files changed, 289 insertions(+), 43 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
>
> base-commit: c94f7962e97c2ba0a612656bc456d979f20cb382
> --
> git-series 0.8.11
