From: stefan@agner.ch (Stefan Agner)
Date: Thu, 27 Aug 2015 17:34:55 -0700
Subject: [PATCH v11 0/5] mtd: nand: vf610_nfc: Freescale NFC for VF610
Message-ID: <1440722100-25388-1-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In this 11th revision the driver now rereads the OOB area in case
hardware ECC fails. This allows to count the flipped bits accross
the whole page reliably. Also the device tree bindings have been
updated: NAND chips can be specified using sub-nodes, the ECC
properties are part of those chip nodes. Note however that the
driver currently only supports one NAND chip. The driver has been
verified again using the MTD tests.

More information and the full test log of earlier patchset version
can be found in the cover letter of the last revision v6:
http://thread.gmane.org/gmane.linux.kernel/1979868

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

mtd_speedtest of this 11th revision on a Colibri VF61:

[ 2321.921612] =================================================
[ 2321.927459] mtd_speedtest: MTD device: 3
[ 2321.936619] mtd_speedtest: MTD device size 104857600, eraseblock size 131072, page size 2048, count of eraseblocks 800, pages per eraseblock 64, OOB size 64
[ 2321.954428] mtd_test: scanning for bad eraseblocks
[ 2321.959626] mtd_test: block 142 is bad
[ 2321.966038] mtd_test: scanned 800 eraseblocks, 1 are bad
[ 2322.370120] mtd_speedtest: testing eraseblock write speed
[ 2344.047677] mtd_speedtest: eraseblock write speed is 4718 KiB/s
[ 2344.053687] mtd_speedtest: testing eraseblock read speed
[ 2351.890573] mtd_speedtest: eraseblock read speed is 13059 KiB/s
[ 2352.315120] mtd_speedtest: testing page write speed
[ 2374.882015] mtd_speedtest: page write speed is 4533 KiB/s
[ 2374.887526] mtd_speedtest: testing page read speed
[ 2382.886572] mtd_speedtest: page read speed is 12791 KiB/s
[ 2383.290314] mtd_speedtest: testing 2 page write speed
[ 2405.362236] mtd_speedtest: 2 page write speed is 4634 KiB/s
[ 2405.367925] mtd_speedtest: testing 2 page read speed
[ 2413.299551] mtd_speedtest: 2 page read speed is 12901 KiB/s
[ 2413.305228] mtd_speedtest: Testing erase speed
[ 2413.707595] mtd_speedtest: erase speed is 257612 KiB/s
[ 2413.712796] mtd_speedtest: Testing 2x multi-block erase speed
[ 2414.110127] mtd_speedtest: 2x multi-block erase speed is 260897 KiB/s
[ 2414.116656] mtd_speedtest: Testing 4x multi-block erase speed
[ 2414.510316] mtd_speedtest: 4x multi-block erase speed is 264268 KiB/s
[ 2414.516838] mtd_speedtest: Testing 8x multi-block erase speed
[ 2414.908075] mtd_speedtest: 8x multi-block erase speed is 265641 KiB/s
[ 2414.914607] mtd_speedtest: Testing 16x multi-block erase speed
[ 2415.306958] mtd_speedtest: 16x multi-block erase speed is 264268 KiB/s
[ 2415.313586] mtd_speedtest: Testing 32x multi-block erase speed
[ 2415.702660] mtd_speedtest: 32x multi-block erase speed is 267028 KiB/s
[ 2415.709270] mtd_speedtest: Testing 64x multi-block erase speed
[ 2416.098225] mtd_speedtest: 64x multi-block erase speed is 266333 KiB/s
[ 2416.104833] mtd_speedtest: finished
[ 2416.108379] =================================================

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
 drivers/mtd/nand/vf610_nfc.c                       | 890 +++++++++++++++++++++
 8 files changed, 1063 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/vf610-nfc.txt
 create mode 100644 drivers/mtd/nand/vf610_nfc.c

-- 
2.5.0
