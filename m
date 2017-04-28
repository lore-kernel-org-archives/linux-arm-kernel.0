From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Apr 2017 14:53:37 +0200
Subject: [RFC/RFT PATCH 10/18] PCI: rcar: Convert PCI scan API to
 pci_scan_root_bus_bridge()
In-Reply-To: <20170426111809.19922-11-lorenzo.pieralisi@arm.com>
References: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
 <20170426111809.19922-11-lorenzo.pieralisi@arm.com>
Message-ID: <CAK8P3a0_VN1YoSqQ08YHcezRaKCE+2XwVpKfGjiok1qKxT+s1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 26, 2017 at 1:18 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> The introduction of pci_scan_root_bus_bridge() provides a PCI core
> API to scan a PCI root bus backed by an already initialized
> struct pci_host_bridge object, which simplifies the bus scan
> interface and makes the PCI scan root bus interface easier to
> generalize as members are added to the struct pci_host_bridge().
>
> Convert PCI rcar host code to pci_scan_root_bus_bridge() to
> improve the PCI root bus scanning interface.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Simon Horman <horms@verge.net.au>
> ---
>  drivers/pci/host/pcie-rcar.c | 28 ++++++++++++++++++----------
>  1 file changed, 18 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
> index cb07c45..051b4db 100644
> --- a/drivers/pci/host/pcie-rcar.c
> +++ b/drivers/pci/host/pcie-rcar.c
> @@ -451,27 +451,35 @@ static int rcar_pcie_enable(struct rcar_pcie *pcie)
>  {
>         struct device *dev = pcie->dev;
>         struct pci_bus *bus, *child;
> -       LIST_HEAD(res);
> +       struct pci_host_bridge *bridge;
> +       int ret;
> +
> +       bridge = pci_alloc_host_bridge(0);
> +       if (!bridge)
> +               return -ENOMEM;

The pci_alloc_host_bridge() here should also be moved into
rcare_pcie_probe(), replacing the devm_kzalloc there.

        Arnd
