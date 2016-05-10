From: rafael@kernel.org (Rafael J. Wysocki)
Date: Tue, 10 May 2016 19:54:17 +0200
Subject: [PATCH V7 08/11] pci, acpi: Support for ACPI based generic PCI
 host controller
In-Reply-To: <1462893601-8937-9-git-send-email-tn@semihalf.com>
References: <1462893601-8937-1-git-send-email-tn@semihalf.com>
 <1462893601-8937-9-git-send-email-tn@semihalf.com>
Message-ID: <CAJZ5v0hp1+D4Hd+6EQeZb_WNn6JK=55h8AAOwAWYX2CwATP0dw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 10, 2016 at 5:19 PM, Tomasz Nowicki <tn@semihalf.com> wrote:
> This patch is going to implement generic PCI host controller for
> ACPI world, similar to what pci-host-generic.c driver does for DT world.
>
> All such drivers, which we have seen so far, were implemented within
> arch/ directory since they had some arch assumptions (x86 and ia64).
> However, they all are doing similar thing, so it makes sense to find
> some common code and abstract it into the generic driver.
>
> In order to handle PCI config space regions properly, we define new
> MCFG interface which does sanity checks on MCFG table and keeps its
> root pointer. User is able to lookup MCFG regions based on that root
> pointer and specified domain:bus_start:bus_end touple. We are using
> pci_mmcfg_late_init old prototype to avoid another function name.
>
> The implementation of pci_acpi_scan_root() looks up the MCFG entries
> and sets up a new mapping (regions are not mapped until host controller ask
> for it). Generic PCI functions are used for accessing config space.
> Driver selects PCI_ECAM and uses functions from drivers/pci/ecam.h
> to create and access ECAM mappings.
>
> As mentioned in Kconfig help section, ACPI_PCI_HOST_GENERIC choice
> should be made on a per-architecture basis.
>
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> Signed-off-by: Jayachandran C <jchandra@broadcom.com>
> ---
>  drivers/acpi/Kconfig            |   8 +++
>  drivers/acpi/Makefile           |   1 +
>  drivers/acpi/pci_mcfg.c         |  97 ++++++++++++++++++++++++++
>  drivers/acpi/pci_root_generic.c | 149 ++++++++++++++++++++++++++++++++++++++++

Why do we need a new file?  Would there be any problem with adding
that code to pci_root.c?
