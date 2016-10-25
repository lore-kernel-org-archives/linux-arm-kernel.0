From: guohanjun@huawei.com (Hanjun Guo)
Date: Tue, 25 Oct 2016 23:09:15 +0800
Subject: [PATCH v3 00/14] ACPI platform MSI,
 interrupt producer/consumer and its example mbi-gen
Message-ID: <1477408169-22217-1-git-send-email-guohanjun@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanjun Guo <hanjun.guo@linaro.org>

This patch series is v3 of a previous posting,

https://lkml.org/lkml/2016/9/14/510

v2 -> v3:
	- Drop RFC tag
	- Rebase against v4.9-rc2 and Lorenzo's v6 of ACPI IORT ARM SMMU support [1]
	- Add 3 cleanup patches (patch 1, 2, 3)
	- Drop arch_init call patch from last version
	- Introduce a callback for platform device to set msi domain
	- Introduce a new API to get paltform device's domain instead of
	  reusing the PCI one in previous version
	- Add a patch to rework iort_node_get_id()

[1]: http://www.mail-archive.com/linux-kernel at vger.kernel.org/msg1251993.html

v2 -> v1:
	- Fix the bug of if multi Interrupt() resoures in single _PRS,
          we need to calculate all the irq numbers (I missed it in previous
          version);
	- Rebased on Marc's irq/irqchip-4.9 branch and Lorenzo's v5
	  SMMU patches (also Robin's SMMu patches)
	- Add patch irqchip: mbigen: promote mbigen init.

With platform msi support landed in the kernel, and the introduction
of IORT for GICv3 ITS (PCI MSI) [1], the framework for platform msi
is ready, this patch set add few patches to enable the ACPI platform
msi support.

For platform device connecting to ITS on arm platform, we have IORT
table with the named componant node to describe the mappings of paltform
device and ITS, so we can retrieve the dev id and find its parent
irqdomain (ITS) from IORT table (simlar with the ACPI ITS support).

With acpi platform msi supported, we add the ACPI support for irqchip
mbi-gen, which use this framework to form its stacked irqdomain, below
is the mbi-gen's topology in the system:


  | ---------------|                  |------------------|
  |                |       MSI        |                  |     wired interrupt(s)
  |       ITS      |<-----------------|   MBI-GEN        |<----------------------------- IO device(s)
  |                |                  |                  |<----------------------------- IO device(s)
  ------------------                  -------------------

So with ACPI platform MSI support, we can build the stacked domain for
mbi-gen which represented its mappings with the named componant in IORT,
but we still missing the connectings of devices to mbi-gen as in ACPI
world devices connect to main interrupt controller in MADT in default.

In ACPI 6.1, section 19.6.62, Interrupt Resource Descriptor Macro,

    Interrupt (ResourceUsage, EdgeLevel, ActiveLevel, Shared,
    ResourceSourceIndex, ResourceSource, DescriptorName)
    { InterruptList } => Buffer
    
For the arguement ResourceUsage and DescriptorName, which means:
    
ResourceUsage describes whether the device consumes the specified
interrupt ( ResourceConsumer ) or produces it for use by a child
device ( ResourceProducer ).
If nothing is specified, then ResourceConsumer is assumed.
    
DescriptorName evaluates to a name string which refers to the
entire resource descriptor.
    
So it can be used for devices connecting to a specific interrupt
prodcucer instead of the main interrupt controller in MADT, we can
define:

Interrupt(ResourceConsumer,..., "\_SB.IRQP") {12,14,....},

then get the interrupt producer with the full path name "\_SB.IRQP".

Thanks
Hanjun

Hanjun Guo (12):
  ACPI: ARM64: IORT: minor cleanup for iort_match_node_callback()
  irqchip: gic-v3-its: keep the head file include in alphabetic order
  ACPI: ARM64: IORT: add missing comment for iort_dev_find_its_id()
  irqchip: gicv3-its: platform-msi: refactor its_pmsi_prepare()
  ACPI: platform-msi: retrieve dev id from IORT
  irqchip: gicv3-its: platform-msi: refactor its_pmsi_init() to prepare
    for ACPI
  irqchip: gicv3-its: platform-msi: scan MADT to create platform msi
    domain
  ACPI: ARM64: IORT: rework iort_node_get_id()
  ACPI: platform: setup MSI domain for ACPI based platform device
  msi: platform: make platform_msi_create_device_domain() ACPI aware
  ACPI: irq: introduce interrupt producer
  irqchip: mbigen: Add ACPI support

Kefeng Wang (2):
  irqchip: mbigen: drop module owner
  irqchip: mbigen: introduce mbigen_of_create_domain()

 drivers/acpi/acpi_platform.c                  |  11 +++
 drivers/acpi/arm64/iort.c                     |  83 ++++++++++++++++++--
 drivers/acpi/gsi.c                            |  10 ++-
 drivers/acpi/resource.c                       |  85 ++++++++++++++------
 drivers/base/platform-msi.c                   |   3 +-
 drivers/base/platform.c                       |   3 +
 drivers/irqchip/irq-gic-v3-its-platform-msi.c | 106 +++++++++++++++++++------
 drivers/irqchip/irq-gic-v3-its.c              |   3 +-
 drivers/irqchip/irq-mbigen.c                  | 109 ++++++++++++++++++++++----
 include/acpi/acpi_bus.h                       |   1 +
 include/linux/acpi_iort.h                     |  11 +++
 include/linux/platform_device.h               |   3 +
 12 files changed, 346 insertions(+), 82 deletions(-)

-- 
1.7.12.4
