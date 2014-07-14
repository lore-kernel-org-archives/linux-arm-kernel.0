From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 15 Jul 2014 01:24:35 +0800
Subject: [PATCH 0/2] pinctrl: sunxi: misc improvements for gpio
Message-ID: <1405358677-23657-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These 2 patches are fixes / improvements to the gpio side of the
sunxi pinctrl driver. They are based on pinctrl/devel (3a19805).
The patches change the same lines of code, so they are sent together.

Patch 1 adds locking gpio lines when used as external interrupts.
Similar patches were done by Linus and other maintainers for various
platforms.

A somewhat related issue is that the sunxi pinctrl driver does not
block users from requesting an already muxed pin as a gpio line.
Maybe we should do some locking there as well? Are there any kernel
interfaces for this? Or do we need to do it in the driver specifically
for our hardware?

(I had the unfortunate experience of poking GPIOs listed in the fex
files, not noticing they were used by the uart console.)


Patch 2 changes the gpio ranges registered by the pinctrl driver.
Instead of just passing the pin number, we pass the pin offset,
so that the range is not out of bounds (with respect to gpiochip.ngpio).
This happens on sun6i/sun8i platforms for the R_PIO controllers.

As gpiochip.base currently matches the pin number base, we get the nice
result that gpio numbers match pin numbers again.

AFAIK pinctrl pin numbers are device specific, so I'm wondering if we
should also number them in terms of offsets, rather than absolute pin
numbers. It's more of an asthetic change though. Any thoughts?

Thank you


Cheers
ChenYu


Chen-Yu Tsai (2):
  pinctrl: sunxi: use gpiolib API to mark a GPIO used as an IRQ
  pinctrl: sunxi: number gpio ranges starting from 0

 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

-- 
2.0.1
