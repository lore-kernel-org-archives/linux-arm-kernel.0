From: lho@apm.com (Loc Ho)
Date: Fri, 22 May 2015 17:32:55 -0600
Subject: [PATCH v11 0/4] edac: Add APM X-Gene SoC EDAC driver
Message-ID: <1432337580-3750-1-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the APM X-Gene SoC EDAC driver for DT.

v11:
* Update DT binding documnetation with additional memory controller and PMD
  controller instance number
* Move global MC variables to EDAC top level structure
* Move EDAC support functions to top of file
* Inlined some EDAC support functions
* Remove define of CONFIG_EDAC_DEBUG where it is possible
* Update driver to reflect additional memory controller and PMD controller
  properties in DT
* Update DT with additional memory controller and PMD instance number
* Drop the stub scrub function for ARM64. You will need an EDAC code update
  to compile.

v10:
* Move regmap for CSW, MCBA, MCBB, and efuse to top driver node and add
  accessor support functions
* Change retrieval OF address proerty for subnode to use of_address_to_resource
* Add COMPILE_TEST to Kconfig for EDAC_XGENE
* Update DT binding documentation and DT node accordingly
* Remove DT node naming and number from nodes

v9:
* Update maintainer section
* Update binding documentation to reflect update DT binding
* Restructure the EDAC driver such that its includes subnode for MC, PMD's,
  and future L3's and SoC.
* Update DT node to reflect update DT binding
* NOTE: Temporary removed L3 and SoC. They will be added back later on.

v8:
* Change ASM_EDAC_H to __ASM_EDAC_H in file edac.h
* Add WARN_ONCE in stub function atomic_scrub
* Update DTS binding documentation (with only memory controller node)
* Temporary remove L1/L2, L3, and SoC driver code and update memory driver
  code accordingly

v7:
* Update binding documentation for memory controller, PMD, L3, and SoC EDAC
* Change resource for PCP, CSW, MCBA, MCBB, and efuse to syscon type nodes
  and updae driver accordingly
* Fix clearing L2 RTO register properly
* Fix the MODULE_DEVICE_TABLE for OF
* Update DT accordingly to binding documentation

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

 .../devicetree/bindings/edac/apm-xgene-edac.txt    |   78 ++
 MAINTAINERS                                        |    7 +
 arch/arm64/Kconfig                                 |    1 +
 arch/arm64/boot/dts/apm/apm-storm.dtsi             |   83 ++
 drivers/edac/Kconfig                               |    7 +
 drivers/edac/Makefile                              |    1 +
 drivers/edac/xgene_edac.c                          | 1254 ++++++++++++++++++++
 7 files changed, 1431 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/edac/apm-xgene-edac.txt
 create mode 100644 drivers/edac/xgene_edac.c
