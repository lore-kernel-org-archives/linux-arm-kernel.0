From: dianders@chromium.org (Doug Anderson)
Date: Thu, 14 Aug 2014 08:47:23 -0700
Subject: [PATCH] ARM: dts: Add sdio0 and sdio1 to the rk3288
In-Reply-To: <1407995360-26009-1-git-send-email-addy.ke@rock-chips.com>
References: <1407995360-26009-1-git-send-email-addy.ke@rock-chips.com>
Message-ID: <CAD=FV=XxF0zTVtV75FRDbiVq1MCrWpXak-vkP0iofPXXtE_OHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Addy,

On Wed, Aug 13, 2014 at 10:49 PM, Addy Ke <addy.ke@rock-chips.com> wrote:
> Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
> ---
>  arch/arm/boot/dts/rk3288.dtsi | 76 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
>
> diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
> index 7a9173d..a440869 100644
> --- a/arch/arm/boot/dts/rk3288.dtsi
> +++ b/arch/arm/boot/dts/rk3288.dtsi
> @@ -120,6 +120,32 @@
>                 //fifo-depth = <0x100>;
>         };
>
> +       sdio0: dwmmc at ff0d0000 {
> +               compatible = "rockchip,rk3288-dw-mshc";
> +               reg = <0xff0d0000 0x4000>;
> +               interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               clocks = <&cru HCLK_SDIO0>, <&cru SCLK_SDIO0>;
> +               clock-names = "biu", "ciu";
> +
> +               fifo-depth = <0x100>;
> +       };

Please repost and match what's in Heiko's "wip/v3.18-next/dts" tree
for the other dwmmc controllers.  Specifically:

* No more #address-cells and #size-cells.
* By default status = "disabled".
* Sort properties alphabetically.


> +
> +       sdio1: dwmmc at ff0e0000 {
> +               compatible = "rockchip,rk3288-dw-mshc";
> +               reg = <0xff0e0000 0x4000>;
> +               interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               clocks = <&cru HCLK_SDIO1>, <&cru SCLK_SDIO1>;
> +               clock-names = "biu", "ciu";
> +
> +               fifo-depth = <0x100>;
> +       };
> +
>         emmc: dwmmc at ff0f0000 {
>                 compatible = "rockchip,rk3288-dw-mshc";
>                 reg = <0xff0f0000 0x4000>;
> @@ -589,6 +615,56 @@
>                         };
>                 };
>
> +               sdio0 {
> +                       sdio0_clk: sdio0-clk {
> +                               rockchip,pins = <4 25 RK_FUNC_1 &pcfg_pull_none>;
> +                       };
> +
> +                       sdio0_cmd: sdio0-cmd {
> +                               rockchip,pins = <4 24 RK_FUNC_1 &pcfg_pull_up>;
> +                       };
> +
> +                       sdio0_pwr: sdio0-pwr {
> +                               rockchip,pins = <4 28 RK_FUNC_1 &pcfg_pull_up>;
> +                       };
> +
> +                       sdio0_bus1: sdio0-bus1 {
> +                               rockchip,pins = <4 20 RK_FUNC_1 &pcfg_pull_up>;
> +                       };
> +
> +                       sdio0_bus4: sdio0-bus4 {
> +                               rockchip,pins = <4 20 RK_FUNC_1 &pcfg_pull_up>,
> +                                               <4 21 RK_FUNC_1 &pcfg_pull_up>,
> +                                               <4 22 RK_FUNC_1 &pcfg_pull_up>,
> +                                               <4 23 RK_FUNC_1 &pcfg_pull_up>;
> +                       };

Can you add the card detect line here?  How about the write protect
line?  What about the "bkpwr" and "int" lines?


> +               };
> +
> +               sdio1 {
> +                       sdio1_clk: sdio1-clk {
> +                               rockchip,pins = <4 7 RK_FUNC_4 &pcfg_pull_none>;

This requires that <https://patchwork.kernel.org/patch/4701721/> land
in order to compile.  Since that hasn't landed you should explicitly
reference it.



> +                       };
> +
> +                       sdio1_cmd: sdio1-cmd {
> +                               rockchip,pins = <4 6 RK_FUNC_4 &pcfg_pull_up>;
> +                       };
> +
> +                       sdio1_pwr: sdio1-pwr {
> +                               rockchip,pins = <4 9 RK_FUNC_4 &pcfg_pull_up>;
> +                       };
> +
> +                       sdio1_bus1: sdio1-bus1 {
> +                               rockchip,pins = <4 24 RK_FUNC_4 &pcfg_pull_up>;

This is probably wrong and should be <3 24 ...>, not <4 24 ...>.

> +                       };
> +
> +                       sdio1_bus4: sdio1-bus4 {
> +                               rockchip,pins = <3 24 RK_FUNC_4 &pcfg_pull_up>,
> +                                               <3 25 RK_FUNC_4 &pcfg_pull_up>,
> +                                               <3 26 RK_FUNC_4 &pcfg_pull_up>,
> +                                               <3 27 RK_FUNC_4 &pcfg_pull_up>;
> +                       };
> +               };
> +
>                 emmc {
>                         emmc_clk: emmc-clk {
>                                 rockchip,pins = <3 18 RK_FUNC_2 &pcfg_pull_none>;
