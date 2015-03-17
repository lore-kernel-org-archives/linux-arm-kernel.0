From: lho@apm.com (Loc Ho)
Date: Tue, 17 Mar 2015 00:30:16 -0600
Subject: [PATCH v6 0/4] edac: Add APM X-Gene SoC EDAC driver
Message-ID: <1426573821-1937-1-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the APM X-Gene SoC EDAC driver for DT.

v6:
* Rebase to 4.0.0-rc3
* Add memory scrub stub function and enable ARM64 EDAC support patch
* Add bit definition defines for L2RTOS registers
* Remove un-necessary clearing of all L1/L2 software generated registers
* Remove wrong notification of LSU un-correctable error
* Change L2 reporting of un-correcable error to correctable error
* Change clearing of the L2C L2RTO registers
* Add support for L2 HW version 1 and version 2 or above
* Add support for L3 HW version 1 and version 2 or above

v5:
* Rebase to 3.17.rc1 (next)
* Update binding documentation for additional SoC node binding resource
* Enable MCU correctable and uncorrectable interrupts if not enabled by
  firmware
* Enable top level interrupt only after all MCU registered. Otherwise,
  error interrupt will never get cleared by the corresponding MCU.
* Remove clearing of L1 and L2 errors during initialization time. Otherwise,
  they will not be captured between firmware booting and error configuration.
* Add capture and clearing SoC register bus errors
* Add register bus resource to SoC DT node

v4:
* Fix PMD l1/l2 error reading address due to wrong variable type
* Fix clearing of software generated and HW errors for l1/l2

v3:
* Update binding documentation for PMD DT node and exampples
* Add binding documentation for SoC DT node
* Change MC, PMD, and L3C driver error injection to use debugfs
* Add missing IRQ for MC correctable error (code and DT)
* Use true/false where appropriate instead 1/0
* Add bit definition for L1 MMUESR register and fully decode this error
* Remove the un-necessary dev variable from xgene_edac_pmd_ctx structure
* Add check for disabled PMD (code and DT)
* Switch to edac_printk instead pr_err
* Some minor comments update

v2:
* Add EDAC entry in MAINTAINERS for APM EDAC driver
* Remove the MC scrub patch
* Remove the word 'Caches' from Kconfig
* Change all MASK defines to use BIT(x)
* Update comment or remove them
* Wrap error injection code around CONFIG_EDAC_DEBUG
* Change function name xgene_edac_mc_hw_init to xgene_edac_mc_irq_ctl
* Change all function XXX_hw_init to XXX_hw_ctl
* Fix typo 'activie'
* Move calling function edac_mc_alloc after resource retrieval
* Check for NULL on platform_get_resource return if reference directly
* Add documentation for struct xgene_edac_pmd_ctx
* Move L1 and L2 check out of function xgene_edac_pmd_check to its own
  functions
* Use for loop for configure each CPU of an PMD
* Replace /2 by >> 1
* Remove unnecessary comment on edac_device_add_device failure
* Make mem_err_ip static const
* Unwind EDAC register correctly if failed
---
Loc Ho (5):
  arm64: Enable EDAC on ARM64
  MAINTAINERS: Add entry for APM X-Gene SoC EDAC driver
  Documentation: Add documentation for the APM X-Gene SoC EDAC DTS
    binding
  edac: Add APM X-Gene SoC EDAC driver
  arm64: Add APM X-Gene SoC EDAC DTS entries

 .../devicetree/bindings/edac/apm-xgene-edac.txt    |   82 +
 MAINTAINERS                                        |    8 +
 arch/arm64/Kconfig                                 |    1 +
 arch/arm64/boot/dts/apm/apm-storm.dtsi             |   98 +
 arch/arm64/include/asm/edac.h                      |   31 +
 drivers/edac/Kconfig                               |    9 +-
 drivers/edac/Makefile                              |    1 +
 drivers/edac/xgene_edac.c                          | 2183 ++++++++++++++++++++
 8 files changed, 2412 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/edac/apm-xgene-edac.txt
 create mode 100644 arch/arm64/include/asm/edac.h
 create mode 100644 drivers/edac/xgene_edac.c
