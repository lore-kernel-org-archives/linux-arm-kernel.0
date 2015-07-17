From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 17 Jul 2015 11:32:41 +0200
Subject: [PATCH 0/9] gpiolib: Add GPIO name support
Message-ID: <1437125570-28623-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is a proposal to add GPIO names to the kernel based on devicetree
descriptions.

This series adds GPIO name support. Until now it is only possible to use names
for already requested GPIOs (for example what they are used for). It is not
possible to identify GPIOs by a name although most of them have a name for
example in the schematics of the board. This makes it difficult to identify
a specific GPIO from userspace.

As the GPIO name information is a hardware description this series uses the
devicetree bindings introduced by the GPIO hogging mechanism, specifically
'line-name', to identify GPIOs. The sysfs 'export' file is changed to accept
names as fallback. The gpio numbers still have a higher priority to ensure
backwards compatibility.

Exported GPIOs are still using their number as directory name (gpio<ID>). But the
directories now contain a 'name' file which is '(null)' for non-existent names
and the name otherwise.

This series can be used to have an easy name mapping for udev with a quite
simple rule similar to this:
	SUBSYSTEM=="gpio", KERNEL=="gpio*", ATTR{name}!="(null)", ACTION=="add", \
	PROGRAM+="/bin/sh -c 'mkdir -p /dev/gpios; rm -f /dev/gpios/$attr{name}; ln -s /sys%p/ /dev/gpios/$attr{name}"
With this rule udev adds a link for each exported GPIO with a name into
/dev/gpios/. This way it is not necessary to know the number of a GPIO to use
it.

Best Regards,

Markus


Markus Pargmann (9):
  gpiolib: Fix possible use of wrong name
  gpiolib-of: Rename gpio_hog functions to be generic
  gpio: Allow hogged gpios to be requested
  gpio: Add 'name' to the gpio descriptor struct
  gpiolib: Implement gpio_name_to_desc()
  gpiolib-of: Reuse 'line-name' from DT as gpio descriptor name
  gpiolib-sysfs: Add gpio name parsing for sysfs export
  gpiolib-sysfs: Show gpio-name in /sys/class/gpio/gpio*/name
  gpiolib: Add gpio name information to /sys/kernel/debug/gpio

 drivers/gpio/gpiolib-of.c     | 45 +++++++++++++++++++------------
 drivers/gpio/gpiolib-sysfs.c  | 61 ++++++++++++++++++++++++++++++++++---------
 drivers/gpio/gpiolib.c        | 46 +++++++++++++++++++++++++++++---
 drivers/gpio/gpiolib.h        |  3 +++
 include/linux/gpio/consumer.h |  7 +++++
 5 files changed, 128 insertions(+), 34 deletions(-)

-- 
2.1.4
