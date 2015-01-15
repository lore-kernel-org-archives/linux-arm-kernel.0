From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 15 Jan 2015 09:20:05 +0100
Subject: [RFC 0/3] mmc: Add dynamic frequency scaling
In-Reply-To: <1421054585-9032-1-git-send-email-k.kozlowski@samsung.com>
References: <1421054585-9032-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <CAPDyKFpGiaDJ3zjCSSbcia6iLS2+FLBRjGAheQAzvFsAkJax+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Mike, Stephen (Clock maintainers)

On 12 January 2015 at 10:23, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:
> Hi,
>
>
> I would like to hear some comments about idea of scaling MMC clock
> frequency. The basic idea is to lower the clock when device is
> completely idle or not busy enough.

We already have host drivers that implements runtime PM support.
Typically that would mean the clock will be gated once the device
becomes runtime PM suspended.

Why should we decrease the frequency of an already gated clock?

I think this boils done to how DVFS transitions can be triggered from
the clock drivers, right?

Currently the clock framework supports this through clock rate change
notifiers. Should we have clock notifiers for clk_prepare|unprepare()
as well? I do remember that someone posted patches for that a while
ago, but those were rejected.

Mike, Stephen - comments?

Kind regards
Uffe

>
> The patchset adds MMC card as a devfreq device and uses simple_ondemand
> as governor. In idle this gave benefits (less energy consumed during
> idle):
> 1. Trats2 (Exynos4412): 2.6%
> 2. Rinato (Exynos3250): 1%
>
> but (especially on Rinato) it had impact on performance (probably
> because ondemand triggering a little to late). What is interesting
> manually changing the clock (without this patchset) gave slightly
> bigger benefits. Maybe the devfreq introduces noticeable overhead?
>
>
> Comments are welcomed. Maybe on other platforms this has bigger impact?
>
> Best regards,
> Krzysztof
>
>
> Krzysztof Kozlowski (3):
>   mmc: Add dynamic frequency scaling
>   ARM: dts: Specify MSHC realistic clocks and use frequency scaling
>   ARM: dts: Use frequency scaling for MSHC
>
>  Documentation/devicetree/bindings/mmc/mmc.txt |   2 +
>  arch/arm/boot/dts/exynos3250-rinato.dts       |   1 +
>  arch/arm/boot/dts/exynos4412-trats2.dts       |   4 +-
>  drivers/mmc/card/block.c                      | 247 ++++++++++++++++++++++++++
>  drivers/mmc/core/Kconfig                      |  16 ++
>  drivers/mmc/core/core.h                       |   1 -
>  drivers/mmc/core/host.c                       |   2 +
>  include/linux/mmc/card.h                      |   8 +
>  include/linux/mmc/host.h                      |   3 +
>  9 files changed, 282 insertions(+), 2 deletions(-)
>
> --
> 1.9.1
>
