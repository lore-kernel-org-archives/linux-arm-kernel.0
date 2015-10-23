From: bhupesh.sharma@freescale.com (Bhupesh Sharma)
Date: Sat, 24 Oct 2015 01:01:49 +0530
Subject: [PATCH v4 00/12] ARM64: Update support for FSL's LS2085A SoC
Message-ID: <1445628721-10483-1-git-send-email-bhupesh.sharma@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the v4 of the patchset which updates the support for FSL's LS2085A SoC
which is now being renamed to LS2080A (and is based on ARMv8 architecture).

Here is a description of what this patchset tries to achieve:
(v3 can be viewed here: http://www.spinics.net/lists/arm-kernel/msg452747.html)

  - Patch 1:
    Freescale will be a supporting a host of ARMv8 based SoCs which
    will be based on a similar overall SoC architecture. So, this patch
    converts the existing infrastructure to use the generic convention
    ARCH_LAYERSCAPE.
    
    	Changes since v3:
	-----------------
	No changes

  - Patch 2:
    Freescale is renaming the LS2085A SoC to LS2080A - this patch handles the
    same.
    Further details of the LS2080a based platforms can be seen here:
    http://www.freescale.com/products/arm-processors/qoriq-arm-processors/qoriq-ls2080a-40a-multicore-communications-processors:LS2080A?fsrch=1&sr=1&pageNum=1
    
	Changes since v3:
	-----------------
	No changes

  - Patch 3:
    Adds DTS binding documentation for Freescale's LS2080A QDS and RDB boards
    
	Changes since v3:
	-----------------
	No changes

  - Patch 4:
    This patch moves the FSL board specific bindings out of 'powerpc/' folder
    as the same board components can be used for ARM based SoCs as well.
	
	Changes since v3:
	-----------------
	No changes

  - Patch 5:
    Updates PCIe devicetree binding documentation for LS2080A.
	
	Changes since v3:
	-----------------
	Minor rewording of commit log and making clock-related properties
	optional in Designware PCIe controller bindings.

  - Patch 6:
    Updates the GPIO devicetree binding documentation for LS2080A.
	
	Changes since v3:
	-----------------
	No changes

  - Patch 7:
    Updates the DWC3 USB bindings to provide reference to generic USB
    bindings.
	
	Changes since v3:
	-----------------
	No changes

  - Patch 8:
    Updates the support of various peripherals (PMU, SMMU, SATA, PCI, SPI)
    present on FSL LS2080a SoC in the SoC DTSI.
	
	Changes since v3:
	-----------------
	Removed ls1021a-ahci compatible string for sata devices.
	Added 'status = disabled' for certain peripherals which are not
	available on simulator platform.

  - Patch 9:
    Updates the DTS LS2080a simulator platform to reflect the new
    peripherals added in the DTSI.
	
	Changes since v3:
	-----------------
	Removed the 'status = disabled' for certain peripherals which are not
	available on simulator platform as this is now handled in the
	DTSI itself.

  - Patch 10:
    Remove text about writing to Free Software Foundation
	
	Changes since v3:
	-----------------
	No changes

  - Patch 11:
    Adds new DTS files for LS2080a based QDS and RDB boards.
	
	Changes since v3:
	-----------------
	No changes

  - Patch 12:
    Adds build support for LS2080a QDS and RDB board DTS files.
	
	Changes since v3:
	-----------------
	Moved compilation directives for various DTBs on individual lines
	inside the Makefile.

Rebasing details:
-----------------
- Rebased against linux-next git tree, branch: master

- Rebased against Scott's latest v3 of QorIQ clk fixes, which can be
  viewed here:
  http://linux.freescale.net/patchwork/patch/59805/

Bhupesh Sharma (12):
  arm64: Use generic Layerscape SoC family naming
  arm64: Rename FSL LS2085A SoC support code to LS2080A
  Documentation: DT: Add entry for FSL LS2080A QDS and RDB boards
  Documentation/dts: Move FSL board-specific bindings out of /powerpc
  doc/bindings: Update Layerscape PCIe devicetree bindings for LS2080A
  doc/bindings: Update GPIO devicetree binding documentation for
    LS2080A
  doc: DTS: Update DWC3 binding to provide reference to generic
    bindings
  dts/ls2080a: Update DTSI to add support of various peripherals
  dts/ls2080a: Update Simulator DTS to add support of various
    peripherals
  dts/ls2080a: Remove text about writing to Free Software Foundation
  dts/ls2080a: Add DTS support for LS2080a QDS & RDB boards
  dts/Makefile: Add build support for LS2080a QDS & RDB board DTS

 Documentation/devicetree/bindings/arm/fsl.txt      |   16 +-
 .../{powerpc/fsl/board.txt => board/fsl-board.txt} |   14 +-
 .../devicetree/bindings/gpio/gpio-mpc8xxx.txt      |    4 +-
 .../devicetree/bindings/pci/designware-pcie.txt    |   10 +-
 .../devicetree/bindings/pci/layerscape-pci.txt     |   14 +-
 Documentation/devicetree/bindings/usb/dwc3.txt     |    3 +-
 arch/arm64/Kconfig.platforms                       |    6 +-
 arch/arm64/boot/dts/freescale/Makefile             |    4 +-
 arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dts  |  204 ++++++++
 .../{fsl-ls2085a-simu.dts => fsl-ls2080a-rdb.dts}  |  131 ++++-
 .../{fsl-ls2085a-simu.dts => fsl-ls2080a-simu.dts} |   25 +-
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi     |  515 ++++++++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi     |  163 -------
 arch/arm64/configs/defconfig                       |    2 +-
 14 files changed, 902 insertions(+), 209 deletions(-)
 rename Documentation/devicetree/bindings/{powerpc/fsl/board.txt => board/fsl-board.txt} (90%)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dts
 copy arch/arm64/boot/dts/freescale/{fsl-ls2085a-simu.dts => fsl-ls2080a-rdb.dts} (51%)
 rename arch/arm64/boot/dts/freescale/{fsl-ls2085a-simu.dts => fsl-ls2080a-simu.dts} (81%)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
 delete mode 100644 arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi

-- 
1.7.9.5
