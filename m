From: robh@kernel.org (Rob Herring)
Date: Thu, 10 Dec 2015 15:21:10 -0600
Subject: [PATCH 0/3] DT labels for connector device mapping
Message-ID: <1449782473-20880-1-git-send-email-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Having a common connector interface across different platforms can be 
problematic for determining which SOC device is connected to which 
connector pins. The standard DT property "label" is intended to provide 
a human readable name for a device and can be used to provide this 
information. Then userspace can can read the label to determine the 
device mapping. For example:

for f in $(ls -d /sys/class/tty/tty*); do
  label=$(cat $f/device/of_node/label)
  if [ "$label" = "LS-UART1" ]; then
    # you've found UART1, so do something with it.
    # $f/dev is the major:minor for the /dev node
  fi
done

This series adds labels on hikey and dragonboard 410c devices for the 
low speed and high speed connectors. Not tested at all.

BTW, there are no platform maintainers listed for these files. Setting 
them should be enforced for the dts files as DT maintainers mainly 
review binding docs, not dts files.

Rob

Rob Herring (3):
  arm64: dts: apq8016-sbc: enable UART0 on LS connector
  arm64: dts: apq8016-sbc: add label properties for UART, I2C, and SPI
  arm64: dts: hikey: add label properties to UARTs

 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts |  7 +++++++
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi      | 14 ++++++++++++++
 2 files changed, 21 insertions(+)

-- 
2.5.0
