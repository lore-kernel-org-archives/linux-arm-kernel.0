From: eddie.huang@mediatek.com (Eddie Huang)
Date: Fri, 16 Jan 2015 18:33:36 +0800
Subject: [PATCH v4 0/2] ARM: mediatek: Add driver for Mediatek I2C controller 
Message-ID: <1421404418-50718-1-git-send-email-eddie.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is the fourth version of Mediatek SoCs I2C controller common
bus driver.

Change in v4:
Modify to support i2c_adapter_quirks base on Wolfram's patch [1].
Remove check transfer size and WRRD combine code. Instead, fill quirk
property and let i2c_check_for_quirks to do the filter.

This driver is based on 3.19-rc1.

MTK I2C HW has some limitations.
1. Only support one i2c_msg number. One exception is WRRD (write then read)
mode. WRRD can have two i2c_msg numbers.

2. Mediatek I2C controller support WRRD(write then read) mode, in WRRD
mode the Repeat Start will be issued between 2 messages.
In this driver if 2 messages is first write then read, the driver will
combine 2 messages using Write-Read mode so the RS will be issued between
the 2 messages.

3. The max transfer data length is 255 in one message. In WRRD mode, the
max data length of second msg is 31.

MT8135 and MT6589 can control I2C pins on PMIC(MT6397) by setting the i2c
registers in MT8135 side. In this case, driver should set OFFSET_PATH_DIR
bit first, the operation on other registers are still the same.
For now MT6589/MT8135 support this, MT6577/MT6595/MT8127 do not support.
For example, If want to use I2C4/5/6 pins on MT8135 just need to enable
the pinmux, else if want to use I2C pins on PMIC(MT6397) need to add
"mediatek,have-pmic" property in the .dts file of each platform.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/314804.html

Xudong Chen (2):
  dt-bindings: Add I2C bindings for mt65xx/mt81xx.
  I2C: mediatek: Add driver for MediaTek I2C controller

 .../devicetree/bindings/i2c/i2c-mt6577.txt         |  40 ++
 drivers/i2c/busses/Kconfig                         |   9 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-mt65xx.c                    | 710 +++++++++++++++++++++
 4 files changed, 760 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mt6577.txt
 create mode 100644 drivers/i2c/busses/i2c-mt65xx.c

--
1.8.1.1.dirty
