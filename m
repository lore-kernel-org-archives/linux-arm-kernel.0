From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Mon, 15 Jan 2018 17:22:31 +0100
Subject: [RFC PATCH 0/2] fixing the gpio ownership
Message-ID: <20180115162233.6205-1-ludovic.desroches@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

A few weeks ago, I have sent an RFC about adding bias support for GPIOs [1].

It was motivated by the fact that I wanted to enable the pinmuxing strict mode
for my pin controller which can muxed a pin as a peripheral or as a GPIO.

Enabling the strict mode prevents several devices to be probed because
requesting a GPIO fails. The pin request function complains about the
ownership of the GPIO which is different from the mux ownership. I have to
remove my pinctrl node to avoid this conflict but I need it to configure my
pins and to set a pull-up bias for my GPIOs.

My first idea was to add new flags in addition to GPIO_ACTIVE_HIGH and others.
Obviously, it was not the way to go since many new flags may be added:
strength, debounce, etc.

Then I proposed a very "quick and dirty" patch to give the picture of what I
have in mind but I had no feedback. It was probably too dirty. The idea was
to add a cell to the gpios property with a phandle on a pinctrl node which
contains only the pinconf, no pinmux. The configuration is applied later when
requesting the GPIO. The main issue is that enabling the strict mode will
break old DTBs. I was going to submit patches for this but, after using the
sysfs which still show me a bad ownership, I decided that it should be fixed.

So I did these patches. Unfortunately, there are several ways to lead to
gpiod_request(). It does the trick only for the gpiod_get family. The issue is
still present with legacy gpio_request and fwnode_get_named_gpiod. It seems
that more and more drivers are converted to use GPIO descriptors so there is
some hope. The advantage of this solution is to not break old DTBs. As I am
not aware of all usage of the gpiolib, I tried to implement it in the safest
way.

Regards

Ludovic

[1] https://www.spinics.net/lists/arm-kernel/msg623149.html


Ludovic Desroches (2):
  pinctrl: add consumer variant for gpio request
  gpio: provide a consumer when requesting a gpio

 drivers/gpio/gpiolib.c           | 40 +++++++++++++++++++++++++++++++++-------
 drivers/pinctrl/core.c           | 13 ++++++++++---
 drivers/pinctrl/pinmux.c         | 16 ++++++++++++++--
 drivers/pinctrl/pinmux.h         | 10 ++++++++++
 include/linux/gpio/driver.h      |  5 +++++
 include/linux/pinctrl/consumer.h |  6 ++++++
 6 files changed, 78 insertions(+), 12 deletions(-)

-- 
2.12.2
