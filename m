From: helgaas@kernel.org (Bjorn Helgaas)
Date: Fri, 06 Oct 2017 17:24:20 -0500
Subject: [PATCH 0/2] vgaarb: Select fallback default VGA device
Message-ID: <20171006221358.12211.42879.stgit@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches are supposed to fix a problem Daniel Axtens found on the
HiSilicon D05 board.  The VGA device there is behind a bridge that doesn't
support PCI_BRIDGE_CTL_VGA, so the arbiter never selects the device as the
default.

The first patch extends the arbiter so that if it can't find an enabled VGA
device with legacy resources, it selects the first enabled device *without*
legacy resources (this is what fixes the D05).  If that fails, it selects
the first device that isn't enabled.  The combination of both changes
should make the current powerpc fixup_vga() quirk unnecessary.

N.B. It changes the powerpc behavior: if there are several enabled VGA
devices, the current quirk selects the last one, while this patch selects
the first one.  If this is a problem, I can drop that part of the patch and
keep the quirk.

The second patch pulls out this fallback device detection (and the EFI
override) from vga_arb_device_init() to make it easier to read.

---

Bjorn Helgaas (2):
      vgaarb: Select a default VGA device even if there's no legacy VGA
      vgaarb: Factor out EFI and fallback default device selection


 arch/powerpc/kernel/pci-common.c |   12 ------
 drivers/gpu/vga/vgaarb.c         |   72 +++++++++++++++++++++++++++++---------
 2 files changed, 55 insertions(+), 29 deletions(-)
