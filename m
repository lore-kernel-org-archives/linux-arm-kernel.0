From: sstabellini@kernel.org (Stefano Stabellini)
Date: Tue, 17 Jan 2017 14:20:54 -0800 (PST)
Subject: [RFC] Device memory mappings for Dom0 on ARM64 ACPI systems
Message-ID: <alpine.DEB.2.10.1701171309040.2347@sstabellini-ThinkPad-X260>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I would like to discuss with ARM64 and ACPI Linux maintainers the best
way to complete ACPI support in Linux for Dom0 on ARM64.


As a reminder, Xen can only parse static ACPI tables. It doesn't have a
bytecode interpreter. Xen maps all ACPI tables to Dom0, which parses
them as it does on native. Device memory is mapped in stage-2 by Xen
upon Dom0 request: a small driver under drivers/xen registers for
BUS_NOTIFY_ADD_DEVICE events, then calls xen_map_device_mmio, which
issues XENMEM_add_to_physmap_range hypercalls to Xen that creates the
appropriate stage-2 mappings.

This approach works well, but it breaks in few interesting cases.
Specifically, anything that requires a device memory mapping but it is
not a device, doesn't generate a BUS_NOTIFY_ADD_DEVICE event, thus, no
hypercalls to Xen are made. Examples are: ACPI OperationRegion (1), ECAM
(2), other memory regions described in static tables such as BERT (3).

What is the best way to map these regions in Dom0? I am going to
detail a few options that have been proposed and evaluated so far.


(2) and (3), being described by static tables, could be parsed by Xen
and mapped beforehand. However, this approach wouldn't work for (1).
Additionally, Xen and Linux versions can mix and match, so it is
possible, even likely, to run an old Xen and a new Dom0 on a new
platform. Xen might not know about a new ACPI table, while Linux might.
In this scenario, Xen wouldn't be able to map the region described in
the new table beforehand, but Linux would still try to access it. I
imagine that this problem could be work-arounded by blacklisting any
unknown static tables in Xen, but it seems suboptimal. (By blacklisting,
I mean removing them before starting Dom0.)

For this reason, and to use the same approach for (1), (2) and (3), it
looks like the best solution is for Dom0 to request the stage-2
mappings to Xen.  If we go down this route, what is the best way to do
it?


a) One option is to provide a Xen specific implementation of
acpi_os_ioremap in Linux. I think this is the cleanest approach, but
unfortunately, it doesn't cover cases where ioremap is used directly. (2)
is one of such cases, see
arch/arm64/kernel/pci.c:pci_acpi_setup_ecam_mapping and
drivers/pci/ecam.c:pci_ecam_create. (3) is another one of these cases,
see drivers/acpi/apei/bert.c:bert_init.

b) Otherwise, we could write an alternative implementation of ioremap
on arm64. The Xen specific ioremap would request a stage-2 mapping
first, then create the stage-1 mapping as usual. However, this means
issuing an hypercall for every ioremap call.

c) Finally, a third option is to create the stage-2 mappings seamlessly
in Xen upon Dom0 memory faults. Keeping in mind that SMMU and guest
pagetables are shared in the Xen hypervisor, this approach does not work
if one of the pages that need a stage-2 mapping is used as DMA target
before Dom0 accesses it. No SMMU mappings would be available for the
page yet, so the DMA transaction would fail. After Dom0 touches the
page, the DMA transaction would succeed. I don't know how likely is this
scenario to happen, but it seems fragile to rely on it.


For these reasons, I think that the best option might be b).
Do you agree? Did I miss anything? Do you have other suggestions?


Many thanks,

Stefano


References:
https://lists.xenproject.org/archives/html/xen-devel/2016-12/msg01693.html
https://lists.xenproject.org/archives/html/xen-devel/2016-12/msg02425.html
https://lists.xenproject.org/archives/html/xen-devel/2016-12/msg02531.html
