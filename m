From: yuanzhichang@hisilicon.com (Zhichang Yuan)
Date: Wed, 7 Sep 2016 21:33:49 +0800
Subject: [PATCH V2 0/4] ARM64 LPC: legacy ISA I/O support
Message-ID: <1473255233-154297-1-git-send-email-yuanzhichang@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "zhichang.yuan" <yuanzhichang@hisilicon.com>

This patch supports the 16550 compatible UART attached to the Low-Pin-Count
interface mplemented on Hisilicon Hip06 SoC. The periperals attached this LPC
include UART, BT, KCS, and so on.
	                -----------
			| LPC host|
	                |         |
	                -----------
	                     |
 	        _____________V_______________LPC
                  |			  |
                  V	                  V
             -----------             ------------
             |  UART   |             |  BT(ipmi)|
             -----------             ------------

When master accesses those periperals beneath the Hip06 LPC, a specific LPC
driver is needed to make LPC host generate the standard LPC I/O cycles with
the target periperals'I/O port addresses. But on curent arm64 world, there is
no real I/O accesses. All the I/O operations through in/out pair are based on
MMIO which is not satisfied the I/O mechanism on Hip06 LPC.
To solve this issue and keep the relevant existing peripherals' driver
unchanged, this patch set redefines the in/out pair to support both the IO
operations for Hip06 LPC and the original MMIO. The way specific to Hip06 is
named as indirect-IO in this patchset.

This patch set is built based on mainline v4.8-rc5;

Changes from V1:
  - Support the ACPI LPC device;
  - Optimize the dts LPC driver in ISA compatible mode;
  - Reserve the IO range below 4K in avoid the possible conflict with PCI host
  IO ranges;
  - Support the LPC uart and relevant earlycon;

Signed-off-by: Zhichang Yuan <yuanzhichang@hisilicon.com>

zhichang.yuan (4):
  ARM64 LPC: Indirect ISA port IO introduced
  ARM64 LPC: LPC driver implementation on Hip06
  ARM64 LPC: support serial based on low-pin-count
  ARM64 LPC: support earlycon for UART connected to LPC

 .../arm/hisilicon/hisilicon-low-pin-count.txt      |  27 +
 .../devicetree/bindings/serial/hisi-lpc-uart.txt   |  50 ++
 arch/arm64/Kconfig                                 |   6 +
 arch/arm64/include/asm/io.h                        | 109 ++++
 arch/arm64/include/asm/pci.h                       |   1 -
 drivers/bus/Kconfig                                |   8 +
 drivers/bus/Makefile                               |   1 +
 drivers/bus/hisi_lpc.c                             | 625 +++++++++++++++++++++
 drivers/of/address.c                               |   3 +-
 drivers/pci/pci.c                                  |   6 +-
 drivers/tty/serial/8250/8250_hisi_lpc.c            | 104 ++++
 drivers/tty/serial/8250/Kconfig                    |   9 +
 drivers/tty/serial/8250/Makefile                   |   1 +
 13 files changed, 945 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt
 create mode 100644 Documentation/devicetree/bindings/serial/hisi-lpc-uart.txt
 create mode 100644 drivers/bus/hisi_lpc.c
 create mode 100644 drivers/tty/serial/8250/8250_hisi_lpc.c

-- 
1.9.1
