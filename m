From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 17 Oct 2017 17:55:53 +0100
Subject: [PATCH v5 0/3] implement workaround for Socionext Synquacer pre-ITS
Message-ID: <20171017165556.30250-1-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From patch 3/3:

  The Socionext Synquacer SoC's implementation of GICv3 has a so-called
  'pre-ITS', which maps 32-bit writes targeted at a separate window of
  size '4 << device_id_bits' onto writes to GITS_TRANSLATER with device
  ID taken from bits [device_id_bits + 1:2] of the window offset.
  Writes that target GITS_TRANSLATER directly are reported as originating
  from device ID #0.

  So add a workaround for this. Given that this breaks isolation, clear
  the IRQ_DOMAIN_FLAG_MSI_REMAP flag as well.

v5: - move back to using a single DT property to describe the window; this
      is appropriate given that the CPU never accesses the window, and so
      modelling it using the standard DT idiom involving buses and ranges
      is not necessary
v4: - add patch to allow the quirk hook to signal whether it was applied or
      not; this is necessary for hardware whose IIDR is not sufficient to
      identify it
    - use DT sub-node rather than property to describe the quirk
    - remove pre_its_size field, and use get_msi_base() function pointer
      instead
v3: - add patch to pull device ID space discovery forward, so we can quirk
      it as well (as we already do for Cavium)
    - use existing quirks framework as much as possible
    - get rid of ITS_WORKAROUND_xxx flag: it is no longer needed after the
      refactoring

v2: - use a 32-bit host address/size rather than a PCI address, to factor
      out the involvement of an SMMU (which the platform does have, but it
      is unclear atm if it can be exposed to the OS)
    - add msi_domain_flags member to move the quirk flag checks out of the
      common code path*

Ard Biesheuvel (3):
  drivers/irqchip: gicv3: probe device ID space before quirks handling
  drivers/irqchip: gic: make quirks matching conditional on init return
    value
  drivers/irqchip: gicv3: add workaround for Synquacer pre-ITS

 Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt |   4 +
 arch/arm64/Kconfig                                                    |   8 ++
 drivers/irqchip/irq-gic-common.c                                      |   5 +-
 drivers/irqchip/irq-gic-common.h                                      |   2 +-
 drivers/irqchip/irq-gic-v3-its.c                                      | 102 ++++++++++++++++----
 5 files changed, 101 insertions(+), 20 deletions(-)

-- 
2.11.0
