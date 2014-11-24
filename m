From: xudong.chen@mediatek.com (Xudong Chen)
Date: Mon, 24 Nov 2014 17:38:46 +0800
Subject: [PATCH v3 0/2] ARM: mediatek: Add driver for Mediatek I2C controller
Message-ID: <1416821928-11453-1-git-send-email-xudong.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is the third version of Mediatek SoCs I2C controller common
bus driver.
Compared to the second version,
1. Add comments for clock in dt-bindings file i2c-mt6577.txt.
2. Remove mt8135.dtsi because of the dependency on pinctrl and clock.
3. Encode the feature have-dcm in i2c-mt65xx.c by checking the compatible.

This driver is based on 3.18-rc1.

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

MT8135 and MT6589 can control I2C pins on PMIC(MT6397) by setting the i2c
registers in MT8135 side. In this case, driver should set OFFSET_PATH_DIR
bit first, the operation on other registers are still the same.
For now MT6589/MT8135 support this, MT6577/MT6595/MT8127 do not support.
For example, If want to use I2C4/5/6 pins on MT8135 just need to enable
the pinmux, else if want to use I2C pins on PMIC(MT6397) need to add
"mediatek,have-pmic" property in the .dts file of each platform.

Xudong Chen (2):
  dt-bindings: Add I2C bindings for mt65xx/mt81xx.
  I2C: mediatek: Add driver for MediaTek I2C controller

 .../devicetree/bindings/i2c/i2c-mt6577.txt         |  40 ++
 drivers/i2c/busses/Kconfig                         |   9 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-mt65xx.c                    | 742 +++++++++++++++++++++
 4 files changed, 792 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mt6577.txt
 create mode 100644 drivers/i2c/busses/i2c-mt65xx.c

--
1.8.1.1.dirty
