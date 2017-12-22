From: zhang.lyra@gmail.com (Chunyan Zhang)
Date: Fri, 22 Dec 2017 13:31:43 +0800
Subject: [PATCH V7 12/12] arm64: dts: add clocks for SC9860
In-Reply-To: <20171207125715.16160-13-chunyan.zhang@spreadtrum.com>
References: <20171207125715.16160-1-chunyan.zhang@spreadtrum.com>
 <20171207125715.16160-13-chunyan.zhang@spreadtrum.com>
Message-ID: <CAAfSe-ubWLn9nhGiP1sk+HFbhcBM=Md7kVQBKuUNzmF3-xQjhw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ arm at kernel.org

On 7 December 2017 at 20:57, Chunyan Zhang <chunyan.zhang@spreadtrum.com> wrote:
> Some clocks on SC9860 are in the same address area with syscon devices,
> those are what have a property of 'sprd,syscon' which would refer to
> syscon devices, others would have a reg property indicated their address
> ranges.
>
> Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
> ---
>  arch/arm64/boot/dts/sprd/sc9860.dtsi | 115 +++++++++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/sprd/whale2.dtsi |  18 +++++-
>  2 files changed, 131 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/sprd/sc9860.dtsi b/arch/arm64/boot/dts/sprd/sc9860.dtsi
> index 7b7d8ce..bf03da4 100644
> --- a/arch/arm64/boot/dts/sprd/sc9860.dtsi
> +++ b/arch/arm64/boot/dts/sprd/sc9860.dtsi
> @@ -7,6 +7,7 @@
>   */
>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/sprd,sc9860-clk.h>
>  #include "whale2.dtsi"
>
>  / {
> @@ -183,6 +184,120 @@
>         };
>
>         soc {
> +               pmu_gate: pmu-gate {
> +                       compatible = "sprd,sc9860-pmu-gate";
> +                       sprd,syscon = <&pmu_regs>; /* 0x402b0000 */
> +                       clocks = <&ext_26m>;
> +                       #clock-cells = <1>;
> +               };
> +
> +               pll: pll {
> +                       compatible = "sprd,sc9860-pll";
> +                       sprd,syscon = <&ana_regs>; /* 0x40400000 */
> +                       clocks = <&pmu_gate 0>;
> +                       #clock-cells = <1>;
> +               };
> +
> +               ap_clk: clock-controller at 20000000 {
> +                       compatible = "sprd,sc9860-ap-clk";
> +                       reg = <0 0x20000000 0 0x400>;
> +                       clocks = <&ext_26m>, <&pll 0>,
> +                                <&pmu_gate 0>;
> +                       #clock-cells = <1>;
> +               };
> +
> +               aon_prediv: aon-prediv {
> +                       compatible = "sprd,sc9860-aon-prediv";
> +                       reg = <0 0x402d0000 0 0x400>;
> +                       clocks = <&ext_26m>, <&pll 0>,
> +                                <&pmu_gate 0>;
> +                       #clock-cells = <1>;
> +               };
> +
> +               apahb_gate: apahb-gate {
> +                       compatible = "sprd,sc9860-apahb-gate";
> +                       sprd,syscon = <&ap_ahb_regs>; /* 0x20210000 */
> +                       clocks = <&aon_prediv 0>;
> +                       #clock-cells = <1>;
> +               };
> +
> +               aon_gate: aon-gate {
> +                       compatible = "sprd,sc9860-aon-gate";
> +                       sprd,syscon = <&aon_regs>; /* 0x402e0000 */
> +                       clocks = <&aon_prediv 0>;
> +                       #clock-cells = <1>;
> +               };
> +
> +               aonsecure_clk: clock-controller at 40880000 {
> +                       compatible = "sprd,sc9860-aonsecure-clk";
> +                       reg = <0 0x40880000 0 0x400>;
> +                       clocks = <&ext_26m>, <&pll 0>;
> +                       #clock-cells = <1>;
> +               };
> +
> +               agcp_gate: agcp-gate {
> +                       compatible = "sprd,sc9860-agcp-gate";
> +                       sprd,syscon = <&agcp_regs>; /* 0x415e0000 */
> +                       clocks = <&aon_prediv 0>;
> +                       #clock-cells = <1>;
> +               };
> +
> +               gpu_clk: clock-controller at 60200000 {
> +                       compatible = "sprd,sc9860-gpu-clk";
> +                       reg = <0 0x60200000 0 0x400>;
> +                       clocks = <&pll 0>;
> +                       #clock-cells = <1>;
> +               };
> +
> +               vsp_clk: clock-controller at 61000000 {
> +                       compatible = "sprd,sc9860-vsp-clk";
> +                       reg = <0 0x61000000 0 0x400>;
> +                       clocks = <&ext_26m>, <&pll 0>;
> +                       #clock-cells = <1>;
> +               };
> +
> +               vsp_gate: vsp-gate {
> +                       compatible = "sprd,sc9860-vsp-gate";
> +                       sprd,syscon = <&vsp_regs>; /* 0x61100000 */
> +                       clocks = <&vsp_clk 0>;
> +                       #clock-cells = <1>;
> +               };
> +
> +               cam_clk: clock-controller at 62000000 {
> +                       compatible = "sprd,sc9860-cam-clk";
> +                       reg = <0 0x62000000 0 0x4000>;
> +                       clocks = <&ext_26m>, <&pll 0>;
> +                       #clock-cells = <1>;
> +               };
> +
> +               cam_gate: cam-gate {
> +                       compatible = "sprd,sc9860-cam-gate";
> +                       sprd,syscon = <&cam_regs>; /* 0x62100000 */
> +                       clocks = <&cam_clk 0>;
> +                       #clock-cells = <1>;
> +               };
> +
> +               disp_clk: clock-controller at 63000000 {
> +                       compatible = "sprd,sc9860-disp-clk";
> +                       reg = <0 0x63000000 0 0x400>;
> +                       clocks = <&ext_26m>, <&pll 0>;
> +                       #clock-cells = <1>;
> +               };
> +
> +               disp_gate: disp-gate {
> +                       compatible = "sprd,sc9860-disp-gate";
> +                       sprd,syscon = <&disp_regs>; /* 0x63100000 */
> +                       clocks = <&disp_clk 0>;
> +                       #clock-cells = <1>;
> +               };
> +
> +               apapb_gate: apapb-gate {
> +                       compatible = "sprd,sc9860-apapb-gate";
> +                       sprd,syscon = <&ap_apb_regs>; /* 0x70b00000 */
> +                       clocks = <&ap_clk 0>;
> +                       #clock-cells = <1>;
> +               };
> +
>                 funnel at 10001000 { /* SoC Funnel */
>                         compatible = "arm,coresight-funnel", "arm,primecell";
>                         reg = <0 0x10001000 0 0x1000>;
> diff --git a/arch/arm64/boot/dts/sprd/whale2.dtsi b/arch/arm64/boot/dts/sprd/whale2.dtsi
> index 6ea3a75..328009c 100644
> --- a/arch/arm64/boot/dts/sprd/whale2.dtsi
> +++ b/arch/arm64/boot/dts/sprd/whale2.dtsi
> @@ -106,10 +106,24 @@
>                 };
>         };
>
> -       ext_26m: ext-26m {
> +       ext_32k: ext_32k {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <32768>;
> +               clock-output-names = "ext-32k";
> +       };
> +
> +       ext_26m: ext_26m {
>                 compatible = "fixed-clock";
>                 #clock-cells = <0>;
>                 clock-frequency = <26000000>;
> -               clock-output-names = "ext_26m";
> +               clock-output-names = "ext-26m";
> +       };
> +
> +       ext_rco_100m: ext_rco_100m {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <100000000>;
> +               clock-output-names = "ext-rco-100m";
>         };
>  };
> --
> 2.7.4
>
