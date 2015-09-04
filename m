From: bhupesh.sharma@freescale.com (Bhupesh Sharma)
Date: Fri, 4 Sep 2015 12:27:42 +0530
Subject: [PATCH v2 00/10] ARM64: Update support for FSL's LS2085A SoC
Message-ID: <1441349872-4560-1-git-send-email-bhupesh.sharma@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the v2 of the patchset which updates the support for FSL's LS2085A SoC
which is now being renamed to LS2080A (and is based on ARMv8 architecture).

Here is a description of what this patchset tries to achieve:

  - Patch 1:
    Freescale will be a churning out a host of ARMv8 based SoCs which
    will be based on a similar overall SoC architecture. So, this patch
    converts the existing infrastructure to use the generic convention
    ARCH_LAYERSCAPE. Also since Freescale is renaming LS2085A to LS2080A
    this patch fixes the same as well.

    Further details of the LS2080a based platforms can be seen here:
    http://www.freescale.com/products/arm-processors/qoriq-arm-processors/qoriq-ls2080a-40a-multicore-communications-processors:LS2080A?fsrch=1&sr=1&pageNum=1

  - Patch 2:
    Adds DTS binding documentation for Freescale's LS2080A QDS and RDB boards

  - Patch 3:
    This patch adds bindings for QIXIS FPGA controller found on FSL boards.

  - Patch 4:
    Updates PCIe devicetree binding documentation for LS2080A.

  - Patch 5:
    Updates clk-qoriq bindings for FSL's chassis-3.0 SoCs
  
  - Patch 6:
    Addresses changes required in clk-qoriq driver to handle
    little-endian clockgen SoCs like LS2080A.

  - Patch 7:
    Updates the support of various peripherals (PMU, Watchdog, SMMU,
    SATA, PCI, SPI, etc.) present on FSL LS2080a SoC in the SoC DTSI.

  - Patch 8:
    Updates the DTS LS2085a simulator platform to reflect the new
    peripherals added in the DTSI.

  - Patch 9:
    Adds new DTS files for LS2085a based QDS and RDB boards.
  
  - Patch 10:
    Adds build support for LS2085a QDS and RDB board DTS files.

Rebasing details:
-----------------
- Rebased against arm-soc git tree, branch: next/dt

- Rebased against Scott's latest v2 of QorIQ clk fixes, which can be
  viewed here:
  https://patchwork.kernel.org/patch/7020471/
  https://patchwork.kernel.org/patch/7020541/
  https://patchwork.kernel.org/patch/7020491/
  https://patchwork.kernel.org/patch/7020481/
  https://patchwork.kernel.org/patch/7020501/

Changes since v1:
----------------
(v1 can be viewed here: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-April/334990.html)

- Addressed Mark's comments regarding the FTM alarm timer node.
	Removed the node for now as the FTM binding change related discussion is
	underway with the maintainers.
- Added support for Layerscape family of SoCs and changed name of
  LS2085a chip to LS2080a chip.
- Updated QorIQ clk driver to support LS2080a like SoCs.
- Added support for SATA nodes in the DTSI.
- Added binding document for on-board QIXIS FPGA controllers.

Note:
-----
I get a checkpatch warning for the amba-bus compatible string being missing from
Documentation/devicetree/bindings/ . I am not aware if some patch is already
being worked on, to solve the same:
	compatible = "arm,amba-bus";

If not, I can try to send a patch, with the re-spin of this patchset.

Bhupesh Sharma (9):
  arm64: Use generic Layerscape SoC family naming & rename LS2085A to
    LS2080A
  Documentation: DT: Add entry for FSL LS2080A QDS and RDB boards
  Documentation/dts: Add bindings for QIXIS FPGA controller found on
    FSL boards
  doc/bindings: Update PCIe devicetree binding documentation for
    LS2080A
  doc/bindings: Update clk-qoriq bindings for FSL's chassis-3.0 SoCs
  dts/ls2085a: Update DTSI to add support of various peripherals
  dts/ls2085a: Update Simulator DTS to add support of various
    peripherals
  dts/ls2080a: Add DTS support for LS2080a QDS & RDB boards
  dts/Makefile: Add build support for LS2080a QDS & RDB board DTS

Scott Wood (1):
  clk: qoriq: Add ls2080a support.

 .../devicetree/bindings/arm/fsl,board.txt          |   31 +
 Documentation/devicetree/bindings/arm/fsl.txt      |   16 +-
 .../devicetree/bindings/clock/qoriq-clock.txt      |   16 +-
 .../devicetree/bindings/pci/layerscape-pci.txt     |    3 +-
 arch/arm64/Kconfig                                 |    6 +-
 arch/arm64/boot/dts/freescale/Makefile             |    2 +-
 arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dts  |  198 +++++++
 .../{fsl-ls2085a-simu.dts => fsl-ls2080a-rdb.dts}  |  126 +++-
 .../{fsl-ls2085a-simu.dts => fsl-ls2080a-simu.dts} |   64 +-
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi     |  612 ++++++++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi     |  163 ------
 arch/arm64/configs/defconfig                       |    2 +-
 drivers/clk/Kconfig                                |    2 +-
 drivers/clk/clk-qoriq.c                            |   78 ++-
 14 files changed, 1107 insertions(+), 212 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/fsl,board.txt
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dts
 copy arch/arm64/boot/dts/freescale/{fsl-ls2085a-simu.dts => fsl-ls2080a-rdb.dts} (52%)
 rename arch/arm64/boot/dts/freescale/{fsl-ls2085a-simu.dts => fsl-ls2080a-simu.dts} (76%)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
 delete mode 100644 arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi

-- 
1.7.9.5
