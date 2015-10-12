From: leo.yan@linaro.org (Leo Yan)
Date: Tue, 13 Oct 2015 00:32:11 +0800
Subject: [PATCH v4 0/4] mailbox: hisilicon: add Hi6220 mailbox driver
Message-ID: <1444667535-16948-1-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi6220 mailbox supports up to 32 channels. Each channel is unidirectional
with a maximum message size of 8 words. I/O is performed using register
access (there is no DMA) and the cell raises an interrupt when messages
are received.

This patch series is to implement Hi6220 mailbox driver. It registers
two channels into framework for communication with MCU, one is tx channel
and another is rx channel. Now mailbox driver is used to send message to
MCU to control dynamic voltage and frequency scaling for CPU, GPU and DDR.

Changes from v3:
* The patch series for enabling idle state for Hi6220 has reserved memory
  regions, so this series will not include it anymore
* Refined mailbox driver according to Jassi's suggestion;
  Removed kfifo from mailbox driver;
  Removed spinlock for ipc registers accessing, due every channel has its
  own dedicated bit in ipc register and readl/writel will introduce memory
  barrier, so don't need spinlock to protect ipc registers accessing
* After mailbox driver is ready, can use patch 4 to enable CPU's OPPs and
  stub clock driver; finally can enable CPUFreq driver for CPU frequency
  scaling

Changes from v2:
* Get rid of unused memory regions from memory node in DT, and don't use
  reserved-memory node according to Mark and Leif's suggestion; Haojian also
  has updated UEFI for efi memory info

Changes from v1:
* Correct lock usage for SMP scenario

Changes from RFC:
* According to Jassi's review, totally remove the abstract common driver
  layer and only commit driver dedicated for Hi6220
* According to Paul Bolle's review, fix typo issue for Kconfig and remove
  unnecessary dependency with OF and fix minor for mailbox driver
* Refine a little for dts nodes


Leo Yan (4):
  dt-bindings: mailbox: Document Hi6220 mailbox driver
  mailbox: Hi6220: add mailbox driver
  arm64: dts: add mailbox node for Hi6220
  arm64: dts: add Hi6220's stub clock node

 .../bindings/mailbox/hisilicon,hi6220-mailbox.txt  |  57 ++++
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi          |  31 ++
 drivers/mailbox/Kconfig                            |   8 +
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/hi6220-mailbox.c                   | 371 +++++++++++++++++++++
 5 files changed, 469 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/hisilicon,hi6220-mailbox.txt
 create mode 100644 drivers/mailbox/hi6220-mailbox.c

-- 
1.9.1
