From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu, 24 Jul 2014 12:02:43 +0200
Subject: [RFC] PCI: pcie-designware: allow drivers as loadable modules
In-Reply-To: <5303286.K45Li7B92z@wuerfel>
References: <5303286.K45Li7B92z@wuerfel>
Message-ID: <1406196163.4590.21.camel@weser.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 24.07.2014, 11:17 +0200 schrieb Arnd Bergmann:
> From 0ee79c7451851a34e5a7c33eb6020befcdcb2b24 Mon Sep 17 00:00:00 2001
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Thu, 24 Jul 2014 11:12:48 +0200
> Subject: [PATCH] PCI: pcie-designware: allow drivers as loadable modules
> 
> The new pcie-spear13xx driver uses the pcie-designware library
> and in the current form it can be built as a loadable module.
> However, the functions it uses from the base driver are not exported,
> so this results in a build failure and a module that can never
> be loaded:
> 
> ERROR: "dw_pcie_host_init" [drivers/pci/host/pcie-spear13xx.ko] undefined!
> ERROR: "dw_handle_msi_irq" [drivers/pci/host/pcie-spear13xx.ko] undefined!
> ERROR: "dw_pcie_msi_init" [drivers/pci/host/pcie-spear13xx.ko] undefined!
> ERROR: "dw_pcie_cfg_write" [drivers/pci/host/pcie-spear13xx.ko] undefined!
> ERROR: "dw_pcie_cfg_read" [drivers/pci/host/pcie-spear13xx.ko] undefined!
> ERROR: "dw_pcie_setup_rc" [drivers/pci/host/pcie-spear13xx.ko] undefined!
> ERROR: "dw_pcie_link_up" [drivers/pci/host/pcie-spear13xx.ko] undefined!
> 
> If we want to allow loadable pcie-designware drivers, we have to
> export all those symbols and ensure none of them are marked as __init.
> This also requires making pci_assign_unassigned_resources available
> after boot.

My series "PCI: designware: init order/resource alloc fixes" removes
this function call from pcie-designware, so if it get's accepted this
should not be necessary.

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
