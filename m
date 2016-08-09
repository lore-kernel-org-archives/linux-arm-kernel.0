From: guohanjun@huawei.com (Hanjun Guo)
Date: Tue, 9 Aug 2016 15:05:56 +0800
Subject: [RFC PATCH 00/10] ACPI platform MSI,
 interrupt producer and its example mbi-gen
Message-ID: <1470726366-40809-1-git-send-email-guohanjun@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanjun Guo <hanjun.guo@linaro.org>

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

This is the RFC version and we still needs to address:
 - the code is still in drivers/acpi/iort.c which will move to
   drivers/acpi/arm64 in the future;

 - Retrieve the dev id from IORT which require the req_id but
   for platform device we don't need that, so we may need to
   add proper API for platform device;

 - Setting device's MSI domain's code is just plugged into the platform
   driver core code, which may need better solution.

Comments are warmly welcomed!

Thanks
Hanjun


Hanjun Guo (8):
  irqchip: gicv3-its: platform-msi: refactor its_pmsi_prepare()
  ACPI: platform-msi: retrieve dev id from IORT
  irqchip: gicv3-its: platform-msi: refactor its_pmsi_init() to prepare
    for ACPI
  irqchip: gicv3-its: platform-msi: scan MADT to create platform msi
    domain
  ACPI: platform: setup MSI domain for ACPI based platform device
  msi: platform: make platform_msi_create_device_domain() ACPI aware
  ACPI: irq: introduce interrupt producer
  irqchip: mbigen: Add ACPI support

Kefeng Wang (2):
  irqchip: mbigen: drop module owner
  irqchip: mbigen: introduce mbigen_of_create_domain()

 drivers/acpi/gsi.c                            |  10 ++-
 drivers/acpi/iort.c                           |  32 +++++++-
 drivers/acpi/resource.c                       |  85 ++++++++++++++------
 drivers/base/platform-msi.c                   |  19 ++++-
 drivers/base/platform.c                       |   2 +
 drivers/irqchip/irq-gic-v3-its-platform-msi.c | 107 +++++++++++++++++++------
 drivers/irqchip/irq-mbigen.c                  | 109 ++++++++++++++++++++++----
 include/acpi/acpi_bus.h                       |   1 +
 include/linux/iort.h                          |   7 ++
 include/linux/msi.h                           |   1 +
 10 files changed, 300 insertions(+), 73 deletions(-)

-- 
1.7.12.4
