From: jbrunet@baylibre.com (Jerome Brunet)
Date: Tue, 07 Nov 2017 12:03:17 +0100
Subject: [PATCH v3 0/4] fix the clock setting for SAR ADC
In-Reply-To: <20171107053646.31087-1-yixun.lan@amlogic.com>
References: <20171107053646.31087-1-yixun.lan@amlogic.com>
Message-ID: <1510052597.1328.69.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-11-07 at 13:36 +0800, Yixun Lan wrote:
> patch [1/4]:
>   Fix wrong SARADC/SANA clock gate bit in Meson-GXBB/GXL,
> the published datasheet also has wrong description about this.
> 
> patch [2-4/4]:
>   Drop the "sana" clock from SAR ADC module,
> 
>   From the hardware perspective, the SAR ADC module doesn't
> require "sana" clock to wrok. This should apply to all SoC,
> including meson6,8, GXBB, GXL..
> 
> Note: the whole patchset series has been tested at GXL-P212 board,
> we haven't got any meson6,8 board to test, so I would appreciate
> if someone (Martin?) could help to confirm it works there.
>  
> Changes since v2 at [2] :
>   - explicitly point out 'sana' clock is not required for saradc, and drop
> them
>   - update comments, as the published datasheet is wrong
>  
> Changes since v1 at [1] :
>   - correct SAR ADC/SANA clock gate bit
> 
> [1] http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005221.ht
> ml
> [2] http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005242.ht
> ml
> 

Those patches should go through different trees. To avoid causing a (temporary)
regression, the clk patch absolutely needs to be merged before any other patches
is merged.

I can take the clk patch as a fix for v4.15. It's too late for v4.14 but it's
not big deal, I suppose the long term kernel will pick it up later on.

Once the sana clock is indeed *the* sana clock, which of IIO or DT patch is
merged first does not matter, the sana clock is optional.

BTW, the cover letter and the IIO patch are missing the IIO maintainer and
mailing list. According to MAINTAINERS, you are missing:

* Jonathan Cameron <jic23@kernel.org>
* linux-iio at vger.kernel.org

Please resend with the warning note above (so other maintainers are aware of
dependency), the correction applied to patch 1 commit log and the missing
recipients.

> 
> Xingyu Chen (3):
>   iio: adc: meson-saradc: remove irrelevant clock "sana"
>   dt-bindings: iio: adc: update the doc for SAR ADC
>   ARM64: dts: meson: drop "sana" clock from SAR ADC
> 
> Yixun Lan (1):
>   clk: meson: gxbb: fix wrong clock for SARADC/SANA
> 
>  .../bindings/iio/adc/amlogic,meson-saradc.txt        |  1 -
>  arch/arm/boot/dts/meson8.dtsi                        |  5 ++---
>  arch/arm/boot/dts/meson8b.dtsi                       |  5 ++---
>  arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi          |  3 +--
>  arch/arm64/boot/dts/amlogic/meson-gxl.dtsi           |  3 +--
>  drivers/clk/meson/gxbb.c                             |  4 ++--
>  drivers/iio/adc/meson_saradc.c                       | 20 -----------------
> ---
>  7 files changed, 8 insertions(+), 33 deletions(-)
> 
