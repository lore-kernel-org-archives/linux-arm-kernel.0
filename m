From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Fri, 15 Jan 2016 14:20:59 +0000
Subject: [PATCH V4 0/7] clk: bcm2835: add clocks and add MASH support
Message-ID: <1452867667-2447-1-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

The clk-bcm2835 driver right now relies on BCM2835_CLOCK_COUNT defined
in include/dt-binding/clocks/bcm2835.h
With every new clock introduced this value needs to increase,
which is not what should happen for bindings.

So we reorganize the driver so that it is no longer necessary
to define BCM2835_CLOCK_COUNT.

Also the driver calculates fractional clock dividers correctly,
but it does not enable the bit to enable support in the register.
As a minimal extension we now can also define higher order MASH
support when defining the clocks.

There is also an issue when the clock divider is < 2 - in that
case no clock-output is generate. The clamping code has been
enhanced to handle this as well.

Similarly there is also the clamping of the highest divider now
limited to the highest possible integer divider instead of the
highest possible fractional diviver.

Finally we add all the 23 different HW clocks that have not been
configured in the driver.

Changelog:
	V1 -> V2: split the asoc/sound patches from the clock patches
	      	  enable frac/mash support
	V2 -> V3: clamp clock divider to be >= 2
		  clamp max clock divider to be integer (not fractional)
		  added additional limit checks for divider selection
		    allowing fallback to lower mash levels.
		  use a newer probing mechanism based on a single array
	V3 -> V4: fixed bad NULL pointer check in init
	      	  fixed (mash) limit checks
		  separated basic mash support from limits checks
		  really tested with I2S device (unfortunately V3 was
		  not well tested in this respect)

Martin Sperl (7):
  clk: bcm2835: the minimum clock divider is 2
  clk: bcm2835: clamp clock divider to highest integer only
  clk: bcm2835: remove use of BCM2835_CLOCK_COUNT in driver
  clk: bcm2835: enable management of PCM clock
  clk: bcm2835: add missing 22 HW-clocks.
  clk: bcm2835: enable fractional and mash support
  clk: bcm2835: apply limits on dividers to MASH mode.

 drivers/clk/bcm/clk-bcm2835.c       |  583 ++++++++++++++++++++++++++++++-----
 include/dt-bindings/clock/bcm2835.h |   25 +-
 2 files changed, 521 insertions(+), 87 deletions(-)

--
1.7.10.4
