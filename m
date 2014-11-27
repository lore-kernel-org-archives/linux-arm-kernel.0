From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 27 Nov 2014 11:50:43 +0000
Subject: [PATCH v3 3/5] arm64: dts: Add support for Spreadtrum SC9836 SoC
 in dts and Makefile
In-Reply-To: <1416917818-10506-4-git-send-email-chunyan.zhang@spreadtrum.com>
References: <Sharkl64-v3>
 <1416917818-10506-1-git-send-email-chunyan.zhang@spreadtrum.com>
 <1416917818-10506-4-git-send-email-chunyan.zhang@spreadtrum.com>
Message-ID: <20141127115042.GE857@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 25, 2014 at 12:16:56PM +0000, Chunyan Zhang wrote:
> From: Zhizhou Zhang <zhizhou.zhang@spreadtrum.com>
> 
> Adds the device tree support for Spreadtrum SC9836 SoC which is based on
> Sharkl64 platform.
> 
> Sharkl64 platform contains the common nodes of Spreadtrum's arm64-based SoCs.
> 
> Signed-off-by: Zhizhou Zhang <zhizhou.zhang@spreadtrum.com>
> Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
> Signed-off-by: Orson Zhai <orson.zhai@spreadtrum.com>
> ---
>  arch/arm64/boot/dts/Makefile                  |    1 +
>  arch/arm64/boot/dts/sprd-sc9836-openphone.dts |   85 ++++++++++++++++++++
>  arch/arm64/boot/dts/sprd-sc9836.dtsi          |  103 ++++++++++++++++++++++++
>  arch/arm64/boot/dts/sprd-sharkl64.dtsi        |  105 +++++++++++++++++++++++++
>  4 files changed, 294 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/sprd-sc9836-openphone.dts
>  create mode 100644 arch/arm64/boot/dts/sprd-sc9836.dtsi
>  create mode 100644 arch/arm64/boot/dts/sprd-sharkl64.dtsi
> 
> diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
> index f8001a6..d0aff8a 100644
> --- a/arch/arm64/boot/dts/Makefile
> +++ b/arch/arm64/boot/dts/Makefile
> @@ -1,4 +1,5 @@
>  dtb-$(CONFIG_ARCH_THUNDER) += thunder-88xx.dtb
> +dtb-$(CONFIG_ARCH_SHARKL64) += sprd-sc9836-openphone.dtb
>  dtb-$(CONFIG_ARCH_VEXPRESS) += rtsm_ve-aemv8a.dtb foundation-v8.dtb
>  dtb-$(CONFIG_ARCH_XGENE) += apm-mustang.dtb
 
[...]

> +       gic: interrupt-controller at 12001000 {
> +               compatible = "arm,cortex-a15-gic", "arm,cortex-a9-gic";
> +               #interrupt-cells = <3>;
> +               interrupt-controller;
> +               reg = <0 0x12001000 0 0x1000>,
> +                     <0 0x12002000 0 0x1000>,
> +                     <0 0x12004000 0 0x2000>,
> +                     <0 0x12006000 0 0x2000>;
> +       };

I believe GICC should be 8KiB here.

> +
> +       psci {
> +               compatible = "arm,psci-0.2";
> +               method = "smc";
> +       };

Do you have a complete PSCI 0.2 implementation (e.g. are all the
mandatory functions implemented)?

I take it CPUs enter the kernel at EL2?

How have you tested this?

> +
> +       timer {
> +               compatible = "arm,armv8-timer";
> +               interrupts = <1 13 0xff01>,
> +                            <1 14 0xff01>,
> +                            <1 11 0xff01>,
> +                            <1 10 0xff01>;
> +               clock-frequency = <26000000>;

Please remove the clock-frequency property. Your FW should initialise
CNTFRQ_EL0 on all CPUs (certainly PSCI 0.2 requires that you do this).

[...]

> +       clocks {
> +               clk26mhz: clk26mhz {
> +                       compatible = "fixed-clock";
> +                       #clock-cells = <0>;
> +                       clock-frequency = <26000000>;
> +               };
> +       };

Get rid of the "clocks" container node. There's no need for it.

Thanks,
Mark.
