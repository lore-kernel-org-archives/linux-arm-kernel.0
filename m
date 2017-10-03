From: andrzej.p@samsung.com (Andrzej Pietrasiewicz)
Date: Tue, 03 Oct 2017 14:59:36 +0200
Subject: [PATCHv2 0/2]
In-Reply-To: <ba580a0c-36c3-b227-61ee-97637532823e@ti.com>
References: <ba580a0c-36c3-b227-61ee-97637532823e@ti.com>
 <CGME20171003125944eucas1p1fad23e6171786fda69ccd9419354911b@eucas1p1.samsung.com>
Message-ID: <1507035578-24945-1-git-send-email-andrzej.p@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This is the second version of patches in this thread.

The series fixes problems with enumerating of SuperSpeed devices
on an Odroid XU3. There was a patch series from Vivek Gautam in
circulation, but it got lost somehow. Please see:

https://lkml.org/lkml/2014/9/2/166
https://lkml.org/lkml/2015/2/2/257

I adapted his patch so that it does not use a hacky solution to force
additional initialization in order for calibration to happen.
With this patch enumeration happens correctly and a super speed device
is recognized as such.

@Kishon:

As far as I understand what you suggest is to move phy_init() and
phy_power_on() invocations from dwc3/core.c to xhci-plat, but,
to the best of my knowledge, they are needed in device mode, too.

Changes since v1:

- added calibrate() callback to phy
- used calibrate() instead of reset() to trigger the calibration

Andrzej Pietrasiewicz (1):
  drivers: phy: add calibrate method

Vivek Gautam (1):
  phy: exynos5-usbdrd: Calibrate LOS levels for exynos5420/5800

 drivers/phy/phy-core.c                   |  14 +++
 drivers/phy/samsung/phy-exynos5-usbdrd.c | 183 +++++++++++++++++++++++++++++++
 drivers/usb/dwc3/core.c                  |   7 +-
 include/linux/phy/phy.h                  |  10 ++
 4 files changed, 212 insertions(+), 2 deletions(-)

-- 
1.9.1
