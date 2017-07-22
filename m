From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 22 Jul 2017 10:19:08 +0800
Subject: [PATCH 3/4] arm: sunxi: Add AXP20X_ADC
In-Reply-To: <20170721162005.18892-3-maxime.ripard@free-electrons.com>
References: <20170721162005.18892-1-maxime.ripard@free-electrons.com>
 <20170721162005.18892-3-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v64tx6M1CJSKr_wgD4LM+-ER+Yqpj-hUftptj41PVhbBBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 22, 2017 at 12:20 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The APX20X_POWER option, that is a dependency of the USB controllers
> depends on IIO and AXP20X_ADC. Add it so that we can get a working USB
> back.

The statement is only half true. AXP20X_POWER can fall back to reading
the ADC registers directly if AXP20X_ADC is not enabled. Is there a plan
to remove this feature?

Also, AXP20X_ADC is only really needed if the hardware is AXP20x, and
not the later ones that don't have voltage/current sensing. I would
like to change the hard dependency on AXP20X_ADC to the "imply"
keyword in Kconfig for the AC and battery power supply drivers.
That is another discussion though.

So I think the description should be something like

    AXP20X_POWER depends on IIO. Even though it does not depend on
    AXP20X_ADC, it is the new, preferred way of getting power supply
    readings. The other AXP power supply drivers use it as well.

    Enable both options.

ChenYu

> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/configs/sunxi_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
> index 400eb9366a66..456988dd7b0e 100644
> --- a/arch/arm/configs/sunxi_defconfig
> +++ b/arch/arm/configs/sunxi_defconfig
> @@ -127,6 +127,8 @@ CONFIG_DMADEVICES=y
>  CONFIG_DMA_SUN6I=y
>  # CONFIG_IOMMU_SUPPORT is not set
>  CONFIG_EXTCON=y
> +CONFIG_IIO=y
> +CONFIG_AXP20X_ADC=y
>  CONFIG_PWM=y
>  CONFIG_PWM_SUN4I=y
>  CONFIG_PHY_SUN4I_USB=y
> --
> 2.13.3
>
