From: robherring2@gmail.com (Rob Herring)
Date: Wed, 26 Mar 2014 09:45:13 -0500
Subject: [RFC PATCH 02/12] pci: host: pcie-dra7xx: add support for
 pcie-dra7xx controller
In-Reply-To: <1395842272-15267-3-git-send-email-kishon@ti.com>
References: <1395842272-15267-1-git-send-email-kishon@ti.com>
 <1395842272-15267-3-git-send-email-kishon@ti.com>
Message-ID: <CAL_JsqKeQvbU24V2-3KQuFoLwkL31DEcEEVDenfTA0P++Hn_fQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 26, 2014 at 8:57 AM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> Added support for pcie controller in dra7xx. This driver re-uses
> the designware core code that is already present in kernel.
>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  Documentation/devicetree/bindings/pci/ti-pci.txt |   35 ++
>  drivers/pci/host/Kconfig                         |   10 +
>  drivers/pci/host/Makefile                        |    1 +
>  drivers/pci/host/pcie-dra7xx.c                   |  411 ++++++++++++++++++++++
>  4 files changed, 457 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/ti-pci.txt
>  create mode 100644 drivers/pci/host/pcie-dra7xx.c
>
> diff --git a/Documentation/devicetree/bindings/pci/ti-pci.txt b/Documentation/devicetree/bindings/pci/ti-pci.txt
> new file mode 100644
> index 0000000..0528c47
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/ti-pci.txt
> @@ -0,0 +1,35 @@
> +TI PCI Controllers
> +
> +PCIe Designware Controller
> +This node should have the properties described in "designware-pcie.txt".
> + - compatible: Should be "ti,dra7xx-pcie""
> + - reg : Address and length of the register set for the device.
> + - phys : the phandle for the PHY device (used by generic PHY framework)
> + - phy-names : the names of the PHY corresponding to the PHYs present in the
> +   *phy* phandle.
> + - resets: phandle used if reset is handled be soc

s/be/by/ ?

> + - reset-names: name given to the phandle
> + - ti,device-type: Should be 1 - EP TYPE, 2 - LEG EP TYPE OR 3 - RC TYPE

I don't think this makes sense. I'd imagine we'd need the binding to
look quite a bit different if endpoint mode was actually supported. I
think I would start defining endpoint mode with a different compatible
string and go from there.

> +
> +Example:
> +pcie at 51000000 {
> +       compatible = "ti,dra7xx-pcie";
> +       reg = <0x51002000 0x14c>, <0x51000000 0x2000>, <0x4A002540 0x1f>, <0x4A003c24 0x4>, <0x4AE07310 0x4>;

This is different number of entries from your actual dts. You need to
define how many reg entries, what they are, and the order.

Rob
