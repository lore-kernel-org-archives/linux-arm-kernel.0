From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Fri, 29 Aug 2014 10:58:44 -0700
Subject: [PATCH 0/3] gpio: zynq: Fix suspend/wake
Message-ID: <1409335127-26712-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

after our discussion during the push of the gpio-zynq driver, we took a
closer look at the LED and gpio_keys drivers.

For LEDs and other simple use-cases where you need to control an output,
that driver is great and a patch to get the LEDs on our boards added to
DT is pending.

For the keys, and especially wake, things didn't look that good. Testing
revealed a couple of flaws in the driver's wake-related implementation
which should be fixed with this series.

I'm still not fully convinced that the gpio_keys are the best
replacement for the sysfs interface when it comes to inputs. For that
reason and to have a way to do some quick wake testing, I'd like to
propose adding the ability to control wake through the sysfs interface
(patch 3).

The series is based on Linus T's current tip + the Zynq-related patches
from gpio/for-next + Lars' pending patch 'gpio: zynq: Take bank
offset into account when reporting a IRQ'.
A branch with all those patches can be found here:
https://github.com/sorenb-xlnx/linux-xlnx/commits/gpio

	Thanks,
	S?ren

Ezra Savard (2):
  gpio: zynq: Mask non-wakeup GPIO interrupts on suspend
  gpio: zynq: Fixed broken wakeup implementation

Soren Brinkmann (1):
  gpio: lib-sysfs: Add 'wakeup' attribute

 drivers/gpio/gpio-zynq.c     | 38 +++++++++++++---------
 drivers/gpio/gpiolib-sysfs.c | 75 ++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 92 insertions(+), 21 deletions(-)

-- 
2.1.0.1.g27b9230
