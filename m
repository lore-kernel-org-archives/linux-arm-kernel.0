From: ryder.lee@mediatek.com (Ryder Lee)
Date: Wed, 14 Mar 2018 09:41:49 +0800
Subject: [PATCH v1] arm: dts: mt7623: add PCIe related nodes
In-Reply-To: <4e567be2546f90ef62a5df0e957e8a014e460cde.1518576282.git.ryder.lee@mediatek.com>
References: <4e567be2546f90ef62a5df0e957e8a014e460cde.1518576282.git.ryder.lee@mediatek.com>
Message-ID: <1520991709.12028.3.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,

Just a gentle ping on this patch.

Thanks

On Wed, 2018-02-14 at 11:27 +0800, Ryder Lee (???) wrote:
> This patch adds some device nodes for the PCIe function block and updates
> related pinmux.
> 
> Moreover, we add interrupt-map properties in both parent and children as
> the chip only has one IRQ per slot that is connected to all INTx and get
> propagated through the bridges and it also represents the root ports own
> interrupts.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---
> 
> Sorry to send v1 in such a rush. Somehow I forgot to add something in previous version.
> 
> changes since v1:
>  - enable device nodes - pcie0_phy & pcie2_phy
>  - fix dtc warning: Warning (pci_bridge): Node /pcie-controller at 1a140000 node name is not "pci" or "pcie"
> ---
>  arch/arm/boot/dts/mt7623.dtsi                 | 105 ++++++++++++++++++++++++++
>  arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts |  30 ++++++++
>  2 files changed, 135 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
> index 629c92b..137ce99 100644
> --- a/arch/arm/boot/dts/mt7623.dtsi
> +++ b/arch/arm/boot/dts/mt7623.dtsi
> @@ -667,6 +667,111 @@
>                 #reset-cells = <1>;
>         };
> 
> +       pcie: pcie at 1a140000 {
> +               compatible = "mediatek,mt7623-pcie";
> +               device_type = "pci";
> +               reg = <0 0x1a140000 0 0x1000>, /* PCIe shared registers */
> +                     <0 0x1a142000 0 0x1000>, /* Port0 registers */
> +                     <0 0x1a143000 0 0x1000>, /* Port1 registers */
> +                     <0 0x1a144000 0 0x1000>; /* Port2 registers */
> +               reg-names = "subsys", "port0", "port1", "port2";
> +               #address-cells = <3>;
> +               #size-cells = <2>;
> +               #interrupt-cells = <1>;
> +               interrupt-map-mask = <0xf800 0 0 0>;
> +               interrupt-map = <0x0000 0 0 0 &sysirq GIC_SPI 193 IRQ_TYPE_LEVEL_LOW>,
> +                               <0x0800 0 0 0 &sysirq GIC_SPI 194 IRQ_TYPE_LEVEL_LOW>,
> +                               <0x1000 0 0 0 &sysirq GIC_SPI 195 IRQ_TYPE_LEVEL_LOW>;
> +               clocks = <&topckgen CLK_TOP_ETHIF_SEL>,
> +                        <&hifsys CLK_HIFSYS_PCIE0>,
> +                        <&hifsys CLK_HIFSYS_PCIE1>,
> +                        <&hifsys CLK_HIFSYS_PCIE2>;
> +               clock-names = "free_ck", "sys_ck0", "sys_ck1", "sys_ck2";
> +               resets = <&hifsys MT2701_HIFSYS_PCIE0_RST>,
> +                        <&hifsys MT2701_HIFSYS_PCIE1_RST>,
> +                        <&hifsys MT2701_HIFSYS_PCIE2_RST>;
> +               reset-names = "pcie-rst0", "pcie-rst1", "pcie-rst2";
> +               phys = <&pcie0_port PHY_TYPE_PCIE>,
> +                      <&pcie1_port PHY_TYPE_PCIE>,
> +                      <&u3port1 PHY_TYPE_PCIE>;
> +               phy-names = "pcie-phy0", "pcie-phy1", "pcie-phy2";
> +               power-domains = <&scpsys MT2701_POWER_DOMAIN_HIF>;
> +               bus-range = <0x00 0xff>;
> +               status = "disabled";
> +               ranges = <0x81000000 0 0x1a160000 0 0x1a160000 0 0x00010000
> +                         0x83000000 0 0x60000000 0 0x60000000 0 0x10000000>;
> +
> +               pcie at 0,0 {
> +                       reg = <0x0000 0 0 0 0>;
> +                       #address-cells = <3>;
> +                       #size-cells = <2>;
> +                       #interrupt-cells = <1>;
> +                       interrupt-map-mask = <0 0 0 0>;
> +                       interrupt-map = <0 0 0 0 &sysirq GIC_SPI 193 IRQ_TYPE_LEVEL_LOW>;
> +                       ranges;
> +                       num-lanes = <1>;
> +                       status = "disabled";
> +               };
> +
> +               pcie at 1,0 {
> +                       reg = <0x0800 0 0 0 0>;
> +                       #address-cells = <3>;
> +                       #size-cells = <2>;
> +                       #interrupt-cells = <1>;
> +                       interrupt-map-mask = <0 0 0 0>;
> +                       interrupt-map = <0 0 0 0 &sysirq GIC_SPI 194 IRQ_TYPE_LEVEL_LOW>;
> +                       ranges;
> +                       num-lanes = <1>;
> +                       status = "disabled";
> +               };
> +
> +               pcie at 2,0 {
> +                       reg = <0x1000 0 0 0 0>;
> +                       #address-cells = <3>;
> +                       #size-cells = <2>;
> +                       #interrupt-cells = <1>;
> +                       interrupt-map-mask = <0 0 0 0>;
> +                       interrupt-map = <0 0 0 0 &sysirq GIC_SPI 195 IRQ_TYPE_LEVEL_LOW>;
> +                       ranges;
> +                       num-lanes = <1>;
> +                       status = "disabled";
> +               };
> +       };
> +
> +       pcie0_phy: pcie-phy at 1a149000 {
> +               compatible = "mediatek,generic-tphy-v1";
> +               reg = <0 0x1a149000 0 0x0700>;
> +               #address-cells = <2>;
> +               #size-cells = <2>;
> +               ranges;
> +               status = "disabled";
> +
> +               pcie0_port: pcie-phy at 1a149900 {
> +                       reg = <0 0x1a149900 0 0x0700>;
> +                       clocks = <&clk26m>;
> +                       clock-names = "ref";
> +                       #phy-cells = <1>;
> +                       status = "okay";
> +               };
> +       };
> +
> +       pcie1_phy: pcie-phy at 1a14a000 {
> +               compatible = "mediatek,generic-tphy-v1";
> +               reg = <0 0x1a14a000 0 0x0700>;
> +               #address-cells = <2>;
> +               #size-cells = <2>;
> +               ranges;
> +               status = "disabled";
> +
> +               pcie1_port: pcie-phy at 1a14a900 {
> +                       reg = <0 0x1a14a900 0 0x0700>;
> +                       clocks = <&clk26m>;
> +                       clock-names = "ref";
> +                       #phy-cells = <1>;
> +                       status = "okay";
> +               };
> +       };
> +
>         usb1: usb at 1a1c0000 {
>                 compatible = "mediatek,mt7623-xhci",
>                              "mediatek,mt8173-xhci";
> diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> index 7bf5aa2..3efecc5 100644
> --- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> +++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> @@ -209,6 +209,28 @@
>         vqmmc-supply = <&mt6323_vio18_reg>;
>  };
> 
> +&pcie {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pcie_default>;
> +       status = "okay";
> +
> +       pcie at 0,0 {
> +               status = "okay";
> +       };
> +
> +       pcie at 1,0 {
> +               status = "okay";
> +       };
> +};
> +
> +&pcie0_phy {
> +       status = "okay";
> +};
> +
> +&pcie1_phy {
> +       status = "okay";
> +};
> +
>  &pio {
>         cir_pins_a:cir at 0 {
>                 pins_cir {
> @@ -376,6 +398,14 @@
>                 };
>         };
> 
> +       pcie_default: pcie_pin_default {
> +               pins_cmd_dat {
> +                       pinmux = <MT7623_PIN_208_AUD_EXT_CK1_FUNC_PCIE0_PERST_N>,
> +                                <MT7623_PIN_209_AUD_EXT_CK2_FUNC_PCIE1_PERST_N>;
> +                       bias-disable;
> +               };
> +       };
> +
>         pwm_pins_a: pwm at 0 {
>                 pins_pwm {
>                         pinmux = <MT7623_PIN_203_PWM0_FUNC_PWM0>,
> --
> 1.9.1
> 
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
