From: peda@lysator.liu.se (Peter Rosin)
Date: Tue,  8 Dec 2015 04:20:06 +0100
Subject: [RESEND RFC PATCH 0/2] Expose the PIO_ISR register on SAMA5D3
Message-ID: <1449544808-3163-1-git-send-email-peda@lysator.liu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Peter Rosin <peda@axentia.se>

Hi!

I have a signal connected to a gpio pin which is the output of
a comparator. By changing the level of one of the inputs to the
comparator, I can detect the envelope of the other input to
the comparator by using a series of measurements much in the
same maner a manual ADC works, but watching for changes on the
comparator over a period of time instead of only the immediate
output.

Now, the input signal to the comparator might have a high frequency,
which will cause the output from the comparator (and thus the GPIO
input) to change rapidly.

A common(?) idiom for this is to use the interrupt status register
to catch the glitches, but then not have any interrupt tied to
the pin as that could possibly generate pointless bursts of
(expensive) interrupts.

So, these two patches expose an interface to the PIO_ISR register
of the pio controllers on the platform I'm targetting. The first
patch adds some infrastructure to the gpio core and the second
patch hooks up "my" pin controller.

But hey, this seems like an old problem and I was surprised that
I had to touch the source to do it. Which makes me wonder what I'm
missing and what others needing to see short pulses on a pin but not
needing/wanting interrupts are doing?

Yes, there needs to be a way to select the interrupt edge w/o
actually arming the interrupt, that is missing. And probably
other things too, but I didn't want to do more work in case this
is a dead end for some reason...

Cheers,
Peter

Peter Rosin (2):
  gpio: Add isr property of gpio pins
  pinctrl: at91: expose the isr bit

 Documentation/gpio/sysfs.txt   |   12 ++++++++++
 drivers/gpio/gpiolib-sysfs.c   |   30 ++++++++++++++++++++++++
 drivers/gpio/gpiolib.c         |   15 ++++++++++++
 drivers/pinctrl/pinctrl-at91.c |   50 ++++++++++++++++++++++++++++++++++++----
 include/linux/gpio/consumer.h  |    1 +
 include/linux/gpio/driver.h    |    2 ++
 6 files changed, 106 insertions(+), 4 deletions(-)

-- 
1.7.10.4
