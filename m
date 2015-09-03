From: stefan@agner.ch (Stefan Agner)
Date: Wed,  2 Sep 2015 18:06:32 -0700
Subject: [PATCH v12 0/5] mtd: nand: vf610_nfc: Freescale NFC for VF610
Message-ID: <1441242397-870-1-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This v12 fixes a race condition which sometimes has been lead
to corrupted reads. This has been observed while continously
rebooting or in the io_paral ubi-test, see also:
http://thread.gmane.org/gmane.linux.drivers.mtd/59955

Since the 11th revision the driver rereads the OOB area in case
hardware ECC fails. This allows to count the flipped bits accross
the whole page reliably. Also the device tree bindings have been
updated: NAND chips can be specified using sub-nodes, the ECC
properties are part of those chip nodes. Note however that the
driver currently only supports one NAND chip. The driver has been
verified again using the MTD tests.

More information and the full test log of earlier patchset version
can be found in the cover letter of the last revision v6:
http://thread.gmane.org/gmane.linux.kernel/1979868

Changes since v11:
- Unconditionally wait for idle interrupt. This avoids an race condition:
  The interrupt may fire between setting and checking the idle bit. So
  the IRQ handler will increment the completion struct (cmd_done), but
  won't be doing the corresponding decrement via wait_for_completion().
  The subsequent wait_for_completion() will immediately succeed, the
  upper layers then read out the old page buffer (again).
- Return amount of bitflips when counting stuck at zero bits in a
  empty page
- Use a common order of function calls in vf610_nfc_command

Changes since v10:
- Rebased onto l2-mtd/master
- Use children nodes for NAND chips in device tree bindings
- Support exactly one NAND chip using the new device tree bindings
- Reread page OOB on ECC error in order to reliable determine the amount
  of bit flips on a erased page
- Use ECC strength/2 as the only bit flip threshold
- Rely on endianness aware word read to read the ECC status
- Introduce vf610_nfc_variant which reflects the variant according to
  the device tree compatible string
- Use variant to determine chip select implementation
- Use enum for alternate buffer indication
- Renamed page_sz variable in struct vf610_nfc as well as in the function
  vf610_nfc_command to more specific names
- Some smaller code cleanup (altered ECC_SRAM_ADDR, introduce OOB_MAX)

Changes since v9:
- Remove inline of vf610_nfc_done
- Add __iomem to src argument of vf610_nfc_memcpy
- Handle return value of mtd_device_parse_register correctly
- Count bits in OOB too (only non-ECC bits)
- Return bitflips in ecc.read_page callback vf610_nfc_read_page
- Fall-through ALT_BUF_ONFI
- Use BIT macros

Changes since v8:
- Fix 16-Bit NAND flash support by splitting up initialization
  (introduce vf610_nfc_preinit_controller)
- Updated comments in initialziation functions

Changes since v7:
- vf610-twr.dts: Moved NFC pinmux into the existing iomuxc node
  and sort new nfc node behind the existing iomuxc node as well.
- vf610-twr.dts/vf-colibri.dtsi: Dropped _1 suffixes

Changes since v6:
- Rebased ontop of l2-mtd/master (v4.2-rc1 based)
- Removed HAVE_NAND_VF610_NFC and use depends on. This made
  "[PATCH v6 4/6] ARM: vf610: enable NAND Flash Controller" unnecessary

Changes since v5:
- Removed fsl,mpc5125-nfc compatible string
- Removed readl/writel_relaxed
- Change interface of vf610_nfc_transfer_size to match other accessors

Changes since v4:
- Rebased ontop of l2-mtd/master (v4.1-rc4 based)
- Eliminate unnecessary page read (NAND_CMD_SEQIN) since the driver does
  not support sub-page writes anyway (improves write performance)
- Support ONFI by enabling READID command with offset and parameter page
  reads (CMD_PARAM)
- Change to dedicated read_page/write_page function, enables raw writes
- Use __LITTLE_ENDIAN to distingush between LE/BE relevant statements
- Eliminated vf610_nfc_probe_dt in favor of common DT init code
- Use wait_for_completion_timeout
- Some style fixes (spaces, etc.)

Changes since v3:
- Make the driver selectable when COMPILE_TEST is set
- Fix compile error due to superfluous ECC_STATUS configuration in initial
  patch (without ECC correction ECC_STATUS does not need to be configured)
- Remove custom BBT pattern and switch to in-band BBT in the initial patch
- Include two bug fixes, for details see the corresponding U-Boot patches:
  http://thread.gmane.org/gmane.comp.boot-loaders.u-boot/215802

Changes since v2:
- Updated binding documentation

Changes since v1:
- Nest nfc_config struct within the main nfc struct
- Use assigned clock binding to specify NFC clock
- Rebased ontop of MSCM IR patchset (driver parts have been merged)
- Split out arch Kconfig in a separate config
- Fix module license
- Updated MAINTAINERS

Changes since RFC (Bill Pringlemeir):
- Renamed driver from fsl_nfc to vf610_nfc
- Use readl/writel for all register in accessor functions
- Optimized field accessor functions
- Implemented PM (suspend/resume) functions
- Implemented basic support for ECC strength/ECC step size from dt
- Improved performance of count_written_bits by using hweight32
- Support ECC with 60-bytes to correct up to 32 bit errors
- Changed to in-band BBT (NAND_BBT_NO_OOB) which also allows ECC modes
  which uses up to 60 bytes on 64 byte OOB
- Removed custom (downstream) BBT pattern since BBT table won't be
  compatible anyway (due to the change above)

Stefan Agner (5):
  mtd: nand: vf610_nfc: Freescale NFC for VF610, MPC5125 and others
  mtd: nand: vf610_nfc: add hardware BCH-ECC support
  mtd: nand: vf610_nfc: add device tree bindings
  ARM: dts: vf610twr: add NAND flash controller peripherial
  ARM: dts: vf-colibri: enable NAND flash controller

 .../devicetree/bindings/mtd/vf610-nfc.txt          |  59 ++
 MAINTAINERS                                        |   6 +
 arch/arm/boot/dts/vf-colibri.dtsi                  |  39 +
 arch/arm/boot/dts/vf610-twr.dts                    |  47 ++
 arch/arm/boot/dts/vfxxx.dtsi                       |  10 +
 drivers/mtd/nand/Kconfig                           |  11 +
 drivers/mtd/nand/Makefile                          |   1 +
 drivers/mtd/nand/vf610_nfc.c                       | 885 +++++++++++++++++++++
 8 files changed, 1058 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/vf610-nfc.txt
 create mode 100644 drivers/mtd/nand/vf610_nfc.c

-- 
2.5.1
