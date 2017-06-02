From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 2 Jun 2017 12:50:16 +0200
Subject: [PATCH 0/7] dra7: Fixes for MMC devicetree node
In-Reply-To: <20170601143401.16852-1-kishon@ti.com>
References: <20170601143401.16852-1-kishon@ti.com>
Message-ID: <CAPDyKFqHHjZQnnaGLP=xDj3eYgzADDYoomzBuXRviBgh-n2QFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 June 2017 at 16:33, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> There are the set of fixes that were sent initially as part
> of [1].
>
> These are mostly fixes w.r.t populating regulators in
> mmc dt node. It was working before because the regulators
> connecting to the IO lines are always on regulators. This will
> break once we add UHS support where voltage has to be changed
> dynamically.
>
> Performed enumeration testing on dra72-evm-revc, dra72-evm,
> dra7-evm, am572x-evm, am571x-idk and am572x-idk.
>
> This is a preparation series for adding UHS mode support in
> the above mentioned platforms.
>
> [1] -> https://lkml.org/lkml/2017/5/19/196
>
> Kishon Vijay Abraham I (5):
>   ARM: dts: dra72-evm-common: Correct vmmc-supply for mmc2
>   ARM: dts: dra72-evm: Add vmmc_aux supply to mmc1
>   ARM: dts: dra72-evm-revc: Add vmmc_aux supply to mmc1
>   ARM: dts: am57xx-beagle-x15-revb1: Fix supply name used for MMC1 IO
>     lines
>   ARM: dts: dra7: Add "max-frequency" property to MMC dt nodes
>
> Ravikumar Kattekola (1):
>   ARM: dts: dra7-evm: Correct the vmmc-supply for mmc2
>
> Sekhar Nori (1):
>   ARM: OMAP2+: Add pdata-quirks for MMC/SD on DRA74x EVM
>
>  arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts |  2 +-
>  arch/arm/boot/dts/dra7-evm.dts                | 10 ++++++++-
>  arch/arm/boot/dts/dra7.dtsi                   |  5 +++++
>  arch/arm/boot/dts/dra71-evm.dts               | 14 ++++++++++++
>  arch/arm/boot/dts/dra72-evm-common.dtsi       |  2 --
>  arch/arm/boot/dts/dra72-evm-revc.dts          | 18 ++++++++++++++++
>  arch/arm/boot/dts/dra72-evm.dts               | 18 ++++++++++++++++
>  arch/arm/mach-omap2/pdata-quirks.c            | 31 +++++++++++++++++++++++++++
>  include/linux/platform_data/hsmmc-omap.h      |  3 +++
>  9 files changed, 99 insertions(+), 4 deletions(-)

This series add a bunch of new vmmc_aux regulators for the mmc
controller nodes. I would rather see that omap_hsmmc also converts to
use the generic mmc binding for this regulator, which is "vqmmc".

To accomplish that, omap_hsmmc needs to convert to use
mmc_regulator_get_supply(). If the "vqmmc" regulator isn't found, it
should fallback to try the "vmmc_aux".

Can you do that?

Kind regards
Uffe
