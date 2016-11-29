From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 29 Nov 2016 12:43:19 -0600
Subject: [PATCH 0/2] ACPI: Ignore Consumer/Producer for QWord/DWord/Word
 Address Space
Message-ID: <20161129182415.7618.99129.stgit@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Per spec, the Consumer/Producer bit is defined only for Extended
Address Space descriptors and should be ignored for QWord/DWord/Word
Address Space descriptors.  My understanding is that this is because
x86 BIOSes didn't use the bit consistently, so it couldn't be relied
upon.  The Extended descriptors were added later and are presumably
more reliable.

Linux currently looks at Consumer/Producer for all Address Space
descriptors, although we don't use the result very much.  The x86 and
ia64 host bridge driver code doesn't use Consumer/Producer to identify
windows; it assumes all descriptors are windows.

We do currently use Consumer/Producer to decide whether to apply _TRA.
The change in these patches is to ignore Consumer/Producer for
QWord/DWord/Word, so we'll apply _TRA from Consumer descriptors where
we didn't before.  Per spec, that should be safe because _TRA is
required to be zero for Consumer resources.

If we want to describe host bridge register space and ECAM space
directly in the PNP0A03 device on ARM64 (and I guess potentially even
on x86 & ia64), I think we need changes like this so the arch code can
use IORESOURCE_WINDOW to tell which descriptors are windows and which
are registers.

This is a subtle area, so please take a look and let me know what you
think.

These patches are based on v4.9-rc1.  It's getting pretty late in the
cycle, but I think we'd really like to get the ARM64 ACPI PCI story
sorted out for the v4.10 merge window.

---

Bjorn Helgaas (2):
      ACPI: Combine acpi_dev_resource_address_space() and acpi_dev_resource_ext_address_space()
      ACPI: Ignore Consumer/Producer for QWord/DWord/Word Address Space


 drivers/acpi/ioapic.c          |    3 -
 drivers/acpi/resource.c        |  130 ++++++++++++++++++----------------------
 drivers/pnp/pnpacpi/rsparser.c |    3 -
 include/linux/acpi.h           |    2 -
 4 files changed, 59 insertions(+), 79 deletions(-)
