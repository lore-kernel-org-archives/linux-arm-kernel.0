From: robherring2@gmail.com (Rob Herring)
Date: Wed, 29 Apr 2015 11:47:53 -0500
Subject: [PATCH v7 3/5] Documentation: Add documentation for the APM
 X-Gene SoC EDAC DTS binding
In-Reply-To: <1430259045-19012-4-git-send-email-lho@apm.com>
References: <1430259045-19012-1-git-send-email-lho@apm.com>
 <1430259045-19012-2-git-send-email-lho@apm.com>
 <1430259045-19012-3-git-send-email-lho@apm.com>
 <1430259045-19012-4-git-send-email-lho@apm.com>
Message-ID: <CAL_Jsq+nhPUxHxrStB9cdy1YzE7tVPFVR1MrWq3Bz-JUa=3Rvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 28, 2015 at 5:10 PM, Loc Ho <lho@apm.com> wrote:
> This patch adds documentation for the APM X-Gene SoC EDAC DTS binding.
>
> Signed-off-by: Feng Kan <fkan@apm.com>
> Signed-off-by: Loc Ho <lho@apm.com>
> ---
>  .../devicetree/bindings/edac/apm-xgene-edac.txt    |  107 ++++++++++++++++++++
>  1 files changed, 107 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/edac/apm-xgene-edac.txt
>
> diff --git a/Documentation/devicetree/bindings/edac/apm-xgene-edac.txt b/Documentation/devicetree/bindings/edac/apm-xgene-edac.txt
> new file mode 100644
> index 0000000..548299a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/edac/apm-xgene-edac.txt
> @@ -0,0 +1,107 @@
> +* APM X-Gene SoC EDAC nodes
> +
> +EDAC nodes are defined to describe on-chip error detection and correction.
> +There are four types of EDAC:
> +
> +  memory controller    - Memory controller
> +  PMD (L1/L2)          - Processor module unit (PMD) L1/L2 cache
> +  L3                   - CPU L3 cache
> +  SoC                  - SoC IP such as SATA, Ethernet, and etc
> +
> +The following section describes the memory controller DT node binding.
> +
> +Required properties:
> +- compatible           : Shall be "apm,xgene-edac-mc".

You are still describing what you want for EDAC driver not what the
h/w looks like AFAICT.

> +- regmap-pcp           : Regmap of the PCP resource.
> +- regmap-csw           : Regmap of the CSW resource.
> +- regmap-mcba          : Regmap of the MCB-A resource.
> +- regmap-mcbb          : Regmap of the MCB-B resource.

What are these blocks? Regardless, I doubt the linkage here belongs in DT.

> +- reg                  : First resource shall be the MCU resource.
> +- interrupts            : Interrupt-specifier for MCU error IRQ(s).

What is MCU?

> +
> +The following section describes the L1/L2 DT node binding.

Similar comments for the rest. I would define memory controller
bindings and EDAC driver, then worry about the rest.

Rob

> +
> +- compatible           : Shall be "apm,xgene-edac-pmd".
> +- regmap-pcp           : Regmap of the PCP resource.
> +- regmap-efuse         : Regmap of the PMD efuse resource.
> +- reg                  : First resource shall be the PMD resource.
> +- interrupts            : Interrupt-specifier for PMD error IRQ(s).
> +
> +The following section describes the L3 DT node binding.
> +
> +- compatible           : Shall be "apm,xgene-edac-l3".
> +- regmap-pcp           : Regmap of the PCP resource.
> +- reg                  : First resource shall be the L3 resource.
> +- interrupts            : Interrupt-specifier for L3 error IRQ(s).
> +
> +The following section describes the SoC DT node binding.
> +
> +- compatible           : Shall be "apm,xgene-edac-soc"".
> +- regmap-pcp           : Regmap of the PCP resource.
> +- reg                  : First resource shall be the SoC resource.
> +                         Second resource shall be the register bus resource.
> +- interrupts           : Interrupt-specifier for SoC error IRQ(s).
> +
> +Example:
> +       efuse: efuse at 1054a000 {
> +               compatible = "syscon";
> +               reg = <0x0 0x1054a000 0x0 0x20>;
> +       };
> +
> +       pcperror: pcperror at 78800000 {
> +               compatible = "syscon";
> +               reg = <0x0 0x78800000 0x0 0x100>;
> +       };
> +
> +       csw: csw at 7e200000 {
> +               compatible = "syscon";
> +               reg = <0x0 0x7e200000 0x0 0x1000>;
> +       };
> +
> +       mcba: mcba at 7e700000 {
> +               compatible = "syscon";
> +               reg = <0x0 0x7e700000 0x0 0x1000>;
> +       };
> +
> +       mcbb: mcbb at 7e720000 {
> +               compatible = "syscon";
> +               reg = <0x0 0x7e720000 0x0 0x1000>;
> +       };
> +
> +       edacmc0: edacmc0 at 7e800000 {
> +               compatible = "apm,xgene-edac-mc";
> +               regmap-pcp = <&pcperror>;
> +               regmap-csw = <&csw>;
> +               regmap-mcba = <&mcba>;
> +               regmap-mcbb = <&mcbb>;
> +               reg = <0x0 0x7e800000 0x0 0x1000>;
> +               interrupts = <0x0 0x20 0x4>,
> +                            <0x0 0x21 0x4>;
> +       };
> +
> +       edacpmd0: edacpmd0 at 7c000000 {
> +               compatible = "apm,xgene-edac-pmd";
> +               regmap-pcp = <&pcperror>;
> +               regmap-efuse = <&efuse>;
> +               reg = <0x0 0x7c000000 0x0 0x200000>;
> +               interrupts = <0x0 0x20 0x4>,
> +                            <0x0 0x21 0x4>;
> +       };
> +
> +       edacl3: edacl3 at 7e600000 {
> +               compatible = "apm,xgene-edac-l3";
> +               regmap-pcp = <&pcperror>;
> +               reg = <0x0 0x7e600000 0x0 0x1000>;
> +               interrupts = <0x0 0x20 0x4>,
> +                            <0x0 0x21 0x4>;
> +       };
> +
> +       edacsoc: edacsoc at 7e930000 {
> +               compatible = "apm,xgene-edac-soc";
> +               regmap-pcp = <&pcperror>;
> +               reg = <0x0 0x7e930000 0x0 0x1000>,
> +                     <0x0 0x7e000000 0x0 0x1000>;
> +               interrupts = <0x0 0x20 0x4>,
> +                            <0x0 0x21 0x4>,
> +                            <0x0 0x27 0x4>;
> +       };
> --
> 1.7.1
>
