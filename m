From: markus.mayer@broadcom.com (Markus Mayer)
Date: Tue, 29 Mar 2016 11:47:10 -0700
Subject: [PATCH 3/4] arm64: dts: Move NS2 clock DT nodes to separate DT
 file
In-Reply-To: <1459236454-26285-4-git-send-email-anup.patel@broadcom.com>
References: <1459236454-26285-1-git-send-email-anup.patel@broadcom.com>
 <1459236454-26285-4-git-send-email-anup.patel@broadcom.com>
Message-ID: <CAGt4E5vadj_Z8tqapA02z6hHkztM5YgLU4Sv-EYeR-ohk2Jkgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 March 2016 at 00:27, Anup Patel <anup.patel@broadcom.com> wrote:
> For more readabilty and consistency with other Broadcom SoCs, we move
> all NS2 clock DT nodes from main SoC DT file to a separate DT file.
>
> We also update the license header in ns2.dtsi as-per new Broadcom
> convention.
>
> Signed-off-by: Anup Patel <anup.patel@broadcom.com>
> Reviewed-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>
> ---
>  arch/arm64/boot/dts/broadcom/ns2-clock.dtsi | 105 ++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/broadcom/ns2.dtsi       |  81 +--------------------
>  2 files changed, 108 insertions(+), 78 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/broadcom/ns2-clock.dtsi
>
> diff --git a/arch/arm64/boot/dts/broadcom/ns2-clock.dtsi b/arch/arm64/boot/dts/broadcom/ns2-clock.dtsi
> new file mode 100644
> index 0000000..99009fd
> --- /dev/null
> +++ b/arch/arm64/boot/dts/broadcom/ns2-clock.dtsi
> @@ -0,0 +1,105 @@
> +/*
> + *  BSD LICENSE
> + *
> + *  Copyright (c) 2016 Broadcom.  All rights reserved.
> + *
> + *  Redistribution and use in source and binary forms, with or without
> + *  modification, are permitted provided that the following conditions
> + *  are met:
> + *
> + *    * Redistributions of source code must retain the above copyright
> + *      notice, this list of conditions and the following disclaimer.
> + *    * Redistributions in binary form must reproduce the above copyright
> + *      notice, this list of conditions and the following disclaimer in
> + *      the documentation and/or other materials provided with the
> + *      distribution.
> + *    * Neither the name of Broadcom Corporation nor the names of its
> + *      contributors may be used to endorse or promote products derived
> + *      from this software without specific prior written permission.
> + *
> + *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
> + *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> + *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
> + *  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
> + *  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
> + *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
> + *  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
> + *  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
> + *  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> + *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
> + * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + */
> +
> +#include <dt-bindings/clock/bcm-ns2.h>
> +
> +       osc: oscillator {
> +               #clock-cells = <0>;
> +               compatible = "fixed-clock";
> +               clock-frequency = <25000000>;
> +       };
> +
> +       lcpll_ddr: lcpll_ddr at 6501d058 {
> +               #clock-cells = <1>;
> +               compatible = "brcm,ns2-lcpll-ddr";
> +               reg = <0x6501d058 0x20>,
> +                     <0x6501c020 0x4>,
> +                     <0x6501d04c 0x4>;
> +               clocks = <&osc>;
> +               clock-output-names = "lcpll_ddr", "pcie_sata_usb",
> +                                    "ddr", "ddr_ch2_unused",
> +                                    "ddr_ch3_unused", "ddr_ch4_unused",
> +                                    "ddr_ch5_unused";
> +       };
> +
> +       lcpll_ports: lcpll_ports at 6501d078 {
> +               #clock-cells = <1>;
> +               compatible = "brcm,ns2-lcpll-ports";
> +               reg = <0x6501d078 0x20>,
> +                     <0x6501c020 0x4>,
> +                     <0x6501d054 0x4>;
> +               clocks = <&osc>;
> +               clock-output-names = "lcpll_ports", "wan", "rgmii",
> +                                    "ports_ch2_unused",
> +                                    "ports_ch3_unused",
> +                                    "ports_ch4_unused",
> +                                    "ports_ch5_unused";
> +       };
> +
> +       genpll_scr: genpll_scr at 6501d098 {
> +               #clock-cells = <1>;
> +               compatible = "brcm,ns2-genpll-scr";
> +               reg = <0x6501d098 0x32>,
> +                     <0x6501c020 0x4>,
> +                     <0x6501d044 0x4>;
> +               clocks = <&osc>;
> +               clock-output-names = "genpll_scr", "scr", "fs",
> +                                    "audio_ref", "scr_ch3_unused",
> +                                    "scr_ch4_unused", "scr_ch5_unused";
> +       };
> +
> +       iprocmed: iprocmed {
> +               #clock-cells = <0>;
> +               compatible = "fixed-factor-clock";
> +               clocks = <&genpll_scr BCM_NS2_GENPLL_SCR_SCR_CLK>;
> +               clock-div = <2>;
> +               clock-mult = <1>;
> +       };
> +
> +       iprocslow: iprocslow {
> +               #clock-cells = <0>;
> +               compatible = "fixed-factor-clock";
> +               clocks = <&genpll_scr BCM_NS2_GENPLL_SCR_SCR_CLK>;
> +               clock-div = <4>;
> +               clock-mult = <1>;
> +       };
> +
> +       genpll_sw: genpll_sw at 6501d0c4 {
> +               #clock-cells = <1>;
> +               compatible = "brcm,ns2-genpll-sw";
> +               reg = <0x6501d0c4 0x32>,
> +                     <0x6501c020 0x4>,
> +                     <0x6501d044 0x4>;
> +               clocks = <&osc>;
> +               clock-output-names = "genpll_sw", "rpe", "250", "nic",
> +                                    "chimp", "port", "sdio";
> +       };
> diff --git a/arch/arm64/boot/dts/broadcom/ns2.dtsi b/arch/arm64/boot/dts/broadcom/ns2.dtsi
> index 940ed52..0a92a68 100644
> --- a/arch/arm64/boot/dts/broadcom/ns2.dtsi
> +++ b/arch/arm64/boot/dts/broadcom/ns2.dtsi
> @@ -1,7 +1,7 @@
>  /*
>   *  BSD LICENSE
>   *
> - *  Copyright(c) 2015 Broadcom Corporation.  All rights reserved.
> + *  Copyright (c) 2015 Broadcom.  All rights reserved.

I am thinking the 2015 copyright notice should remain as is and a new
2016 notice should be added underneath.

Copyright (c) 2016 Broadcom.  All rights reserved.

>   *
>   *  Redistribution and use in source and binary forms, with or without
>   *  modification, are permitted provided that the following conditions
> @@ -110,33 +110,6 @@
>                                      <&A57_3>;
>         };
>
> -       clocks {
> -               #address-cells = <1>;
> -               #size-cells = <1>;
> -
> -               osc: oscillator {
> -                       #clock-cells = <0>;
> -                       compatible = "fixed-clock";
> -                       clock-frequency = <25000000>;
> -               };
> -
> -               iprocmed: iprocmed {
> -                       #clock-cells = <0>;
> -                       compatible = "fixed-factor-clock";
> -                       clocks = <&genpll_scr BCM_NS2_GENPLL_SCR_SCR_CLK>;
> -                       clock-div = <2>;
> -                       clock-mult = <1>;
> -               };
> -
> -               iprocslow: iprocslow {
> -                       #clock-cells = <0>;
> -                       compatible = "fixed-factor-clock";
> -                       clocks = <&genpll_scr BCM_NS2_GENPLL_SCR_SCR_CLK>;
> -                       clock-div = <4>;
> -                       clock-mult = <1>;
> -               };
> -       };
> -
>         pcie0: pcie at 20020000 {
>                 compatible = "brcm,iproc-pcie";
>                 reg = <0 0x20020000 0 0x1000>;
> @@ -217,6 +190,8 @@
>                 #size-cells = <1>;
>                 ranges = <0 0 0 0xffffffff>;
>
> +               #include "ns2-clock.dtsi"
> +
>                 dma0: dma at 61360000 {
>                         compatible = "arm,pl330", "arm,primecell";
>                         reg = <0x61360000 0x1000>;
> @@ -277,56 +252,6 @@
>                         mmu-masters;
>                 };
>
> -               lcpll_ddr: lcpll_ddr at 6501d058 {
> -                       #clock-cells = <1>;
> -                       compatible = "brcm,ns2-lcpll-ddr";
> -                       reg = <0x6501d058 0x20>,
> -                             <0x6501c020 0x4>,
> -                             <0x6501d04c 0x4>;
> -                       clocks = <&osc>;
> -                       clock-output-names = "lcpll_ddr", "pcie_sata_usb",
> -                                            "ddr", "ddr_ch2_unused",
> -                                            "ddr_ch3_unused", "ddr_ch4_unused",
> -                                            "ddr_ch5_unused";
> -               };
> -
> -               lcpll_ports: lcpll_ports at 6501d078 {
> -                       #clock-cells = <1>;
> -                       compatible = "brcm,ns2-lcpll-ports";
> -                       reg = <0x6501d078 0x20>,
> -                             <0x6501c020 0x4>,
> -                             <0x6501d054 0x4>;
> -                       clocks = <&osc>;
> -                       clock-output-names = "lcpll_ports", "wan", "rgmii",
> -                                            "ports_ch2_unused",
> -                                            "ports_ch3_unused",
> -                                            "ports_ch4_unused",
> -                                            "ports_ch5_unused";
> -               };
> -
> -               genpll_scr: genpll_scr at 6501d098 {
> -                       #clock-cells = <1>;
> -                       compatible = "brcm,ns2-genpll-scr";
> -                       reg = <0x6501d098 0x32>,
> -                             <0x6501c020 0x4>,
> -                             <0x6501d044 0x4>;
> -                       clocks = <&osc>;
> -                       clock-output-names = "genpll_scr", "scr", "fs",
> -                                            "audio_ref", "scr_ch3_unused",
> -                                            "scr_ch4_unused", "scr_ch5_unused";
> -               };
> -
> -               genpll_sw: genpll_sw at 6501d0c4 {
> -                       #clock-cells = <1>;
> -                       compatible = "brcm,ns2-genpll-sw";
> -                       reg = <0x6501d0c4 0x32>,
> -                             <0x6501c020 0x4>,
> -                             <0x6501d044 0x4>;
> -                       clocks = <&osc>;
> -                       clock-output-names = "genpll_sw", "rpe", "250", "nic",
> -                                            "chimp", "port", "sdio";
> -               };
> -
>                 crmu: crmu at 65024000 {
>                         compatible = "syscon";
>                         reg = <0x65024000 0x100>;
> --
> 1.9.1
>
