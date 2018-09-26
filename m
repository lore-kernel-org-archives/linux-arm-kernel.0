From: leoyang.li@nxp.com (Li Yang)
Date: Wed, 26 Sep 2018 18:39:11 -0500
Subject: [PATCH] arm64: dts: Add support for NXP LS1028A SoC
In-Reply-To: <1535555668-7763-1-git-send-email-sudhanshu.gupta@nxp.com>
References: <1535555668-7763-1-git-send-email-sudhanshu.gupta@nxp.com>
Message-ID: <CADRPPNTYd340S1sHPjg0eq7wV8pYjdw+hAx=9VHq8EBA7Twm2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 29, 2018 at 4:24 AM Sudhanshu Gupta <sudhanshu.gupta@nxp.com> wrote:
>
> From: Bhaskar Upadhaya <Bhaskar.Upadhaya@nxp.com>
>
> LS1028A contains two ARM v8 CortexA72 processor cores
> with 32 KB L1-D cache and 48 KB L1-I cache
>
> Features summary
>  Two 32-bit / 64-bit ARM v8 Cortex-A72 CPUs
>   - Arranged as single clusters of two cores sharing a 1 MB L2 cache
>   - Speed Up to 1.3 GHz
>   - Support for cluster power-gating.
>  Cache coherent interconnect (CCI-400)
>   - Hardware-managed data coherency
>   - Up to 400 MHz
>  32-bit DDR4 SDRAM memory controller with ECC
>  Two PCIe 3.0 controllers
>  One serial ATA (SATA 3.0) controller
>  Two high-speed USB 3.0 controllers with integrated PHY
>
>  Following levels of DTSI/DTS files have been created for the LS1028A
>   SoC family:
>
>          - fsl-ls1028a.dtsi:
>                  DTS-Include file for NXP LS1028A SoC.
>
>          - fsl-ls1028a-qds.dts:
>                  DTS file for NXP LS1028A QDS board.
>
>          - fsl-ls1028a-rdb.dts:
>                  DTS file for NXP LS1028A RDB board
>
> Signed-off-by: Sudhanshu Gupta <sudhanshu.gupta@nxp.com>
> Signed-off-by: Rai Harninder <harninder.rai@nxp.com>
> Signed-off-by: Bhaskar Upadhaya <Bhaskar.Upadhaya@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile            |   2 +
>  arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts |  93 ++++++
>  arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts |  74 +++++
>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi    | 355 ++++++++++++++++++++++
>  4 files changed, 524 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
>
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index d116144..b33c64a 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -3,6 +3,8 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-frwy.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-frdm.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-qds.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-rdb.dtb
> +dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-qds.dtb
> +dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-rdb.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1043a-qds.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1043a-rdb.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-qds.dtb
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> new file mode 100644
> index 0000000..586d5cd
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> @@ -0,0 +1,93 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Device Tree file for NXP LS1028A QDS Board.
> + *
> + * Copyright 2018 NXP
> + *
> + * Harninder Rai <harninder.rai@nxp.com>
> + *
> + */
> +
> +/dts-v1/;
> +
> +#include "fsl-ls1028a.dtsi"
> +
> +/ {
> +       model = "LS1028A QDS Board";
> +       compatible = "fsl,ls1028a-qds", "fsl,ls1028a";
> +
> +       aliases {
> +               gpio0 = &gpio1;
> +               gpio1 = &gpio2;
> +               gpio2 = &gpio3;
> +               serial0 = &duart0;
> +               serial1 = &duart1;
> +       };
> +
> +       chosen {
> +               stdout-path = "serial0:115200n8";
> +       };
> +};
> +
> +&duart0 {
> +       status = "okay";
> +};
> +
> +&duart1 {
> +       status = "okay";
> +};
> +
> +&i2c0 {
> +       status = "okay";
> +
> +       pca9847 at 77 {
> +               compatible = "nxp,pca9847";
> +               reg = <0x77>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               i2c at 2 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x2>;
> +
> +                       ina220 at 40 {
> +                               compatible = "ti,ina220";
> +                               reg = <0x40>;
> +                               shunt-resistor = <1000>;
> +                       };
> +
> +                       ina220 at 41 {
> +                               compatible = "ti,ina220";
> +                               reg = <0x41>;
> +                               shunt-resistor = <1000>;
> +                       };
> +               };
> +
> +               i2c at 3 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x3>;
> +
> +                       eeprom at 56 {
> +                               compatible = "atmel,24c512";
> +                               reg = <0x56>;
> +                       };
> +
> +                       eeprom at 57 {
> +                               compatible = "atmel,24c512";
> +                               reg = <0x57>;
> +                       };
> +
> +                       sa56004 at 4c {
> +                               compatible = "nxp,sa56004";
> +                               reg = <0x4c>;

The binding requires a vcc-supply property which is missing here.

> +                       };
> +
> +                       rtc at 51 {
> +                               compatible = "nxp,pcf2129";
> +                               reg = <0x51>;
> +                       };
> +               };
> +       };
> +};
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> new file mode 100644
> index 0000000..e5c4309
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> @@ -0,0 +1,74 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Device Tree file for NXP LS1028A RDB Board.
> + *
> + * Copyright 2018 NXP
> + *
> + * Harninder Rai <harninder.rai@nxp.com>
> + *
> + */
> +
> +/dts-v1/;
> +#include "fsl-ls1028a.dtsi"
> +
> +/ {
> +       model = "LS1028A RDB Board";
> +       compatible = "fsl,ls1028a-rdb", "fsl,ls1028a";
> +
> +       aliases {
> +               serial0 = &duart0;
> +               serial1 = &duart1;
> +       };
> +
> +       chosen {
> +               stdout-path = "serial0:115200n8";
> +       };
> +};
> +
> +&i2c0 {
> +       status = "okay";
> +       pca9847 at 77 {
> +               compatible = "nxp,pca9847";
> +               reg = <0x77>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               i2c at 2 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x02>;
> +
> +                       ina220 at 40 {
> +                               compatible = "ti,ina220";
> +                               reg = <0x40>;
> +                               shunt-resistor = <500>;
> +                       };
> +               };
> +
> +               i2c at 3 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x3>;
> +
> +                       sa56004 at 4c {
> +                               compatible = "nxp,sa56004";
> +                               reg = <0x4c>;
> +                       };
> +
> +                       rtc at 51 {
> +                               compatible = "nxp,pcf2129";
> +                               reg = <0x51>;
> +                       };
> +               };
> +       };
> +
> +
> +};
> +
> +&duart0 {
> +       status = "okay";
> +};
> +
> +&duart1 {
> +       status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> new file mode 100644
> index 0000000..bc860e2
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -0,0 +1,355 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Device Tree Include file for NXP Layerscape-1028A family SoC.
> + *
> + * Copyright 2018 NXP
> + *
> + * Harninder Rai <harninder.rai@nxp.com>
> + *
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/thermal/thermal.h>
> +
> +/ {
> +       compatible = "fsl,ls1028a";
> +       interrupt-parent = <&gic>;
> +       #address-cells = <2>;
> +       #size-cells = <2>;
> +
> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               cpu0: cpu at 0 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a72";
> +                       reg = <0x0>;
> +                       clocks = <&clockgen 1 0>;
> +                       next-level-cache = <&l2>;
> +                       cpu-idle-states = <&CPU_PH20>;
> +                       #cooling-cells = <2>;

enable-method property is required.
#cooling-cells is not needed as you don't define the cooling device.

> +               };
> +
> +               cpu1: cpu at 1 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a72";
> +                       reg = <0x1>;
> +                       clocks = <&clockgen 1 0>;
> +                       next-level-cache = <&l2>;
> +                       cpu-idle-states = <&CPU_PH20>;
> +               };
> +
> +               l2: l2-cache {
> +                       compatible = "cache";
> +               };
> +       };
> +
> +       idle-states {
> +               /*
> +                * PSCI node is not added default, U-boot will add missing
> +                * parts if it determines to use PSCI.
> +                */
> +               entry-method = "arm,psci";
> +
> +               CPU_PH20: cpu-ph20 {
> +                       compatible = "arm,idle-state";
> +                       idle-state-name = "PH20";
> +                       arm,psci-suspend-param = <0x00010000>;
> +                       entry-latency-us = <1000>;
> +                       exit-latency-us = <1000>;
> +                       min-residency-us = <3000>;
> +               };
> +       };
> +
> +       memory at 80000000 {
> +               device_type = "memory";
> +       };
> +
> +       sysclk: sysclk {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <100000000>;
> +               clock-output-names = "sysclk";
> +       };
> +
> +       reboot {
> +               compatible ="syscon-reboot";
> +               regmap = <&dcfg>;
> +               offset = <0xb0>;
> +               mask = <0x02>;
> +               status = "disabled";
> +       };
> +
> +       timer {
> +               compatible = "arm,armv8-timer";
> +               interrupts = <GIC_PPI 13 (GIC_CPU_MASK_RAW(0xf) |

Probably GIC_CPU_MASK_SIMPLE(2) as you only have two cores.  The same
for all the PPI interrupts below.

> +                                         IRQ_TYPE_LEVEL_LOW)>,
> +                            <GIC_PPI 14 (GIC_CPU_MASK_RAW(0xf) |
> +                                         IRQ_TYPE_LEVEL_LOW)>,
> +                            <GIC_PPI 11 (GIC_CPU_MASK_RAW(0xf) |
> +                                         IRQ_TYPE_LEVEL_LOW)>,
> +                            <GIC_PPI 10 (GIC_CPU_MASK_RAW(0xf) |
> +                                         IRQ_TYPE_LEVEL_LOW)>;
> +       };
> +
> +       pmu {
> +               compatible = "arm,cortex-a72-pmu";
> +               interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;

The binding says one interrupt per core, why we are having 4 interrupts here.

> +               interrupt-affinity = <&cpu0>,
> +                                    <&cpu1>;
> +               status = "disabled";
> +       };
> +
> +       gic: interrupt-controller at 6000000 {
> +               compatible= "arm,gic-v3";
> +               #address-cells = <2>;
> +               #size-cells = <2>;
> +               ranges;
> +               reg= <0x0 0x06000000 0 0x10000>, /* GIC Dist */
> +                       <0x0 0x06040000 0 0x40000>; /* GIC Redistributor */
> +               #interrupt-cells= <3>;
> +               interrupt-controller;
> +               interrupts = <GIC_PPI 9 (GIC_CPU_MASK_RAW(0xf) |
> +                                        IRQ_TYPE_LEVEL_LOW)>;
> +               its:gic-its at 6020000 {
> +                       compatible = "arm,gic-v3-its";
> +                       msi-controller;
> +                       reg = <0x0 0x06020000 0 0x20000>;/* GIC Translater */
> +               };
> +       };
> +
> +       soc: soc {
> +               compatible = "simple-bus";
> +               #address-cells = <2>;
> +               #size-cells = <2>;
> +               ranges;
> +
> +               smmu: iommu at 5000000 {
> +                       compatible = "arm,mmu-500";
> +                       reg = <0 0x5000000 0 0x800000>;
> +                       #global-interrupts = <8>;
> +                       #iommu-cells = <1>;
> +                       stream-match-mask = <0x7C00>;
> +                       /* global secure fault */
> +                       interrupts = <0 13 4>,
> +                       /* combined secure interrupt */
> +                                    <0 14 4>,
> +                       /* global non-secure fault */
> +                                    <0 15 4>,
> +                       /* combined non-secure interrupt */
> +                                    <0 16 4>,
> +                       /* performance counter interrupts 0-7 */
> +                                    <0 211 4>, <0 212 4>,
> +                                    <0 213 4>, <0 214 4>,
> +                       /* per context interrupt, 64 interrupts */
> +                                    <0 146 4>, <0 147 4>,
> +                                    <0 148 4>, <0 149 4>,
> +                                    <0 150 4>, <0 151 4>,
> +                                    <0 152 4>, <0 153 4>,
> +                                    <0 154 4>, <0 155 4>,
> +                                    <0 156 4>, <0 157 4>,
> +                                    <0 158 4>, <0 159 4>,
> +                                    <0 160 4>, <0 161 4>,
> +                                    <0 162 4>, <0 163 4>,
> +                                    <0 164 4>, <0 165 4>,
> +                                    <0 166 4>, <0 167 4>,
> +                                    <0 168 4>, <0 169 4>,
> +                                    <0 170 4>, <0 171 4>,
> +                                    <0 172 4>, <0 173 4>,
> +                                    <0 174 4>, <0 175 4>,
> +                                    <0 176 4>, <0 177 4>,
> +                                    <0 178 4>, <0 179 4>,
> +                                    <0 180 4>, <0 181 4>,
> +                                    <0 182 4>, <0 183 4>,
> +                                    <0 184 4>, <0 185 4>,
> +                                    <0 186 4>, <0 187 4>,
> +                                    <0 188 4>, <0 189 4>,
> +                                    <0 190 4>, <0 191 4>,
> +                                    <0 192 4>, <0 193 4>,
> +                                    <0 194 4>, <0 195 4>,
> +                                    <0 196 4>, <0 197 4>,
> +                                    <0 198 4>, <0 199 4>,
> +                                    <0 200 4>, <0 201 4>,
> +                                    <0 202 4>, <0 203 4>,
> +                                    <0 204 4>, <0 205 4>,
> +                                    <0 206 4>, <0 207 4>,
> +                                    <0 208 4>, <0 209 4>;
> +               };
> +
> +               ddr: memory-controller at 1080000 {
> +                       compatible = "fsl,qoriq-memory-controller";
> +                       reg = <0x0 0x1080000 0x0 0x1000>;
> +                       interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
> +                       big-endian;
> +               };
> +
> +               scfg: scfg at 1fc0000 {
> +                       compatible = "fsl,ls1028a-scfg", "syscon";
> +                       reg = <0x0 0x1fc0000 0x0 0x10000>;
> +                       big-endian;
> +               };
> +
> +               dcfg: dcfg at 1e00000 {
> +                       compatible = "fsl,ls1028a-dcfg", "syscon";
> +                       reg = <0x0 0x1e00000 0x0 0x10000>;
> +                       big-endian;
> +               };
> +
> +               clockgen: clocking at 1300000 {
> +                       compatible = "fsl,ls1028a-clockgen";
> +                       reg = <0x0 0x1300000 0x0 0xa0000>;
> +                       #clock-cells = <2>;
> +                       clocks = <&sysclk>;
> +               };
> +
> +               i2c0: i2c at 2000000 {
> +                       compatible = "fsl,vf610-i2c";
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x0 0x2000000 0x0 0x10000>;
> +                       interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&clockgen 4 1>;
> +                       dma-names = "tx", "rx";

You don't define dmas here why you add dma-names?  And you only added
this in the first i2c node.

> +                       status = "disabled";
> +               };
> +
> +               i2c1: i2c at 2010000 {
> +                       compatible = "fsl,vf610-i2c";
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x0 0x2010000 0x0 0x10000>;
> +                       interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&clockgen 4 1>;
> +                       status = "disabled";
> +               };
> +
> +               i2c2: i2c at 2020000 {
> +                       compatible = "fsl,vf610-i2c";
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x0 0x2020000 0x0 0x10000>;
> +                       interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&clockgen 4 1>;
> +                       status = "disabled";
> +               };
> +
> +               i2c3: i2c at 2030000 {
> +                       compatible = "fsl,vf610-i2c";
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x0 0x2030000 0x0 0x10000>;
> +                       interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&clockgen 4 1>;
> +                       status = "disabled";
> +               };
> +
> +               i2c4: i2c at 2040000 {
> +                       compatible = "fsl,vf610-i2c";
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x0 0x2040000 0x0 0x10000>;
> +                       interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&clockgen 4 1>;
> +                       status = "disabled";
> +               };
> +
> +               i2c5: i2c at 2050000 {
> +                       compatible = "fsl,vf610-i2c";
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x0 0x2050000 0x0 0x10000>;
> +                       interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&clockgen 4 1>;
> +                       status = "disabled";
> +               };
> +
> +               i2c6: i2c at 2060000 {
> +                       compatible = "fsl,vf610-i2c";
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x0 0x2060000 0x0 0x10000>;
> +                       interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&clockgen 4 1>;
> +                       status = "disabled";
> +               };
> +
> +               i2c7: i2c at 2070000 {
> +                       compatible = "fsl,vf610-i2c";
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x0 0x2070000 0x0 0x10000>;
> +                       interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&clockgen 4 1>;
> +                       status = "disabled";
> +               };
> +
> +               duart0: serial at 21c0500 {
> +                       compatible = "fsl,ns16550", "ns16550a";
> +                       reg = <0x00 0x21c0500 0x0 0x100>;
> +                       interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&clockgen 4 1>;

Should be disabled by default?  As you enabled it in board dts.

> +               };
> +
> +               duart1: serial at 21c0600 {
> +                       compatible = "fsl,ns16550", "ns16550a";
> +                       reg = <0x00 0x21c0600 0x0 0x100>;
> +                       interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&clockgen 4 1>;

Should be disabled by default?  As you enabled it in board dts.

> +               };
> +
> +               gpio1: gpio at 2300000 {
> +                       compatible = "fsl,qoriq-gpio";
> +                       reg = <0x0 0x2300000 0x0 0x10000>;
> +                       interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
> +                       gpio-controller;
> +                       #gpio-cells = <2>;
> +                       interrupt-controller;
> +                       #interrupt-cells = <2>;
> +               };
> +
> +               gpio2: gpio at 2310000 {
> +                       compatible = "fsl,qoriq-gpio";
> +                       reg = <0x0 0x2310000 0x0 0x10000>;
> +                       interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
> +                       gpio-controller;
> +                       #gpio-cells = <2>;
> +                       interrupt-controller;
> +                       #interrupt-cells = <2>;
> +               };
> +
> +               gpio3: gpio at 2320000 {
> +                       compatible = "fsl,qoriq-gpio";
> +                       reg = <0x0 0x2320000 0x0 0x10000>;
> +                       interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
> +                       gpio-controller;
> +                       #gpio-cells = <2>;
> +                       interrupt-controller;
> +                       #interrupt-cells = <2>;
> +               };
> +
> +               wdog0: watchdog at 23c0000 {
> +                       compatible= "arm,armv8-timer";
> +                       reg = <0x0 0x23c0000 0x0 0x10000>;
> +                       interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&clockgen 4 1>;
> +                       big-endian;
> +                       status = "disabled";
> +               };
> +
> +               sata: sata at 3200000 {
> +                       compatible = "fsl,ls1028a-ahci";
> +                       reg = <0x0 0x3200000 0x0 0x10000>,
> +                               <0x0 0x20140520 0x0 0x4>;
> +                       reg-names = "ahci", "sata-ecc";
> +                       interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&clockgen 4 1>;
> +                       status = "disabled";
> +               };
> +
> +       };
> +};
> +
> --
> 1.9.1
>
