From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 2 Dec 2014 11:09:09 +0000
Subject: [PATCH 14/19] arm64: dts: exynos: Add dts files for 64-bit
 Exynos5433 SoC
In-Reply-To: <1417510196-6714-15-git-send-email-cw00.choi@samsung.com>
References: <1417510196-6714-1-git-send-email-cw00.choi@samsung.com>
 <1417510196-6714-15-git-send-email-cw00.choi@samsung.com>
Message-ID: <20141202110909.GB23671@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Dec 02, 2014 at 08:49:51AM +0000, Chanwoo Choi wrote:
> This patch adds new Exynos5433 dtsi to support 64-bit Exynos5433 SoC based on
> Octal core CPUs (quad Cortex-A57 and quad Cortex-A53). And Exynos5433 supports
> PSCI (Power State Coordination Interface) v0.1.
>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Acked-by: Inki Dae <inki.dae@samsung.com>
> Acked-by: Geunsik Lim <geunsik.lim@samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi | 698 +++++++++++++++++++++
>  arch/arm64/boot/dts/exynos/exynos5433.dtsi         | 515 +++++++++++++++
>  2 files changed, 1213 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi
>  create mode 100644 arch/arm64/boot/dts/exynos/exynos5433.dtsi

[...]

> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               cpu0: cpu at 100 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a53", "arm,armv8";
> +                       enable-method = "psci";
> +                       reg = <0x100>;
> +               };
> +
> +               cpu1: cpu at 101 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a53", "arm,armv8";
> +                       enable-method = "psci";
> +                       reg = <0x101>;
> +               };
> +
> +               cpu2: cpu at 102 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a53", "arm,armv8";
> +                       enable-method = "psci";
> +                       reg = <0x0 0x102>;
> +               };
> +
> +               cpu3: cpu at 103 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a53", "arm,armv8";
> +                       enable-method = "psci";
> +                       reg = <0x103>;
> +               };
> +
> +               cpu4: cpu at 0 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a57", "arm,armv8";
> +                       enable-method = "psci";
> +                       reg = <0x0>;
> +               };
> +
> +               cpu5: cpu at 1 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a57", "arm,armv8";
> +                       enable-method = "psci";
> +                       reg = <0x1>;
> +               };
> +
> +               cpu6: cpu at 2 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a57", "arm,armv8";
> +                       enable-method = "psci";
> +                       reg = <0x2>;
> +               };
> +
> +               cpu7: cpu at 3 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a57", "arm,armv8";
> +                       enable-method = "psci";
> +                       reg = <0x3>;
> +               };
> +       };
> +
> +       psci {
> +               compatible = "arm,psci";
> +               method = "smc";
> +               cpu_off = <0x84000002>;
> +               cpu_on = <0xC4000003>;
> +       };

Given your comments on the latest posting, has CPU_OFF been tested, and
does it work for _all_ CPUs (including CPU0)?

> +
> +       soc: soc {
> +               compatible = "simple-bus";
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges;

Is that valid when changing the number of cells? The address spaces
aren't strictly identical in that case, and I'd expect a translation
something like:

        ranges = <0x0 0x0 0x0 0xff000000>;

Where the final cell is a sufficiently large value to cover all
addresses in the soc node.

[...]

> +               gic:interrupt-controller at 11001000 {
> +                       compatible = "arm,gic-400";
> +                       #interrupt-cells = <3>;
> +                       interrupt-controller;
> +                       reg =   <0x11001000 0x1000>,
> +                               <0x11002000 0x1000>,
> +                               <0x11004000 0x2000>,
> +                               <0x11006000 0x2000>;
> +                       interrupts = <1 9 0xf04>;
> +               };

The GICC needs to be 0x2000 long to map the GICC_DIR, which is at
0x1000-0x1003.

[...]

> +               pinctrl_alive: pinctrl at 10580000 {
> +                       compatible = "samsung,exynos5433-pinctrl";
> +                       reg = <0x10580000 0x1000>;
> +
> +                       wakeup-interrupt-controller {
> +                               compatible = "samsung,exynos7-wakeup-eint";
> +                               interrupts = <0 16 0>;
> +                       };
> +               };

How exactly does the wakeup interrupt controller interact with the GIC?
Surely the relationship between the two should be described?

Is it a subcomponent of the pincontrol block?

Thanks,
Mark.
