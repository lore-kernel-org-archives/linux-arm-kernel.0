From: leoyang.li@nxp.com (Li Yang)
Date: Wed, 24 Oct 2018 16:41:29 -0500
Subject: [PATCH v5 6/6] arm64: dts: add LX2160ARDB board support
In-Reply-To: <1539536883-1928-7-git-send-email-vabhav.sharma@nxp.com>
References: <1539536883-1928-1-git-send-email-vabhav.sharma@nxp.com>
 <1539536883-1928-7-git-send-email-vabhav.sharma@nxp.com>
Message-ID: <CADRPPNSQt=d4HDR9YckZnXvFi4jB2RisraT869BvTGbpS3Etdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 15, 2018 at 12:14 AM Vabhav Sharma <vabhav.sharma@nxp.com> wrote:
>
> LX2160A reference design board (RDB) is a high-performance
> computing, evaluation, and development platform with LX2160A
> SoC.
>
> Signed-off-by: Priyanka Jain <priyanka.jain@nxp.com>
> Signed-off-by: Sriram Dash <sriram.dash@nxp.com>
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> Signed-off-by: Horia Geanta <horia.geanta@nxp.com>
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> Signed-off-by: Zhang Ying-22455 <ying.zhang22455@nxp.com>
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>

Acked-by: Li Yang <leoyang.li@nxp.com>

> ---
>  arch/arm64/boot/dts/freescale/Makefile            |   1 +
>  arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 119 ++++++++++++++++++++++
>  2 files changed, 120 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
>
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 86e18ad..445b72b 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -13,3 +13,4 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-rdb.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-simu.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2088a-qds.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2088a-rdb.dtb
> +dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-rdb.dtb
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> new file mode 100644
> index 0000000..6481e5f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> @@ -0,0 +1,119 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +//
> +// Device Tree file for LX2160ARDB
> +//
> +// Copyright 2018 NXP
> +
> +/dts-v1/;
> +
> +#include "fsl-lx2160a.dtsi"
> +
> +/ {
> +       model = "NXP Layerscape LX2160ARDB";
> +       compatible = "fsl,lx2160a-rdb", "fsl,lx2160a";
> +
> +       aliases {
> +               crypto = &crypto;
> +               serial0 = &uart0;
> +       };
> +
> +       chosen {
> +               stdout-path = "serial0:115200n8";
> +       };
> +
> +       sb_3v3: regulator-sb3v3 {
> +               compatible = "regulator-fixed";
> +               regulator-name = "MC34717-3.3VSB";
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +               regulator-boot-on;
> +               regulator-always-on;
> +       };
> +};
> +
> +&crypto {
> +       status = "okay";
> +};
> +
> +&esdhc0 {
> +       sd-uhs-sdr104;
> +       sd-uhs-sdr50;
> +       sd-uhs-sdr25;
> +       sd-uhs-sdr12;
> +       status = "okay";
> +};
> +
> +&esdhc1 {
> +       mmc-hs200-1_8v;
> +       mmc-hs400-1_8v;
> +       bus-width = <8>;
> +       status = "okay";
> +};
> +
> +&i2c0 {
> +       status = "okay";
> +
> +       i2c-mux at 77 {
> +               compatible = "nxp,pca9547";
> +               reg = <0x77>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               i2c at 2 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x2>;
> +
> +                       power-monitor at 40 {
> +                               compatible = "ti,ina220";
> +                               reg = <0x40>;
> +                               shunt-resistor = <1000>;
> +                       };
> +               };
> +
> +               i2c at 3 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x3>;
> +
> +                       temperature-sensor at 4c {
> +                               compatible = "nxp,sa56004";
> +                               reg = <0x4c>;
> +                               vcc-supply = <&sb_3v3>;
> +                       };
> +
> +                       temperature-sensor at 4d {
> +                               compatible = "nxp,sa56004";
> +                               reg = <0x4d>;
> +                               vcc-supply = <&sb_3v3>;
> +                       };
> +               };
> +       };
> +};
> +
> +&i2c4 {
> +       status = "okay";
> +
> +       rtc at 51 {
> +               compatible = "nxp,pcf2129";
> +               reg = <0x51>;
> +               // IRQ10_B
> +               interrupts = <0 150 0x4>;
> +       };
> +};
> +
> +&uart0 {
> +       status = "okay";
> +};
> +
> +&uart1 {
> +       status = "okay";
> +};
> +
> +&usb0 {
> +       status = "okay";
> +};
> +
> +&usb1 {
> +       status = "okay";
> +};
> --
> 2.7.4
>
