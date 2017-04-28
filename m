From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Apr 2017 14:41:59 +0200
Subject: [RFC/RFT PATCH 04/18] ARM: PCI: bios32: Convert PCI scan API to
 pci_scan_root_bus_bridge()
In-Reply-To: <20170426111809.19922-5-lorenzo.pieralisi@arm.com>
References: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
 <20170426111809.19922-5-lorenzo.pieralisi@arm.com>
Message-ID: <CAK8P3a3+fjMkq9C6bbz69yWGr6Qh6w2dPN3PJBXDxur8Qc02Kg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 26, 2017 at 1:17 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:

> @@ -483,10 +483,31 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
>
>                         if (hw->scan)
>                                 sys->bus = hw->scan(nr, sys);
> -                       else
> -                               sys->bus = pci_scan_root_bus_msi(parent,
> -                                       sys->busnr, hw->ops, sys,
> -                                       &sys->resources, hw->msi_ctrl);
> +                       else {
> +                               bridge = pci_alloc_host_bridge(0);
> +                               if (!bridge) {
> +                                       kfree(sys);
> +                                       break;
> +                               }

I think for consistency, the pci_alloc_host_bridge() here should replace
the sys=kzalloc(sizeof(struct pci_sys_data), GFP_KERNEL), and
the pci_sys_data made the bridge->private pointer.

      Arnd
