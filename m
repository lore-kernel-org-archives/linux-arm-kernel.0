From: robh@kernel.org (Rob Herring)
Date: Tue, 27 Oct 2015 14:19:40 -0500
Subject: [PATCH v12 7/8] Documentation: DT: Add HiSilicon PCIe host binding
In-Reply-To: <1445859350-26375-8-git-send-email-wangzhou1@hisilicon.com>
References: <1445859350-26375-1-git-send-email-wangzhou1@hisilicon.com>
 <1445859350-26375-8-git-send-email-wangzhou1@hisilicon.com>
Message-ID: <CAL_JsqKamKx8vVVv7qVZ8oyjXLem93B9dnJAxvvoRWd3XEc=7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 26, 2015 at 6:35 AM, Zhou Wang <wangzhou1@hisilicon.com> wrote:
> This patch adds related DTS binding document for HiSilicon PCIe host driver.
>
> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  .../bindings/arm/hisilicon/hisilicon.txt           | 17 +++++++++
>  .../devicetree/bindings/pci/hisilicon-pcie.txt     | 44 ++++++++++++++++++++++
>  2 files changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
>
> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
> index 3504dca..6ac7c00 100644
> --- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
> +++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
> @@ -171,6 +171,23 @@ Example:
>         };
>
>  -----------------------------------------------------------------------
> +Hisilicon HiP05 PCIe-SAS system controller
> +
> +Required properties:
> +- compatible : "hisilicon,pcie-sas-subctrl", "syscon";
> +- reg : Register address and size
> +
> +The HiP05 PCIe-SAS system controller is shared by PCIe and SAS controllers in
> +HiP05 Soc to implement some basic configurations.
> +
> +Example:
> +       /* for HiP05 PCIe-SAS system */
> +       pcie_sas: system_controller at 0xb0000000 {
> +               compatible = "hisilicon,pcie-sas-subctrl", "syscon";
> +               reg = <0xb0000000 0x10000>;
> +       };
> +
> +-----------------------------------------------------------------------
>  Hisilicon CPU controller
>
>  Required properties:
> diff --git a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
> new file mode 100644
> index 0000000..17c6ed9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
> @@ -0,0 +1,44 @@
> +HiSilicon PCIe host bridge DT description
> +
> +HiSilicon PCIe host controller is based on Designware PCI core.
> +It shares common functions with PCIe Designware core driver and inherits
> +common properties defined in
> +Documentation/devicetree/bindings/pci/designware-pci.txt.
> +
> +Additional properties are described here:
> +
> +Required properties:
> +- compatible: Should contain "hisilicon,hip05-pcie".
> +- reg: Should contain rc_dbi, config registers location and length.
> +- reg-names: Must include the following entries:
> +  "rc_dbi": controller configuration registers;
> +  "config": PCIe configuration space registers.
> +- msi-parent: Should be its_pcie which is an ITS receiving MSI interrupts.
> +- port-id: Should be 0, 1, 2 or 3.


> +
> +Optional properties:
> +- status: Either "ok" or "disabled".
> +- dma-coherent: Present if DMA operations are coherent.
> +
> +Example:
> +       pcie at 0xb0080000 {
> +               compatible = "hisilicon,hip05-pcie", "snps,dw-pcie";
> +               reg = <0 0xb0080000 0 0x10000>, <0x220 0x00000000 0 0x2000>;
> +               reg-names = "rc_dbi", "config";
> +               bus-range = <0  15>;
> +               msi-parent = <&its_pcie>;
> +               #address-cells = <3>;
> +               #size-cells = <2>;
> +               device_type = "pci";
> +               dma-coherent;
> +               ranges = <0x82000000 0 0x00000000 0x220 0x00000000 0 0x10000000>;
> +               num-lanes = <8>;
> +               port-id = <1>;
> +               #interrupts-cells = <1>;
> +               interrupts-map-mask = <0xf800 0 0 7>;
> +               interrupts-map = <0x0 0 0 1 &mbigen_pcie 1 10
> +                                 0x0 0 0 2 &mbigen_pcie 2 11
> +                                 0x0 0 0 3 &mbigen_pcie 3 12
> +                                 0x0 0 0 4 &mbigen_pcie 4 13>;
> +               status = "ok";
> +       };
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
