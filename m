From: suravee.suthikulpanit@amd.com (Suravee Suthikulpanit)
Date: Fri, 12 Sep 2014 05:13:51 -0500
Subject: [PATCH v10 09/10] PCI: Assign unassigned bus resources in
 pci_scan_root_bus()
In-Reply-To: <1410184472-17630-10-git-send-email-Liviu.Dudau@arm.com>
References: <1410184472-17630-1-git-send-email-Liviu.Dudau@arm.com>
 <1410184472-17630-10-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <5412C75F.30207@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/8/2014 8:54 AM, Liviu Dudau wrote:
> If the firmware has not assigned all the bus resources and
> we are not just probing the PCIe busses, it makes sense to
> assign the unassigned resources in pci_scan_root_bus().
>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> ---
>   drivers/pci/probe.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index ef891d2..508cf61 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1953,6 +1953,9 @@ struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
>   	if (!found)
>   		pci_bus_update_busn_res_end(b, max);
>
> +	if (!pci_has_flag(PCI_PROBE_ONLY))
> +		pci_assign_unassigned_bus_resources(b);
> +
>   	pci_bus_add_devices(b);
>   	return b;
>   }
>

Liviu,

Besides the check for PCI_PROBE_ONLY here, I think we also need to avoid calling
"pci_enable_resources()" in the "driver/pci/pci.c: pcibios_enable_device()" for
PCI_PROBE_ONLY mode since the resource is not assigned by Linux. Otherwise, the
"drivers/pci/setup-res.c: pci_enable_resource()" would fail w/ error:

     can't enable device: BAR ..... not assigned

Actually, in "arch/arm/kernel/bios32.c:", the weak "pcibios_enable_device()" function
also has the check for PCI_PROBE_ONLY mode before calling pci_enable_resources().

Thanks,

Suravee
