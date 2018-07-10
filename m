From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 10 Jul 2018 10:31:14 +0900
Subject: [PATCH 1/2] ARM: dts: arria10: update NAND clocking
In-Reply-To: <1531176063-30140-1-git-send-email-dinguyen@kernel.org>
References: <1531176063-30140-1-git-send-email-dinguyen@kernel.org>
Message-ID: <CAK7LNARAVSK5VY=_RfO2PXJCAnXJN3sXoAY=ijSwVojeo=c66w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-07-10 7:41 GMT+09:00 Dinh Nguyen <dinguyen@kernel.org>:
> The NAND IP needs 2 clocks(nand_x_clk and nand_clk). This patch adds a
> nand_x_clk, which is derived from the nand_clk, but has a fixed divider
> of 4.
>
> Update the NAND node to use the additional clock.
>
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
>  arch/arm/boot/dts/socfpga_arria10.dtsi | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
> index a4dcb68..558b5ea 100644
> --- a/arch/arm/boot/dts/socfpga_arria10.dtsi
> +++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
> @@ -377,13 +377,21 @@
>                                                 clk-gate = <0xC8 11>;
>                                         };
>
> -                                       nand_clk: nand_clk {
> +                                       nand_x_clk: nand_x_clk {
>                                                 #clock-cells = <0>;
>                                                 compatible = "altr,socfpga-a10-gate-clk";
>                                                 clocks = <&l4_mp_clk>;
>                                                 clk-gate = <0xC8 10>;
>                                         };
>
> +                                       nand_clk: nand_clk {
> +                                               #clock-cells = <0>;
> +                                               compatible = "altr,socfpga-a10-gate-clk";
> +                                               clocks = <&nand_x_clk>;
> +                                               fixed-divider = <4>;
> +                                               clk-gate = <0xC8 10>;
> +                                       };
> +
>                                         spi_m_clk: spi_m_clk {
>                                                 #clock-cells = <0>;
>                                                 compatible = "altr,socfpga-a10-gate-clk";
> @@ -650,7 +658,8 @@
>                         reg-names = "nand_data", "denali_reg";
>                         interrupts = <0 99 4>;
>                         dma-mask = <0xffffffff>;
> -                       clocks = <&nand_clk>;
> +                       clocks = <&nand_clk>, <&nand_x_clk>;
> +                       clock-names = "nand", "nand_x";


Doesn't SOCFPGA really need the ECC clock?

SOCFPGA has HW ECC engine.


I suggested to add ECC clock, and Richard agreed.
https://lkml.org/lkml/2018/6/22/573





>                         status = "disabled";
>                 };
>
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
