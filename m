From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Thu, 23 Feb 2017 17:45:47 +0100
Subject: [PATCH v2 0/5] ARM64: Initial Realtek RTD1295 enablement
Message-ID: <20170223164553.3715-1-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This mini-series adds initial support for the Realtek RTD1295 SoC and
the Zidoo X9S TV box.

v2 does minor cleanups only.

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

KVM appears to initialize okay, but was not yet tested with QEMU.

[    0.256947] kvm [1]: 8-bit VMID
[    0.256986] kvm [1]: IDMAP page: 73b000
[    0.257025] kvm [1]: HYP VA range: 800000000000:ffffffffffff
[    0.257458] kvm [1]: Hyp mode initialized successfully
[    0.257529] kvm [1]: virtual timer IRQ3

More experimental patches at:
https://github.com/afaerber/linux/commits/rtd1295-next

Have a lot of fun!

Cheers,
Andreas

v1 -> v2:
* Add Acked-bys
* Tweak DT subjects
* Reword DT bindings
* Drop one memreserve
* Add MAINTAINERS patch

Cc: Roc He <hepeng@zidoo.tv>
Cc: devicetree at vger.kernel.org

Andreas F?rber (5):
  dt-bindings: Add vendor prefix for Zidoo
  dt-bindings: arm: Add Realtek RTD1295 bindings
  ARM64: Prepare Realtek RTD1295
  ARM64: dts: Prepare Realtek RTD1295 and Zidoo X9S
  MAINTAINERS: Add Realtek section

 Documentation/devicetree/bindings/arm/realtek.txt  |  20 +++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 MAINTAINERS                                        |   7 +
 arch/arm64/Kconfig.platforms                       |   6 +
 arch/arm64/boot/dts/Makefile                       |   1 +
 arch/arm64/boot/dts/realtek/Makefile               |   5 +
 arch/arm64/boot/dts/realtek/rtd1295-zidoo-x9s.dts  |  78 ++++++++++
 arch/arm64/boot/dts/realtek/rtd1295.dtsi           | 162 +++++++++++++++++++++
 8 files changed, 280 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/realtek.txt
 create mode 100644 arch/arm64/boot/dts/realtek/Makefile
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1295-zidoo-x9s.dts
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1295.dtsi

-- 
2.10.2
