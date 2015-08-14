From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 14 Aug 2015 16:10:57 +0200
Subject: [PATCH v3 0/9] gpiolib: Add GPIO name support
Message-ID: <1439561466-14350-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes in v3:
As discussed in the v2 thread, we are using the already existing gpiochip names
now. To avoid races between kernel and userspace, the setup of gpio names in
the gpio descriptors has to happen right before the gpiochip is added for use
and after the gpio descriptors are available. Unfortunately this is exactly in
the function gpiochip_add().

So we can't use a a function as proposed in the discussion like
gpiochip_set_names(), as this function would only be possible after we executed
gpiochip_add(). Before that point the gpio descriptors are not available. But
this can potentially lead to races between userspace and the gpio chip.

That is the reason why I left the names array in the gpioscript. But this array
is now only used to initialize the GPIO descriptors. The named sysfs
directories are now created using the name stored in the gpio descriptor.

As the name is now directly represented through the sysfs directory name, I am
not sure if it makes sense to keep the patch which adds a 'name' property to
the sysfs GPIO directories. For the moment it is still in this series.

Other changes in v3:
 - Renamed generic of_parse_gpio() to of_parse_own_gpio()
 - Replaced pr_warn with dev_warn as the device is available in the parsing code
   in gpiolib-of
 - Introduced name collision checks when adding the names from gpiochip->names
   to the gpio descriptors
 - Added documentation about /sys/class/gpio/<GPIO>/name
 - Added check for DT in case the GPIO already has a name. This may happen as
   there are different ways to set a name, through 'line-name' property and
   node name

Best Regards,

Markus


Changes in v2:
 - Removed patch 'gpiolib: Fix possible use of wrong name'
 - Removed discussed patch 'gpio: Allow hogged gpios to be requested' from this
   series
 - Fixed show gpio name patch (locks, (null) printing, and getting the descriptor)
 - Merged gpio name patch into gpio_name_to_desc() patch

Description from v1:

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
directories now contain a 'name' file which is '' for non-existent names and
the name otherwise.

This series can be used to have an easy name mapping for udev with a quite
simple rule similar to this:
	SUBSYSTEM=="gpio", KERNEL=="gpio*", ATTR{name}!="(null)", ACTION=="add", \
	PROGRAM+="/bin/sh -c 'mkdir -p /dev/gpios; rm -f /dev/gpios/$attr{name}; ln -s /sys%p/ /dev/gpios/$attr{name}"
With this rule udev adds a link for each exported GPIO with a name into
/dev/gpios/. This way it is not necessary to know the number of a GPIO to use
it.


Markus Pargmann (9):
  gpiolib-of: Rename gpio_hog functions to be generic
  gpio: Introduce gpio descriptor 'name'
  gpiolib: Use GPIO name from names array for gpio descriptor
  gpio-sysfs: Use gpio descriptor name instead of gpiochip names array
  gpiolib: Add gpio name information to /sys/kernel/debug/gpio
  gpiolib-sysfs: Show gpio-name in /sys/class/gpio/gpio*/name
  gpiolib-sysfs: Add gpio name parsing for sysfs export
  gpiolib-of: Reuse 'line-name' from DT as gpio descriptor name
  gpiolib-of: Use dev_warn instead of pr_warn

 Documentation/ABI/testing/sysfs-gpio |  1 +
 drivers/gpio/gpiolib-of.c            | 50 +++++++++++++---------
 drivers/gpio/gpiolib-sysfs.c         | 67 +++++++++++++++++++++---------
 drivers/gpio/gpiolib.c               | 80 ++++++++++++++++++++++++++++++++++--
 drivers/gpio/gpiolib.h               |  3 ++
 include/linux/gpio/consumer.h        |  7 ++++
 6 files changed, 166 insertions(+), 42 deletions(-)

-- 
2.4.6
