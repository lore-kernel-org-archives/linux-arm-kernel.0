From: pku.leo@gmail.com (Leo Li)
Date: Mon, 8 Aug 2016 18:03:23 -0500
Subject: [PATCH] [linux-devel]arm64: Add DTS support for FSL's LS1012A SoC
In-Reply-To: <1469165712-4356-1-git-send-email-Bhaskar.Upadhaya@nxp.com>
References: <1469165712-4356-1-git-send-email-Bhaskar.Upadhaya@nxp.com>
Message-ID: <CADRPPNT+gJQeyVUjU8QiwiNe1eXT4bZz4iAc-3SXycZweb3reA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 22, 2016 at 12:35 AM, Bhaskar Upadhaya
<Bhaskar.Upadhaya@nxp.com> wrote:
>
> The QorIQ LS1012A processor is a new Freescale' SoC optimized
> for battery-backed or USB-powered, integrates a single ARM
> Cortex-A53 core with a hardware packet forwarding engine
> and high-speed interfaces to deliver line-rate networking performance.
> LS1012AQDS, LS1012ARDB, LS1012AFRDM are a high-performance development platform
> using LS1012A SoC.
>
> Add the device tree support for FSL LS1012A SoC.
> Following levels of DTSI/DTS files have been created for the LS1012A
> SoC family:
>
>         - fsl-ls1012a.dtsi:
>                 DTS-Include file for FSL LS1012A SoC.
>
>         - fsl-ls1012a-frdm.dts:
>                 DTS file for FSL LS1012A FRDM board.
>
>         - fsl-ls1012a-qds.dts:
>                 DTS file for FSL LS1012A QDS board.
>
>         - fsl-ls1012a-rdb.dts:
>                 DTS file for FSL LS1012A RDB board.
>
> Add ls1012ardb, ls1012aqds and ls1012afrdm dtb in Makefile
>
> Signed-off-by: Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>
> Signed-off-by: Calvin Johnson <calvin.johnson@nxp.com>
> Signed-off-by: Makarand Pawagi <makarand.pawagi@nxp.com>
> Signed-off-by: Pratiyush Mohan Srivastava <pratiyush.srivastava@nxp.com>
> Signed-off-by: Yunhui Cui <yunhui.cui@nxp.com>
> Signed-off-by: Rajesh Bhagat <rajesh.bhagat@nxp.com>
> Signed-off-by: Alison Wang <alison.wang@nxp.com>
> Signed-off-by: Jia Hongtao <hongtao.jia@nxp.com>
> Signed-off-by: Anji J <anji.jagarlmudi@freescale.com>
> Signed-off-by: Bhaskar Upadhaya <Bhaskar.Upadhaya@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile             |   3 +
>  arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts | 186 ++++++++
>  arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts  | 218 +++++++++
>  arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts  | 115 +++++
>  arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi     | 512 +++++++++++++++++++++
>  5 files changed, 1034 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
>
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 1b7783d..4aa3bee 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -3,6 +3,9 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1043a-rdb.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-qds.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-rdb.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-simu.dtb
> +dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-qds.dtb
> +dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-rdb.dtb
> +dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-frdm.dtb
>
>  always         := $(dtb-y)
>  subdir-y       := $(dts-dirs)
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts b/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
> new file mode 100644
> index 0000000..5db6133
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
> @@ -0,0 +1,186 @@
> +/*
> + * Device Tree Include file for Freescale Layerscape-1012A family SoC.
> + *
> + * Copyright 2016, Freescale Semiconductor Inc.
> +
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions are met:
> + *     * Redistributions of source code must retain the above copyright
> + *       notice, this list of conditions and the following disclaimer.
> + *     * Redistributions in binary form must reproduce the above copyright
> + *       notice, this list of conditions and the following disclaimer in the
> + *       documentation and/or other materials provided with the distribution.
> + *     * Neither the name of Freescale Semiconductor nor the
> + *       names of its contributors may be used to endorse or promote products
> + *       derived from this software without specific prior written permission.
> + *
> + *
> + * ALTERNATIVELY, this software may be distributed under the terms of the
> + * GNU General Public License ("GPL") as published by the Free Software
> + * Foundation, either version 2 of that License or (at your option) any
> + * later version.
> + *
> + * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
> + * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
> + * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
> + * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
> + * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
> + * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
> + * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
> + * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
> + * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + */
> +/dts-v1/;
> +
> +#include "fsl-ls1012a.dtsi"
> +
> +/ {
> +       model = "LS1012A FREEDOM Board";
> +       compatible = "fsl,ls1012a-frdm", "fsl,ls1012a";
> +
> +       aliases {
> +               crypto = &crypto;
> +       };
> +
> +       sys_mclk: clock-mclk {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <25000000>;
> +       };
> +
> +       regulators {
> +               compatible = "simple-bus";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               reg_1p8v: regulator at 0 {
> +                       compatible = "regulator-fixed";
> +                       reg = <0>;
> +                       regulator-name = "1P8V";
> +                       regulator-min-microvolt = <1800000>;
> +                       regulator-max-microvolt = <1800000>;
> +                       regulator-always-on;
> +               };
> +       };
> +
> +       sound {
> +               compatible = "simple-audio-card";
> +               simple-audio-card,format = "i2s";
> +               simple-audio-card,widgets =
> +                       "Microphone", "Microphone Jack",
> +                       "Headphone", "Headphone Jack",
> +                       "Speaker", "Speaker Ext",
> +                       "Line", "Line In Jack";
> +               simple-audio-card,routing =
> +                       "MIC_IN", "Microphone Jack",
> +                       "Microphone Jack", "Mic Bias",
> +                       "LINE_IN", "Line In Jack",
> +                       "Headphone Jack", "HP_OUT",
> +                       "Speaker Ext", "LINE_OUT";
> +
> +               simple-audio-card,cpu {
> +                       sound-dai = <&sai2>;
> +                       frame-master;
> +                       bitclock-master;
> +               };
> +
> +               simple-audio-card,codec {
> +                       sound-dai = <&codec>;
> +                       frame-master;
> +                       bitclock-master;
> +                       system-clock-frequency = <25000000>;
> +               };
> +       };
> +};
> +
> +&qspi {
> +       num-cs = <2>;
> +       bus-num = <0>;
> +       status = "disabled";
> +       fsl,ddr-sampling-point = <4>;
> +
> +       qflash0: s25fs512s at 0 {
> +               compatible = "spansion,m25p80";
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               spi-max-frequency = <20000000>;
> +               m25p,fast-read;
> +               reg = <0>;
> +       };
> +};
> +&ftm0 {
> +       status = "disabled";
> +};
> +
> +&i2c0 {
> +       status = "okay";
> +
> +       codec: sgtl5000 at a {
> +               #sound-dai-cells = <0>;
> +               compatible = "fsl,sgtl5000";
> +               reg = <0xa>;
> +               VDDA-supply = <&reg_1p8v>;
> +               VDDIO-supply = <&reg_1p8v>;
> +               clocks = <&sys_mclk 1>;
> +       };
> +};
> +
> +&duart0 {
> +       status = "okay";
> +};
> +&pfe {
> +       status = "disabled";
> +       ethernet at 0 {
> +               compatible = "fsl,pfe-gemac-port";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               reg = < 0x0 >;  /* GEM_ID */
> +               fsl,gemac-bus-id = <0x0>;       /* BUS_ID */
> +               fsl,gemac-phy-id = <0x2>;       /* PHY_ID */
> +               fsl,mdio-mux-val = <0x0>;
> +               local-mac-address = [ 00 1A 2B 3C 4D 5E ];
> +               phy-mode = "sgmii";
> +               fsl,pfe-gemac-if-name = "eth0";
> +               fsl,pfe-phy-if-flags = <0x0>;
> +               fsl,pfe-gemac-mode = <0x1B00>; /* GEMAC_SW_CONF | GEMAC_SW_FULL_DUPLEX | GEMAC_SW_SPEED_1G */
> +
> +               mdio at 0 {
> +                       reg = <0x1>; /* enabled/disabled */
> +                       fsl,mdio-phy-mask = <0xFFFFFFF9>;
> +               };
> +       };
> +       ethernet at 1 {
> +               compatible = "fsl,pfe-gemac-port";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               reg = < 0x1 >;  /* GEM_ID */
> +               fsl,gemac-bus-id = < 0x1 >;     /* BUS_ID */
> +               fsl,gemac-phy-id = < 0x1 >;     /* PHY_ID */
> +               fsl,mdio-mux-val = <0x0>;
> +               local-mac-address = [ 00 AA BB CC DD EE ];
> +               phy-mode = "sgmii";
> +               fsl,pfe-gemac-if-name = "eth1";
> +               fsl,pfe-phy-if-flags = <0x0>;
> +               fsl,pfe-gemac-mode = <0x1B00>; /* GEMAC_SW_CONF | GEMAC_SW_FULL_DUPLEX | GEMAC_SW_SPEED_1G */
> +               mdio at 0 {
> +                       reg = <0x0>; /* enabled/disabled */
> +                       fsl,mdio-phy-mask = <0xFFFFFFF9>;
> +               };
> +
> +       };
> +
> +};
>

Beside the other comment for the pfe nodes, the nodes themselves have
problems.  DTC is spitting out messages like this:

Warning (reg_format): "reg" property in /pfe at 04000000/ethernet at 0 has
invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
Warning (reg_format): "reg" property in /pfe at 04000000/ethernet at 1 has
invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
Warning (ranges_format): "ranges" property in /pfe at 04000000 has
invalid length (32 bytes) (parent #address-cells == 2, child
#address-cells == 2, #size-cells == 1)
Warning (avoid_default_addr_size): Relying on default #address-cells
value for /pfe at 04000000/ethernet at 0
Warning (avoid_default_addr_size): Relying on default #size-cells
value for /pfe at 04000000/ethernet at 0
Warning (avoid_default_addr_size): Relying on default #address-cells
value for /pfe at 04000000/ethernet at 1
Warning (avoid_default_addr_size): Relying on default #size-cells
value for /pfe at 04000000/ethernet at 1

Ditto for the nodes in other board dts.

Regards,
Leo
