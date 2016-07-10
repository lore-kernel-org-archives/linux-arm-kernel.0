From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 10 Jul 2016 16:10:12 -0300
Subject: [PATCH 3/6] ARM: dts: imx25: substitute NO_PAD_CTL by the
 respective reset value
In-Reply-To: <1468145266-7567-4-git-send-email-uwe@kleine-koenig.org>
References: <1468145266-7567-1-git-send-email-uwe@kleine-koenig.org>
 <1468145266-7567-4-git-send-email-uwe@kleine-koenig.org>
Message-ID: <CAOMZO5A=6HLPacwp0seBn_s+AVF7zaUjUO8wOb1WoyvU1JrH7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Sun, Jul 10, 2016 at 7:07 AM, Uwe Kleine-K?nig <uwe@kleine-koenig.org> wrote:

>  arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi       | 18 +++----
>  .../imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts  |  2 +-
> diff --git a/arch/arm/boot/dts/imx25-pdk.dts b/arch/arm/boot/dts/imx25-pdk.dts
> index c823e45a7a01..643d083951ef 100644
> --- a/arch/arm/boot/dts/imx25-pdk.dts
> +++ b/arch/arm/boot/dts/imx25-pdk.dts

>         pinctrl_fec: fecgrp {
>                 fsl,pins = <
> -                       MX25_PAD_FEC_MDC__FEC_MDC               0x80000000
> +                       MX25_PAD_FEC_MDC__FEC_MDC               0x00000060
>                         MX25_PAD_FEC_MDIO__FEC_MDIO             0x400001e0
> -                       MX25_PAD_FEC_TDATA0__FEC_TDATA0         0x80000000
> -                       MX25_PAD_FEC_TDATA1__FEC_TDATA1         0x80000000
> -                       MX25_PAD_FEC_TX_EN__FEC_TX_EN           0x80000000
> -                       MX25_PAD_FEC_RDATA0__FEC_RDATA0         0x80000000
> -                       MX25_PAD_FEC_RDATA1__FEC_RDATA1         0x80000000
> -                       MX25_PAD_FEC_RX_DV__FEC_RX_DV           0x80000000
> -                       MX25_PAD_FEC_TX_CLK__FEC_TX_CLK         0x1c0
> -                       MX25_PAD_A17__GPIO_2_3                  0x80000000
> -                       MX25_PAD_D12__GPIO_4_8                  0x80000000
> +                       MX25_PAD_FEC_TDATA0__FEC_TDATA0         0x00000060
> +                       MX25_PAD_FEC_TDATA1__FEC_TDATA1         0x00000060
> +                       MX25_PAD_FEC_TX_EN__FEC_TX_EN           0x00000060
> +                       MX25_PAD_FEC_RDATA0__FEC_RDATA0         0x000000c1
> +                       MX25_PAD_FEC_RDATA1__FEC_RDATA1         0x000000c0
> +                       MX25_PAD_FEC_RX_DV__FEC_RX_DV           0x000000c0
> +                       MX25_PAD_FEC_TX_CLK__FEC_TX_CLK         0x000001c0
> +                       MX25_PAD_A17__GPIO_2_3                  0x00000000
> +                       MX25_PAD_D12__GPIO_4_8                  0x000000a1

Looking at the mx25pdk U-boot source code we see that FEC pins are not
configured as per the default power-on reset values, so this changes
the behavior.

>         pinctrl_i2c1: i2c1grp {
>                 fsl,pins = <
> -                       MX25_PAD_I2C1_CLK__I2C1_CLK             0x80000000
> -                       MX25_PAD_I2C1_DAT__I2C1_DAT             0x80000000
> +                       MX25_PAD_I2C1_CLK__I2C1_CLK             0x000000a8
> +                       MX25_PAD_I2C1_DAT__I2C1_DAT             0x000000a8

Same happens with I2C pins.

To stay in the safe side I would only change the pins that have GPIO
functionality in this patch.

Then we could later change each 0x80000000 occurrance by replacing it
with the actual PAD register value instead of the power on defaults.
