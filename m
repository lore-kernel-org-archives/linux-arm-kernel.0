From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Mon, 19 Nov 2018 21:12:26 +0100
Subject: [PATCH v5 1/2] dt-bindings: PCI: meson: add DT bindings for
 Amlogic Meson PCIe controller
In-Reply-To: <1539049990-30810-2-git-send-email-hanjie.lin@amlogic.com>
References: <1539049990-30810-1-git-send-email-hanjie.lin@amlogic.com>
 <1539049990-30810-2-git-send-email-hanjie.lin@amlogic.com>
Message-ID: <CAFBinCCChD-phwyb3hSzAjBmy09g35ijQa_chJX5HufuVnPjaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Hanjie, Hello Yue,

sorry for being late with my comment

On Tue, Oct 9, 2018 at 3:53 AM Hanjie Lin <hanjie.lin@amlogic.com> wrote:
>
> From: Yue Wang <yue.wang@amlogic.com>
>
> The Amlogic Meson PCIe host controller is based on the Synopsys DesignWare
> PCI core. This patch adds documentation for the DT bindings in Meson PCIe
> controller.
>
> Signed-off-by: Yue Wang <yue.wang@amlogic.com>
> Signed-off-by: Hanjie Lin <hanjie.lin@amlogic.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/pci/amlogic,meson-pcie.txt | 70 ++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
>
> diff --git a/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt b/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
> new file mode 100644
> index 0000000..12b18f8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
> @@ -0,0 +1,70 @@
> +Amlogic Meson AXG DWC PCIE SoC controller
> +
> +Amlogic Meson PCIe host controller is based on the Synopsys DesignWare PCI core.
> +It shares common functions with the PCIe DesignWare core driver and
> +inherits common properties defined in
> +Documentation/devicetree/bindings/pci/designware-pci.txt.
> +
> +Additional properties are described here:
> +
> +Required properties:
> +- compatible:
> +       should contain "amlogic,axg-pcie" to identify the core.
> +- reg:
> +       should contain the configuration address space.
> +- reg-names: Must be
> +       - "elbi"        External local bus interface registers
> +       - "cfg"         Meson specific registers
> +       - "phy"         Meson PCIE PHY registers
is this only the PCIe PHY registers or is it the registers of the PHY
which supports USB3.0 and PCIe?
buildroot_openlinux_kernel_4.9_fbdev_20180706 uses the following
registers in the pcie_A node for the "phy" registers:
0x0 0xff646000 0x0 0x2000
while the usb3_phy_v2 node uses:
phy-reg = <0xff646000>;

> +       - "config"      PCIe configuration space
> +- reset-gpios: The GPIO to generate PCIe PERST# assert and deassert signal.
> +- clocks: Must contain an entry for each entry in clock-names.
> +- clock-names: Must include the following entries:
> +       - "pclk"       PCIe GEN 100M PLL clock
> +       - "port"       PCIe_x(A or B) RC clock gate
> +       - "general"    PCIe Phy clock
> +       - "mipi"       PCIe_x(A or B) 100M ref clock gate
> +- resets: phandle to the reset lines.
> +- reset-names: must contain "phy" "port" and "apb"
> +       - "phy"         Share PHY reset
> +       - "port"        Port A or B reset
> +       - "apb"         Share APB reset
> +- device_type:
> +       should be "pci". As specified in designware-pcie.txt
> +
> +
> +Example configuration:
> +
> +       pcie: pcie at f9800000 {
> +                       compatible = "amlogic,axg-pcie", "snps,dw-pcie";
> +                       reg = <0x0 0xf9800000 0x0 0x400000
> +                                       0x0 0xff646000 0x0 0x2000
> +                                       0x0 0xff644000 0x0 0x2000
> +                                       0x0 0xf9f00000 0x0 0x100000>;
> +                       reg-names = "elbi", "cfg", "phy", "config";
is the order of the reg-names correct?
buildroot_openlinux_kernel_4.9_fbdev_20180706 uses 0xff646000 for the
PHY (instead of 0xff646000) in mesong12a.dtsi and mesong12b.dtsi


Regards
Martin
