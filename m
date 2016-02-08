From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Sun, 7 Feb 2016 19:00:39 -0500
Subject: [PATCH 0/5] Modularize PCI_DW related drivers.
Message-ID: <1454889644-27830-1-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In a recent patch series that aimed to remove code related to module
unload for PCI support that was simply non modular, the discussion
led to people wanting to keep the code and push towards taking the
steps needed to support moving it towards tristate instead[1].

Here, we take step one, which is simply making the Kconfig change
and then dealing with any build fallout or modpost fallout.  What
amounts to essentially a sanity build test.  To be clear, these
have not been runtime validated; that will need to be done by those
with access to real hardware.  However, the changes are not anything
that should disrupt any existing built-in validation, so real world
users should not be impacted by this change.

We start with a smaller family of drivers; those that actively select
PCI_DW, as a nice self contained group to test the waters and see if
everyone is still good with this approach before investing more time
on a wider scale to other pci/host/ code blocks.

As such the drivers here share a dependency on having the same group
of functions exported in order to successfully complete modpost.

In addition, we have to stray outside drivers/pci to add exports
in two places; once for an ARM fault handler, and once for an OF
variable.

The pci-keystone-dw.c instance was handled separately because it
consists of two source files that need their own group of driver
specific exports above and beyond the "shared" ones.

Then we convert the Kconfig for all remaining at once; we could have
done it on a per driver basis for ease of revert if anyone really
objects, but since it would be a one line change, that seemed like
not a real concern.

Build testing was done on the linux-next tree for arm allmodconfig.

[1] https://lkml.kernel.org/r/20160108203102.GH5354 at localhost

-- 

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: devicetree at vger.kernel.org
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Ley Foon Tan <lftan@altera.com>
Cc: Murali Karicheri <m-karicheri2@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-arm-msm at vger.kernel.org
Cc: linux-pci at vger.kernel.org


Paul Gortmaker (5):
  ARM: add EXPORT_SYMBOL of hook_fault_code for PCI host modularization
  drivers/of: add EXPORT_SYMBOL to of_irq_count
  drivers/pci: export dw syms enabling board specific PCI code to be
    tristate
  drivers/pci: make host/pci-keystone-dw.c modular
  drivers/pci: make most of the PCI_DW drivers modular

 arch/arm/mm/fault.c                |  3 ++-
 drivers/of/irq.c                   |  1 +
 drivers/pci/host/Kconfig           | 16 ++++++++--------
 drivers/pci/host/pci-keystone-dw.c | 16 +++++++++++++++-
 drivers/pci/host/pcie-designware.c |  7 +++++++
 5 files changed, 33 insertions(+), 10 deletions(-)

-- 
2.6.1
