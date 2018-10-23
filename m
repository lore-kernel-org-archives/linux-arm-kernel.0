From: yogeshnarayan.gaur@nxp.com (Yogesh Narayan Gaur)
Date: Tue, 23 Oct 2018 09:37:00 +0000
Subject: [PATCH v3 0/7] spi: add support for octo mode
Message-ID: <1540287311-1572-1-git-send-email-yogeshnarayan.gaur@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for octo mode IO data transfer.
Micron flash, mt35xu512aba, supports octal mode data transfer and
NXP FlexSPI controller supports 8 data lines for data transfer (Rx/Tx).

Patch series
* Add support for octo mode flags and parsing of same in spi driver.
* Add parsing logic for spi-mem framework and m25p80.c device file.
* Add opcodes for octo I/O commands in spi-nor framework, Read and Write proto for (1-1-8/1-8-8) mode.
  Opcodes are added as per octal data IO commands required for mt35xu512aba [1] flash.
* Add mode bit required for octo mode in nxp-fspi driver [2].
* Define binding property 'spi-rx/tx-bus-width' for LX2160ARDB target [2].

Cherry pick below 2 patches (from: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git):
    c639f871febe6667d9afce28108c634e5636c735 spi: spi-mem: Fix inverted logic in op sanity check
    db122eb8a749a1eff038f9a282c620ab16c4be1d spi: spi-mem: Add extra sanity checks on the op param

Tested on LX2160ARDB target with nxp-fspi driver, below are
Read performance number of 1-1-1 and 1-1-8 read protocol.

 root at lxxx:~# cat /proc/mtd
 dev:    size   erasesize  name
 mtd0: 04000000 00001000 "spi0.0"
 mtd1: 04000000 00001000 "spi0.1"
 root at lxxx:~# time mtd_debug read /dev/mtd0 0x0 0x1000000 0read
 Copied 16777216 bytes from address 0x00000000 in flash to 0read

 real    0m2.792s
 user    0m0.000s
 sys     0m2.790s
 root at lxxx:~# time mtd_debug read /dev/mtd1 0x0 0x1000000 0read
 Copied 16777216 bytes from address 0x00000000 in flash to 0read

 real    0m0.441s
 user    0m0.000s
 sys     0m0.440s
 root at ls1012ardb:~#

 Flash device MTD0 configured in 1-1-1 protocol.
 Flash device MTD1 configured in 1-1-8 protocol.

[1] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=70384
[2] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=72181

Yogesh Gaur (7):
  spi: add support for octo mode I/O data transfer
  spi: spi-mem: add support for octo mode I/O data transfer
  mtd: spi-nor: add opcodes for octo Read/Write commands
  mtd: spi-nor: add octo read flag for flash mt35xu512aba
  mtd: m25p80: add support of octo mode I/O transfer
  spi: nxp-fspi: add octo mode flag bit for octal support
  arm64: dts: lx2160a: update fspi node

Changes for v3:
- Add octo mode support in spi_setup().
- Rename all patches with 'octal' string modified as 'octo'.
Changes for v2:
- Incorporated review comments of Boris and Vignesh.

 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts |  4 ++++
 drivers/mtd/devices/m25p80.c                      |  9 ++++++++-
 drivers/mtd/spi-nor/spi-nor.c                     | 15 ++++++++++++++-
 drivers/spi/spi-mem.c                             |  9 ++++++++-
 drivers/spi/spi-nxp-fspi.c                        |  4 ++--
 drivers/spi/spi.c                                 | 12 ++++++++++--
 include/linux/mtd/spi-nor.h                       |  8 ++++++++
 include/linux/spi/spi.h                           |  2 ++
 8 files changed, 56 insertions(+), 7 deletions(-)

-- 
2.7.4
