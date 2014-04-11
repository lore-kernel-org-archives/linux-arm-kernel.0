From: t.stanislaws@samsung.com (Tomasz Stanislawski)
Date: Fri, 11 Apr 2014 13:48:28 +0200
Subject: [PATCH 0/2] Add support for sii9234 chip
Message-ID: <1397216910-15904-1-git-send-email-t.stanislaws@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,
This patchset adds support for sii9234 HD Mobile Link Bridge.  The chip is used
to convert HDMI signal into MHL.  The driver enables HDMI output on Trats and
Trats2 boards.

The code is based on the driver [1] developed by:
       Adam Hampson <ahampson@sta.samsung.com>
       Erik Gilling <konkers@android.com>
with additional contributions from:
       Shankar Bandal <shankar.b@samsung.com>
       Dharam Kumar <dharam.kr@samsung.com>

The drivers architecture was greatly simplified and transformed into a form
accepted (hopefully) by opensource community.  The main differences from
original code are:
* using single I2C client instead of 4 subclients
* remove all logic non-related to establishing HDMI link
* simplify error handling
* rewrite state machine in interrupt handler
* wakeup and discovery triggered by an extcon event
* integrate with Device Tree

For now, the driver is added to drivers/misc/ directory because it has neigher
userspace nor kernel interface.  The chip is capable of receiving and
processing CEC events, so the driver may export an input device in /dev/ in the
future.  However CEC could be also handled by HDMI driver.

I kindly ask for suggestions about the best location for this driver.

Both the chip and the driver are quite autonomic. The chip works as 'invisible
proxy' for HDMI signal, so there is no need to integrate it with HDMI drivers
by helper-subsystems like v4l2_subdev or drm_bridge.  If the driver is merged
then the driver from drivers/media/platform/s5p-tv/sii9234_drv.c could be safely
removed.

All comments are welcome.

Regards,
Tomasz Stanislawski


References:
[1] https://github.com/junpei0824/SC02C-linux/tree/master-jelly-cm-aokp/drivers/media/video/mhl


Tomasz Stanislawski (2):
  misc: add sii9234 driver
  arm: dts: trats2: add SiI9234 node

 Documentation/devicetree/bindings/sii9234.txt |   22 +
 arch/arm/boot/dts/exynos4412-trats2.dts       |   43 +
 drivers/misc/Kconfig                          |    8 +
 drivers/misc/Makefile                         |    1 +
 drivers/misc/sii9234.c                        | 1081 +++++++++++++++++++++++++
 5 files changed, 1155 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sii9234.txt
 create mode 100644 drivers/misc/sii9234.c

-- 
1.7.9.5
