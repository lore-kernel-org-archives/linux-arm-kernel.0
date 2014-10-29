From: xudong.chen@mediatek.com (Xudong Chen)
Date: Wed, 29 Oct 2014 13:37:35 +0800
Subject: [PATCH 0/3] ARM: mediatek: Add driver for Mediatek I2C controller
Message-ID: <1414561058-23803-1-git-send-email-xudong.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver is based on 3.18-rc1 & Hongzhou's gpio patch.

MTK I2C HW has some limitation.
1. If the i2c_msg number is more than one, STOP will be issued instead of
RS(Repeat Start) between each message.
Such as: "START + ADDR + DATA_n + STOP + START + ADDR + DATA_n + STOP ..."

2. Mediatek I2C controller support WRRD(write then read) mode, in WRRD
mode the Repeat Start will be issued between 2 messages.
In this driver if 2 messages is first write then read, the driver will
combine 2 messages using Write-Read mode so the RS will be issued between
the 2 messages.
Ex: W/R/R, driver will combine first W/R and then R.
The data series will be:
"START + WriteADDR + DATA + RS + ReadADDR + DATA + STOP + START + ReadADDR +
DATA + STOP".

3. Due to HW limitation, in this version the max transfer data length is 255
in one message. If want to transfer more than 255 bytes, HW needs the SW
driver to split the data. Take 600 bytes for example, the data need to be
divided into 3 parts 255 + 255 + 90. The data series will be:
"START + ADDR + DATA_255 + RS + ADDR + DATA_255 + RS + ADDR +  DATA_90 + STOP"
instead of "START + ADDR + DATA_900 + STOP".
We haven't implement this yet, we will do this in the separate patch.

MT8135 can control I2C pins on PMIC(MT6397) by setting the i2c registers in
MT8135 side. In this case, driver should set OFFSET_PATH_DIR bit first, the
operation on other registers are still the same.

Xudong Chen (3):
  dt-bindings: Add I2C bindings for mt65xx/mt81xx.
  ARM: mediatek: Add I2C node for mt8135 and mt8127
  I2C: mediatek: Add driver for MediaTek I2C controller

 .../devicetree/bindings/i2c/i2c-mt6577.txt         |  37 ++
 arch/arm/boot/dts/mt8127.dtsi                      |  27 +
 arch/arm/boot/dts/mt8135.dtsi                      |  51 ++
 drivers/i2c/busses/Kconfig                         |   9 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-mt65xx.c                    | 728 +++++++++++++++++++++
 6 files changed, 853 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mt6577.txt
 create mode 100644 drivers/i2c/busses/i2c-mt65xx.c

--
1.8.1.1.dirty
