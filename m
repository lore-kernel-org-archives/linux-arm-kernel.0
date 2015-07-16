From: adam.yh.lee@gmail.com (Adam YH Lee)
Date: Thu, 16 Jul 2015 15:20:26 -0700
Subject: [PATCH] Fix incomplete initialization of ADC[3:6]
Message-ID: <1437085227-28845-1-git-send-email-adam.yh.lee@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

TPS65950(TWL4030) paired with OMAP3 is used in devices such as Beagleboard and
Gumstix Overo COMs. Its ADCs from 3 to 6 seem to be broken [1][2][3].

The ADC readings for these pins are stuck at near 0v for these two reasons:
        - 3v1 bias regulator (vusb3v1) is off unless USB-otg is being used
        - pins are not configured to attach as ADC

This patch attempts to fix these issues by making sure 3v1 regulator is enabled
and pins are correctly configured as ADC inputs.

[1] http://comments.gmane.org/gmane.linux.ports.arm.omap/83698
[2] http://gumstix.8.x6.nabble.com/twl4030-madc-low-read-value-td4967139.html#none
[3] https://e2e.ti.com/support/power_management/pmu/f/43/t/732

Adam YH Lee (1):
  [TWL4030 MADC] Fix ADC[3:6] readings

 drivers/iio/adc/twl4030-madc.c | 14 ++++++++++++++
 drivers/phy/phy-twl4030-usb.c  |  7 +++++++
 2 files changed, 21 insertions(+)

-- 
2.1.4
