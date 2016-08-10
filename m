From: groeck@google.com (Guenter Roeck)
Date: Wed, 10 Aug 2016 15:10:12 -0700
Subject: [v10 PATCH 1/5] Documentation: bindings: add dt doc for Rockchip
 USB Type-C PHY
In-Reply-To: <1470785557-21974-2-git-send-email-zyw@rock-chips.com>
References: <1470785557-21974-1-git-send-email-zyw@rock-chips.com>
 <1470785557-21974-2-git-send-email-zyw@rock-chips.com>
Message-ID: <CABXOdTcgLHkxhk+LbBxe9wfmMBHVxt0NgStvG4MCcZKi_J2zLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 9, 2016 at 4:32 PM, Chris Zhong <zyw@rock-chips.com> wrote:
> This patch adds a binding that describes the Rockchip USB Type-C PHY
> for rk3399
>
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

>
> ---
>
> Changes in v10:
> - remove rockchip,uphy-dp-sel property
>
> Changes in v9:
> - change #phy-cells to 1
>
> Changes in v8: None
> Changes in v7: None
> Changes in v6:
> - add assigned-clocks and assigned-clock-rates
>
> Changes in v5: None
> Changes in v4:
> - add a #phy-cells node
>
> Changes in v3:
> - use compatible: rockchip,rk3399-typec-phy
> - use dashes instead of underscores.
>
> Changes in v2:
> - add some registers description
>
> Changes in v1:
> - add extcon node description
> - move the registers in phy driver
> - remove the suffix of reset
>
>  .../devicetree/bindings/phy/phy-rockchip-typec.txt | 82 ++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
>
> diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt b/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
> new file mode 100644
> index 0000000..bf372e6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
> @@ -0,0 +1,82 @@
> +* ROCKCHIP type-c PHY
> +---------------------
> +
> +Required properties:
> + - compatible : must be "rockchip,rk3399-typec-phy"
> + - reg: Address and length of the usb phy control register set
> + - rockchip,grf : phandle to the syscon managing the "general
> +   register files"
> + - clocks : phandle + clock specifier for the phy clocks
> + - clock-names : string, clock name, must be "tcpdcore", "tcpdphy-ref";
> + - assigned-clocks: main clock, should be <&cru SCLK_UPHY0_TCPDCORE> or
> +                   <&cru SCLK_UPHY1_TCPDCORE>;
> + - assigned-clock-rates : the phy core clk frequency, shall be: 50000000
> + - resets : a list of phandle + reset specifier pairs
> + - reset-names : string reset name, must be:
> +                "uphy", "uphy-pipe", "uphy-tcphy"
> + - extcon : extcon specifier for the Power Delivery
> + - #phy-cells: must be 1. create 2 PHY node:
> +               <&tcphy0 0> and <&tcphy1 0> for DP PHY.
> +               <&tcphy0 1> and <&tcphy1 1> for USB3 PHY.
> +   See ./phy-bindings.txt for details.
> +
> +Note, there are 2 type-c phys for RK3399, and they are almost identical, except
> +these registers(description below), every register node contains 3 sections:
> +offset, enable bit, write mask bit.
> + - rockchip,typec-conn-dir : the register of type-c connector direction,
> +   for type-c phy0, it must be <0xe580 0 16>;
> +   for type-c phy1, it must be <0xe58c 0 16>;
> + - rockchip,usb3tousb2-en : the register of type-c force usb3 to usb2 enable
> +   control.
> +   for type-c phy0, it must be <0xe580 3 19>;
> +   for type-c phy1, it must be <0xe58c 3 19>;
> + - rockchip,external-psm : the register of type-c phy external psm clock
> +   selection.
> +   for type-c phy0, it must be <0xe588 14 30>;
> +   for type-c phy1, it must be <0xe594 14 30>;
> + - rockchip,pipe-status : the register of type-c phy pipe status.
> +   for type-c phy0, it must be <0xe5c0 0 0>;
> +   for type-c phy1, it must be <0xe5c0 16 16>;
> +
> +Example:
> +       tcphy0: phy at ff7c0000 {
> +               compatible = "rockchip,rk3399-typec-phy";
> +               reg = <0x0 0xff7c0000 0x0 0x40000>;
> +               rockchip,grf = <&grf>;
> +               #phy-cells = <1>;
> +               extcon = <&fusb0>;
> +               clocks = <&cru SCLK_UPHY0_TCPDCORE>,
> +                        <&cru SCLK_UPHY0_TCPDPHY_REF>;
> +               clock-names = "tcpdcore", "tcpdphy-ref";
> +               assigned-clocks = <&cru SCLK_UPHY0_TCPDCORE>;
> +               assigned-clock-rates = <50000000>;
> +               resets = <&cru SRST_UPHY0>,
> +                        <&cru SRST_UPHY0_PIPE_L00>,
> +                        <&cru SRST_P_UPHY0_TCPHY>;
> +               reset-names = "uphy", "uphy-pipe", "uphy-tcphy";
> +               rockchip,typec-conn-dir = <0xe580 0 16>;
> +               rockchip,usb3tousb2-en = <0xe580 3 19>;
> +               rockchip,external-psm = <0xe588 14 30>;
> +               rockchip,pipe-status = <0xe5c0 0 0>;
> +       };
> +
> +       tcphy1: phy at ff800000 {
> +               compatible = "rockchip,rk3399-typec-phy";
> +               reg = <0x0 0xff800000 0x0 0x40000>;
> +               rockchip,grf = <&grf>;
> +               #phy-cells = <1>;
> +               extcon = <&fusb1>;
> +               clocks = <&cru SCLK_UPHY1_TCPDCORE>,
> +                        <&cru SCLK_UPHY1_TCPDPHY_REF>;
> +               clock-names = "tcpdcore", "tcpdphy-ref";
> +               assigned-clocks = <&cru SCLK_UPHY1_TCPDCORE>;
> +               assigned-clock-rates = <50000000>;
> +               resets = <&cru SRST_UPHY1>,
> +                        <&cru SRST_UPHY1_PIPE_L00>,
> +                        <&cru SRST_P_UPHY1_TCPHY>;
> +               reset-names = "uphy", "uphy-pipe", "uphy-tcphy";
> +               rockchip,typec-conn-dir = <0xe58c 0 16>;
> +               rockchip,usb3tousb2-en = <0xe58c 3 19>;
> +               rockchip,external-psm = <0xe594 14 30>;
> +               rockchip,pipe-status = <0xe5c0 16 16>;
> +       };
> --
> 1.9.1
>
