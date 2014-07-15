From: robherring2@gmail.com (Rob Herring)
Date: Tue, 15 Jul 2014 10:11:41 -0500
Subject: [PATCH 1/8] ARM: Add platform support for Fujitsu MB86S7X SoCs
In-Reply-To: <1405232911-4569-1-git-send-email-mollie.wu@linaro.org>
References: <1405232911-4569-1-git-send-email-mollie.wu@linaro.org>
Message-ID: <CAL_JsqKvwxjEDZPVwL646PhPKr7oemBzxr6cZ+X=uJQ2u_XZ8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding Nico for cluster PM code.

On Sun, Jul 13, 2014 at 1:28 AM, Mollie Wu <mollie.wu@linaro.org> wrote:
> The MB86S7X is a bigLITTLE configuration of 2xCA7 & 2xCA15 under Linux.
> And the remote master firmware (called SCB) running on CM3. Linux asks
> for things to be done over Mailbox API, to SCB which controls most of
> the important things. variations S70 & S73 are supported.
>
> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Olof <olof@lixom.net>
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Tetsuya Takinishi <t.takinishi@jp.fujitsu.com>
> Signed-off-by: Mollie Wu <mollie.wu@linaro.org>
> ---
>  .../bindings/arm/fujistu/power_domain.txt          |  22 +
>  arch/arm/Kconfig                                   |   2 +
>  arch/arm/Makefile                                  |   1 +
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/mb86s70.dtsi                     | 635 ++++++++++++++
>  arch/arm/boot/dts/mb86s70eb.dts                    |  38 +
>  arch/arm/boot/dts/mb86s73.dtsi                     | 910 +++++++++++++++++++++
>  arch/arm/boot/dts/mb86s73eb.dts                    |  73 ++
>  arch/arm/configs/fujitsu_defconfig                 | 156 ++++
>  arch/arm/mach-mb86s7x/Kconfig                      |  18 +
>  arch/arm/mach-mb86s7x/Makefile                     |   2 +
>  arch/arm/mach-mb86s7x/board.c                      |  65 ++
>  arch/arm/mach-mb86s7x/iomap.h                      |  34 +
>  arch/arm/mach-mb86s7x/mcpm.c                       | 293 +++++++
>  arch/arm/mach-mb86s7x/pm_domains.c                 | 237 ++++++
>  arch/arm/mach-mb86s7x/scb_mhu.c                    | 447 ++++++++++
>  include/linux/platform_data/mb86s7x_mbox.h         | 249 ++++++
>  17 files changed, 3183 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/fujistu/power_domain.txt
>  create mode 100644 arch/arm/boot/dts/mb86s70.dtsi
>  create mode 100644 arch/arm/boot/dts/mb86s70eb.dts
>  create mode 100644 arch/arm/boot/dts/mb86s73.dtsi
>  create mode 100644 arch/arm/boot/dts/mb86s73eb.dts
>  create mode 100644 arch/arm/configs/fujitsu_defconfig
>  create mode 100644 arch/arm/mach-mb86s7x/Kconfig
>  create mode 100644 arch/arm/mach-mb86s7x/Makefile
>  create mode 100644 arch/arm/mach-mb86s7x/board.c
>  create mode 100644 arch/arm/mach-mb86s7x/iomap.h
>  create mode 100644 arch/arm/mach-mb86s7x/mcpm.c
>  create mode 100644 arch/arm/mach-mb86s7x/pm_domains.c
>  create mode 100644 arch/arm/mach-mb86s7x/scb_mhu.c
>  create mode 100644 include/linux/platform_data/mb86s7x_mbox.h
>
> diff --git a/Documentation/devicetree/bindings/arm/fujistu/power_domain.txt b/Documentation/devicetree/bindings/arm/fujistu/power_domain.txt
> new file mode 100644
> index 0000000..44abfe8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/fujistu/power_domain.txt
> @@ -0,0 +1,22 @@
> +* Fujitsu MB86S7x Power Domains
> +
> +Remote f/w on MB86S7x can enable/disable power to various IPs.
> +
> +Required Properties:
> +- compatible: Should be "fujitsu,mb86s7x-pd"
> +- index: Index of the power gate control for the block
> +
> +Example:
> +
> +       pd_cpu: genpd at 3 {
> +               compatible = "fujitsu,mb86s7x-pd";
> +               index = <3>;
> +       };
> +
> +Example of the node using power domain:
> +
> +       node {
> +               /* ... */
> +               fujitsu,power-domain = <&pd_cpu>;
> +               /* ... */
> +       };
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 245058b..44fd319 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -955,6 +955,8 @@ source "arch/arm/mach-kirkwood/Kconfig"
>
>  source "arch/arm/mach-ks8695/Kconfig"
>
> +source "arch/arm/mach-mb86s7x/Kconfig"
> +
>  source "arch/arm/mach-msm/Kconfig"
>
>  source "arch/arm/mach-moxart/Kconfig"
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 6721fab..d6ec5cd 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -166,6 +166,7 @@ machine-$(CONFIG_ARCH_KEYSTONE)             += keystone
>  machine-$(CONFIG_ARCH_KIRKWOOD)                += kirkwood
>  machine-$(CONFIG_ARCH_KS8695)          += ks8695
>  machine-$(CONFIG_ARCH_LPC32XX)         += lpc32xx
> +machine-$(CONFIG_ARCH_MB86S7X)         += mb86s7x
>  machine-$(CONFIG_ARCH_MMP)             += mmp
>  machine-$(CONFIG_ARCH_MOXART)          += moxart
>  machine-$(CONFIG_ARCH_MSM)             += msm
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index adb5ed9..0c8addb 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -154,6 +154,7 @@ dtb-$(CONFIG_ARCH_KIRKWOOD) += $(kirkwood)
>  dtb-$(CONFIG_MACH_KIRKWOOD) += $(kirkwood)
>  dtb-$(CONFIG_ARCH_LPC32XX) += ea3250.dtb phy3250.dtb
>  dtb-$(CONFIG_ARCH_MARCO) += marco-evb.dtb
> +dtb-$(CONFIG_ARCH_MB86S7X) += mb86s70eb.dtb mb86s73eb.dtb
>  dtb-$(CONFIG_ARCH_MOXART) += moxart-uc7112lx.dtb
>  dtb-$(CONFIG_ARCH_MXC) += \
>         imx25-eukrea-mbimxsd25-baseboard.dtb \
> diff --git a/arch/arm/boot/dts/mb86s70.dtsi b/arch/arm/boot/dts/mb86s70.dtsi
> new file mode 100644
> index 0000000..b6d8970
> --- /dev/null
> +++ b/arch/arm/boot/dts/mb86s70.dtsi
> @@ -0,0 +1,635 @@
> +
> +/dts-v1/;
> +
> +/ {
> +       model = "Fujitsu mb86s70";
> +       compatible = "fujitsu,mb86s70";
> +       interrupt-parent = <&gic>;
> +       #address-cells = <2>;
> +       #size-cells = <1>;
> +
> +       aliases {
> +               serial0 = &uart0;
> +               serial1 = &uart1;
> +               serial2 = &uart2;
> +       };
> +
> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               cpu0: cpu at 0 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a7";
> +                       reg = <0x100>;

reg and the unit-address (cpu at 0) should match. So either you need
cpu at 100 or "reg = <0>;".

Same thing on the other cpu entries.

> +                       cci-control-port = <&cci_control3>;
> +                       clock-frequency = <800000000>;
> +                       operating-points = <
> +                               /* kHz    uV */
> +                               800000  900000
> +                       >;

What's the point in a single freq?

You can add this later as the current operating-points binding has
several limitations and is likely to get replaced.

> +                       clock-latency = <100000>;
> +               };
> +
> +               cpu1: cpu at 1 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a7";
> +                       reg = <0x101>;
> +                       cci-control-port = <&cci_control3>;
> +                       clock-frequency = <800000000>;
> +                       operating-points = <
> +                               /* kHz    uV */
> +                               800000  900000
> +                       >;
> +                       clock-latency = <100000>;
> +               };
> +
> +               cpu2: cpu at 2 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a15";
> +                       reg = <0x0>;
> +                       cci-control-port = <&cci_control4>;
> +                       clock-frequency = <1000000000>;
> +                       operating-points = <
> +                               /* kHz    uV */
> +                               1200000 900000
> +                               1600000 1000000
> +                               2000000 1100000
> +                               2400000 1200000
> +                       >;
> +                       clock-latency = <100000>;
> +               };
> +
> +               cpu3: cpu at 3 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a15";
> +                       reg = <0x1>;
> +                       cci-control-port = <&cci_control4>;
> +                       clock-frequency = <1000000000>;
> +                       operating-points = <
> +                               /* kHz    uV */
> +                               1200000 900000
> +                               1600000 1000000
> +                               2000000 1100000
> +                               2400000 1200000
> +                       >;
> +                       clock-latency = <100000>;
> +               };
> +       };
> +
> +       cci at 2c090000 {
> +               compatible = "arm,cci-400";
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               reg = <0 0x2c090000 0x1000>;
> +               ranges = <0x0 0x0 0x2c090000 0x10000>;
> +
> +               cci_control3: slave-if at 4000 {
> +                       compatible = "arm,cci-400-ctrl-if";
> +                       interface-type = "ace";
> +                       reg = <0x4000 0x1000>;
> +               };
> +
> +               cci_control4: slave-if at 5000 {
> +                       compatible = "arm,cci-400-ctrl-if";
> +                       interface-type = "ace";
> +                       reg = <0x5000 0x1000>;
> +               };
> +
> +               pmu at 9000 {
> +                       compatible = "arm,cci-400-pmu";
> +                       reg = <0x9000 0x5000>;
> +                       interrupts = <0 77 4>,
> +                                       <0 77 4>,
> +                                       <0 77 4>,
> +                                       <0 77 4>,
> +                                       <0 77 4>;
> +               };
> +       };
> +
> +       /**
> +        * cntrlr : 0->ALW, 1->DDR3, 2->MAIN, 3->CA15, 4->HDMI, 5->DPHY
> +        * port : [0,7] -> Gateable Clock Ports.  [8]->UngatedCLK
> +        */
> +       clocks {
> +               clk_alw_0_0: clk_alw_0_0 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <0>;
> +                       domain = <0>;
> +                       port = <0>;
> +               };
> +
> +               clk_alw_0_1: clk_alw_0_1 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <0>;
> +                       domain = <0>;
> +                       port = <1>;
> +               };
> +
> +               clk_alw_0_2: clk_alw_0_2 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <0>;
> +                       domain = <0>;
> +                       port = <2>;
> +               };
> +
> +               clk_alw_0_4: clk_alw_0_4 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <0>;
> +                       domain = <0>;
> +                       port = <4>;
> +               };
> +
> +               clk_alw_0_5: clk_alw_0_5 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <0>;
> +                       domain = <0>;
> +                       port = <5>;
> +               };
> +
> +               clk_alw_0_8: clk_alw_0_8 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <0>;
> +                       domain = <0>;
> +                       port = <8>;
> +               };
> +
> +               clk_alw_1_0: clk_alw_1_0 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <0>;
> +                       domain = <1>;
> +                       port = <0>;
> +               };
> +
> +               clk_alw_1_1: clk_alw_1_1 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <0>;
> +                       domain = <1>;
> +                       port = <1>;
> +               };
> +
> +               clk_alw_1_8: clk_alw_1_8 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <0>;
> +                       domain = <1>;
> +                       port = <8>;
> +               };
> +
> +               clk_alw_2_0: clk_alw_2_0 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <0>;
> +                       domain = <2>;
> +                       port = <0>;
> +               };
> +
> +               clk_alw_2_1: clk_alw_2_1 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <0>;
> +                       domain = <2>;
> +                       port = <1>;
> +               };
> +
> +               clk_alw_2_2: clk_alw_2_2 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <0>;
> +                       domain = <2>;
> +                       port = <2>;
> +               };
> +
> +               clk_alw_2_4: clk_alw_2_4 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <0>;
> +                       domain = <2>;
> +                       port = <4>;
> +               };
> +
> +               clk_alw_2_5: clk_alw_2_5 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <0>;
> +                       domain = <2>;
> +                       port = <5>;
> +               };
> +
> +               clk_alw_2_8: clk_alw_2_8 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <0>;
> +                       domain = <2>;
> +                       port = <8>;
> +               };
> +
> +               clk_alw_6_8: clk_alw_6_8 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <0>;
> +                       domain = <6>;
> +                       port = <8>;
> +               };
> +
> +               clk_alw_7_0: clk_alw_7_0 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <0>;
> +                       domain = <7>;
> +                       port = <0>;
> +               };
> +
> +               clk_alw_8_0: clk_alw_8_0 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <0>;
> +                       domain = <8>;
> +                       port = <0>;
> +               };
> +
> +               clk_alw_a_0: clk_alw_a_0 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <0>;
> +                       domain = <0x0a>;
> +                       port = <0>;
> +               };
> +
> +               clk_alw_a_1: clk_alw_a_1 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <0>;
> +                       domain = <0x0a>;
> +                       port = <1>;
> +               };
> +
> +               clk_ddr3_0_0: clk_ddr3_0_0 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <1>;
> +                       domain = <0>;
> +                       port = <0>;
> +               };
> +
> +               clk_main_0_0: clk_main_0_0 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <2>;
> +                       domain = <0>;
> +                       port = <0>;
> +               };
> +
> +               clk_main_0_8: clk_main_0_8 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <2>;
> +                       domain = <0>;
> +                       port = <8>;
> +               };
> +
> +               clk_main_1_3: clk_main_1_3 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <2>;
> +                       domain = <1>;
> +                       port = <3>;
> +               };
> +
> +               clk_main_1_4: clk_main_1_4 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <2>;
> +                       domain = <1>;
> +                       port = <4>;
> +               };
> +
> +               clk_main_2_0: clk_main_2_0 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <2>;
> +                       domain = <2>;
> +                       port = <0>;
> +               };
> +
> +               clk_main_2_3: clk_main_2_3 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <2>;
> +                       domain = <2>;
> +                       port = <3>;
> +               };
> +
> +               clk_main_2_7: clk_main_2_7 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <2>;
> +                       domain = <2>;
> +                       port = <7>;
> +               };
> +
> +               clk_main_3_0: clk_main_3_0 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <2>;
> +                       domain = <3>;
> +                       port = <0>;
> +               };
> +
> +               clk_main_3_3: clk_main_3_3 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <2>;
> +                       domain = <3>;
> +                       port = <3>;
> +               };
> +
> +               clk_main_3_4: clk_main_3_4 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <2>;
> +                       domain = <3>;
> +                       port = <4>;
> +               };
> +
> +               clk_main_3_5: clk_main_3_5 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <2>;
> +                       domain = <3>;
> +                       port = <5>;
> +               };
> +
> +               clk_main_3_6: clk_main_3_6 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <2>;
> +                       domain = <3>;
> +                       port = <6>;
> +               };
> +
> +               clk_main_4_0: clk_main_4_0 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <2>;
> +                       domain = <4>;
> +                       port = <0>;
> +               };
> +
> +               clk_main_4_1: clk_main_4_1 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <2>;
> +                       domain = <4>;
> +                       port = <1>;
> +               };
> +
> +               clk_main_5_0: clk_main_5_0 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <2>;
> +                       domain = <5>;
> +                       port = <0>;
> +               };
> +
> +               clk_main_5_3: clk_main_5_3 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <2>;
> +                       domain = <5>;
> +                       port = <3>;
> +               };
> +
> +               clk_main_5_4: clk_main_5_4 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <2>;
> +                       domain = <5>;
> +                       port = <4>;
> +               };
> +
> +               clk_main_5_5: clk_main_5_5 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <2>;
> +                       domain = <5>;
> +                       port = <5>;
> +               };
> +
> +               clk_main_7_0: clk_main_7_0 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <2>;
> +                       domain = <7>;
> +                       port = <0>;
> +               };
> +
> +               clk_main_8_1: clk_main_8_1 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <2>;
> +                       domain = <8>;
> +                       port = <1>;
> +               };
> +
> +               clk_main_9_0: clk_main_9_0 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <2>;
> +                       domain = <9>;
> +                       port = <0>;
> +               };
> +
> +               clk_hdmi_0_0: clk_hdmi_0_0 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <4>;
> +                       domain = <0>;
> +                       port = <0>;
> +               };
> +
> +               clk_hdmi_1_0: clk_hdmi_1_0 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <4>;
> +                       domain = <1>;
> +                       port = <0>;
> +               };
> +
> +               clk_hdmi_2_0: clk_hdmi_2_0 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <4>;
> +                       domain = <2>;
> +                       port = <0>;
> +               };
> +
> +               clk_hdmi_3_0: clk_hdmi_3_0 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <4>;
> +                       domain = <3>;
> +                       port = <0>;
> +               };
> +
> +               clk_dphy_0_0: clk_dphy_0_0 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <5>;
> +                       domain = <0>;
> +                       port = <0>;
> +               };
> +
> +               clk_dphy_1_0: clk_dphy_1_0 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <5>;
> +                       domain = <1>;
> +                       port = <0>;
> +               };
> +       };
> +
> +       gic: interrupt-controller at 2c001000 {

All these devices should be under a bus node with simple-bus compatible string.

> +               compatible = "arm,cortex-a15-gic", "arm,cortex-a9-gic";
> +               #interrupt-cells = <3>;
> +               interrupt-controller;
> +               reg = <0 0x2c001000 0x1000>,
> +                     <0 0x2c002000 0x1000>,

I think the size should be 0x2000 here for the cpu interface.

> +                     <0 0x2c004000 0x2000>,
> +                     <0 0x2c006000 0x2000>;
> +               interrupts = <1 9 0xf04>;
> +       };
> +
> +       timer0: timer0 at 31080000 {

should be timer at 31080000

> +               compatible = "arm,sp804";
> +               reg = <0 0x31080000 0x10000>;

sp804 size is 0x1000.

> +               interrupts = <0 324 4>,
> +                            <0 325 4>;
> +               clocks = <&clk_alw_6_8>;
> +       };

No arch timer?


> +
> +       mhu: mhu0 at 2b1f0000 {

mhu0 should be mbox or mailbox.

> +               #mbox-cells = <1>;
> +               compatible = "fujitsu,mhu";
> +               reg = <0 0x2B1F0000 0x1000>;

Lower case hex please.

> +               interrupts = <0 36 4>, /* LP Non-Sec */
> +                            <0 35 4>, /* HP Non-Sec */
> +                            <0 37 4>; /* Secure */
> +       };
> +
> +       mhu_client: scb at 0 {
> +               compatible = "fujitsu,scb";
> +               mbox = <&mhu 1>;

Is the mailbox binding finalized?

> +               mbox-names = "HP_NonSec";
> +       };
> +
> +       pinctrl: pinctrl at 2a4d0000 {
> +               compatible = "fujitsu,mb86s70-pinctrl";
> +               reg = <0 0x2a4d0000 0x1000>;
> +               #gpio-range-cells = <3>;
> +       };
> +
> +       gpio0: mb86s70_gpio0 {

node name should be gpio at 31000000

> +               compatible = "fujitsu,mb86s7x-gpio";
> +               reg = <0 0x31000000 0x10000>;
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +               gpio-ranges = <&pinctrl 0 0 32>;
> +               clocks = <&clk_alw_2_1>;
> +       };
> +
> +       gpio1: mb86s70_gpio1 {

ditto

> +               compatible = "fujitsu,mb86s7x-gpio";
> +               reg = <0 0x31010000 0x10000>;
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +               gpio-ranges = <&pinctrl 0 32 32>;
> +               clocks = <&clk_alw_2_1>;
> +       };
> +
> +       uart0: serial at 0x31040000 {

Drop the 0x in the unit-address.

> +               compatible = "snps,dw-apb-uart";
> +               reg = <0 0x31040000 0x100>;
> +               interrupts = <0 320 0x4>;
> +               clock-frequency = <62500000>;
> +               reg-io-width = <4>;
> +               reg-shift = <2>;
> +               clocks = <&clk_alw_2_1>;
> +               clock-names = "sclk";
> +       };
> +
> +       uart1: serial at 0x31050000 {
> +               compatible = "snps,dw-apb-uart";
> +               reg = <0 0x31050000 0x100>;
> +               interrupts = <0 321 0x4>;
> +               clock-frequency = <62500000>;
> +               reg-io-width = <4>;
> +               reg-shift = <2>;
> +               clocks = <&clk_alw_2_1>;
> +               clock-names = "sclk";
> +       };
> +
> +       uart2: serial at 0x31060000 {
> +               compatible = "snps,dw-apb-uart";
> +               reg = <0 0x31060000 0x100>;
> +               interrupts = <0 322 0x4>;
> +               clock-frequency = <62500000>;
> +               reg-io-width = <4>;
> +               reg-shift = <2>;
> +               clocks = <&clk_alw_2_1>;
> +               clock-names = "sclk";
> +       };
> +
> +       sdhci0: emmc at 300c0000 {
> +               compatible = "fujitsu,f-sdh30";

This should include the chip part number the IP is in.

> +               reg = <0 0x300c0000 0x1000>;
> +               interrupts = <0 164 0x4>,
> +                            <0 165 0x4>;
> +               voltage-ranges = <1800 1800>, <3300 3300>;
> +               bus-width = <8>;
> +               clocks = <&clk_alw_1_8>, <&clk_alw_6_8>;
> +               clock-names = "sd_sd4clk", "sd_bclk";
> +       };
> +
> +       sdhci1: sdio at 36600000 {
> +               compatible = "fujitsu,f-sdh30";
> +               reg = <0 0x36600000 0x1000>;
> +               interrupts = <0 172 0x4>,
> +                            <0 173 0x4>;
> +               voltage-ranges = <1800 1800>, <3300 3300>;
> +               pwr-mux-gpios = <&gpio0 7 0>;
> +               clocks = <&clk_hdmi_2_0>, <&clk_hdmi_3_0>;
> +               clock-names = "sd_sd4clk", "sd_bclk";
> +       };
> +
> +       eth0: f_taiki {
> +                compatible = "fujitsu,ogma";

This should include the chip part number the IP is in.

> +               reg = <0 0x31600000 0x10000>,
> +                       <0 0x31618000 0x4000>,
> +                       <0 0x3161c000 0x4000>;
> +               interrupts = <0 163 0x4>;
> +               clocks = <&clk_alw_0_8>;
> +               phy-mode = "rgmii";
> +               max-speed = <1000>;
> +               max-frame-size = <9000>;
> +               local-mac-address = [ a4 17 31 00 00 ed ];
> +               phy-handle = <&ethphy0>;
> +
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               ethphy0: ethernet-phy at 1 {
> +                       device_type = "ethernet-phy";
> +                       compatible = "ethernet-phy-ieee802.3-c22";
> +                       reg = <1>;
> +               };
> +       };
> +};
> diff --git a/arch/arm/boot/dts/mb86s70eb.dts b/arch/arm/boot/dts/mb86s70eb.dts
> new file mode 100644
> index 0000000..ee25dd9
> --- /dev/null
> +++ b/arch/arm/boot/dts/mb86s70eb.dts
> @@ -0,0 +1,38 @@
> +
> +/include/ "mb86s70.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +       model = "Fujitsu MB86S70 EVB";
> +       compatible = "fujitsu,mb86s70-evb";
> +
> +       memory {
> +               device_type = "memory";
> +               reg = <0 0x80000000 0x80000000>, <0x08 0x80000000 0x80000000>;
> +
> +       };
> +
> +       chosen {
> +               bootargs = "loglevel=4 console=ttyS0,115200 root=/dev/mmcblk1p2 rootfstype=ext4 rootwait rw";
> +       };
> +
> +       gpio-leds {
> +               compatible = "gpio-leds";
> +
> +               d3 {
> +                       label = "led3";

This reflects the label on the board? If not, a better name is needed
like what is its function.

> +                       gpios = <&gpio0 4 GPIO_ACTIVE_HIGH>;
> +                       linux,default-trigger = "default-on";
> +               };
> +               d4 {
> +                       label = "led4";
> +                       gpios = <&gpio0 5 GPIO_ACTIVE_HIGH>;
> +                       linux,default-trigger = "mmc1";
> +               };
> +               d5 {
> +                       label = "led5";
> +                       gpios = <&gpio0 6 GPIO_ACTIVE_HIGH>;
> +               };
> +       };
> +};
> diff --git a/arch/arm/boot/dts/mb86s73.dtsi b/arch/arm/boot/dts/mb86s73.dtsi
> new file mode 100644
> index 0000000..ef4f5a0
> --- /dev/null
> +++ b/arch/arm/boot/dts/mb86s73.dtsi

Similar comments apply to this dtsi file.

> @@ -0,0 +1,910 @@
> +
> +/ {
> +       model = "Fujitsu mb86s73";
> +       compatible = "fujitsu,mb86s73";
> +       interrupt-parent = <&gic>;
> +       #address-cells = <2>;
> +       #size-cells = <1>;
> +
> +       aliases {
> +               serial0 = &uart0;
> +               serial1 = &uart1;
> +               serial2 = &uart2;
> +       };
> +
> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               cpu0: cpu at 0 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a7";
> +                       reg = <0x100>;
> +                       cci-control-port = <&cci_control3>;
> +                       clock-frequency = <800000000>;
> +                       operating-points = <
> +                               /* kHz    uV */
> +                               800000   900000
> +                               1200000  1000000
> +                       >;
> +                       clock-latency = <100000>;
> +                       fujitsu,power-domain = <&pd_cpu>;
> +               };
> +
> +               cpu1: cpu at 1 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a7";
> +                       reg = <0x101>;
> +                       cci-control-port = <&cci_control3>;
> +                       clock-frequency = <800000000>;
> +                       operating-points = <
> +                               /* kHz    uV */
> +                               800000   900000
> +                               1200000  1000000
> +                       >;
> +                       clock-latency = <100000>;
> +                       fujitsu,power-domain = <&pd_cpu>;
> +               };
> +       };
> +
> +       cci at 2c090000 {
> +               compatible = "arm,cci-400";
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               reg = <0 0x2c090000 0x1000>;
> +               ranges = <0x0 0x0 0x2c090000 0x10000>;
> +               fujitsu,power-domain = <&pd_offchip>;
> +
> +               cci_control3: slave-if at 4000 {
> +               compatible = "arm,cci-400-ctrl-if";
> +                       interface-type = "ace";
> +                       reg = <0x4000 0x1000>;
> +               };
> +       };
> +
> +       /**
> +        * cntrlr : 0->ALW, 1->DDR3, 2->MAIN, 3->CA7, 4->USB, 5->FPDLINK
> +        * port : [0,7] -> Gateable Clock Ports.  [8]->UngatedCLK
> +        */
> +       clocks {
> +               clk_alw_0_0: clk_alw_0_0 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <0>;
> +                       domain = <0>;
> +                       port = <0>;
> +               };
> +
> +               clk_alw_0_1: clk_alw_0_1 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <0>;
> +                       domain = <0>;
> +                       port = <1>;
> +               };
> +
> +               clk_alw_0_2: clk_alw_0_2 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <0>;
> +                       domain = <0>;
> +                       port = <2>;
> +               };
> +
> +               clk_alw_0_4: clk_alw_0_4 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <0>;
> +                       domain = <0>;
> +                       port = <4>;
> +               };
> +
> +               clk_alw_0_5: clk_alw_0_5 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <0>;
> +                       domain = <0>;
> +                       port = <5>;
> +               };
> +
> +               clk_alw_0_8: clk_alw_0_8 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <0>;
> +                       domain = <0>;
> +                       port = <8>;
> +               };
> +
> +               clk_alw_1_0: clk_alw_1_0 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <0>;
> +                       domain = <1>;
> +                       port = <0>;
> +               };
> +
> +               clk_alw_1_1: clk_alw_1_1 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <0>;
> +                       domain = <1>;
> +                       port = <1>;
> +               };
> +
> +               clk_alw_1_2: clk_alw_1_2 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <0>;
> +                       domain = <1>;
> +                       port = <2>;
> +               };
> +
> +               clk_alw_1_8: clk_alw_1_8 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <0>;
> +                       domain = <1>;
> +                       port = <8>;
> +               };
> +
> +               clk_alw_2_0: clk_alw_2_0 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <0>;
> +                       domain = <2>;
> +                       port = <0>;
> +               };
> +
> +               clk_alw_2_1: clk_alw_2_1 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <0>;
> +                       domain = <2>;
> +                       port = <1>;
> +               };
> +
> +               clk_alw_2_2: clk_alw_2_2 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <0>;
> +                       domain = <2>;
> +                       port = <2>;
> +               };
> +
> +               clk_alw_2_4: clk_alw_2_4 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <0>;
> +                       domain = <2>;
> +                       port = <4>;
> +               };
> +
> +               clk_alw_2_5: clk_alw_2_5 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <0>;
> +                       domain = <2>;
> +                       port = <5>;
> +               };
> +
> +               clk_alw_2_8: clk_alw_2_8 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <0>;
> +                       domain = <2>;
> +                       port = <8>;
> +               };
> +
> +               clk_alw_6_8: clk_alw_6_8 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <0>;
> +                       domain = <6>;
> +                       port = <8>;
> +               };
> +
> +               clk_alw_7_0: clk_alw_7_0 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <0>;
> +                       domain = <7>;
> +                       port = <0>;
> +               };
> +
> +               clk_alw_8_0: clk_alw_8_0 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <0>;
> +                       domain = <8>;
> +                       port = <0>;
> +               };
> +
> +               clk_alw_a_0: clk_alw_a_0 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <0>;
> +                       domain = <0x0a>;
> +                       port = <0>;
> +               };
> +
> +               clk_alw_a_1: clk_alw_a_1 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <0>;
> +                       domain = <0x0a>;
> +                       port = <1>;
> +               };
> +
> +               clk_alw_b_0: clk_alw_b_0 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <0>;
> +                       domain = <0x0b>;
> +                       port = <0>;
> +               };
> +
> +               clk_alw_c_0: clk_alw_c_0 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <0>;
> +                       domain = <0x0c>;
> +                       port = <0>;
> +               };
> +
> +               clk_ddr3_0_0: clk_ddr3_0_0 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <1>;
> +                       domain = <0>;
> +                       port = <0>;
> +               };
> +
> +               clk_main_0_0: clk_main_0_0 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <2>;
> +                       domain = <0>;
> +                       port = <0>;
> +               };
> +
> +               clk_main_0_8: clk_main_0_8 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <2>;
> +                       domain = <0>;
> +                       port = <8>;
> +               };
> +
> +               clk_main_1_3: clk_main_1_3 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <2>;
> +                       domain = <1>;
> +                       port = <3>;
> +               };
> +
> +               clk_main_1_4: clk_main_1_4 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <2>;
> +                       domain = <1>;
> +                       port = <4>;
> +               };
> +
> +               clk_main_2_0: clk_main_2_0 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <2>;
> +                       domain = <2>;
> +                       port = <0>;
> +               };
> +
> +               clk_main_2_3: clk_main_2_3 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <2>;
> +                       domain = <2>;
> +                       port = <3>;
> +               };
> +
> +               clk_main_2_4: clk_main_2_4 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <2>;
> +                       domain = <2>;
> +                       port = <4>;
> +               };
> +
> +               clk_main_2_7: clk_main_2_7 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <2>;
> +                       domain = <2>;
> +                       port = <7>;
> +               };
> +
> +               clk_main_3_0: clk_main_3_0 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <2>;
> +                       domain = <3>;
> +                       port = <0>;
> +               };
> +
> +               clk_main_3_3: clk_main_3_3 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <2>;
> +                       domain = <3>;
> +                       port = <3>;
> +               };
> +
> +               clk_main_3_4: clk_main_3_4 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <2>;
> +                       domain = <3>;
> +                       port = <4>;
> +               };
> +
> +               clk_main_3_5: clk_main_3_5 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <2>;
> +                       domain = <3>;
> +                       port = <5>;
> +               };
> +
> +               clk_main_3_6: clk_main_3_6 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <2>;
> +                       domain = <3>;
> +                       port = <6>;
> +               };
> +
> +               clk_main_4_0: clk_main_4_0 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <2>;
> +                       domain = <4>;
> +                       port = <0>;
> +               };
> +
> +               clk_main_4_4: clk_main_4_4 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <2>;
> +                       domain = <4>;
> +                       port = <4>;
> +               };
> +
> +               clk_main_4_5: clk_main_4_5 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <2>;
> +                       domain = <4>;
> +                       port = <5>;
> +               };
> +
> +               clk_main_5_0: clk_main_5_0 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <2>;
> +                       domain = <5>;
> +                       port = <0>;
> +               };
> +
> +               clk_main_5_3: clk_main_5_3 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <2>;
> +                       domain = <5>;
> +                       port = <3>;
> +               };
> +
> +               clk_main_5_4: clk_main_5_4 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <2>;
> +                       domain = <5>;
> +                       port = <4>;
> +               };
> +
> +               clk_main_5_5: clk_main_5_5 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <2>;
> +                       domain = <5>;
> +                       port = <5>;
> +               };
> +
> +               clk_main_7_0: clk_main_7_0 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <2>;
> +                       domain = <7>;
> +                       port = <0>;
> +               };
> +
> +               clk_main_8_1: clk_main_8_1 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <2>;
> +                       domain = <8>;
> +                       port = <1>;
> +               };
> +
> +               clk_main_9_0: clk_main_9_0 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <2>;
> +                       domain = <9>;
> +                       port = <0>;
> +               };
> +
> +               clk_main_a_0: clk_main_a_0 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <2>;
> +                       domain = <0xa>;
> +                       port = <0>;
> +               };
> +
> +               clk_main_b_0: clk_main_b_0 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <2>;
> +                       domain = <0xb>;
> +                       port = <0>;
> +               };
> +
> +               clk_main_c_0: clk_main_c_0 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <2>;
> +                       domain = <0xc>;
> +                       port = <0>;
> +               };
> +
> +               clk_main_d_0: clk_main_d_0 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <2>;
> +                       domain = <0xd>;
> +                       port = <0>;
> +               };
> +
> +               clk_usb_0_0: clk_usb_0_0 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <4>;
> +                       domain = <0>;
> +                       port = <0>;
> +               };
> +
> +               clk_usb_1_0: clk_usb_1_0 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <4>;
> +                       domain = <1>;
> +                       port = <0>;
> +               };
> +
> +               clk_usb_2_0: clk_usb_2_0 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <4>;
> +                       domain = <2>;
> +                       port = <0>;
> +               };
> +
> +               clk_usb_3_0: clk_usb_3_0 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <4>;
> +                       domain = <3>;
> +                       port = <0>;
> +               };
> +
> +               clk_fpdlink_0_0: clk_fpdlink_0_0 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <5>;
> +                       domain = <0>;
> +                       port = <0>;
> +               };
> +
> +               clk_fpdlink_1_0: clk_fpdlink_1_0 {
> +                       compatible = "fujitsu,mb86s7x_clk";
> +                       #clock-cells = <0>;
> +                       cntrlr = <5>;
> +                       domain = <1>;
> +                       port = <0>;
> +               };
> +       };
> +
> +       timer0: timer0 at 31080000 {
> +               compatible = "arm,sp804";
> +               reg = <0 0x31080000 0x10000>;
> +               interrupts = <0 324 4>,
> +                            <0 325 4>;
> +               clocks = <&clk_alw_6_8>;
> +       };
> +
> +       timer1: archtimer {
> +               compatible = "arm,armv7-timer";
> +               clock-frequency = <125000000>;
> +               interrupts = <1 13 0xf08>,
> +                            <1 14 0xf08>,
> +                            <1 11 0xf08>,
> +                            <1 10 0xf08>;
> +       };
> +
> +       pinctrl: pinctrl at 2a4d0000 {
> +               compatible = "fujitsu,mb86s73-pinctrl";
> +               reg = <0 0x2a4d0000 0x1000>, <0 0x312e0000 0x1000>;
> +               #gpio-range-cells = <3>;
> +
> +               pcie0_pins_active: pcie0_active {
> +                       mb86s7x,function = "pcie0";
> +                       mb86s7x,drvst = <4>; /* in mA */
> +               };
> +               pcie0_pins_sleep: pcie0_sleep {
> +                       mb86s7x,function = "pcie0";
> +                       mb86s7x,drvst = <0>; /* Implies Hi-z */
> +               };
> +
> +               usb3h0_pins_active: usb3h0_active {
> +                       mb86s7x,function = "usb3h0";
> +                       mb86s7x,drvst = <4>; /* in mA */
> +               };
> +               usb3h0_pins_sleep: usb3h0_sleep {
> +                       mb86s7x,function = "usb3h0";
> +                       mb86s7x,drvst = <0>; /* Implies Hi-z */
> +               };
> +
> +               usb2h0_pins_active: usb2h0_active {
> +                       mb86s7x,function = "usb2h0";
> +                       mb86s7x,drvst = <4>; /* in mA */
> +               };
> +               usb2h0_pins_sleep: usb2h0_sleep {
> +                       mb86s7x,function = "usb2h0";
> +                       mb86s7x,drvst = <0>; /* Implies Hi-z */
> +               };
> +
> +               usb2d0_pins_active: usb2d0_active {
> +                       mb86s7x,function = "usb2d0";
> +                       mb86s7x,drvst = <4>; /* in mA */
> +               };
> +               usb2d0_pins_sleep: usb2d0_sleep {
> +                       mb86s7x,function = "usb2d0";
> +                       mb86s7x,drvst = <0>; /* Implies Hi-z */
> +               };
> +
> +               sdh30_pins_active: sdh30_active {
> +                       mb86s7x,function = "sdh30";
> +                       mb86s7x,drvst = <4>; /* in mA */
> +               };
> +               sdh30_pins_sleep: sdh30_sleep {
> +                       mb86s7x,function = "sdh30";
> +                       mb86s7x,drvst = <0>; /* Implies Hi-z */
> +               };
> +
> +               emmc0_pins_active: emmc0_active {
> +                       mb86s7x,function = "emmc0";
> +                       mb86s7x,drvst = <4>; /* in mA */
> +               };
> +               emmc0_pins_sleep: emmc0_sleep {
> +                       mb86s7x,function = "emmc0";
> +                       mb86s7x,drvst = <0>; /* Implies Hi-z */
> +               };
> +
> +               hsspi0_pins_active: hsspi0_active {
> +                       mb86s7x,function = "hsspi0";
> +                       mb86s7x,drvst = <8>; /* in mA */
> +               };
> +               hsspi0_pins_sleep: hsspi0_sleep {
> +                       mb86s7x,function = "hsspi0";
> +                       mb86s7x,drvst = <0>; /* Implies Hi-z */
> +               };
> +
> +               gmacd0_pins_active: gmacd0_active {
> +                       mb86s7x,function = "gmacd0";
> +                       mb86s7x,drvst = <4>; /* in mA */
> +               };
> +               gmacd0_pins_sleep: gmacd0_sleep {
> +                       mb86s7x,function = "gmacd0";
> +                       mb86s7x,drvst = <0>; /* Implies Hi-z */
> +               };
> +
> +               gmacm0_pins_active: gmacm0_active {
> +                       mb86s7x,function = "gmacm0";
> +                       mb86s7x,drvst = <4>; /* in mA */
> +               };
> +               gmacm0_pins_sleep: gmacm0_sleep {
> +                       mb86s7x,function = "gmacm0";
> +                       mb86s7x,drvst = <0>; /* Implies Hi-z */
> +               };
> +
> +               i2s0_pins_active: i2s0_active {
> +                       mb86s7x,function = "i2s0";
> +                       mb86s7x,drvst = <4>; /* in mA */
> +               };
> +               i2s0_pins_sleep: i2s0_sleep {
> +                       mb86s7x,function = "i2s0";
> +                       mb86s7x,drvst = <0>; /* Implies Hi-z */
> +               };
> +
> +               other0_pins_active: other0_active {
> +                       mb86s7x,function = "other0";
> +                       mb86s7x,drvst = <4>; /* in mA */
> +               };
> +               other0_pins_sleep: other0_sleep {
> +                       mb86s7x,function = "other0";
> +                       mb86s7x,drvst = <0>; /* Implies Hi-z */
> +               };
> +
> +               jtag0_pins_active: jtag0_active {
> +                       mb86s7x,function = "jtag0";
> +                       mb86s7x,drvst = <4>; /* in mA */
> +               };
> +               jtag0_pins_sleep: jtag0_sleep {
> +                       mb86s7x,function = "jtag0";
> +                       mb86s7x,drvst = <0>; /* Implies Hi-z */
> +               };
> +
> +               pcie1_pins_active: pcie1_active {
> +                       mb86s7x,function = "pcie1";
> +                       mb86s7x,drvst = <4>; /* in mA */
> +               };
> +               pcie1_pins_sleep: pcie1_sleep {
> +                       mb86s7x,function = "pcie1";
> +                       mb86s7x,drvst = <0>; /* Implies Hi-z */
> +               };
> +
> +               usb3h1_pins_active: usb3h1_active {
> +                       mb86s7x,function = "usb3h1";
> +                       mb86s7x,drvst = <4>; /* in mA */
> +               };
> +               usb3h1_pins_sleep: usb3h1_sleep {
> +                       mb86s7x,function = "usb3h1";
> +                       mb86s7x,drvst = <0>; /* Implies Hi-z */
> +               };
> +
> +               cfg_pins_active: cfg_active {
> +                       mb86s7x,function = "cfg";
> +                       mb86s7x,drvst = <4>; /* in mA */
> +               };
> +               cfg_pins_sleep: cfg_sleep {
> +                       mb86s7x,function = "cfg";
> +                       mb86s7x,drvst = <0>; /* Implies Hi-z */
> +               };
> +
> +               uart0_pins_active: uart0_active {
> +                       mb86s7x,function = "uart0";
> +                       mb86s7x,drvst = <4>; /* in mA */
> +               };
> +               uart0_pins_sleep: uart0_sleep {
> +                       mb86s7x,function = "uart0";
> +                       mb86s7x,drvst = <0>; /* Implies Hi-z */
> +               };
> +
> +               uart1_pins_active: uart1_active {
> +                       mb86s7x,function = "uart1";
> +                       mb86s7x,drvst = <4>; /* in mA */
> +               };
> +               uart1_pins_sleep: uart1_sleep {
> +                       mb86s7x,function = "uart1";
> +                       mb86s7x,drvst = <0>; /* Implies Hi-z */
> +               };
> +
> +               uart2_pins_active: uart2_active {
> +                       mb86s7x,function = "uart2";
> +                       mb86s7x,drvst = <4>; /* in mA */
> +               };
> +               uart2_pins_sleep: uart2_sleep {
> +                       mb86s7x,function = "uart2";
> +                       mb86s7x,drvst = <0>; /* Implies Hi-z */
> +               };
> +
> +               trace_pins_active: trace_active {
> +                       mb86s7x,function = "trace";
> +                       mb86s7x,drvst = <4>; /* in mA */
> +               };
> +               trace_pins_sleep: trace_sleep {
> +                       mb86s7x,function = "trace";
> +                       mb86s7x,drvst = <0>; /* Implies Hi-z */
> +               };
> +
> +               pl244_pins_active: pl244_active {
> +                       mb86s7x,function = "pl244";
> +                       mb86s7x,drvst = <4>; /* in mA */
> +               };
> +               pl244_pins_sleep: pl244_sleep {
> +                       mb86s7x,function = "pl244";
> +                       mb86s7x,drvst = <0>; /* Implies Hi-z */
> +               };
> +
> +               smt_pins_active: smt_active {
> +                       mb86s7x,function = "smt";
> +                       mb86s7x,drvst = <4>; /* in mA */
> +               };
> +               smt_pins_sleep: smt_sleep {
> +                       mb86s7x,function = "smt";
> +                       mb86s7x,drvst = <0>; /* Implies Hi-z */
> +               };
> +
> +               memcs_pins_active: memcs_active {
> +                       mb86s7x,function = "memcs";
> +                       mb86s7x,drvst = <4>; /* in mA */
> +               };
> +               memcs_pins_sleep: memcs_sleep {
> +                       mb86s7x,function = "memcs";
> +                       mb86s7x,drvst = <0>; /* Implies Hi-z */
> +               };
> +       };
> +
> +       gpio0: mb86s70_gpio0 {
> +               compatible = "fujitsu,mb86s7x-gpio";
> +               reg = <0 0x31000000 0x10000>;
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +               gpio-ranges = <&pinctrl 0 0 32>;
> +               clocks = <&clk_alw_2_1>;
> +       };
> +
> +       gpio1: mb86s70_gpio1 {
> +               compatible = "fujitsu,mb86s7x-gpio";
> +               reg = <0 0x31010000 0x10000>;
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +               gpio-ranges = <&pinctrl 0 32 32>;
> +               clocks = <&clk_alw_2_1>;
> +       };
> +
> +       pd_alwayson: genpd at 0 {
> +               compatible = "fujitsu,mb86s7x-pd";
> +               index = <0>;
> +       };
> +
> +       pd_default: genpd at 1 {
> +               compatible = "fujitsu,mb86s7x-pd";
> +               index = <1>;
> +       };
> +
> +       pd_offchip: genpd at 2 {
> +               compatible = "fujitsu,mb86s7x-pd";
> +               index = <2>;
> +       };
> +
> +       pd_cpu: genpd at 3 {
> +               compatible = "fujitsu,mb86s7x-pd";
> +               index = <3>;
> +       };
> +
> +       gic: interrupt-controller at 2c001000 {
> +               compatible = "arm,cortex-a15-gic", "arm,cortex-a9-gic";
> +               #interrupt-cells = <3>;
> +               interrupt-controller;
> +               reg = <0 0x2c001000 0x1000>,
> +                     <0 0x2c002000 0x1000>,
> +                     <0 0x2c004000 0x2000>,
> +                     <0 0x2c006000 0x2000>;
> +               interrupts = <1 9 0xf04>;
> +       };
> +
> +       pmu_a7 {
> +               compatible = "arm,cortex-a7-pmu";
> +               interrupts = <0 18 4>,
> +                            <0 22 4>;
> +               fujitsu,power-domain = <&pd_cpu>;
> +       };
> +
> +       mhu: mhu0 at 2b1f0000 {
> +               #mbox-cells = <1>;
> +               compatible = "fujitsu,mhu";
> +               reg = <0 0x2B1F0000 0x1000>;
> +               interrupts = <0 36 4>, /* LP Non-Sec */
> +                            <0 35 4>, /* HP Non-Sec */
> +                            <0 37 4>; /* Secure */
> +               fujitsu,power-domain = <&pd_default>;
> +       };
> +
> +       mhu_client: scb at 0 {
> +               compatible = "fujitsu,scb";
> +               mbox = <&mhu 1>;
> +               mbox-names = "HP_NonSec";
> +       };
> +
> +       uart0: serial at 0x31040000 {
> +               compatible = "snps,dw-apb-uart";
> +               reg = <0 0x31040000 0x100>;
> +               interrupts = <0 320 0x4>;
> +               clock-frequency = <62500000>;
> +               reg-io-width = <4>;
> +               reg-shift = <2>;
> +               clocks = <&clk_alw_2_1>;
> +               clock-names = "sclk";
> +               fujitsu,power-domain = <&pd_default>;
> +               pinctrl-names = "default", "sleep";
> +               pinctrl-0 = <&uart0_pins_active>;
> +               pinctrl-1 = <&uart0_pins_sleep>;
> +       };
> +
> +       uart1: serial at 0x31050000 {
> +               compatible = "snps,dw-apb-uart";
> +               reg = <0 0x31050000 0x100>;
> +               interrupts = <0 321 0x4>;
> +               clock-frequency = <62500000>;
> +               reg-io-width = <4>;
> +               reg-shift = <2>;
> +               clocks = <&clk_alw_2_1>;
> +               clock-names = "sclk";
> +               fujitsu,power-domain = <&pd_default>;
> +               pinctrl-names = "default", "sleep";
> +               pinctrl-0 = <&uart1_pins_active>;
> +               pinctrl-1 = <&uart1_pins_sleep>;
> +       };
> +
> +       uart2: serial at 0x31060000 {
> +               compatible = "snps,dw-apb-uart";
> +               reg = <0 0x31060000 0x100>;
> +               interrupts = <0 322 0x4>;
> +               clock-frequency = <62500000>;
> +               reg-io-width = <4>;
> +               reg-shift = <2>;
> +               clocks = <&clk_alw_2_1>;
> +               clock-names = "sclk";
> +               fujitsu,power-domain = <&pd_default>;
> +               pinctrl-names = "default", "sleep";
> +               pinctrl-0 = <&uart2_pins_active>;
> +               pinctrl-1 = <&uart2_pins_sleep>;
> +       };
> +
> +       sdhci0: emmc at 300c0000 {
> +               compatible = "fujitsu,f-sdh30";
> +               reg = <0 0x300c0000 0x1000>;
> +               interrupts = <0 164 0x4>,
> +                            <0 165 0x4>;
> +               voltage-ranges = <1800 1800>, <3300 3300>;
> +               bus-width = <8>;
> +               clocks = <&clk_alw_c_0>, <&clk_alw_b_0>;
> +               clock-names = "sd_sd4clk", "sd_bclk";
> +               fujitsu,power-domain = <&pd_default>;
> +       };
> +
> +       sdhci1: sdio at 36600000 {
> +               compatible = "fujitsu,f-sdh30";
> +               reg = <0 0x36600000 0x1000>;
> +               interrupts = <0 172 0x4>,
> +                            <0 173 0x4>;
> +               voltage-ranges = <1800 1800>, <3300 3300>;
> +               clocks = <&clk_main_c_0>, <&clk_main_d_0>;
> +               clock-names = "sd_sd4clk", "sd_bclk";
> +               resume-detect-retry;
> +               fujitsu,power-domain = <&pd_offchip>;
> +       };
> +
> +       eth0: f_taiki {
> +                compatible = "fujitsu,ogma";
> +               reg = <0 0x31600000 0x10000>, <0 0x31618000 0x4000>, <0 0x3161c000 0x4000>;
> +               interrupts = <0 163 0x4>;
> +               clocks = <&clk_alw_0_8>;
> +               phy-mode = "rgmii";
> +               max-speed = <1000>;
> +               max-frame-size = <9000>;
> +               local-mac-address = [ a4 17 31 00 00 ed ];
> +               phy-handle = <&ethphy0>;
> +               fujitsu,power-domain = <&pd_default>;
> +
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               ethphy0: ethernet-phy at 1 {
> +                       device_type = "ethernet-phy";
> +                       compatible = "ethernet-phy-ieee802.3-c22";
> +                       reg = <1>;
> +               };
> +       };
> +};
> diff --git a/arch/arm/boot/dts/mb86s73eb.dts b/arch/arm/boot/dts/mb86s73eb.dts
> new file mode 100644
> index 0000000..81862d9
> --- /dev/null
> +++ b/arch/arm/boot/dts/mb86s73eb.dts
> @@ -0,0 +1,73 @@
> +
> +/include/ "mb86s73.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +
> +/ {
> +       model = "Fujitsu MB86S73 EVB";
> +       compatible = "fujitsu,mb86s73-evb";
> +
> +       memory {
> +               device_type = "memory";
> +               reg = <0 0x80000000 0x80000000>;
> +       };
> +
> +       chosen {
> +               bootargs = "loglevel=4 console=ttyS0,115200 root=/dev/mmcblk0p2 rootfstype=ext4 rootwait rw";
> +       };
> +
> +       gpio-leds {
> +               compatible = "gpio-leds";
> +
> +               d34_a {
> +                       label = "led34a";
> +                       gpios = <&gpio1 30 GPIO_ACTIVE_HIGH>;
> +                       linux,default-trigger = "heartbeat";
> +               };
> +               d34_b {
> +                       label = "led34b";
> +                       gpios = <&gpio1 31 GPIO_ACTIVE_HIGH>;
> +                       linux,default-trigger = "mmc1";
> +               };
> +               d37 {
> +                       label = "led37";
> +                       gpios = <&gpio0 30 GPIO_ACTIVE_HIGH>;
> +                       linux,default-trigger = "default-on";
> +               };
> +               d38 {
> +                       label = "led38";
> +                       gpios = <&gpio0 31 GPIO_ACTIVE_HIGH>;
> +               };
> +       };
> +
> +       gpio-keys {
> +               compatible = "gpio-keys-polled";
> +               poll-interval = <20>;
> +               home {
> +                       label = "Home";
> +                       gpios = <&gpio1 4 0>;
> +                       linux,code = <KEY_HOME>;
> +                       gpio-key;
> +               };
> +               power {
> +                       label = "Power";
> +                       gpios = <&gpio1 5 0>;
> +                       linux,code = <KEY_POWER>;
> +                       gpio-key;
> +               };
> +
> +               up {
> +                       label = "Up";
> +                       gpios = <&gpio1 6 0>;
> +                       linux,code = <KEY_UP>;
> +                       gpio-key;
> +               };
> +               down {
> +                       label = "Down";
> +                       gpios = <&gpio1 7 0>;
> +                       linux,code = <KEY_DOWN>;
> +                       gpio-key;
> +               };
> +       };
> +};
> diff --git a/arch/arm/configs/fujitsu_defconfig b/arch/arm/configs/fujitsu_defconfig
> new file mode 100644
> index 0000000..bfc78c9
> --- /dev/null
> +++ b/arch/arm/configs/fujitsu_defconfig
> @@ -0,0 +1,156 @@
> +# CONFIG_LOCALVERSION_AUTO is not set
> +CONFIG_DEFAULT_HOSTNAME="MB86S7x"
> +CONFIG_SYSVIPC=y
> +CONFIG_NO_HZ=y
> +CONFIG_HIGH_RES_TIMERS=y
> +CONFIG_IKCONFIG=y
> +CONFIG_IKCONFIG_PROC=y
> +CONFIG_NAMESPACES=y
> +CONFIG_BLK_DEV_INITRD=y
> +CONFIG_RD_BZIP2=y
> +CONFIG_RD_LZMA=y
> +CONFIG_RD_XZ=y
> +CONFIG_RD_LZO=y
> +CONFIG_CC_OPTIMIZE_FOR_SIZE=y
> +CONFIG_EXPERT=y
> +# CONFIG_COMPAT_BRK is not set
> +CONFIG_SLAB=y
> +CONFIG_PROFILING=y
> +CONFIG_MODULES=y
> +CONFIG_MODULE_UNLOAD=y
> +CONFIG_ARCH_MB86S7X=y
> +CONFIG_ARM_LPAE=y
> +# CONFIG_SWP_EMULATE is not set
> +CONFIG_ARM_ERRATA_754322=y
> +CONFIG_ARM_ERRATA_754327=y
> +CONFIG_ARM_ERRATA_764369=y
> +CONFIG_ARM_ERRATA_775420=y
> +CONFIG_ARM_ERRATA_798181=y
> +CONFIG_PCI=y
> +CONFIG_PCIEASPM_POWERSAVE=y
> +CONFIG_SMP=y
> +CONFIG_SCHED_MC=y
> +CONFIG_SCHED_SMT=y
> +CONFIG_BL_SWITCHER=y
> +CONFIG_BL_SWITCHER_DUMMY_IF=m
> +CONFIG_VMSPLIT_2G=y
> +CONFIG_PREEMPT=y
> +CONFIG_THUMB2_KERNEL=y
> +CONFIG_HIGHMEM=y
> +CONFIG_CMA=y
> +# CONFIG_ATAGS is not set
> +CONFIG_ZBOOT_ROM_TEXT=0x0
> +CONFIG_ZBOOT_ROM_BSS=0x0
> +CONFIG_CMDLINE="mem=2048M earlycon=ttyS0,115200 earlyprintk console=ttyS0,115200 console=tty0 root=/dev/mmcblk0p2 rootfstype=ext4 rootwait"
> +CONFIG_KEXEC=y
> +CONFIG_CPU_IDLE=y
> +CONFIG_VFP=y
> +CONFIG_NEON=y
> +CONFIG_PM_WAKELOCKS=y
> +CONFIG_PM_RUNTIME=y
> +CONFIG_PM_DEBUG=y
> +CONFIG_NET=y
> +CONFIG_PACKET=y
> +CONFIG_UNIX=y
> +CONFIG_INET=y
> +CONFIG_IP_MULTICAST=y
> +CONFIG_IP_PNP=y
> +CONFIG_IP_PNP_DHCP=y
> +CONFIG_IP_PNP_BOOTP=y
> +# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
> +# CONFIG_INET_XFRM_MODE_TUNNEL is not set
> +# CONFIG_INET_XFRM_MODE_BEET is not set
> +# CONFIG_INET_LRO is not set
> +CONFIG_IPV6=y
> +CONFIG_INET6_XFRM_MODE_TRANSPORT=m
> +CONFIG_INET6_XFRM_MODE_TUNNEL=m
> +CONFIG_INET6_XFRM_MODE_BEET=m
> +CONFIG_IPV6_SIT=m
> +# CONFIG_ANDROID_PARANOID_NETWORK is not set
> +# CONFIG_WIRELESS is not set
> +CONFIG_DEVTMPFS=y
> +CONFIG_DEVTMPFS_MOUNT=y
> +# CONFIG_FW_LOADER_USER_HELPER is not set
> +CONFIG_DMA_CMA=y
> +CONFIG_CMA_SIZE_MBYTES=192
> +CONFIG_BLK_DEV_LOOP=m
> +CONFIG_BLK_DEV_CRYPTOLOOP=m
> +CONFIG_BLK_DEV_RAM=y
> +CONFIG_BLK_DEV_RAM_COUNT=2
> +CONFIG_BLK_DEV_RAM_SIZE=1024
> +# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
> +CONFIG_INPUT_MOUSEDEV_SCREEN_X=800
> +CONFIG_INPUT_MOUSEDEV_SCREEN_Y=480
> +CONFIG_INPUT_EVDEV=m
> +# CONFIG_KEYBOARD_ATKBD is not set
> +CONFIG_KEYBOARD_GPIO_POLLED=y
> +# CONFIG_MOUSE_PS2 is not set
> +CONFIG_MOUSE_GPIO=m
> +CONFIG_INPUT_TOUCHSCREEN=y
> +CONFIG_TOUCHSCREEN_EGALAX=m
> +CONFIG_TOUCHSCREEN_ILI210X=m
> +# CONFIG_SERIO_SERPORT is not set
> +CONFIG_VT_HW_CONSOLE_BINDING=y
> +CONFIG_LEGACY_PTY_COUNT=16
> +# CONFIG_DEVKMEM is not set
> +CONFIG_SERIAL_8250=y
> +# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
> +CONFIG_SERIAL_8250_CONSOLE=y
> +CONFIG_SERIAL_8250_EXTENDED=y
> +CONFIG_SERIAL_8250_DW=y
> +CONFIG_SERIAL_OF_PLATFORM=y
> +# CONFIG_HW_RANDOM is not set
> +CONFIG_I2C=y
> +# CONFIG_I2C_COMPAT is not set
> +# CONFIG_I2C_HELPER_AUTO is not set
> +CONFIG_GPIO_SYSFS=y
> +# CONFIG_HWMON is not set
> +# CONFIG_VGA_ARB is not set
> +# CONFIG_HID is not set
> +# CONFIG_USB_SUPPORT is not set
> +CONFIG_MMC=y
> +CONFIG_MMC_CLKGATE=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_F_SDH30=y
> +CONFIG_NEW_LEDS=y
> +CONFIG_LEDS_CLASS=y
> +CONFIG_LEDS_GPIO=y
> +CONFIG_LEDS_TRIGGERS=y
> +CONFIG_LEDS_TRIGGER_TIMER=y
> +CONFIG_LEDS_TRIGGER_HEARTBEAT=y
> +CONFIG_LEDS_TRIGGER_BACKLIGHT=m
> +CONFIG_LEDS_TRIGGER_CPU=y
> +CONFIG_LEDS_TRIGGER_GPIO=y
> +CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
> +CONFIG_LEDS_TRIGGER_TRANSIENT=m
> +CONFIG_MAILBOX=y
> +CONFIG_MBOX_F_MHU=y
> +# CONFIG_IOMMU_SUPPORT is not set
> +CONFIG_EXT4_FS=y
> +CONFIG_EXT4_FS_POSIX_ACL=y
> +CONFIG_EXT4_FS_SECURITY=y
> +CONFIG_VFAT_FS=m
> +CONFIG_TMPFS=y
> +CONFIG_CONFIGFS_FS=m
> +CONFIG_CRAMFS=y
> +CONFIG_ROMFS_FS=y
> +CONFIG_NLS_CODEPAGE_437=m
> +CONFIG_NLS_ISO8859_1=m
> +CONFIG_PRINTK_TIME=y
> +CONFIG_DEBUG_INFO=y
> +CONFIG_DEBUG_FS=y
> +CONFIG_MAGIC_SYSRQ=y
> +CONFIG_DEBUG_MEMORY_INIT=y
> +# CONFIG_DEBUG_PREEMPT is not set
> +# CONFIG_RCU_CPU_STALL_VERBOSE is not set
> +# CONFIG_FTRACE is not set
> +CONFIG_DEBUG_USER=y
> +# CONFIG_DEBUG_LL is not set
> +CONFIG_DEBUG_LL_UART_8250=y
> +CONFIG_DEBUG_UART_PHYS=0x31040000
> +CONFIG_DEBUG_UART_VIRT=0xfe000000
> +CONFIG_DEBUG_UART_8250_WORD=y
> +# CONFIG_EARLY_PRINTK is not set
> +CONFIG_CRYPTO_AES=y
> +# CONFIG_CRYPTO_ANSI_CPRNG is not set
> +# CONFIG_CRYPTO_HW is not set
> diff --git a/arch/arm/mach-mb86s7x/Kconfig b/arch/arm/mach-mb86s7x/Kconfig
> new file mode 100644
> index 0000000..44f5b0c
> --- /dev/null
> +++ b/arch/arm/mach-mb86s7x/Kconfig
> @@ -0,0 +1,18 @@
> +config ARCH_MB86S7X
> +       bool "Fujitsu MB86S7x platforms" if (ARCH_MULTI_V7 && ARM_LPAE)
> +       select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
> +       select ARM_AMBA
> +       select ARM_GIC
> +       select ARM_TIMER_SP804
> +       select HAVE_ARM_ARCH_TIMER
> +       select ARCH_REQUIRE_GPIOLIB
> +       select ARCH_HAS_CPUFREQ
> +       select ARCH_HAS_OPP
> +       select PM_OPP
> +       select PINCTRL
> +       select PINCTRL_MB86S7X
> +       select ARM_CCI
> +       select BIG_LITTLE
> +       select PM_GENERIC_DOMAINS if PM
> +       help
> +         Support for Fujitsu MB86S7x based platforms
> diff --git a/arch/arm/mach-mb86s7x/Makefile b/arch/arm/mach-mb86s7x/Makefile
> new file mode 100644
> index 0000000..5524a6c
> --- /dev/null
> +++ b/arch/arm/mach-mb86s7x/Makefile
> @@ -0,0 +1,2 @@
> +obj-y          += board.o scb_mhu.o mcpm.o
> +obj-$(CONFIG_PM_GENERIC_DOMAINS) += pm_domains.o
> diff --git a/arch/arm/mach-mb86s7x/board.c b/arch/arm/mach-mb86s7x/board.c
> new file mode 100644
> index 0000000..d6e76ec
> --- /dev/null
> +++ b/arch/arm/mach-mb86s7x/board.c
> @@ -0,0 +1,65 @@
> +/*
> + * Support for the Fujitsu's MB86S7x based devices.
> + *
> + * Copyright (C) 2014 Linaro, LTD
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/of.h>
> +
> +#include <asm/mcpm.h>
> +#include <asm/mach/map.h>
> +#include <asm/mach/arch.h>
> +
> +#include "iomap.h"
> +
> +bool __init mb86s7x_smp_init_ops(void)
> +{
> +       struct device_node *node;
> +
> +       node = of_find_compatible_node(NULL, NULL, "arm,cci-400");
> +       if (node && of_device_is_available(node)) {
> +               mcpm_smp_set_ops();
> +               return true;
> +       }
> +
> +       return false;
> +}
> +
> +#define IOMAP_DEV(name) { \
> +               .virtual = (unsigned long) MB86S7X_##name##_VIRT, \
> +               .pfn = __phys_to_pfn(MB86S7X_##name##_PHYS), \
> +               .length = MB86S7X_##name##_SIZE, \
> +               .type = MT_DEVICE, \
> +       }
> +
> +static struct map_desc mb86s7x_io_desc[] = {
> +       IOMAP_DEV(MHU),
> +       IOMAP_DEV(ISRAM),
> +};
> +
> +void __init mb86s7x_dt_map_io(void)
> +{
> +       iotable_init(mb86s7x_io_desc, ARRAY_SIZE(mb86s7x_io_desc));
> +}
> +
> +static const char *mb86s7x_dt_match[] __initconst = {
> +       "fujitsu,mb86s70-evb",
> +       "fujitsu,mb86s73-evb",
> +       NULL,
> +};
> +
> +DT_MACHINE_START(MB86S7X_DT, "Fujitsu MB86S7X-based board")
> +       .dt_compat      = mb86s7x_dt_match,
> +       .smp_init       = smp_init_ops(mb86s7x_smp_init_ops),
> +       .map_io         = mb86s7x_dt_map_io,
> +MACHINE_END
> diff --git a/arch/arm/mach-mb86s7x/iomap.h b/arch/arm/mach-mb86s7x/iomap.h
> new file mode 100644
> index 0000000..2b8db1d
> --- /dev/null
> +++ b/arch/arm/mach-mb86s7x/iomap.h
> @@ -0,0 +1,34 @@
> +/*
> + * arch/arm/mach-mb86s7x/iomap.h
> + *
> + * Created by: Jassi Brar <jassisinghbrar@gmail.com>
> + * Copyright:  (C) 2013-2014 Linaro Limited
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __MB86S7X_IOMAP_H
> +#define __MB86S7X_IOMAP_H
> +
> +#include <linux/sizes.h>
> +
> +#define SEC_RSTADDR_OFF                0x3fc
> +
> +#define MB86S7X_MHU_PHYS       0x2b1f0000
> +#define MB86S7X_MHU_SIZE       SZ_4K
> +
> +/* Internal SRAM */
> +#define MB86S7X_ISRAM_PHYS     0x2e000000
> +#define MB86S7X_ISRAM_SIZE     SZ_16K
> +#define MB86S7X_TRAMPOLINE_PHYS        (MB86S7X_ISRAM_PHYS + 0x3c00)
> +
> +#define MB86S7X_ISRAM_VIRT     IOMEM(0xfe000000)
> +#define MB86S7X_MHU_VIRT       (MB86S7X_ISRAM_VIRT + MB86S7X_ISRAM_SIZE)
> +
> +/* Non-Secure High-Priority Channel is used */
> +#define MB86S7X_SHM_FROM_SCB_VIRT      (MB86S7X_ISRAM_VIRT + 0x3800)
> +#define MB86S7X_TRAMPOLINE_VIRT                (MB86S7X_ISRAM_VIRT + 0x3c00)
> +
> +#endif /* __MB86S7X_IOMAP_H */
> diff --git a/arch/arm/mach-mb86s7x/mcpm.c b/arch/arm/mach-mb86s7x/mcpm.c
> new file mode 100644
> index 0000000..86d223f
> --- /dev/null
> +++ b/arch/arm/mach-mb86s7x/mcpm.c
> @@ -0,0 +1,293 @@
> +/*
> + * arch/arm/mach-mb86s7x/mcpm.c
> + *
> + * "Inspired" by tc_pm.c
> + * Copyright:  (C) 2013-2014  Fujitsu Semiconductor Limited
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/io.h>
> +#include <linux/pm.h>
> +#include <linux/delay.h>
> +#include <linux/kernel.h>
> +#include <linux/reboot.h>
> +#include <linux/arm-cci.h>
> +#include <linux/spinlock.h>
> +#include <linux/irqchip/arm-gic.h>
> +#include <linux/platform_data/mb86s7x_mbox.h>
> +
> +#include <asm/mcpm.h>
> +#include <asm/cp15.h>
> +#include <asm/cputype.h>
> +#include <asm/system_misc.h>
> +
> +#include "iomap.h"
> +
> +static arch_spinlock_t mb86s7x_pm_lock = __ARCH_SPIN_LOCK_UNLOCKED;

You should not be using arch_spinlock_t directly.

> +static int mb86s7x_pm_use_count[2][2];
> +
> +#define MB86S7X_WFICOLOR_VIRT (MB86S7X_ISRAM_VIRT + WFI_COLOR_REG_OFFSET)
> +
> +static void mb86s7x_set_wficolor(unsigned clstr, unsigned cpu, unsigned clr)
> +{
> +       u8 val;
> +
> +       if (clr & ~AT_WFI_COLOR_MASK)
> +               return;
> +
> +       val = readb_relaxed(MB86S7X_WFICOLOR_VIRT + clstr * 2 + cpu);
> +       val &= ~AT_WFI_COLOR_MASK;
> +       val |= clr;
> +       writeb_relaxed(val, MB86S7X_WFICOLOR_VIRT + clstr * 2 + cpu);
> +}
> +
> +static int mb86s7x_pm_power_up(unsigned int cpu, unsigned int cluster)
> +{
> +       struct completion got_rsp;
> +       int ret = 0;
> +
> +       pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
> +
> +       arch_spin_lock(&mb86s7x_pm_lock);
> +
> +       mb86s7x_pm_use_count[cpu][cluster]++;
> +
> +       if (mb86s7x_pm_use_count[cpu][cluster] == 1) {
> +               struct mb86s7x_cpu_gate cmd;
> +
> +               arch_spin_unlock(&mb86s7x_pm_lock);

Can't you use atomic operations here (i.e. atomic_inc_return) instead of a lock?

In any case, Nicolas should review the cluster PM code if he hasn't
already. As Arnd pointed out, this patch should be split up into
multiple patches. I'd suggest splitting into DT bindings, DTS files,
base support, mailbox, MCPM, and PM domains.

That's all I've got time and energy for reviewing for now.

Rob
