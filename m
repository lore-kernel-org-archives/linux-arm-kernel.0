From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun, 14 May 2017 04:24:24 +0200
Subject: [PATCH v3 0/5] arm64: Initial Realtek RTD1295 enablement
Message-ID: <20170514022429.11555-1-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This mini-series adds initial support for the Realtek RTD1295 SoC and
the Zidoo X9S TV box.

v3 changes #address-cells, #size-cells and ranges.

With these patches CPU0 can be booted with earlycon.

PSCI doesn't work despite present in the vendor device tree; as enable-method
it instead used a custom "rtk-spin-table" that I sadly have no source code of.

The UARTs use a custom interrupt controller that I again lack source code of;
with interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH> it can boot into an initrd.

The boot process is slightly twisted: The files need to be loaded from a
32-bit U-Boot, then boot into 64-bit U-Boot where the kernel can be booted.
Similar to my previous Amlogic S905 work, the TEXT_OFFSET poses a problem, so
a uImage needs to be used (or the kernel patched) for load address 0x00280000.
I haven't succeeded loading an initrd via bootm/booti; but as quick workaround
initrd=$rootfs_loadaddr,0x$filesize can manually be specified in $bootargs.

Cf. https://en.opensuse.org/HCL:Zidoo_X9S

More experimental patches at:
https://github.com/afaerber/linux/commits/rtd1295-next

Have a lot of fun!

Cheers,
Andreas

v2 -> v3:
* DT cleanups (Rob)
* Drop arm at kernel.org again (Olof)

v1 -> v2:
* Add Acked-bys
* Tweak DT subjects
* Reword DT bindings
* Drop one memreserve
* Add MAINTAINERS patch

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
Cc: Roc He <hepeng@zidoo.tv>
Cc: devicetree at vger.kernel.org

Andreas F?rber (5):
  dt-bindings: Add vendor prefix for Zidoo
  dt-bindings: arm: Add Realtek RTD1295 bindings
  ARM64: Prepare Realtek RTD1295
  ARM64: dts: Add Realtek RTD1295 and Zidoo X9S
  MAINTAINERS: Add Realtek section

 Documentation/devicetree/bindings/arm/realtek.txt  |  20 ++++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 MAINTAINERS                                        |   7 ++
 arch/arm64/Kconfig.platforms                       |   6 +
 arch/arm64/boot/dts/Makefile                       |   1 +
 arch/arm64/boot/dts/realtek/Makefile               |   5 +
 arch/arm64/boot/dts/realtek/rtd1295-zidoo-x9s.dts  |  42 +++++++
 arch/arm64/boot/dts/realtek/rtd1295.dtsi           | 131 +++++++++++++++++++++
 8 files changed, 213 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/realtek.txt
 create mode 100644 arch/arm64/boot/dts/realtek/Makefile
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1295-zidoo-x9s.dts
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1295.dtsi

-- 
2.12.0
