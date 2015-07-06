From: majun258@huawei.com (Ma Jun)
Date: Mon, 6 Jul 2015 15:09:05 +0800
Subject: [PATCH v3 0/3] IRQ/Gic-V3:Support Mbigen interrupt controller
Message-ID: <1436166548-34920-1-git-send-email-majun258@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set is applied to supprot the mbigen device.

Mbigen means Message Based Interrupt Generator.
Its a kind of interrupt controller collects
the interrupts from external devices and generate msi interrupt.

Mbigen is applied to reduce the number of wire connected interrupts.

As the peripherals increasing, the interrupts lines needed is increasing
much, especially on the Arm64 server soc.

Therefore, the interrupt pin in gic is not enought for so many perpherals.

Mbigen is designed to fix this problem.

Mbigen chip locates in ITS or outside of ITS.

The working flow of Mbigen shows as below:

external devices ------> MBIGEN ------->ITS

The devices connect to Mbigen chip through wire connecting way.
Mbigen detects and collectes the interrupts from the these devices.

Then, Mbigen generats the MBI interrupts by writting the ITS
Translator register.

Ma Jun (3):
  Add mbigen driver to support mbigen interrupt controller
  Change arm-gic-its to support the Mbigen interrupt
  dt-binding:Documents the mbigen bindings

 Documentation/devicetree/bindings/arm/mbigen.txt |   65 +++
 drivers/irqchip/Kconfig                          |    8 +
 drivers/irqchip/Makefile                         |    1 +
 drivers/irqchip/irq-gic-v3-its.c                 |   60 ++-
 drivers/irqchip/irq-mbigen.c                     |  486 ++++++++++++++++++++++
 include/linux/mbi.h                              |   15 +
 6 files changed, 615 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/mbigen.txt
 create mode 100644 drivers/irqchip/irq-mbigen.c
 create mode 100644 include/linux/mbi.h
