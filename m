From: stefan@agner.ch (Stefan Agner)
Date: Thu,  5 Mar 2015 00:10:19 +0100
Subject: [PATCH 0/5] mtd: nand: vf610_nfc: Freescale NFC for VF610
Message-ID: <1425510624-22250-1-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for Freescale NAND flash controller (NFC) found on
various devices such as Vybrid (VF610), MPC5125, MCF54418 (ColdFire)
and Kinetis K70.

The patchset is based on the patchset by Bill Pringlemeir, see:
http://thread.gmane.org/gmane.linux.ports.arm.kernel/295419

A variant of this driver is in upstream U-Boot now. During this
process, various points have been discussed and changed. Those
changes are also incorporated in this patchset, including the
change to the name "vf610_nfc" (discussion in first patchset).
http://thread.gmane.org/gmane.comp.boot-loaders.u-boot/192465
http://thread.gmane.org/gmane.comp.boot-loaders.u-boot/193142
http://thread.gmane.org/gmane.comp.boot-loaders.u-boot/193351
http://thread.gmane.org/gmane.comp.boot-loaders.u-boot/195441
http://thread.gmane.org/gmane.comp.boot-loaders.u-boot/195513

MTD tests worked, except mtd_nandecctest.ko: The test stopped
already after changing the first bit. I guess this is due to not
properly working raw page read/write implementation. However,
implementing those functions is not feasible since ECC is always
done on-the-fly.

Performance keypoints (slightly less for page write/reads):
[ 1782.284398] mtd_speedtest: testing eraseblock write speed
[ 1963.472907] mtd_speedtest: eraseblock write speed is 2877 KiB/s
[ 1963.478913] mtd_speedtest: testing eraseblock read speed
[ 2004.906267] mtd_speedtest: eraseblock read speed is 12586 KiB/s

The driver has only been tested on Freescale Vybrid. Tests on other
platforms welcome, especially on big endian architectures...

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
  ARM: dts: vf610: add NAND flash controller peripherial
  ARM: dts: vf-colibri: enable NAND flash controller

 .../devicetree/bindings/mtd/vf610-nfc.txt          |  38 +
 arch/arm/boot/dts/vf-colibri.dtsi                  |  31 +
 arch/arm/boot/dts/vf500.dtsi                       |   4 +
 arch/arm/boot/dts/vf610-twr.dts                    |  43 +
 arch/arm/boot/dts/vfxxx.dtsi                       |   7 +
 arch/arm/mach-imx/Kconfig                          |   1 +
 drivers/mtd/nand/Kconfig                           |  14 +
 drivers/mtd/nand/Makefile                          |   1 +
 drivers/mtd/nand/vf610_nfc.c                       | 873 +++++++++++++++++++++
 9 files changed, 1012 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/vf610-nfc.txt
 create mode 100644 drivers/mtd/nand/vf610_nfc.c

-- 
2.3.0
