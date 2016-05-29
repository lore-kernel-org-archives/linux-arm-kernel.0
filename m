From: carlo@caione.org (Carlo Caione)
Date: Sun, 29 May 2016 13:12:00 +0200
Subject: [PATCH v5 0/3] Add Amlogic secure monitor driver
Message-ID: <1464520323-19531-1-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

In the Amlogic SoCs the secure monitor calls are used for a lot of reasons:
interact with the NVMEM (efuses), check the reboot reason, set USB boot, ...

This driver defines a generic interface towards the secure monitor that can be
used by more specialized drivers to interact with the secure monitor itself
without worrying about bounce buffers managing.

Changelog:

v5:
  * Moved IDs from DT to header file
  * Made read/write bounce buffers not mandatory
  * Introduced helper meson_sm_map_shmem()

v4:
  * Changed patches order
  * Removed now useless PATCH 2/4
  * Changed compatible to be SoC-specific
  * In the DT now we use SoC-agnostic IDs for the SMC functions. These IDs are
    traslated into SoC specific function IDs inside the driver
  * Added error checking on meson_sm_call() to retrieve the base address
  * Improved printing on errors

v3:
  * Moved driver to drivers/firmware
  * Added EXPORT_SYMBOL macros
  * Changed '_' in '-'
  * Introduced 'struct meson_sm_firmware' and 'meson_sm_get_fw()' to be used by
    drivers using the secure-monitor to enforce probe ordering

v2:
  * All the SMC function identifiers are now in a SoC-specific header file to
    be included by the DTS files so the SMC commands are now defined in the DT
    instead to be hardcoded into the driver
  * Patchset is no longer an RFC
  * Better error management and boundary checking
  * s/unsigned int/u32/
  * SMC call not only on CPU 0
  * Fix memory leaking
  * s/amlogic/meson/ in the directory names


Carlo Caione (3):
  firmware: Amlogic: Add secure monitor driver
  documentation: Add secure monitor binding documentation
  ARM64: dts: amlogic: gxbb: Enable secure monitor

 .../bindings/firmware/meson/meson_sm.txt           |  33 +++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |   8 +
 drivers/firmware/Kconfig                           |   1 +
 drivers/firmware/Makefile                          |   1 +
 drivers/firmware/meson/Kconfig                     |   8 +
 drivers/firmware/meson/Makefile                    |   1 +
 drivers/firmware/meson/meson_sm.c                  | 223 +++++++++++++++++++++
 include/linux/firmware/meson/meson_sm.h            |  32 +++
 8 files changed, 307 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/meson/meson_sm.txt
 create mode 100644 drivers/firmware/meson/Kconfig
 create mode 100644 drivers/firmware/meson/Makefile
 create mode 100644 drivers/firmware/meson/meson_sm.c
 create mode 100644 include/linux/firmware/meson/meson_sm.h

-- 
2.7.4
