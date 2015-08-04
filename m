From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 4 Aug 2015 18:49:56 -0500
Subject: [PATCH v4 1/3] PCI: generic: remove dependency on hw_pci
In-Reply-To: <1438721620-15493-1-git-send-email-jchandra@broadcom.com>
References: <1438721620-15493-1-git-send-email-jchandra@broadcom.com>
Message-ID: <20150804234956.GF17327@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 05, 2015 at 02:23:38AM +0530, Jayachandran C wrote:
> The current code in pci-host-generic.c uses pci_common_init_dev()
> from arm architecture to do some part of the PCI setup, and this
> prevents it from being used with arm64 architecture.
> 
> The part of pci_common_init_dev() that is really needed by
> pci-host-generic.c is very limited and can be done in the same
> file without using hw_pci API of ARM. The ARM platform requires
> a pci_sys_data as sysdata for the PCI bus, this can be handled by
> setting up gen_pci to have a pci_sys_data variable as the first
> element.
> 
> Signed-off-by: Jayachandran C <jchandra@broadcom.com>
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Tested-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Tested-by: Pavel Fedin <p.fedin@samsung.com>

I applied all three of these to my pci/enumeration branch for v4.3.

I made a few changes, the most important being to call
pcie_bus_configure_settings() before pci_bus_add_devices(), because drivers
may claim devices in pci_bus_add_devices(), and the PCI core shouldn't
touch devices after drivers claim them.

I dropped the acks and tested-by because of that change, but I'll happily
add them back if Lorenzo and Pavel confirm.  The patches are here if you
want to review/test them:

https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/enumeration

I'm sure the other patches on that branch will need some tweaks, too, so I
don't have any problem with updating these.

Bjorn
