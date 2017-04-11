From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 11 Apr 2017 17:33:11 +0100
Subject: [PATCH 0/2] arm64: acpi/pci: allow the firmware BAR configuration to
 be preserved
Message-ID: <20170411163313.18577-1-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a followup to the discussion regarding whether ACPI/arm64 systems
should preserve the PCI configuration performed by the firmware, or always
reconfigure it from scratch.

This series proposes to put it under the control of the firmware, by invoking
the _DSM method, and preserving the firmware configuration only when it
returns 0.

Patch #1 is a preparatory bugfix that solves the issue that I/O bridge
windows starting at 0x0 are dismissed when looking for parent resources.

Patch #2 adds the logic to invoke the _DSM and claim the existing
configuration rather than reallocate it from scratch if it returns '0'

Ard Biesheuvel (2):
  drivers: pci: do not disregard parent resources starting at 0x0
  arm64: acpi/pci: invoke _DSM whether to preserve firmware PCI setup

 arch/arm64/kernel/pci.c  | 20 ++++++++++++++++++--
 drivers/pci/pci.c        |  2 +-
 include/linux/pci-acpi.h |  7 ++++---
 3 files changed, 23 insertions(+), 6 deletions(-)

-- 
2.9.3
